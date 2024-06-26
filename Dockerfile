FROM node:18-alpine
LABEL author="tringuyennek"

ARG NEXT_PUBLIC_BASE_URL
ARG NEXT_PUBLIC_BASE_URL_V2
ARG NEXT_PUBLIC_API_URL
ARG NEXT_PUBLIC_URL
ARG NEXT_PUBLIC_CLOUD_NAME
ARG NEXT_PUBLIC_API_KEY
ARG NEXT_PUBLIC_API_SECRET
ARG NEXT_PUBLIC_UPLOAD_PRESET
ARG NEXT_PUBLIC_GOOGLE_GEMINI_API_KEY

ENV NEXT_PUBLIC_BASE_URL=$NEXT_PUBLIC_BASE_URL \
    NEXT_PUBLIC_BASE_URL_V2=$NEXT_PUBLIC_BASE_URL_V2 \
    NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL \
    NEXT_PUBLIC_URL=$NEXT_PUBLIC_URL \
    NEXT_PUBLIC_CLOUD_NAME=$NEXT_PUBLIC_CLOUD_NAME \
    NEXT_PUBLIC_API_KEY=$NEXT_PUBLIC_API_KEY \
    NEXT_PUBLIC_API_SECRET=$NEXT_PUBLIC_API_SECRET \
    NEXT_PUBLIC_UPLOAD_PRESET=$NEXT_PUBLIC_UPLOAD_PRESET \
    NEXT_PUBLIC_GOOGLE_GEMINI_API_KEY=$NEXT_PUBLIC_GOOGLE_GEMINI_API_KEY
    
WORKDIR /app

COPY package*.json yarn.lock ./
RUN apk add --no-cache git \
    && yarn install --frozen-lockfile \
    && yarn cache clean

COPY . .
RUN yarn build

EXPOSE 3005

CMD ["yarn", "start"]