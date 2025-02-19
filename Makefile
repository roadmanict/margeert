.PHONY: init-submodules update-submodules publish diff-template

include .env

DIFF_TEMPLATE_FILE=diff-template.patch

init-submodules:
	git submodule init

update-submodules:
	git submodule update --remote --merge

serve:
	hugo server

dist:
	rm -rf ./public/
	hugo --minify --environment production

publish: dist
	export $(shell sed 's/=.*//' .env)
	aws s3 sync ./public s3://${S3_BUCKET_NAME} --delete

diff-template:
	rm ${DIFF_TEMPLATE_FILE}
	diff -ru -x .git -x .idea . ../hugo-template/ > ${DIFF_TEMPLATE_FILE}