# ================================
# Build image
# ================================
FROM registry.gitlab.com/finestructure/spi-base:0.6.0 as build
WORKDIR /build

# First just resolve dependencies.
# This creates a cached layer that can be reused 
# as long as your Package.swift/Package.resolved
# files do not change.
COPY ./Package.* ./
RUN swift package resolve

# Copy entire repo into container
COPY . .

# Compile with optimizations
RUN swift build \
    --enable-test-discovery \
    -c release \
    -Xswiftc -g

# ================================
# Run image
# ================================
# we need a special base image so that we can run `swift dump-package`
FROM registry.gitlab.com/finestructure/spi-base:0.6.0

WORKDIR /run

# Copy build artifacts
COPY --from=build /build/.build/release /run
# Copy Swift runtime libraries
COPY --from=build /usr/lib/swift/ /usr/lib/swift/
# Copy static resources
COPY --from=build /build/Public /run/Public
COPY --from=build /build/Resources /run/Resources

ENTRYPOINT ["./Run"]
CMD ["serve", "--env", "production", "--hostname", "0.0.0.0"]
