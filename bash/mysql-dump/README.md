### Info

A simple script to backup my databases using cronie

### Dependencies

- `cronie` (optional) [[info](https://fedorahosted.org/cronie/)]

### Usage

```shell
mysql_dump.sh [<options>]
```

| Option | Description |
|:-------|:------------|
| `--mysql-host` | The name or IP of the MySQL server, by default `localhost`. |
| `--mysql-port` | The MySQL port, by default `3306`. |
| `--mysql-databases` | A list of databases separated by a comma. |
| `--mysql-user` | The MySQL user. |
| `--mysql-password` | The MySQL password. |
| `--backup-path` | The path where the backup files will be created, by default the current directory. |
