import cv2
import sys


if len(sys.argv) != 3:
    print("usage: grey2color.py input output")
    sys.exit(1)

inp = cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE)
inp *= 3
out = cv2.applyColorMap(inp, cv2.COLORMAP_JET)

cv2.imwrite(sys.argv[2], out)
