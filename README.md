scumblr
=======

This is a [docker-compose](https://docs.docker.com/compose/) implementation for [Netflix's Scumblr](https://github.com/Netflix/Scumblr).

You'll simply just want:

```
docker-compose up
```

It will create four containers based on Ubuntu 14.04 LTS for:
- PostgreSQL
- Redis
- Scumblr (Rails)
- Sidekiq

The default login is `admin / admin`.
