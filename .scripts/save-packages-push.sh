set -x

brew leaves > ~/.packages/brew.txt
brew cask list > ~/.packages/brew-cask.txt
pip3 list --not-required > ~/.packages/pip3.txt
pip2.7 list --not-required > ~/.packages/pip27.txt
npm list --global --parseable --depth=0 | sed '1d' | awk '{gsub(/\/.*\//,"",$1); print}' > ~/.packages/npm.txt

git add -f ~/.packages/*
git commit -m"Adding packages"
git push
