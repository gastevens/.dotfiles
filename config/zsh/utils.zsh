# Utility Functions and Settings

# Create a directory and cd into it
function mkcd() {
  mkdir -p "$@" && cd "$_";
}

# Extract most known archives with one command
function extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show the top 10 commands used
function top10() {
  history | awk '{print $2}' | awk 'BEGIN {FS="|"} {print $1}' | sort | uniq -c | sort -nr | head -n 10
}

# Create a new git repo with remote on GitHub
function git-new() {
  local repo_name=$1
  
  if [[ -z "$repo_name" ]]; then
    echo "Usage: git-new <repository-name>"
    return 1
  fi
  
  # Create the repo on GitHub
  gh repo create "$repo_name" --public --clone
  cd "$repo_name"
  
  # Initialize the repository locally
  touch README.md
  echo "# $repo_name" > README.md
  git add README.md
  git commit -m "Initial commit"
  git push -u origin main
  
  echo "Repository $repo_name created and initialized"
}

# Find out which process is listening on a port
function port() {
  lsof -i ":$1" | grep LISTEN
}

# Brew wrap if available
if [ -f $(brew --prefix)/etc/brew-wrap ]; then
  source $(brew --prefix)/etc/brew-wrap
fi

