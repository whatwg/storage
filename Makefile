SHELL=/bin/bash -o pipefail
.PHONY: local remote deploy review

remote: storage.bs
	@ (HTTP_STATUS=$$(curl https://api.csswg.org/bikeshed/ \
	                       --output storage.html \
	                       --write-out "%{http_code}" \
	                       --header "Accept: text/plain, text/html" \
	                       -F die-on=warning \
	                       -F md-Text-Macro="COMMIT-SHA LOCAL COPY" \
	                       -F file=@storage.bs) && \
	[[ "$$HTTP_STATUS" -eq "200" ]]) || ( \
		echo ""; cat storage.html; echo ""; \
		rm -f storage.html; \
		exit 22 \
	);

local: storage.bs
	bikeshed spec storage.bs storage.html --md-Text-Macro="COMMIT-SHA LOCAL COPY"

deploy: storage.bs
	curl --remote-name --fail https://resources.whatwg.org/build/deploy.sh
	bash ./deploy.sh

review: storage.bs
	curl --remote-name --fail https://resources.whatwg.org/build/review.sh
	bash ./review.sh
