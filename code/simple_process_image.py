import nibabel as nib
import sys

img_t1 = nib.load(sys.argv[1])
print(img_t1.shape)
