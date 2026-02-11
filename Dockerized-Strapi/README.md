# Dockerized Strapi Application

---

## 📌 Project Overview

This project demonstrates the complete containerization of a Strapi application using Docker with a multi-stage build approach. The goal of this implementation is to create a production-ready container image that is lightweight, efficient, and deployable across environments.

The application is built using Strapi (Headless CMS) and containerized using Docker to ensure environment consistency, portability, and scalability.

---

## 🚀 Objectives

- Containerize a Strapi application using Docker
- Implement a multi-stage Docker build
- Separate build and production environments
- Expose the application on port 1337
- Ensure production-ready configuration
- Maintain clean repository structure

---

## 🏗️ Project Structure

Dockerized-Strapi/
├── config/
├── public/
├── src/
├── .dockerignore
├── Dockerfile
├── package.json
├── package-lock.json
├── README.md
└── screenshots/

---

## 🐳 Docker Implementation Details

### Multi-Stage Build Strategy

This project uses a multi-stage Dockerfile to optimize the final image size and improve build performance.

### Stage 1: Builder Stage

- Uses Node 18 Alpine image
- Installs dependencies
- Builds Strapi admin panel
- Prepares production assets

### Stage 2: Production Stage

- Uses lightweight Node 18 Alpine
- Copies built artifacts from builder stage
- Sets environment to production
- Exposes port 1337
- Runs Strapi in production mode

---

## 📄 Dockerfile

```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:18-alpine
WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app ./

EXPOSE 1337

CMD ["npm", "run", "start"]
```

---

## 📦 .dockerignore

```
node_modules
.git
.gitignore
.env
Dockerfile
```

---

## 🔧 Build Instructions

```bash
docker build -t strapi-app .
```

---

## ▶ Run Instructions

```bash
docker run --env-file .env -p 1337:1337 strapi-app
```

---

## 🌐 Access Application

After running the container:

http://localhost:1337

---

## 🔐 Environment Variables

Example .env file:

```
APP_KEYS=key1,key2,key3,key4
API_TOKEN_SALT=your_salt
ADMIN_JWT_SECRET=your_admin_secret
SESSION_SECRET=your_session_secret
PORT=1337
```

---

## 🧠 Why Multi-Stage Build?

- Reduces final image size
- Removes unnecessary build dependencies
- Improves security posture
- Enhances deployment efficiency

---

## 📊 Docker Verification Commands

```bash
docker images
docker ps
```

---

## 🛡️ Production Considerations

- Use secure environment variables
- Implement proper database configuration
- Configure reverse proxy (NGINX) in production
- Enable logging and monitoring
- Apply CI/CD for automated deployments

---

## 📚 Technologies Used

- Node.js
- Strapi
- Docker
- Alpine Linux

---

## 🎯 Outcome

The Strapi application successfully runs inside a Docker container in production mode with optimized image size and clean repository structure. The application is accessible via port 1337 and is fully containerized for deployment.

---

## 📌 Conclusion

This project demonstrates practical DevOps skills including containerization, environment management, and production-ready backend deployment. The implementation follows industry best practices and ensures portability, consistency, and scalability across environments.


