local: storage.bs
	bikeshed spec storage.bs storage.html --md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"

remote: storage.bs
	curl https://api.csswg.org/bikeshed/ -f -F file=@storage.bs > storage.html -F md-Text-Macro="SNAPSHOT-LINK LOCAL COPY"

deploy: storage.bs
	curl --remote-name --fail https://resources.whatwg.org/build/deploy.sh && bash ./deploy.sh
