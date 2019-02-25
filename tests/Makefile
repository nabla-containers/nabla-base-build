all: gotest/goapp.nabla curl/test_curl.nabla

gotest/goapp.nabla:
	make -C gotest

curl/test_curl.nabla:
	make -C curl

clean:
	make -C gotest clean
	make -C curl clean
