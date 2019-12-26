FROM node:alpine as builder #builder tag set so it can be refered to

WORKDIR '/app'

COPY package.json .
RUN npm install

# copy evrything in our frontend directory
COPY . .

RUN npm run build

# just copying over a portion of the builder phase to the nginx phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
