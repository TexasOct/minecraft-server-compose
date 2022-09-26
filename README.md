## 简介
便捷的 minecraft dockercompose 部署工具，主要针对模组服。

结构如下
```shell
.
├── depends
│   ├── build.sh
│   └── farbic.jar # 如为 forge 加载器则命名为 forge.jar
├── docker-compose.yml #以已映射 mcrcon 端口，且为方便构建，请填写代理 
├── Dockerfile-server 
├── README.md
└── server.properties # 服务器初始参数
```

## 使用
直接启动容器
```shell
docker compose up -d
```
