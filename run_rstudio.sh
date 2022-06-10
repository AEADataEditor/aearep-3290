#!/bin/bash
IMG=larsvilhuber/aearep-3290-github:2022-06-10

docker run --rm -p 8787:8787 -v $(pwd):/home/rstudio -e DISABLE_AUTH=true $IMG
