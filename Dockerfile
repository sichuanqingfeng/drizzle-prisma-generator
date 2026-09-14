FROM node:20-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm install -g pnpm

RUN npm config set registry https://registry.npmmirror.com

WORKDIR /app

FROM base AS prod-deps
COPY . /app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile
RUN pnpm exec prisma generate

FROM base AS builder
COPY . /app
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm exec prisma generate
RUN pnpm run build

FROM base
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=builder /app/dist/ /app/dist
COPY --from=builder /app/prisma/ /app/prisma
COPY --from=builder /app/package.json /app
COPY --from=builder /app/pnpm-lock.yaml /app
COPY --from=builder /app/nest-cli.json /app

ENV TZ=Asia/Shanghai

EXPOSE 3080

CMD ["node", "dist/main.js"]
