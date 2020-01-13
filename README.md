# QiNiuSDK

生成七牛上传凭证

## 安装

```
dependencies: [
    .package(url: "https://github.com/Adrift001/QiNiuSDK.git", from: "0.0.3")
]
```

```
targets: [
    .target(name: "App", dependencies: ["QiNiuSDK"]),
]
```

## 使用 

```
let auth = Auth.create(accessKey: "xxx", secretKey: "xxx")
let token = auth.uploadToken(bucket: "xxx")
print(token)
```

## 详细操作

具体操作参考 `BucketTests.swift`

> 注意: 没有服务器直传部分的功能.