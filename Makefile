all: docker-build docker-run

docker-build:
	docker build . -t svg-to-vector

docker-run:
	docker run --rm -it  -v $$(PWD)/mount/input:/mounts/input -v $$(PWD)/mount/output:/mounts/output svg-to-vector

clean:
	rm -rf mount/output/*.{svg,xml}