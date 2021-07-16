# TODO: make this runnable from anywhere
set -e

# ! There's gotta be a better way to do this
source ../.env || true  # ignore this error if source file not present

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -i | --input)
        SRC_FOLDER="$2"
        shift
        shift
        ;;
    -o | --output)
        DST_FOLDER="$2"
        shift
        shift
        ;;
    -s | --skip)
        SKIP="$2"
        shift
        shift
        ;;
    -e | --ensemble)
        USE_ENSEMBLE="$2"
        shift
        shift
        ;;
    *) # Gather unknown arguments
        POSITIONAL+=("$1")
        shift
        ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [ "${USE_ENSEMBLE}" == "y" ]; then
    WEIGHTS="weights/IMSC/last_95_448_32_aug2.pt weights/IMSC/last_95_640_16.pt weights/IMSC/last_120_640_32_aug2.pt weights/IMSC/last_100_100_640_16.pt"
else
    WEIGHTS="weights/IMSC/last_95.pt"
fi

# INFERENCE_*_FOLDER are optionally defined in .env
if [ -r ${SRC_FOLDER+x} ]; then
    SRC_FOLDER=$ORIGINAL_FRAMES_FOLDER
fi
if [ -r ${DST_FOLDER+x} ]; then
    DST_FOLDER=$PREDICTION_FRAMES_FOLDER
fi

python3 detect.py \
    --weights ${WEIGHTS} \
    --img-size 640 \
    --source ${SRC_FOLDER} \
    --output ${DST_FOLDER} \
    --conf-thres 0.20 \
    --iou-thres 0.9999 \
    --agnostic-nms \
    --augment \
    --device 0
