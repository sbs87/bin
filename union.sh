#This script creates the union of all files in the specificed directory that contain a .preunion file extension
#Assumes field to create union is the first field of each .preunion file
#Assumes union.py script is in the same directory as the presentt wrapper, the bin

UNION_DIR=$1
UNION_FILE_NAME=$2
PYTHON_SCRIPT_DIR='/diag/home/stsmith/bin'
PRE_UNION_EXTENTION='sorted'
BINARY=$3
cd $UNION_DIR

#Create universe file.. change $1 to alter field number
awk '{print $1}' *.$PRE_UNION_EXTENTION | sort -u > universe

#Run the union.py script

mkdir tmp

for i in `ls *.$PRE_UNION_EXTENTION`
do
python $PYTHON_SCRIPT_DIR/union.py universe $i $BINARY > tmp/$i.tmp
done

#Concatenate all tmp union files, clean up
#join tmp/*.tmp > $UNION_FILE_NAME.union
#rm -r tmp
#rm universe
