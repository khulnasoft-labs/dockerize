if ! which "$(go env CC)" &> /dev/null; then
  go env -w CC=gcc
fi
