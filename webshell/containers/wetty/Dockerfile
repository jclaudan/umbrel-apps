FROM node:current-alpine as base

# Install build dependencies
RUN apk add --no-cache build-base python3

# Define environment variables for pnpm
ENV PNPM_HOME="/root/.pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Enable Corepack to manage package installations and install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Set the working directory for the container
WORKDIR /usr/src/app

# Copy the application files into the container
COPY . .

# Install production dependencies
FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/root/.pnpm pnpm install --prod --frozen-lockfile

# Build the application
FROM base AS build
RUN --mount=type=cache,id=pnpm,target=/root/.pnpm pnpm install --frozen-lockfile
RUN pnpm run build

# Prepare the final image with just the runtime dependencies and built code
FROM node:current-alpine
LABEL maintainer="butlerx@notthe.cloud"

# Set the working directory for the container
WORKDIR /usr/src/app

# Set the environment to production
ENV NODE_ENV=production

# Copy the production node_modules and build directories from the intermediate stages
COPY --from=prod-deps /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/build ./build

# Copy package.json (and other necessary files like package-lock.json if present)
COPY package.json ./

# Install runtime dependencies
RUN apk add --no-cache coreutils openssh-client sshpass && \
    mkdir -p ~/.ssh

# Expose the port that the application listens on
EXPOSE 8000

# Start the application
CMD [ "pnpm", "start" ]
