FROM ubuntu:20.04

# Set the path to the repo root folder
# I set /home because I'm working within a Docker container
ARG BASEDIR=/home

# The name of the folder generated when untarring PJSIP sources file
# In general, the name corresponds to that of the tar, except the file extension
ARG PJSIP_DIR_NAME="pjproject"

# TOOLS AND LIBRARIES DOWNLOAD DIRECTORY
ENV DOWNLOAD_DIR="$BASEDIR/tools"

ENV PJSIP_BASE_PATH="${DOWNLOAD_DIR}/${PJSIP_DIR_NAME}"

# BUILD DIRECTORY WHERE ALL THE BUILD ARTIFACTS WILL BE
ENV BUILD_DIR="$BASEDIR/output"

# The output directory where to store PJSIP compiled libraries
ENV PJSIP_BUILD_OUT_PATH="$BUILD_DIR/pjsip-build-output"

WORKDIR $BASEDIR
COPY . $BASEDIR

RUN ./prepare-build-system

VOLUME ["$PJSIP_BUILD_OUT_PATH", "$PJSIP_BASE_PATH"]
