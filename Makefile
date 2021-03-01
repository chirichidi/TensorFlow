RUNTIME_DEV_TAG='tf'

update: \
	update-code-only \
	build

update-code-only:
	git reset --hard
	git pull

build: \
	runtime-build \

runtime-build:
	docker pull deeplearningzerotoall/tensorflow
	docker run -it \
	--name ${RUNTIME_DEV_TAG} \
	-v /data/app/TensorFlow:/workspace/TensorFlow \
	--workdir=/workspace/TensorFlow \
	-p 8888:8888 \
	-p 6006:6006 \
	deeplearningzerotoall/tensorflow \
	bash -c "pip install --upgrade pip && pip install -r requirements.txt && /bin/bash"

start:
	docker start ${RUNTIME_DEV_TAG}
	docker exec -it ${RUNTIME_DEV_TAG} jupyter notebook --ip 0.0.0.0 --allow-root

rm:
	docker rm ${RUNTIME_DEV_TAG}