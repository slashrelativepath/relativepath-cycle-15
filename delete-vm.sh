# Checks to see if the VM exists and if so, deletes it

if (multipass list | grep -q "^relativepath\s")
then
  echo "Deleting the VM... 🗑️"
  multipass delete relativepath --purge
else
  echo "The relativepath VM was not found"
fi

# Verifies the VM is deleted
echo "relativepath should not be in the list below:"
multipass list
