set -x RUST_INSTALL "$HOME/.cargo"
set -x PATH $PATH "$RUST_INSTALL/bin"

function _rust_install
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
end

function _rust_completions
    rustup completions fish >"$HOME/.config/fish/completions/rust.fish"
end

function _on_rust_install --on-event rust_install
    if not test -f "$RUST_INSTALL/bin/rustup"
        _rust_install
    end

    _rust_completions
end

function _on_postexec_rust_update --on-event fish_postexec
    if string match -qr '^rustup update$' $argv
        _rust_completions
    end
end
