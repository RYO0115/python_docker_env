BUILD_IMAGE_NAME="tensor_flow_test"
BUILD_IMAGE_VERSION="latest"
MOUNT_WORKSPACE="./workspace"
TARGET_WORKSPACE=/workspace/src

docker container run -- name ${BUILD_IMAGE_NAME} #-it --rm type=bind,source=${MOUNT_WORKSPACE},target=${TARGET_WORKSPACE}
#docker container run ${BUILD_IMAGE_NAME}:${BUILD_IMAGE_VERSION} -it
