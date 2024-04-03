# bids-datalad-example
An example that illustrates how to wrap a BIDS project with DataLad and then process the images.

## [code/create_datalad_data_repo_project.sh](./code/create_datalad_data_repo_project.sh)
This script takes two arguments, a source directory, and a destination directory.  The source directory should be the root of a BIDS repo.  The source directory is copied over to the destination directory.  Then the  destination directory is converted into a DataLad project at both the root level, with nested DataLad projects at the subject and session levels.
