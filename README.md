# QiNiuSDK

![Swift](https://github.com/Adrift001/QiNiuSDK/workflows/Swift/badge.svg?branch=master)

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
