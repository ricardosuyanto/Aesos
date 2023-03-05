package constants

var ErrorNoUser string
var ErrorGenerateKey string
var ErrorInvalidToken string
var ErrorNoAuthHeader string

func init() {
	ErrorNoUser = "User does not exist"
	ErrorGenerateKey = "Error could not generate key"
	ErrorInvalidToken = "Invalid JWT token"
	ErrorNoAuthHeader = "Authorization header required"
}