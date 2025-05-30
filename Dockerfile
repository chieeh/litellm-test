FROM ghcr.io/berriai/litellm:main-stable
COPY entrypoint.sh /docker/entrypoint.sh
RUN chmod +x /docker/entrypoint.sh
RUN mkdir -p /.cache && chmod -R 777 /.cache
ENTRYPOINT ["/docker/entrypoint.sh"]
CMD ["--port", "4000"]