# Steps

## Startup

```bash
docker build -t decidim:latest .
docker run -it --rm -p 3000:3000 decidim:latest
```

## To get a console

```bash
docker exec -it $(docker ps | grep "decidim:latest" | awk '{print $1}') /bin/bash
```

## Browser

Navigate to `http://localhost:3000/system` to create an organization (see `seeds.rb` for the username and password).

Here are the settings:

![screenshots/settings.png](screenshots/settings.png)

After creating the organization, go to `http://localhost:3000` to get the homepage.

![screenshots/homepage.png](screenshots/homepage.png)

