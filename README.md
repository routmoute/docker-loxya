# Docker Robert2

Robert2 / Loxya container

## Examples

### Docker run

```sh
docker run -p 80:80 \
    routmoute/robert2
```

### Docker-compose

```yaml
services:
  loxya:
    image: routmoute/robert2
    volumes:
    ports:
      - 80:80
```

### Docker-compose with mariadb

With this docker compose, the database server is `database` on port `3306`.

```yaml
services:
  database:
    image: mariadb
    volumes:
      - ./loxya_database:/var/lib/mysql
    environment:
      MARIADB_DATABASE: loxya
      MARIADB_USER: loxya
      MARIADB_PASSWORD: mysqlPassword
      MARIADB_RANDOM_ROOT_PASSWORD: 1
      MARIADB_AUTO_UPGRADE: 1
  loxya:
    image: routmoute/robert2
    depends_on:
      - database
    volumes:
      - ./settings.json:/var/www/html/src/App/Config/settings.json
      - ./data:/var/www/html/data
    ports:
      - 80:80
```
