docker run \
    -v "$PWD":/usr/src/app \
    -w /usr/src/app \
    -e JEKYLL_GITHUB_TOKEN="$JGT" \
    -p "4000:4000" starefossen/github-pages \
