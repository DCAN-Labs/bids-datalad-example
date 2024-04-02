bids_dir=$1

cat << EOT > code/list_titles.sh
for i in ${bids_dir}/subs-*/ses-*/*.mp3; do
get the filename
   base=\$(basename "\$i");
strip the extension
   base=\${base%.mp3};
date as yyyy-mm-dd
   printf "\${base%%__*}\t" | tr '_' '-';
name and title without underscores
   printf "\${base#*__}\n" | tr '_' ' ';
done
EOT