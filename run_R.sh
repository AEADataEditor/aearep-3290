#!/bin/bash
IMG=larsvilhuber/aearep-3290-github:2022-06-10

docker run -it --rm --entrypoint /bin/bash \
	-v $(pwd):/home/rstudio \
	-w /home/rstudio \
	$IMG  ./run
