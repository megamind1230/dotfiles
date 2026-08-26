package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	r := bufio.NewReader(os.Stdin)
	w := bufio.NewWriter(os.Stdout)
	defer w.Flush()

	var t int
	fmt.Fscan(r, &t)
	for ; t > 0; t-- {
		var n int
		fmt.Fscan(r, &n)
		var sum int64
		for i := 0; i < n; i++ {
			var x int64
			fmt.Fscan(r, &x)
			sum += x
		}
		fmt.Fprintln(w, sum)
	}

}
