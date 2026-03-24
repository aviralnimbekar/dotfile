#!/bin/bash

if [ ! -d "$HOME/.sdkman" ]; then
  echo "→ Installing SDKMAN..."
  curl -s "https://get.sdkman.io" | bash
  echo "→ To install Java, run:   sdk install java <version>"
  echo "→ To install Gradle, run: sdk install gradle <version>"
  echo "→ To install Maven, run:  sdk install maven <version>"
else
  echo "→ SDKMAN already installed, skipping."
fi
