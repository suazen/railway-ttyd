# 使用 Nginx 作为基础镜像
FROM nginx:latest

# 安装 ttyd 和 nginx
RUN apk add --no-cache ttyd nginx

# 将 ttyd 添加到 PATH 环境变量中
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${PATH}"

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
