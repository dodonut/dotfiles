package main

import (
	"fmt"
	"strings"
)

func main() {
	str := "/api/v1/invoices/71290?"

	value := strings.Index(str, "?")
	var s2 string
	if value != -1 {
		s2 = str[:value]
	} else {
		s2 = str
	}
	fmt.Println("s2", s2)

	// s := str[strings.Index(str, "?")+1:]
	// iter_str := strings.Split(s, "&")
	// out := map[string]string{}
	// for i := 0; i < len(iter_str); i++ {
	// 	key_value := strings.Split(iter_str[i], "=")
	// 	if len(key_value) == 2 && len(key_value[1]) > 0 {
	// 		out[key_value[0]] = key_value[1]
	// 	}
	// }
	// fmt.Println("map: ", out)

}
