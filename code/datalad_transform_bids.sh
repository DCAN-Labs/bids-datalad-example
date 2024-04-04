module purge
module load datalad/0.19.6

bids_dir=$1
transformation_shell_script=$2

cd $bids_dir || exit
for sub_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
do
  if [ "${sub_dir:2:1}" != "." ]; then
    sub_name=${sub_dir:2:10}
    cd "${bids_dir}/${sub_name}"
    for session_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
    do
      if [ "${session_dir:0:3}" != "./." ]; then
        session_name=${session_dir:0-7}
        cd "${bids_dir}/${sub_name}/${session_name}/anat"
        # Make a transformation
        for nifti_file in $(find -L . -mindepth 1 -maxdepth 1 -xtype l)
          do
          nifti_file=${nifti_file:2}
          extension=${nifti_file: -7}
            if [ "${extension}" = ".nii.gz" ]; then
              nifti_path="${bids_dir}/${sub_name}/${session_name}/anat/$nifti_file"
              $transformation_shell_script $nifti_path
            fi
          done
        cd "../.."
      fi
      datalad save -m "Adding session data: ${sub_name}:${session_name}."
      datalad status
    done
    cd "../$sub_dir" || exit
    datalad save -m "Saving subject project: ${sub_name}."
    datalad status
  fi
done
cd $bids_dir || exit
datalad save -m "Saving repo project."
datalad status
