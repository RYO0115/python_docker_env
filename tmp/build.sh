BUILD_IMAGE_NAME="tensor_flow_test"
MOUNT_WORKSPACE="./workspace"
TARGET_WORKSPACE=/workspace/src

docker run --name ${BUILD_IMAGE_NAME} -it --rm type=bind,source=${MOUNT_WORKSPACE}