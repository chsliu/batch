#Set-ExecutionPolicy RemoteSigned
#convert iso to wbfs

$files = get-childItem . -Filter *.iso

foreach ($file in $files)
{
  .\wbfs_file.exe $file.Name
  $file.Delete()
}
