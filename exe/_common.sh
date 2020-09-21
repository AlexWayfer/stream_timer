## Function to display commands and exit if failed
exe() {
	echo "> $@"
	"$@" || exit 1
}
