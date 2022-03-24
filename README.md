# kmmdev-wsl

my wsl dev machine, based on rocky8

# instructions

Builds `dist/kmmdev-wsl-container.tar`:

```bash
./bin/build && ./bin/export
```

Import as WSL distro (adjust paths as necessary):

```powershell
wsl --import kmmdev "$env:USERPROFILE\WSL2\systems\kmmdev" "$env:USERPROFILE\WSL2\sources\kmmdev-wsl-container.tar"
wsl -d kmmdev
```
