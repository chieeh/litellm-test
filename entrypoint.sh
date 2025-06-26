#!/bin/sh

if [ -n "$LICENSE_URL" ]; then
    # 查找所有 litellm_license.py 文件
    find / -type f -name "litellm_license.py" 2>/dev/null | while read -r file; do
        echo "Found license file: $file"
        # 替换URL
        sed -i "s|https://license.litellm.ai|${LICENSE_URL}|g" "$file"
        echo "Updated license URL in $file"
    done
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
