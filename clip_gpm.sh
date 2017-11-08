cd ./GPM_3B42/
files=`find . -name \*r\*` # grab files

for file in $files; do
	
	filename=$(basename $file) # extract the basename of the file
	filebody=${filename%.*} # extract the filename without the extension
	
	gdalwarp -t_srs '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs' $file ./temp.tiff
	
	gdalwarp -tr 0.0625 0.0625 -t_srs '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs' -cutline ../westernUS.shp -cl 'westernUS' -crop_to_cutline ./temp.tiff ./$filebody.clp.tiff
	
	rm ./temp.tiff
	
done