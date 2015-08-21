# Usual update/upgrade
sudo apt-get update
sudo apt-get upgrade

# Set the Ubunutu RELEASE and CODENAME 
CODENAME=$(lsb_release -c | cut -f2)
RELEASE=$(lsb_release -r | cut -f2)

# Add some repos

## Canonical partners
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

## R - CRAN
sudo add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $CODENAME/"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

## sublime
sudo add-apt-repository ppa:webupd8team/sublime-text-2

## Texstudio
sudo apt-add-repository ppa:blahota/texstudio

# Update
sudo apt-get update


# Installing everything:

## Build tools
sudo apt-get install build-essential

## JDK
sudo apt-get install default-jdk
echo 'JAVA_HOME="/usr/bin/java"' >> ~/.bashrc

# The importatn stuff

## R
sudo apt-get install r-base r-base-dev 

## Revolution R Open: https://mran.revolutionanalytics.com/documents/rro/installation/#revorinst-lin
wget https://mran.revolutionanalytics.com/install/RRO-3.2.1-Ubuntu-$RELEASE.x86_64.tar.gz &&
tar -xzf RRO-3.2.1-Ubuntu-$RELEASE.x86_64.tar.gz &&
cd RRO-3.2.1 &&
sudo ./install.sh &&
cd .. &&
rm RRO-3.2.1-Ubuntu-$RELEASE.x86_64.tar.gz

## Math Kernel Library - Enhances RRO
wget https://mran.revolutionanalytics.com/install/RevoMath-3.2.1.tar.gz &&
tar -xzf RevoMath-3.2.1.tar.gz &&
cd RevoMath &&
sudo ./RevoMath.sh &&
cd .. &&
rm RevoMath-3.2.1.tar.gz &&
rm -rf RevoMath

## RStudio 
wget https://s3.amazonaws.com/rstudio-dailybuilds/rstudio-0.99.467-amd64.deb &&
sudo dpkg -i rstudio-0.99.467-amd64.deb &&
rm rstudio-0.99.467-amd64.deb

## Set R alternatives by default CRAN R 
## To change then just do:
# update-alternatives --config R
sudo update-alternatives --install /usr/bin/R R /usr/lib/R/bin/R 0
sudo update-alternatives --install /usr/bin/R R /usr/lib64/RRO-3.2.1/R-3.2.1/bin/R -1

## LaTeX
sudo apt-get install texlive-full
sudo apt-get texstudio

## Pandoc (from source)
# sudo apt-get install haskell-platform
# cabal update
# cabal install pandoc
## Add path to profile. Restart the machine to get the PATH loaded
# echo 'export PATH="$PATH:$HOME/.cabal/bin"' >> ~/.profile

## pandoc - symbolic link to RStudio's precompiled binaries
## see: https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md
sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc /usr/local/bin
sudo ln -s /usr/lib/rstudio/bin/pandoc/pandoc-citeproc /usr/local/bin

## Python stuff - PyCharm IDE
cd /opt &&
sudo wget https://download.jetbrains.com/python/pycharm-community-4.5.3.tar.gz &&
sudo tar xfz pycharm-community-4.5.3.tar.gz &&
sudo rm pycharm-community-4.5.3.tar.gz

# To run and configure: /opt/pycharm-community-4.5.3/bin/pycharm.sh

## ruby stuff

wget -O ruby-install-0.5.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.5.0.tar.gz &&
tar -xzvf ruby-install-0.5.0.tar.gz &&
cd ruby-install-0.5.0/ &&
sudo make install &&
cd .. &&
rm ruby-install-0.5.0.tar.gz

ruby-install -V
ruby-install ruby 2.2.0

wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz &&
tar -xzvf chruby-0.3.9.tar.gz &&
cd chruby-0.3.9/ &&
sudo make install &&
cd .. &&
rm chruby-0.3.9.tar.gz

echo 'source /usr/local/share/chruby/chruby.sh' >> ~/.bashrc
echo 'source /usr/local/share/chruby/auto.sh' >> ~/.bashrc

source .bashrc
touch ~/.ruby-version
echo 'ruby-2.2.0' >> ~/.ruby-version
chruby
ruby -v
gem install jekyll


# Other stuff

## Dropbox
# sudo apt-get install nautilus-dropbox

## sublime and okular (pdf viwer)
sudo apt-get install sublime-text okular

## Tabula: a program to extract tables from PDFs http://tabula.technology/
## https://github.com/tabulapdf/tabula
cd /opt
sudo wget https://github.com/tabulapdf/tabula/releases/download/v0.9.7/tabula-jar-0.9.7.zip
sudo unzip tabula-jar-0.9.7.zip

## some other stuff 
sudo apt-get install adobe-flashplugin vlc skype

sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove