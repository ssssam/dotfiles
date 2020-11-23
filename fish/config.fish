set -U fish_user_paths $fish_user_paths ~/.local/bin

fish_vi_key_bindings

# https://github.com/ewilliam/import-aliases might make this
# easier, but it doesn't work with Fish 2.3.1 at time of writing.

function edit
  gvim --remote-tab $argv
end

abbr ga "git add $argv"
abbr gb "git branch $argv"
abbr gcp "git cherry-pick $argv"
abbr gd. "git diff $argv"
abbr gd.c "git diff --cached $argv"
abbr gco "git checkout $argv"
abbr gci "git commit $argv"
abbr gd. "git diff $argv"
abbr gd.c "git diff --cached $argv"
abbr gl "git log $argv"
abbr gm.n "git merge --no-ff --no-commit $argv"
abbr gpo "git push origin HEAD"
abbr gpf "git push fork HEAD"
abbr gpw "git push write HEAD"
abbr gr. "git rebase $argv"
abbr gr.a "git rebase --abort $argv"
abbr gr.c "git rebase --continue $argv"
abbr gr.i "git rebase --autosquash --interactive $argv"
abbr grup "git remote update --prune $argv"
abbr gs "git status $argv"
