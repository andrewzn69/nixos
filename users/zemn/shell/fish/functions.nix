{ ... }:

{
  programs.fish.functions = {
    rmrf = ''
      if test (count $argv) -eq 0
          echo "usage: rmrf <file-or-dir>..." >&2
          return 2
      end

      for t in $argv
          if not test -e "$t"
              echo "rmrf: $t: does not exist" >&2
              return 1
          end
      end

      set -l n (find $argv -type f | wc -l | string trim)
      if test "$n" -eq 0
          echo "rmrf: no regular files under $argv" >&2
          return 1
      end

      read -l -P "shred $n file(s) under $argv - irreversible. [y/N] " reply
      if not string match -qir '^y' -- "$reply"
          echo aborted
          return 1
      end

      find $argv -type f -exec shred -v -f -z -u -n 1 {} +

      for t in $argv
          test -d "$t"; and find "$t" -depth -type d -empty -delete
      end
    '';

    fish_should_add_to_history = ''
      string match -qr '^\s' -- $argv[1]; and return 1
      string match -qr '^\s*rmrf(\s|$)' -- $argv[1]; and return 1
      return 0
    '';
  };
}
