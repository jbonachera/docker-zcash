all: docker
docker:
	docker build  -t jbonachera/zcash  .
