brew leaves > ~/.packages
brew cask list > ~/.cask-packages
git add -f ~/.packages ~/.cask-packages
git commit -m"Adding packages"
git push
