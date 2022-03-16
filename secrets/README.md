# Secrets (Authelia)

This directory and it's contents must all be:
1. readable/writable by the system only
2. owned by root

So on the server this project is deployed to:

```shell
chmod 600 secrets/
chown root:root secrets/
```

## Files

* authelia_jwt_secret
