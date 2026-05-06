# Set Homebrew without letting it take PATH precedence
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH=$(echo "$PATH" | sed -e "s|/opt/homebrew/bin:||" -e "s|/opt/homebrew/sbin:||")
  export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"
fi
