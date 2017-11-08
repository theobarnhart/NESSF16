files=`ls ./GPM_3B42/` # grab files

for file in $files; do
	
	echo $file
	
	filename=$(basename $file) # extract the basename of the file
	filebody=${filename%.*} # extract the filename without the extension
	
	gdal_translate ./GPM_3B42/$file ./GPM_3B42/$filebody.r.tiff
	
done