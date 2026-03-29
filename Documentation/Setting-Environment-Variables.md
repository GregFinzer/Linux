# Setting Environment Variables in Linux
Example adding .NET to the path

```bash
nano ~/.bashrc
```

Add this at the end

```bash
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
```

Reload

```bash
source ~/.bashrc
```

## Add dotnet to VS Code

In the VS Code Terminal

```bash
nano ~/.profile
```

Add to the end

```bash
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
```

Log out and log back in.