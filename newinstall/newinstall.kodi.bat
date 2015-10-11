set path=%path%;C:\Program Files (x86)\Git\cmd

cinst -y git kodi

mkdir %appdata%\Kodi
cd/d %appdata%\Kodi
git clone https://github.com/chsliu/userdata.git

