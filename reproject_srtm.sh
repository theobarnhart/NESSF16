cd ./SRTM_Void_Filled/
files='ls *v2.tif'
rm ../reprojecting_progress22.txt # remove output file

for fl in $files; do
filename="${fl%.*}"
gdalwarp -multi -overwrite -wm 500 -tr 90 90 -r bilinear -t_srs '+init=epsg:5070' $fl ${filename}_proj_90m.tif
echo 'Processing '$fl >> ../reprojecting_progress22.txt

done
