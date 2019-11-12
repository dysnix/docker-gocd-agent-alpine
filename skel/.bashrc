## Dumb protection from git output which might contain credentials (gocd uses user:password directly)
#
git() {
  command git "$@" | sed -E 's~(https?:\/\/).*@([^\s$.?#].[^\s]*)~\1\2~'
}
