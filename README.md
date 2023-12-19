# go-crx3

<!-- cspell:ignore blipmdconlkpinefehnmjammfjpmpbjk dgmchnekcpklnjppdmmjlgpmpohmpmgp Println -->

[![Coverage Status](https://coveralls.io/repos/github/mmadfox/go-crx3/badge.svg?branch=master)](https://coveralls.io/github/mmadfox/go-crx3?branch=master)
[![Documentation](https://godoc.org/github.com/joelvaneenwyk/get-web-extension-crx3-golang?status.svg)](https://pkg.go.dev/github.com/joelvaneenwyk/get-web-extension-crx3-golang)
[![Go Report Card](https://goreportcard.com/badge/github.com/joelvaneenwyk/get-web-extension-crx3-golang)](https://goreportcard.com/report/github.com/joelvaneenwyk/get-web-extension-crx3-golang)
![Actions](https://github.com/mmadfox/go-crx3/actions/workflows/cover.yml/badge.svg)

Provides a sets of tools packing, unpacking, zip, unzip, download, gen id, etc...

## Table of Contents

- [go-crx3](#go-crx3)
  - [Table of Contents](#table-of-contents)
    - [Installation](#installation)
    - [Dev commands](#dev-commands)
    - [Examples](#examples)
      - [Pack](#pack)
        - [Pack a zip file or unzipped directory into a crx extension](#pack-a-zip-file-or-unzipped-directory-into-a-crx-extension)
      - [Unpack](#unpack)
        - [Unpack chrome extension into current directory](#unpack-chrome-extension-into-current-directory)
      - [Base64](#base64)
        - [Encode an extension file to a base64 string](#encode-an-extension-file-to-a-base64-string)
      - [Download](#download)
        - [Download a chrome extension from the web store](#download-a-chrome-extension-from-the-web-store)
      - [Zip](#zip)
        - [Zip add an unpacked extension to the archive](#zip-add-an-unpacked-extension-to-the-archive)
      - [Unzip](#unzip)
        - [Unzip an extension to the current directory](#unzip-an-extension-to-the-current-directory)
      - [Gen ID](#gen-id)
        - [Generate extension id (like dgmchnekcpklnjppdmmjlgpmpohmpmgp)](#generate-extension-id-like-dgmchnekcpklnjppdmmjlgpmpohmpmgp)
      - [IsDir, IsZip, IsCRX3](#isdir-iszip-iscrx3)
      - [NewPrivateKey, LoadPrivateKey, SavePrivateKey](#newprivatekey-loadprivatekey-saveprivatekey)
      - [Keygen](#keygen)
  - [License](#license)

### Installation

```ssh
go get -u github.com/joelvaneenwyk/get-web-extension-crx3-golang/crx3
go install github.com/joelvaneenwyk/get-web-extension-crx3-golang/crx3@latest
```

OR download the binary from here

```bash
https://github.com/mmadfox/go-crx3/releases
```

### Dev commands

```shell script
make proto
make test/cover
```

### Examples

#### Pack

##### Pack a zip file or unzipped directory into a crx extension

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

if err := crx3.Extension("/path/to/file.zip").Pack(nil); err != nil {
    panic(err)
}
```

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

pk, err := crx3.LoadPrivateKey("/path/to/key.pem")
if err != nil {
    panic(err)
}
if err := crx3.Extension("/path/to/file.zip").Pack(pk); err != nil {
    panic(err)
}
```

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

pk, err := crx3.LoadPrivateKey("/path/to/key.pem")
if err != nil {
    panic(err)
}
if err := crx3.Extension("/path/to/file.zip").PackTo("/path/to/ext.crx", pk); err != nil {
    panic(err)
}
```

```shell script
crx3 pack /path/to/file.zip
crx3 pack /path/to/file.zip -p /path/to/key.pem
crx3 pack /path/to/file.zip -p /path/to/key.pem -o /path/to/ext.crx
```

#### Unpack

##### Unpack chrome extension into current directory

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

if err := crx3.Extension("/path/to/ext.crx").Unpack(); err != nil {
   panic(err)
}
```

```shell script
crx3 unpack /path/to/ext.crx
```

#### Base64

##### Encode an extension file to a base64 string

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"
import "fmt"

b, err := crx3.Extension("/path/to/ext.crx").Base64()
if err != nil {
   panic(err)
}
fmt.Println(string(b))
```

```shell script
crx3 base64 /path/to/ext.crx [-o /path/to/file]
```

#### Download

##### Download a chrome extension from the web store

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

extensionID := "blipmdconlkpinefehnmjammfjpmpbjk"
filepath := "/path/to/ext.crx"
if err := crx3.DownloadFromWebStore(extensionID,filepath); err != nil {
    panic(err)
}
```

```shell script
crx3 download blipmdconlkpinefehnmjammfjpmpbjk [-o /custom/path]
crx3 download https://chrome.google.com/webstore/detail/lighthouse/blipmdconlkpinefehnmjammfjpmpbjk
```

#### Zip

##### Zip add an unpacked extension to the archive

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

if err := crx3.Extension("/path/to/unpacked").Zip(); err != nil {
    panic(err)
}
```

```shell script
crx3 zip /path/to/unpacked [-o /custom/path]
```

#### Unzip

##### Unzip an extension to the current directory

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

if err := crx3.Extension("/path/to/ext.zip").Unzip(); err != nil {
    panic(err)
}
```

```shell script
crx3 unzip /path/to/ext.zip [-o /custom/path]
```

#### Gen ID

##### Generate extension id (like dgmchnekcpklnjppdmmjlgpmpohmpmgp)

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

id, err := crx3.Extension("/path/to/ext.crx").ID()
if err != nil {
    panic(err)
}
```

```shell script
crx3 id /path/to/ext.crx
```

#### IsDir, IsZip, IsCRX3

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

crx3.Extension("/path/to/ext.zip").IsZip()
crx3.Extension("/path/to/ext").IsDir()
crx3.Extension("/path/to/ext.crx").IsCRX3()
```

#### NewPrivateKey, LoadPrivateKey, SavePrivateKey

```go
import crx3 "github.com/joelvaneenwyk/get-web-extension-crx3-golang"

pk, err := crx3.NewPrivateKey()
if err != nil {
    panic(err)
}
if err := crx3.SavePrivateKey("/path/to/key.pem", pk); err != nil {
    panic(err)
}
pk, err = crx3.LoadPrivateKey("/path/to/key.pem")
```

#### Keygen

```shell script
crx3 keygen /path/to/key.pem
```

## License

go-crx3 is released under the Apache 2.0 license. See [LICENSE.txt](https://github.com/joelvaneenwyk/get-web-extension-crx3-golang/blob/master/LICENSE)
