FROM ghcr.io/berriai/litellm-non_root:main-stable
USER root
COPY entrypoint.sh /docker/entrypoint.sh
RUN chmod +x /docker/entrypoint.sh
RUN mkdir -p /.cache && chmod -R 777 /.cache
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["--port", "4000"]