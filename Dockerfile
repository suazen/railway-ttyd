# 使用 Node.js 14 作为基础镜像
FROM node:14

# 安装 ttyd 和 nginx
RUN apk update && \
    apk add ttyd nginx

# 将 ttyd 添加到 PATH 环境变量中
ENV PATH="/node_modules/.bin:${PATH}"

# 将 nginx 配置文件复制到容器中
COPY nginx.conf /etc/nginx/nginx.conf

# 将应用程序代码复制到容器中
COPY . /app

# 设置工作目录
WORKDIR /app

# 安装依赖项
RUN npm install

# 启动 ttyd 和 nginx
CMD ["bash", "-c", "ttyd bash & nginx -g 'daemon off;'"]
