<div align=center>
  <img src="./lib/assets/icons/ios/AppIcon.appiconset/icon-1024.png" width="180"/>
</div>

![](https://img.shields.io/github/tag/icepy/flutter-dress.svg)
![](https://img.shields.io/jenkins/s/https/jenkins.qa.ubuntu.com/precise-desktop-amd64_default.svg)
![](https://img.shields.io/github/license/icepy/flutter-dress.svg)
![](https://img.shields.io/github/issues/icepy/flutter-dress.svg)
![](https://img.shields.io/github/repo-size/icepy/flutter-dress.svg)

Flutter Dress 是一个全新的 Flutter 工程，它利用 [komeiji-satori/Dress](https://github.com/komeiji-satori/Dress) 的女装资源实现了一个 iOS 和 Android 客户端应用程序，方便大家在手机设备上查阅。

请阅读 [应用设计文档](./doc/README.md)，重在参与。

请查阅 [应用完成进度表](./doc/progress.md)，把握时机。

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## 注意事项

由于 Github 对 API 调用的限制，未经授权验证的 API 调用被限制在60次/1H（授权验证之后的调用频率为5000次/1H），具体参考 [https://developer.github.com/v3/#rate-limiting](https://developer.github.com/v3/#rate-limiting) ，Flutter Dress 没有实现 Github 的授权验证，因此在使用的过程中注意刷新频率。
