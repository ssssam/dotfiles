set -U fish_user_paths $fish_user_paths ~/.local/bin

# https://github.com/ewilliam/import-aliases might make this
# easier, but it doesn't work with Fish 2.3.1 at time of writing.

function edit
  gvim --remote-tab $argv
end

function ga
  git add $argv
end

function gb
  git branch $argv
end

function gcp
  git cherry-pick $argv
end

function gd.
  git diff $argv
end

function gd.c
  git diff --cached $argv
end

function gco
  git checkout $argv
end

function gci
  git commit $argv
end

function gd.
  git diff $argv
end

function gd.c
  git diff --cached $argv
end

function gl
  git log $argv
end

function gm.n
  git merge --no-ff --no-commit $argv
end

function gr.
  git rebase $argv
end

function gr.a
  git rebase --abort $argv
end

function gr.c
  git rebase --continue $argv
end

function gr.i
  git rebase --autosquash --interactive $argv
end

function grup
  git remote update --prune $argv
end

function gs
  git status $argv
end
