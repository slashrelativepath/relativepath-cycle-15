if (test "$(multipass info relativepath | grep 'Name:' | awk '{print $2}')" = 'relativepath')
then
  echo "relative path instance already exists"
else
  echo "creating relative path instance"
  multipass launch --name relativepath --cpus 4 --memory 4G --disk 50G 
fi
