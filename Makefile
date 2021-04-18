.PHONY: update-submodules publish

update-submodules:
	git submodule update --remote --merge

publish:
	rm -rf ./public/
	hugo --minify --environment production
	aws s3 sync ./public s3://s3-bucket
