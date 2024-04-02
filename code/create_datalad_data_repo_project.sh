module purge
module load datalad/0.19.6

src_dir=$1
dest_dir=$2

# Create matching directory structure and create empty DataLad projects.
[[ -d $dest_dir ]] || (mkdir $dest_dir || exit)
cd $dest_dir
datalad create -c text2git || exit
cd $src_dir || exit
for sub_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
do
  sub_name=${sub_dir: -10}
  new_sub_dir="${dest_dir}/${sub_name}"
  [[ -d $new_sub_dir ]] || mkdir $new_sub_dir
  cd $new_sub_dir
  datalad create -c text2git || exit
  cd "${src_dir}/${sub_name}" || exit
  for session_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
      do
          session_name=${session_dir: -7}
          new_session_dir="${new_sub_dir}/${session_name}"
          [[ -d $new_session_dir ]] || mkdir $new_session_dir
          cd "${new_session_dir}" || exit
          datalad create -c text2git || exit
      done
done

# Create DataLad projects
cd $dest_dir || exit
for sub_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
do
  echo "sub_dir: $sub_dir"
  if [ "${sub_dir:2:1}" != "." ]; then
    sub_name=${sub_dir: -10}
    echo "sub_name: $sub_name"
    new_sub_dir="${dest_dir}/${sub_name}"
    cd "$new_sub_dir" || exit
    echo pwd
    for session_dir in $(find . -mindepth 1 -maxdepth 1 -type d)
    do
      echo "session_dir: ${session_dir}"
      if [ "${session_dir:2:1}" != "." ]; then
        session_name=${session_dir: -7}
        new_session_dir="${new_sub_dir}/${session_name}"
        cd "${new_session_dir}" || exit
        source_folder="${src_dir}/${sub_name}/${session_name}"
        dest_folder=${new_session_dir}
        cp -r "$source_folder/anat/" "$dest_folder/"
        datalad save -m "Adding session data: ${sub_name}:${session_name}."
        datalad status
      fi
    done
    cd $new_sub_dir || exit
    datalad save -m "Saving subject project: ${sub_name}."
    datalad status
  fi
done
cd $dest_dir || exit
cp ${src_dir}/dataset_description.json ${dest_dir}
cp ${src_dir}/participants.tsv ${dest_dir}/
datalad save -m "Saving repo project."
datalad status
