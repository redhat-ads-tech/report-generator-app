FROM registry.access.redhat.com/ubi8/openjdk-8-runtime:1.21
COPY target/*.jar /deployments/app.jar
ARG COMMIT_SHA="unknown"
ARG COMMIT_MSG=""
RUN printf '{"sha":"%s","message":"%s","date":"%s"}' \
      "${COMMIT_SHA}" "${COMMIT_MSG}" "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
      > /deployments/revision.json
ENV SPRING_WEB_RESOURCES_STATIC_LOCATIONS="classpath:/static/,file:/deployments/"
