#!/usr/bin/env bash
# Pragmatasevka build script

patch=private-build-plans.toml

greeting(){
  echo "Welcome to Pragmatasevka build script, $USER!"  
  echo "Make sure you have installed the following packages in your system: nodejs, npm, ttfautohint, zip."  
  sleep 3
}

# Clone Iosevka source code
clone(){
  if [ -d "Iosevka" ]; then
    git -C ./Iosevka pull
  else
    git clone https://github.com/be5invis/Iosevka
  fi
}

# Make Pragmatasevka
make(){
  [ -f ./Iosevka/$patch ] && rm -rf ./Iosevka/$patch
  cp $patch ./Iosevka
  cd Iosevka
  npm install
  npm run build -- contents::pragmatasevka
  cd ..
  rm -rf ./pragmatasevka-ttf.zip
  rm -rf ./pragmatasevka-woff2.zip
  zip -jr pragmatasevka-ttf.zip ./Iosevka/dist/pragmatasevka/ttf
  zip -jr pragmatasevka-woff2.zip ./Iosevka/dist/pragmatasevka/woff2
  rm -rf ./Iosevka/dist
}

# Print done
done_msg(){
  echo "Pragmatasevka has been built!"
}

greeting
clone
make
done_msg
