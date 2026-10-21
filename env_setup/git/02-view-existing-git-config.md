Commands to view existing configuration
----------------------------------------------------------------

🔑 TERM: Global config → settings stored in ~/.gitconfig
Applied to every repo on your machine.

----------------------------------------------------------------

1. View all global settings (name, email, editor, etc.)
    ```bash
    git config --global --list
    ```

2. View specific values
    ```bash
    git config --global user.name
    git config --global user.email
    ```

3. View where each setting comes from (global vs local)
    ```bash
    git config --list --show-origin
    ```

4. Open the config file (opens ~/.gitconfig in your configured editor):
    ```bash
    git config --global --edit
    ```