FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# The following expose command normally does nothing for us in dev, but aws elastic beanstalk uses is to expose the port on the container
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html