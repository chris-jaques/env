#!/bin/sh
#
# Google Translation API
#
#

# Translate Shell image from Docker Hub
export ENV_DOCKER_IMAGE_TRANSLATE_SHELL='soimort/translate-shell:latest'

# Translate Shell { fromLang?:toLang? } { ...text }
trans(){
    lang=${1}
    text=${@:2}
    docker run --rm -it $ENV_DOCKER_IMAGE_TRANSLATE_SHELL $lang "$text"
}

# Translate Chinese to English
alias t='trans zh:en'

# Translate to Chinese (simplified)
alias z='trans :zh'

# Translate to Chinese (traditional)
alias zt='trans :zh-TW'