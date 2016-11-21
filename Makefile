local: storage.bs
	bikeshed

remote: storage.bs
	curl https://api.csswg.org/bikeshed/ -f -F file=@storage.bs > storage.html
