export PATH="/Users/dalyt05/Library/Python/2.7/bin:/Users/dalyt05/Library/Python/3.7/bin:/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
export JAVA_13_HOME=$(/usr/libexec/java_home -v13)

alias java11='export JAVA_HOME=$JAVA_11_HOME'
alias java13='export JAVA_HOME=$JAVA_13_HOME'
java13 # set java13 as default
source ~/.bashrc
source ~/.git-completion.bash
