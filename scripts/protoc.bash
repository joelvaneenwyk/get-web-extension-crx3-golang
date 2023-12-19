PWD="$(pwd)"

docker run \
    --rm -v "$PWD":"$PWD" -w "$PWD" github.com/joelvaneenwyk/go-web-extensions/protoc --go_out=paths=source_relative:. ./pb/crx3.proto
