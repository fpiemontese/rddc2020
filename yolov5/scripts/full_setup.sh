set -e

# Ensure script can be run from any directory
INITIAL_DIR=$PWD
SCRIPT_DIR=$(dirname "$0")
cd $SCRIPT_DIR/..  # go to yolov5

# Install requirements
pip3 install -r requirements.txt

# Download training and test dataset
# TODO: make this optional
bash scripts/dataset_setup_for_yolov5.sh

# Download ultralytics weights
bash weights/download_weights.sh

# Download IMSC weights
bash scripts/download_IMSC_grddc2020_weights.sh

# Return to calling directory
cd ${INITIAL_DIR}
