sigla:
  image: docker.si.cnr.it/##{CONTAINER_ID}##
  mem_limit: 512m
  labels:
  - SERVICE_NAME=##{SERVICE_NAME}##
  environment:
  - SERVICE_TAGS=webapp
  - SERVICE_NAME=##{SERVICE_NAME}##
