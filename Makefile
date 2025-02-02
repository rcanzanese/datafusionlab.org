# targets that aren't filenames
.PHONY: all clean deploy build serve

all: build


build:
	jekyll build

# you can configure these at the shell, e.g.:
# SERVE_PORT=5001 make serve
SERVE_HOST ?= 127.0.0.1
SERVE_PORT ?= 5000

serve:
	jekyll serve --port $(SERVE_PORT) --host $(SERVE_HOST)

clean:
	$(RM) -r _site

DEPLOY_BUCKET ?= datafusionlab.org
DEPLOY_PATH ?= /
RSYNC := aws s3 sync

deploy: clean build
	$(RSYNC) _site/ s3://$(DEPLOY_BUCKET)$(DEPLOY_PATH)
