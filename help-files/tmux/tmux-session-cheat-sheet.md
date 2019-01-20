# Tmux Quick Tips

## Start new named Session

```sh
tmux new -s [session name]
```

## Detached from session

```
[C-b] d
```

## List sessions

```
tmux ls
```

## Attach to named session:

```
tmux a -t [name of session]
```

## Kill named session

```
tmux kill-session -t [name of session]
```

