# Base stage for installing dependencies and building the app
FROM node:current-alpine as base

# Install build dependencies for native modules
RUN apk add --no-cache build-base python3

# Install pnpm
RUN corepack enable && npx pnpm i -g pnpm@latest

# Set environment variables for pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Copy application to container and install dependencies
WORKDIR /usr/src/app
COPY . .

# Install production dependencies only
FROM base as prod-deps
RUN pnpm install --prod --frozen-lockfile

# Build the application
FROM base as build
RUN pnpm install --frozen-lockfile && pnpm run build

# Final stage with runtime dependencies and application
FROM node:current-alpine

# Maintainer information
LABEL maintainer="butlerx@notthe.cloud"

# Set working directory for the application
WORKDIR /usr/src/app

# Set the environment to production
ENV NODE_ENV=production
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Copy over the production dependencies
COPY --from=prod-deps /usr/src/app/node_modules ./node_modules

# Copy over the built application
COPY --from=build /usr/src/app/build ./build

# Copy other necessary files like package.json
COPY package.json .

# Install runtime dependencies and tools, also install pnpm globally in the final image
RUN apk add --no-cache coreutils openssh-client sshpass && \
    mkdir ~/.ssh && \
    corepack enable && \
    npx pnpm i -g pnpm@latest

# Expose the port your app runs on
EXPOSE 8000

# Start the application
CMD ["pnpm", "start"]
