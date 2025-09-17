# Docker Loxya

Loxya container
[https://github.com/Loxya/Loxya](https://github.com/Loxya/Loxya)

## Examples

### Docker run

```sh
docker run -p 80:80 \
    -v /yourLocalLoxyaDataFolder/settings.json:/var/www/html/src/App/Config/settings.json \
    -v /yourLocalLoxyaDataFolder/data:/var/www/html/data \
    routmoute/loxya
```

### Docker-compose

```yaml
services:
  loxya:
    image: routmoute/loxya
    volumes:
      - ./settings.json:/var/www/html/src/App/Config/settings.json
      - ./data:/var/www/html/data
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
      - ./database:/var/lib/mysql
    environment:
      MARIADB_DATABASE: loxya
      MARIADB_USER: loxya
      MARIADB_PASSWORD: mysqlPassword
      MARIADB_RANDOM_ROOT_PASSWORD: 1
      MARIADB_AUTO_UPGRADE: 1
  loxya:
    image: routmoute/loxya
    depends_on:
      - database
    volumes:
      - ./settings.json:/var/www/html/src/App/Config/settings.json
      - ./data:/var/www/html/data
    ports:
      - 80:80
```
