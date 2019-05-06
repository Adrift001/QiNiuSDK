# QiNiuSDK

生成七牛上传凭证

## 安装

```
dependencies: [
    .package(url: "https://github.com/Adrift001/QiNiuSDK.git", from: "0.0.1")
]
```

## 使用 

```
let auth = Auth.create(accessKey: "d05f31DhWMuCdnqYLmEHOxxxxx4rQ5dpnPJGB4F", secretKey: "q6l7YgfxOAVGSR8U5_DwButyC5133_urgBGyjIHt")
let token = auth.uploadToken(bucket: "picture")
print(token)
```

## 详细操作

请参考 [Java SDK
](https://developer.qiniu.com/kodo/sdk/1239/java#pfop-uptoken) ,没有服务器直传部分的功能.