
# Step 1: Build React App
FROM node:18-slim as build
WORKDIR /app
# Copy only package.json and lock file for dependency installation
COPY package.json package-lock.json* ./

# Set NODE_OPTIONS to increase memory limit
ENV NODE_OPTIONS="--max-old-space-size=2048"

RUN npm install
COPY . .
RUN npm run build

# Step 2: Server With Nginx

# FROM nginx:1.23-alpine
# COPY --from=build /app/build /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]

