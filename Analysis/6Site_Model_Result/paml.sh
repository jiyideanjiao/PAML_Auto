for i in `ls *.pml`
do
id=$(basename $i .pml)
python autoPAML.py $i phylogeny.tre $id.out
done;
