# GIT

## basics

Version control system
Git: software / Github: service provider
https://git-scm.com/install/

- working directory (changes untracked by git),
- staging area / index (changes tracked by git, yet to be commited),
- git repository (local folder, commited changes),
- external repository (Github or Bitbucket, pushed changes),

## configuration

- aliases (vim ~/.gitconfig)

create new group [alias] and create aliases for git:
[alias]
lo = log --oneline
ch = checkout
st = status -s
br = branch
fe = fetch
pu = push -u origin HEAD

## commands

### basic

git --version
git init (.git folder appears)
git status

<!--

- access to config file:
  `git config --global -e` -> open config file in default editor,

- varia:
  `git config --global user.name "Wookie Wookovsky` -> run only once,
  `git config --global user.email "wookie@wookie.com"` -> only once,
  `git config --global core.editor "code --wait"` -> vs code as default,
  `git config --global core.editor "vim"` -> vim as default,
  `git config --global core.pager "less -X -F"` -> logs in less pager,
  `git config --global core.pager 'vim -'` -> git logs in vim,
  `git config --global init.defaultBranch main` -> (re)names default branch (`git init` required),

- difftool
  `git config --global diff.tool vscode` -> default diff tool,
  `git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"` -> how to launch diff tool in vs code,

## basic commands

`git init` -> to initialize git repository in current folder (.git),
`rm -rf .git/` -> to remove git repository from current folder,
`git status` -> state of git repository (work dir + staging area),
`git status -s` -> short status (two columns with: ?, M, A or none),
`git clone` -> to clone remote git repo (e.g. grom GitHub),
`git help` -> to get help (`git help | less` -> in less pager),
`git commit --help` -> to get help on particular command,

## git add & commit

`git add .` -> adds all files from work dir to staging area,
`git add folder/file.txt folder2/file2.txt` -> adds specific file(s),
`git add *.txt` -> adds files that follow a specific pattern,
`git ls-files` -> lists all files that are in staging area
`git commit` -> adds files from staging area to git repository,
`git commit -m "message"` -> adds file with a message,
`git commit -a -m "text"`, `git commit -am "text"` -> add + commit,
`git commit --amend` -> updates existing commit (`git push --force-with-lease` may be required),

## git log

`git log` -> displays information about commits (q to quit),
`git log --oneline` -> displays high-level information,
`git reflog` -> displays history of HEAD pointer,

- when in vim log output, type `/` to search for any string,

## git diff & difftool

`git diff` -> shows diff between working dir and staging area,
`git diff shaID` -> shows diff between working dir and specific commit,
`git diff --cached`, `git diff --staged` -> shows diffs between staging area and the state of git repo (last commit),
`git difftool`, `git difftool --staged` -> first change config file,

## git show

`git show commitId` -> git log + git diff combined,
`git show HEAD` -> show HEAD commit,
`git show HEAD~1`, `git show HEAD~2` -> show commit previous to HEAD,

## git rm & mv

`git rm junk.txt` -> deletes files and simultaneously stages them (git rm = rm + git add),
`git rm --cached somefile.ext` -> removes a file from staging area (useful, when we accidentally commited a file, and only thed added it to .gitignore; this way we remove it only from staging area, not from working directory),
`git mv junk.txt junk_renamed.txt` -> moves (renames) files and simultaneously stages them (git mv = mv + git add),

## reverting changes: git restore, clean, reset, revert

`git reset --soft` -> soft reset???,
`git reset --hard` -> hard reset???,
`git reset --hard shaID` -> moves HEAD pointer to specific commit or between commits (to any place in commit history), without creating new commit (unlike git revert),

`git revert shaID` -> reverts a specific commit,
`git revert HEAD` -> reverts last commit,
`git revert HEAD~1` -> reverts second last commit,
it reverts repo state to a specific commit and creates a separate commit for that (unlike git reset),

`git restore --cached .` -> restores all changes from staging area,
`git restore --cached filename.ts` -> restore a single file,
`git restore .` -> restores all changes from work dir (if modified),
`git restore filename.ts` -> restores a single file (if modified),

`git clean -d -n .` -> displays all files & folders to be un-tracked,
`git clean -d -f .` -> removes all folders & files to be un-tracked,
`git clean -X -d -n/-f .` -> affects also ignored files & folders,
`rm` or `git rm` -> ofc we can just remove files manually,

## git squah

`git reset --soft HEAD~3`
`git commit -m "new commit message"`
`git push -f` -->
