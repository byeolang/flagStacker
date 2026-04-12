# byeol-cmake

Shared CMake modules for byeol-family repositories.

## Purpose
This repository contains shared build conventions and helper modules:
- common options
- warnings policy
- changelog version parsing helper

## Consumer policy
Consumer repositories should vendor release tags only.
Do not track main directly.

## Custom commands
### by_parse_ver
This extracts the version only when the first version-like line in the changelog starts with `## vMAJOR.MINOR.PATCH`.
If an earlier `v1.2.3` appears in a different form such as `### v1.2.3`, parsing fails.

```cmake
by_parse_ver("../byeol/CHANGELOGS.md")
```

After calling it, these variables are available in the caller scope:
- `BY_VER_MAJOR`
- `BY_VER_MINOR`
- `BY_VER_PATCH`

Relative paths are resolved from the caller's current CMake list file.
