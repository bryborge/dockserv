# Secrets (Authelia)

This directory and it's contents must all be:
1. readable/writable by the system only
2. owned by root

So on the server this project is deployed to:

```shell
chmod 600 secrets/
chown root:root secrets/
```

## Files in secrets/

* authelia_jwt_secret
* authelia_session_redis_password
* authelia_session_secret
* authelia_storage_encryption_key
* authelia_storage_postgres_password

## Setup

1. Create secrets files
2. Generate jwt secret and other secrets/passwords and put them in those files
3. Update appdata/authelia/configuration.yml and users.yml
4. Spin up the redis/postgres services with docker-compose up -d
5. After spin up, hop into the postgres container and add the database password
   you want to use:

   ```shell
   docker-compose exec postgres bash
   psql -U authelia
   ALTER ROLE authelia WITH PASSWORD '<my-password>';
   \q
   exit
   ```
6. Start (or restart) authelia
