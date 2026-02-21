# ---- Stage 1: Build ---- сборка бинарника
FROM golang:1.26.0-alpine AS builder

WORKDIR /build
COPY habits-tracker/ .

RUN if [ ! -f go.mod ]; then \
    go mod init habit-tracker; \
    fi

RUN go mod tidy

RUN CGO_ENABLED=0 go build -o /app/server ./cmd/server/main.go

# ---- Stage 2: Final ---- чистая сборка без зависимостей и компилятора
FROM alpine:3.23.3

RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup

COPY --from=builder /app/server /server
COPY --from=builder /build/internal/templates /internal/templates

RUN chmod +x /server && \
    chown -R appuser:appgroup /internal/templates
    
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

EXPOSE 8080
CMD ["/server"]