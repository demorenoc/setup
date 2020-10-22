# Usual update/upgrade
sudo apt-get update
sudo apt-get upgrade

# Set the Ubunutu RELEASE and CODENAME 
CODENAME=$(lsb_release -c -s)
RELEASE=$(lsb_release -r -s | cut -f1 -d.)

# Add some repos

## Canonical partners
sudo sed -i "/^# deb .*partner/ s/^# //" /etc/apt/sources.list

## R - CRAN. See: https://cran.r-project.org/bin/linux/ubuntu/
sudo add-apt-repository "deb deb https://cloud.r-project.org/bin/linux/ubuntu $CODENAME-cran40/"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

## sublime
sudo add-apt-repository ppa:webupd8team/sublime-text-3

## Texstudio
# sudo apt-add-repository ppa:blahota/texstudio

# Update
sudo apt-get update

# Installing everything:

## First things first

### Git
sudo apt-get install git
git config --global user.name $(whoami)
git config --global user.email "jhondoe@nowhere.who"

### vim
sudo apt-get install vim

### zsh and oh-my-zsh
sudo apt-get zsh
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## To mount and read exfat
sudo apt-get install exfat-fuse exfat-utils

## Build tools
sudo apt-get install build-essential

## JDK
sudo apt-get install default-jdk
sed -i '/export PATH=.*$/a\ \ export JAVA_HOME="/usr/bin/java"' ~/.zshrc

# The importatn stuff

## R
sudo apt-get install r-base r-base-dev

## Revolution R Open: https://mran.revolutionanalytics.com/documents/rro/installation/#revorinst-lin
wget https://mran.revolutionanalytics.com/install/RRO-3.2.2-Ubuntu-$RELEASE.4.x86_64.deb
sudo dpkg -i RRO-3.2.2-Ubuntu-$RELEASE.4.x86_64.deb &&
rm RRO-3.2.2-Ubuntu-$RELEASE.4.x86_64.deb

## Math Kernel Library - Enhances RRO
wget https://mran.revolutionanalytics.com/install/RevoMath-3.2.2.tar.gz &&
tar -xzf RevoMath-3.2.2.tar.gz &&
cd RevoMath &&
sudo ./RevoMath.sh &&
cd .. &&
rm RevoMath-3.2.2.tar.gz &&
rm -rf RevoMath

## Set R alternatives by default CRAN R 
## To change then just do:
# sudo update-alternatives --config R
sudo update-alternatives --install /usr/bin/R R /usr/lib/R/bin/R 0
sudo update-alternatives --install /usr/bin/R R /usr/lib64/RRO-3.2.2/R-3.2.2/bin/R -1

## RStudio
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.3.1093-amd64.deb &&
sudo dpkg -i rstudio-1.3.1093-amd64.deb &&
rm rstudio-1.3.1093-amd64.deb

## LaTeX
# sudo apt-get install texlive-full
# sudo apt-get texstudio

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
sudo wget https://download.jetbrains.com/python/pycharm-community-5.0.2.tar.gz &&
sudo tar xfz pycharm-community-5.0.2.tar.gz &&
sudo rm pycharm-community-5.0.2.tar.gz

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

## sublime and okular
sudo apt-get install sublime-text-installer okular

## Tabula: a program to extract tables from PDFs http://tabula.technology/
## https://github.com/tabulapdf/tabula
# cd /opt
# sudo wget https://github.com/tabulapdf/tabula/releases/download/v0.9.7/tabula-jar-0.9.7.zip
# sudo unzip tabula-jar-0.9.7.zip

## some other stuff 
sudo apt-get install adobe-flashplugin
# sudo vlc skype

sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
