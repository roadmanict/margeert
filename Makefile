.PHONY: update-submodules publish

S3_BUCKET=`cat ./s3-bucket`
DIFF_TEMPLATE_FILE=diff-template.patch

update-submodules:
	git submodule update --remote --merge

publish:
	rm -rf ./public/
	hugo --minify --environment production
	aws s3 sync ./public s3://${S3_BUCKET}

diff-template:
	rm ${DIFF_TEMPLATE_FILE}
	diff -ru -x .git -x .idea . ../hugo-template/ > ${DIFF_TEMPLATE_FILE}