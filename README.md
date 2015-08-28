# Sequence input plugin for Embulk

Just test plugin to me.

## Overview

* **Plugin type**: input
* **Resume supported**: yes
* **Cleanup supported**: yes
* **Guess supported**: no

## Configuration

See below.

## Example

```yaml
in:
  type: sequence
  min: 1
  max: 100
  columns:
    - {name: "number", type: "long"}
out:
  type: stdout
```


## Build

```
$ rake
```
