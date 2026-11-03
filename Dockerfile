# --- STAGE 1: Build environment ---
FROM clux/muslrust:latest AS builder

# Force Cargo to use the standard git CLI to fix the container network drop issue
ENV CARGO_NET_GIT_FETCH_WITH_CLI=true

# Fetch and compile the binary cleanly using muscle-targeted static compilation
RUN cargo install --git https://github.com/dcarrero/mboxshell.git

# --- STAGE 2: Ultra-lightweight runtime ---
FROM alpine:latest

# Bring over the compiled binary from the builder environment (muslrust binary path)
COPY --from=builder /opt/cargo/bin/mboxshell /usr/local/bin/mboxshell

# Create a standard non-root user (appuser) with UID/GID 1000 (standard for host users)
RUN addgroup -g 1000 appuser && \
    adduser -u 1000 -G appuser -D appuser

# Define configurations to point directly to our managed volume locations
ENV MBOXSHELL_CONFIG=/data/config.toml
ENV XDG_CACHE_HOME=/data/.cache
ENV HOME=/data

# Pre-create the directory frames and hand ownership over to the non-root user
RUN mkdir -p /data && chown -R appuser:appuser /data

# Define standard layouts inside the container
VOLUME ["/data"]

# Use appuser to run the TUI
USER appuser

# Boot inside the data directory
WORKDIR /data

# Make the app launch immediately upon container execution
ENTRYPOINT ["mboxshell"]
