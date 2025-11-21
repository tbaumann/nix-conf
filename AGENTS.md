# Style Preferences for This Project

This document outlines the coding style preferences for this Nix configuration
project to help agents and contributors maintain consistency.

## Formatting

- Use `nix fmt` for consistent code formatting. (`nix fmt` formats the entire
  tree. For individual files `nixfmt` can be used.)
- Run the formatter after making changes to ensure consistent styling

## Attribute Assignment Style

### Single Line Assignments

- Prefer single line assignments for single values:
  ```nix
  # Preferred
  programs = {
      git.enable = true;
      yazi.enable = true;
  };
  stylix.targets.firefox.enable = false;
  ```

### Grouping Multiple Attributes

- Group multiple attributes under the same prefix into nested structures:
  ```nix
  # When you have multiple related assignments like:
  stylix.targets.nixos-icons.enable = true;
  stylix.targets.plymouth.enable = true;
  stylix.targets.plymouth.logoAnimated = true;
  stylix.targets.console.enable = true;

  # Group them as:
  stylix = {
    targets = {
      nixos-icons = {
        enable = true;
      };
      plymouth = {
        enable = true;
        logoAnimated = true;
      };
      console = {
        enable = true;
      };
    };
  };
  ```

### When to Group

- Group attributes when the same prefix appears multiple times in a file
- Leave single attribute assignments as single lines
- The goal is improved readability and organization, not unnecessary nesting

## Examples

### Good - Single attributes remain as single lines:

```nix
programs = {
    git.enable = true;
    yazi.enable = true;
};
services.openssh.enable = true;
```

### Good - Multiple related attributes are grouped:

```nix
programs = {
  git = {
    enable = true;
    userName = "John Doe";
    userEmail = "john@example.com";
  };
  yazi = {
    enable = true;
    package = pkgs.yazi;
  };
};
```

### Bad - Unnecesary nesting for single values

```nix
programs = {
    git = {
        enable = true;
    };
    yazi = {
        enable = true;
    };
};
```

# Expected practices

- Use Clan modules when appropriate for modularisation. See
  https://docs.clan.lol/guides/services/community/
- Only use plain NixosModules over clan services in common or home-manager, when
  the use is indeed common. Modularisation of the existing code base is lacking,
  gentle efforts should be taken to improve the situation.
