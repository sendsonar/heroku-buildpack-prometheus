# Prometheus Heroku Buildpack

This [Heroku buildpack][1] installs Prometheus in your Heroku dyno to collect app metrics.

## Configuration

This buildpack assumes that prometheus config file is located at `/prometheus/config.yml` in your application.

In addition, you can include a prerun script, `/prometheus/prerun.sh`, in your application. 
The prerun script runs after all of the standard configuration actions and immediately before starting Prometheus. 
This allows you to modify the environment variables (for example: $DISABLE_PROMETHEUS), perform additional configurations, etc.

```shell
#!/usr/bin/env bash

# Disable based on dyno type
if [ "$DYNOTYPE" == "run" ]; then
  $DISABLE_PROMETHEUS="true"
fi

# Update configuration placeholder using the Heroku application environment variable
if [ -n "$PROMETHEUS_URL" ]; then
  sed -i "s/<URL>/$PROMETHEUS_URL/" "$APP_PROMETHEUS/config.yml"
fi
```

[1]: https://devcenter.heroku.com/articles/buildpacks
