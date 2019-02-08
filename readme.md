Great-Git commit
==============================

At the moment I'm using JIRA at work and with each git commit message
we will also add the JIRA issue number of the task we're currently
working on. This means a lot of manual work when such a tedious
thing could be skipped, or automated.

# Example git commit message

```
// git commit message
headline.. here. 50 chars

body.. here. max-len is 79 chars

[JIRA issue no.]
```

# Example usage

Starting on a new feature? Great, see below

```bash
$ git status
> On branch master

$ git checkout -b new-feature##UNIQUE_ID_HERE##
> Switched to a new branch 'new-feature##UNIQUE_ID_HERE##'
```

As you can see we added `##UNIQUE_ID_HERE##` to the branch name, this
will let the plugin know which part it should extract each time it
opens up the git commit prompt. Resulting in something like this:

```gitcommit
# git commit message
<++>

<++>

UNIQUE_ID_HERE
```

# Tips

I use this plugin along with [incsearch.vim](https://github.com/haya14busa/incsearch.vim/) for a pretty neat flow.

I've created the following file in my `~/.vim` directory:

```vim
" ~/.vim/after/ftplugin/gitcommit.vim

map <expr> <tab> (getline('.') =~ '<++>' ? '<Plug>(incsearch-stay)<++>' : '<Plug>(incsearch-forward)<++>')
cnoremap <expr> <space> (getline('.') =~ '<++>' ? '<cr>S' : '<space>')
imap <c-j> <esc><Plug>(incsearch-forward)<++>
```

## Explanation to mappings

What above does is creating mappings for only when the filetype is
`gitcommit`.

`TAB` is mapped to highlight all placeholders (`<++>`) and jump to
each one. It starts on the one it stands on.

`SPACE` is mapped in command mode, as once you're hitting `TAB`
you'll be in command mode and jumping to placeholders. Now, by hitting
`SPACE` you'll replace the placeholder and be put into insert mode.

`CTRL-J` is mapped in insert mode, once you've finished writing
e.g. your headline, you can jump to the next placeholder by
hitting `CTRL-J` which will put you into normal mode.
