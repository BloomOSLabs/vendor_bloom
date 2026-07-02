#!/bin/bash

PRODUCT_OUT="$1"
WIDTH="$2"
HEIGHT="$3"
HALF_RES="$4"

OUT="$PRODUCT_OUT/obj/BOOTANIMATION"

SOURCE_WIDTH=1080
SOURCE_HEIGHT=1920

if [ "$HEIGHT" -lt "$WIDTH" ]; then
    IMAGEWIDTH="$HEIGHT"
else
    IMAGEWIDTH="$WIDTH"
fi

if [ "$HALF_RES" = "true" ]; then
    IMAGEWIDTH=$(expr $IMAGEWIDTH / 2)
fi

IMAGEHEIGHT=$(expr $IMAGEWIDTH \* $SOURCE_HEIGHT / $SOURCE_WIDTH)

IMAGESCALEWIDTH="$IMAGEWIDTH"
IMAGESCALEHEIGHT="$IMAGEHEIGHT"

RESOLUTION="${IMAGEWIDTH}x${IMAGEHEIGHT}"

rm -rf "$OUT/bootanimation"
mkdir -p "$OUT/bootanimation"

for part_cnt in 0 1 2 3 4
do
    mkdir -p "$OUT/bootanimation/part$part_cnt"
done

tar xfp "vendor/bloom/bootanimation/bootanimation.tar" -C "$OUT/bootanimation/"

mogrify -resize "$RESOLUTION" -colors 250 "$OUT/bootanimation/"*"/"*".png"

echo "$IMAGESCALEWIDTH $IMAGESCALEHEIGHT 60" > "$OUT/bootanimation/desc.txt"
cat "vendor/bloom/bootanimation/desc.txt" >> "$OUT/bootanimation/desc.txt"

cd "$OUT/bootanimation"

zip -qr0 "$OUT/bootanimation.zip" .
