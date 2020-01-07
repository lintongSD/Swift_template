#### 项目架构

项目用到了 MVC 的设计模式

语言以 ```Swift5.0```为主

项目中尽量使用```Swift```语言相关三方库, 使代码同步主流技术方便以后版本的更新迭代

模块化技术

网络层:

1.采用第三方库```Alamofire```网络交互,对其进行了二次封装

2.数据传递采用```Router(路由机制)```

3.数据持久化存储:
采用```UserDefaults```, 对其进行二次封装

4.通知:
采用```Notification```, 对其进行二次封装

```NotificationTool```中的通知名, 只允许传入```NotificationKey```指定字符串, 不允许随意添加通知相关字段, 用来规范整个项目中的通知逻辑


项目整体按照功能进行分块

图片资源: Assets.xcassets (系统)

Classes:

1. ```config```: 接口相关配置相关文件

2. ```components```: 通用组件

3. ```modules```: 项目整体框架

4. ```base```: 相关基础类


#### 项目结构

```     
├── config  配置类
│   ├── ApiConfig   接口配置
│   ├── PRD 生产环境域名配置
│   ├── DEV 测试环境域名配置
│   └── ApiPath 接口相关路径
├── components  通用组件
│   ├── scan    二维码扫描
│   ├── tools   工具类
│   ├── extension   扩展类
│   ├── model   启动模型类
│   └── view    app启动相关类
├── modules  项目结构
│   ├── home    主页
│   ├── left    第二控制器
│   ├── right   第三控制器
│   └── mine    个人中心页
├── base  基类
│   ├── Controller
│   ├── Model
│   └── View
├── AppDelegate  app代理
├── AppdelegateConfig   app相关配置
└── project-Bridging-Header 桥接文件

```
