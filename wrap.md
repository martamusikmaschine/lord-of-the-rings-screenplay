# [Wrap](https://github.com/eprovst/wrap)

You need to download and install [Courier Prime](https://quoteunquoteapps.com/courierprime/).

This does not work:

`go get -u github.com/Wraparound/wrap/cmd/wrap`

Neither does this:

`go install github.com/Wraparound/wrap/cmd/wrap@latest`

This should work out of the box:

`snap install wrap`

This works fine:

```
git clone https://github.com/eprovst/wrap.git
cd wrap
go mod download
go install ./cmd/wrap/main.go
```

The executable is likely located in `$HOME/go/bin`

`wrap version`
