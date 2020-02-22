# 框架

## beego

### 安装

```
go get -u -v github.com/astaxie/beego  //针对源码
go get -u -v github.com/beego/bee      //工具集

检查是否安装成功：bee version
```

### go环境变量查看

```
⇒  go env
GO111MODULE=""
GOARCH="amd64"
GOBIN=""
GOCACHE="/Users/kaiqigu/Library/Caches/go-build"
GOENV="/Users/kaiqigu/Library/Application Support/go/env"
GOEXE=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="darwin"
GONOPROXY=""
GONOSUMDB=""
GOOS="darwin"
GOPATH="/Users/kaiqigu/go"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/Cellar/go/1.13.4/libexec"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/Cellar/go/1.13.4/libexec/pkg/tool/darwin_amd64"
GCCGO="gccgo"
AR="ar"
CC="clang"
CXX="clang++"
CGO_ENABLED="1"
GOMOD=""
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/var/folders/kj/qsbtsy7d1rj66hqqd5p55c1c0000gn/T/go-build930090413=/tmp/go-build -gno-record-gcc-switches -fno-common"
```

```
GOROOT：
golang安装路径，无需设置。

GOPATH：
golang中最重要的一个变量，是项目的工作空间。
GOPATH下会有3个目录：src、bin、pkg。
src目录：go编译时查找代码的地方；
bin目录：go get这种bin工具的时候，二进制文件下载的目的地；
pkg目录：编译生成的lib文件存储的地方。

GOBIN：
go install编译存放路径。可以为空。为空时可执行文件放在各自GOPATH目录的bin文件夹中。
如果GOBIN为空最好将GOPATH的bin目录添加到环境变量PATH中，以便在shell直接运行可执行文件名。
```

### 系统环境变量相关命令

```
查看环境变量：env
添加环境变量：export x_name=x_value
删除环境变量：export x_name
```

### 创建及运行

```
创建：
bee new projectName

运行：
进入到src下对应的项目中；
bee run
```

```
注释：bee new xxx报错解决方案

kaiqigu@localhost:~/go/src|⇒  bee new UserAbout
2020/02/19 16:02:45 ERROR    ▶ 0001 You need to set GOPATH environment variable
______
| ___ \
| |_/ /  ___   ___
| ___ \ / _ \ / _ \
| |_/ /|  __/|  __/
\____/  \___| \___| v1.10.0
2020/02/19 16:02:45 FATAL    ▶ 0002 GOPATH environment variable is not set or empty
kaiqigu@localhost:~/go/src|⇒  export GOPATH=/Users/kaiqigu/go
```


### go build和go run的区别

```
go build：把go的源文件编译并且和它所依赖的包打包成可执行文件。
go run：也要进行编译，但是不打包。

go run运行go源文件要比go build 打包正的可执行文件之后再运行要慢一些，所以在生产环境上我们其实是要求打包成exe。
go build打包后的包要比go源文件大好多，其实是因为打包依赖了其他的文件。
```


### beego项目文件结构

```
在 $GOPATH/src的目录下执行bee new <appname>，会在当前目录下生成以下文件：
myproject
├── conf
│   └── app.conf
├── controllers
│   └── default.go
├── main.go
├── models
├── routers
│   └── router.go
├── static
│   ├── css
│   ├── img
│   └── js
├── tests
│   └── default_test.go
└── views
    └── index.tpl
```

