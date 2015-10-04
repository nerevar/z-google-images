NAME=$(shell basename $(CURDIR))
RELEASE_DIR=release/
BROWSER=/Applications/Yandex.app/Contents/MacOS/Yandex
GIT_REPO=git@github.com:nerevar/z-google-images.git

VERSION:=$(shell cat manifest.json | awk -F '[" .]' '/"version"/ { print $$9"."$$10"."$$11+1}')

.PHONY: test release clean inc

test::
	@echo $(VERSION)

clean:
	-rm -rf $(RELEASE_DIR)

inc:
	sed -i .back -E 's/"([0-9]\.){2}[0-9]{1,2}"/"$(VERSION)"/g' manifest.json
	rm -rf *.back
	git commit -a -m 'manifest version: $(VERSION)'
	git push

release:: inc clean
	$(BROWSER) --pack-extension=$(CURDIR) --pack-extension-key=$(realpath ../)/z-google-images.pem
	git clone -b releases $(GIT_REPO) $(RELEASE_DIR)
	cp ../$(NAME).crx $(RELEASE_DIR)versions/$(NAME).latest.crx
	cp ../$(NAME).crx $(RELEASE_DIR)versions/$(NAME).$(VERSION).crx
	cd $(RELEASE_DIR) && sed -i .back -E 's/([0-9]\.){2}[0-9]{1,2}/$(VERSION)/g' update_manifest.xml
	cd $(RELEASE_DIR) && rm -rf *.back
	cd $(RELEASE_DIR) && git add .
	cd $(RELEASE_DIR) && git commit -a -m 'release $(VERSION)' && git push
