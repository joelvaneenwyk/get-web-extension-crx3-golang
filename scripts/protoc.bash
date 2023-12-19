PWD="$(pwd)"

docker run \
    --rm -v "$PWD":"$PWD" -w "$PWD" github.com/joelvaneenwyk/get-web-extension-crx3-golang/protoc --go_out=paths=source_relative:. ./pb/crx3.proto
