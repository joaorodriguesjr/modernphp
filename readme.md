# PHP Modern Development
Basic configuration to work with php using modern development tools.

## Execute development build:
```bash
docker-compose --file docker-compose.development.yml build
```

## Deploy in Docker Swarm:
```bash
docker run --rm -v $(pwd)/application:/app composer:1.10.8 composer install
docker stack deploy --compose-file docker-compose.development.yml modernphp
```

## Run the code checking:
```bash
docker run --rm -v $(pwd)/application:/app composer:1.10.8 composer check
```
