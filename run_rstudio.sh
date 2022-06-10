#!/bin/bash
baseURL=http://localhost:8787
openURL=${baseURL}

docker run --rm -p 8787:8787 -v $(pwd):/home/rstudio -e DISABLE_AUTH=true rocker/verse
