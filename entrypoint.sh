#!/bin/sh

if [ -n "$LICENSE_URL" ]; then
    file="/app/litellm/proxy/auth/litellm_license.py"
    [ -f "$file" ] && sed -i "s|https://license.litellm.ai|${LICENSE_URL}|g" "$file"
fi

if [ -n "$MODEL_CONFIG_URL" ]; then
    wget -O /app/litellm/proxy/model_config.yaml "$MODEL_CONFIG_URL"
fi

if [ "$USE_DDTRACE" = "true" ]; then
    export DD_TRACE_OPENAI_ENABLED="False"
    exec ddtrace-run litellm "$@"
else
    exec litellm "$@"
fi