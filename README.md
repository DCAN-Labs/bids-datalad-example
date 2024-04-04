# bids-datalad-example
An example that illustrates how to wrap a BIDS project with DataLad and then process the images.  Since the scripts use DataLad, you can easily reproduce the results.  Thus, your data analysis project will be [YODA-compliant](https://handbook.datalad.org/en/latest/basics/101-130-yodaproject.html).

## [code/create_datalad_data_repo_project.sh](./code/create_datalad_data_repo_project.sh)
This script takes two arguments, a source directory, and a destination directory.  The source directory should be the root of a BIDS repo.  The source directory is copied over to the destination directory.  Then the  destination directory is converted into a DataLad project at both the root level, with nested DataLad projects at the subject and session levels.

## [code/datalad_run_bids_example.sh](./code/datalad_run_bids_example.sh)
This script takes two argument.  The first is the root directory of a BIDS repository which is wrapped by a DataLad project (such a directory could be created with the preceding script, create_datalad_data_repo_project.sh.  The second argument is the path to a shell script that takes a single argument, the path to a NIfTI file.  The script can do anything with this NIfTI file.  It can transform the image, analyze it and write the analysis out to a text file, whatever.  datalad_run_bids_example.sh walks the directories of the BIDS directory.  Everytime it encounters a NIfTI file it runs the user-specified shell script on it.  On its way up the BIDS tree the script calls `datalad save` including at the top level.

<hr>

Please contact [Paul Reiners](mailto:reine097@umn.edu) if you have questions about or run into problems when using these scripts.
