set -e

# ! There's gotta be a better way to do this
source ../.env || true # ignore this error if source file not present

POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -i | --input)
        FRAMES_DIR="$2"
        shift
        shift
        ;;
    -o | --output)
        VIDEO_PATH="$2"
        shift
        shift
        ;;
    -f | --fps)
        FPS="$2"
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

# INFERENCE_*_FOLDER vars are optionally defined in .env
if [ -r ${FRAMES_DIR+x} ]; then
    FRAMES_DIR=$PREDICTION_FRAMES_FOLDER
fi
if [ -r ${VIDEO_PATH+x} ]; then
    VIDEO_PATH=$PREDICTION_VIDEO_PATH
fi
if [ -r ${FPS+x} ]; then
    FPS=24
fi

ffmpeg \
    -y \
    -framerate ${FPS} \
    -i ${FRAMES_DIR}/%06d.jpg \
    ${VIDEO_PATH}
