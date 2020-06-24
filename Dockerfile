FROM alpine:latest

LABEL "com.github.actions.name"="clang-format C/C++ Check"
LABEL "com.github.actions.description"="Run clang-format style check for C programs."
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/luis-nogoseke/github-action-clang-format.git"
LABEL "homepage"="https://github.com/luis-nogoseke/github-action-clang-format"
LABEL "maintainer"="jidicula <johanan.idicula@mail.mcgill.ca>"

# Install clang-format
RUN apk --no-cache add clang

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]