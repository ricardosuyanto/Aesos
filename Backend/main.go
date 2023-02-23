package main

import (
	"Project/Aesos/api"
	"fmt"

	_ "github.com/joho/godotenv/autoload"
)


func main() {
	fmt.Println("test")
	db, err := api.SetupDB()
	if(err != nil) {
		panic(err)
	}

	fmt.Println(db.ConnPool)
}