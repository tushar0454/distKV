// Command distkv runs one node of the distkv key-value store.
package main

import (
	"flag"
	"fmt"
	"os"
)

// version is set at build time by the Makefile:
//
//	go build -ldflags "-X main.version=$(git describe --tags --always --dirty)"
var version = "dev"

func main() {
	showVersion := flag.Bool("version", false, "print version and exit")
	flag.Parse()

	if *showVersion {
		fmt.Println("distkv", version)
		return
	}

	fmt.Fprintln(os.Stderr, "distkv: nothing to run yet (see the roadmap in README.md)")
	os.Exit(1)
}
