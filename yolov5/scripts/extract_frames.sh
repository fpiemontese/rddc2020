set -e

# Gather command line arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -i | --input)
        VIDEO_SOURCE="$2"
        shift
        shift
        ;;
    -o | --output)
        FRAMES_DESTINATION="$2"
        shift
        shift
        ;;
    -s | --skip)
        SKIP="$2"
        shift
        shift
        ;;
    *) # Gather unknown arguments
        POSITIONAL+=("$1")
        shift
        ;;
    esac
done

if [ -z ${VIDEO_SOURCE} ]; then
    echo "Source path missing"
    exit 1
fi

if [ -z ${FRAMES_DESTINATION} ]; then
    echo "Destination folder missing"
    exit 1
fi

if [ -z ${SKIP} ]; then
    SKIP=1
fi

# Extract every SKIP-th frame in high quality JPEG format
ffmpeg \
    -i ${VIDEO_SOURCE} \
    -vf "select=not(mod(n\,${SKIP}))" \
    -vsync vfr \
    -qscale:v 2 \
    "${FRAMES_DESTINATION}/%06d.jpg"
