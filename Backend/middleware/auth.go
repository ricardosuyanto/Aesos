package middleware

import (
	"Project/Aesos/constants"
	"crypto/rand"
	"encoding/base64"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

var (
	JwtKey = []byte("ad2e3fef3fedwqed")
)

func GenerateJWTSecretKey() (string, error) {
	const keyLength = 32

	key := make([]byte, keyLength)
	_, err := rand.Read(key)
	if err != nil {
		return "", err
	}

	encodedKey := base64.URLEncoding.EncodeToString(key)

	return encodedKey, nil
}

func CreateToken(username string) (string, error){
	expirationTime := constants.TokenExpirationTime

	claims := &Claims{
		Username: username,
		StandardClaims: jwt.StandardClaims{
			ExpiresAt: expirationTime.Unix(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, err := token.SignedString(JwtKey)

	if err != nil {
		return "", errors.New(constants.ErrorGenerateKey)
	}

	return tokenString, nil
}

func AuthMiddleware() gin.HandlerFunc{
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")

		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"message":"Authorization header required"})
			c.Abort()
			return 
		}

		tokenString := authHeader[len("Bearer "):]

		claims := &Claims{}
		token, err := jwt.ParseWithClaims(tokenString, claims, func(t *jwt.Token) (interface{}, error) {
			if _, ok := t.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, fmt.Errorf("Unexpected signing method: %v", t.Header["alg"])
			}
			return JwtKey, nil
		})

		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"message":"Invalid JWT Token"})
			c.Abort()
			return 
		}

		newToken, status, err := refreshToken(token)

		if err != nil {
			c.JSON(status, gin.H{"message":err.Error()})
			c.Abort()
			return
		}

		c.Header("Authorization", newToken)
	}
}

func refreshToken(token *jwt.Token) (string, int, error) {
	claims, ok := token.Claims.(*Claims)

	if ok && token.Valid {
		exp := claims.ExpiresAt
		now := time.Now().Unix()
		if exp-now < 30 * 60 {
			newToken, err := CreateToken(claims.Username)
			if err != nil {
				return "", http.StatusInternalServerError, errors.New("Failed to generate Token")
			}

			return newToken, http.StatusOK, nil
		}
	}
	return "", 0, nil
}