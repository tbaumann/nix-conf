# Agent Guide for Nix Configuration

This guide helps agentic coding assistants work effectively with this Clan-based NixOS configuration.

## Build & Development Commands

### Primary Commands (via `justfile` - preferred):
- `nix fmt` - Format code (uses nixfmt-rfc-style)
- `nix flake update` - Update inputs
- `nix flake show` - Show available outputs
- `nixos-rebuild switch --flake '.#machine'` - Manual rebuild

### Testing:
- No formal test suite exists
- Use `nixos-rebuild build` to test configurations without switching
- Use `nix flake check` to verify flake outputs (if implemented)

## Code Style & Formatting

### Formatting Rules:
- Use `nix fmt` for consistent code formatting (nixfmt-rfc-style)
- Pre-commit hooks enforce nixfmt-rfc-style automatically
- Format after making changes to ensure consistent styling

### Attribute Assignment Style:

#### Single Line Assignments (Preferred for single values):
```nix
# Good
programs.git.enable = true;
services.openssh.enable = true;
stylix.targets.firefox.enable = false;
```

#### Grouped Assignments (For multiple related attributes):
```nix
# When multiple attributes share prefix, group them:
stylix = {
  targets = {
    nixos-icons.enable = true;
    plymouth = {
      enable = true;
      logoAnimated = true;
    };
    console.enable = true;
  };
};
```

#### When to Group:
- Group when same prefix appears multiple times in a file
- Keep single attributes as single lines
- Goal: improved readability, not unnecessary nesting

### Import & Module Organization:
- Clan modules preferred for modularization
- Place common configurations in `common/` directory
- User configs in `home-manager/` directory
- Machine-specific configs in `machines/` directory
- Custom modules in `modules/` directory

### Naming Conventions:
- Use kebab-case for file names and machine names
- Use camelCase for Nix option names (following Nixpkgs conventions)
- Clan service names use kebab-case

## Project Structure

```
nix-config/
├── flake.nix              # Main flake definition
├── clan.nix               # Clan inventory and services
├── machines/              # Individual machine configurations
├── common/                # Shared system configurations
├── home-manager/          # User-specific configurations
├── modules/               # Custom modules
├── pkgs/                 # Custom packages
└── vars/                 # Clan variables/secrets
```

## Clan Integration

### Clan Modules (Preferred):
- Use Clan modules for service modularization
- See: https://docs.clan.lol/guides/services/community/
- Clan services defined in `clan.nix` inventory
- Secrets managed via `vars/` directory

### Regular NixOS Modules:
- Use only for truly common functionality
- Place in `modules/` or `common/` as appropriate
- Avoid duplicating Clan functionality

## Development Workflow

1. Make changes to configuration files
2. Run `nix fmt` to format code
3. Test with `nixos-rebuild build` before switching

## Common Patterns

### System Configuration:
- Layered imports: machines → common → specific
- Profile-based customization (e.g., `perlless.nix`)
- Service-oriented separation

### Home Manager:
- User-centric configurations
- Program modularization
- Desktop environment separation

### Build Configuration:
- Distributed builds across multiple machines
- Cross-compilation support (x86_64-linux, aarch64-linux)
- Binary cache configuration

## Error Handling

- Test configurations before deployment
- Use `--show-trace` flag for debugging
- Check flake outputs with `just show`
- Use `nom` for better log formatting (configured in justfile)

## Security Practices

- Never commit secrets to repository
- Use Clan vars for secret management
- Review build machine configurations
- Validate external inputs before updating
