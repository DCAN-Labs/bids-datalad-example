module load fsl

nifti_file_path=$1
transformed_path="${nifti_file_path::-7}_transformed.nii.gz"
fslmaths ${nifti_file_path} -add 2 $transformed_path
