FROM registry.access.redhat.com/ubi8/openjdk-8-runtime:1.21
COPY target/*.jar /deployments/app.jar
ARG COMMIT_SHA="unknown"
ARG COMMIT_MSG="local build"
ARG BUILD_DATE="unknown"
ENV REVISION_SHA="${COMMIT_SHA}" \
    REVISION_MSG="${COMMIT_MSG}" \
    REVISION_DATE="${BUILD_DATE}" \
    SPRING_WEB_RESOURCES_STATIC_LOCATIONS="classpath:/static/,file:/tmp/static/"
COPY --chmod=755 entrypoint.sh /deployments/entrypoint.sh
CMD ["/deployments/entrypoint.sh"]
