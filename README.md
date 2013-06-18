# Knife Bootstrap Sync

Sync local directories to remote nodes, prior to bootstrap.

## Usage

Use the `--sync-directory` option with the local directory
and remote directory separated by a `:`. The general use
case is to upload cookbooks for use by chef-solo:

```
$ knife bootstrap 127.0.0.2 --sync-directory './cookbooks:/var/chef/cache/cookbooks' ...
```

# Info

* Repository: https://github.com/heavywater/knife-bootstrapsync
* IRC: Freenode @ #heavywater