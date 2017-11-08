shape='../westernUS.shp'
pth='./MOD16A2_monthly'

band=:MOD_Grid_MOD16A2:PET_1km
prodname=MOD16A2 # nasa /usgs product name

t1=h10v04
t2=h11v04
t3=h10v05
t4=h09v05
t5=h09v06
t6=h08v06
t7=h08v05
t8=h08v04
t9=h09v04

# preallocate the tiles
tile1=$1
tile2=$2
tile3=$3
tile4=$4
tile5=$5
tile6=$6
tile7=$7
tile8=$8
tile9=$9


cd $pth

for year in {2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014}; do
	for month in {01,02,03,04,05,06,07,08,09,10,11,12}; do
		
			tile1=`ls ${prodname}.A${year}M${month}.${t1}.105.*.hdf`
			tile2=`ls ${prodname}.A${year}M${month}.${t2}.105.*.hdf`
			tile3=`ls ${prodname}.A${year}M${month}.${t3}.105.*.hdf`
			tile4=`ls ${prodname}.A${year}M${month}.${t4}.105.*.hdf`
			tile5=`ls ${prodname}.A${year}M${month}.${t5}.105.*.hdf`
			tile6=`ls ${prodname}.A${year}M${month}.${t6}.105.*.hdf`
			tile7=`ls ${prodname}.A${year}M${month}.${t7}.105.*.hdf`
			tile8=`ls ${prodname}.A${year}M${month}.${t8}.105.*.hdf`
			tile9=`ls ${prodname}.A${year}M${month}.${t9}.105.*.hdf`
			
		
			gdalbuildvrt tmp.vrt \
				'HDF4_EOS:EOS_GRID:"'$tile1'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile2'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile3'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile4'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile5'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile6'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile7'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile8'"'$band'' \
				'HDF4_EOS:EOS_GRID:"'$tile9'"'$band''
			
			gdalwarp -tr 0.0625 0.0625 -r near -t_srs '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs' -cutline $shape -cl 'westernUS' -crop_to_cutline tmp.vrt MOD16A2_wUS_PET_A${year}M${month}.clp.tiff
			
			rm tmp.vrt 
	done
done


#for file in ./MOD16A2_monthly/*.hdf; do
	
	#filename=$(basename $file) # extract the basename of the file
	#filebody=${filename%.*} # extract the filename without the extension
	
	#gdalwarp -tr 0.0625 0.0625 -t_srs '+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs' -cutline $shape -cl 'westernUS' -crop_to_cutline "HDF4_EOS:EOS_GRID:""$file"":MOD_Grid_MOD16A2:ET_1km" $filebody.clp.tiff
	
	#done