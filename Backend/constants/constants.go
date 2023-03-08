package constants

import "time"

var ErrorNoUser string
var ErrorGenerateKey string
var ErrorInvalidToken string
var ErrorNoAuthHeader string
var TokenExpirationTime time.Time

func init() {
	ErrorNoUser = "User does not exist"
	ErrorGenerateKey = "Error could not generate key"
	ErrorInvalidToken = "Invalid JWT token"
	ErrorNoAuthHeader = "Authorization header required"
	TokenExpirationTime = time.Now().Add(10 * time.Hour)
}