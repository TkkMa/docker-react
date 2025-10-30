# build folder will be located in /app/build
FROM node:25-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# Run phase
FROM nginx
# copy /app/build from the builder phase to /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
# no RUN command, it starts by default