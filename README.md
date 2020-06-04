# Svg2Vector

This is intended to be an easy CLI to convert Svg files to vector assets for both ios and android. There are a couple online tools that can do this, but I wanted something more configurable and programmatic (i.e. CLI-driven).

### Rquirements

- Docker
- Make (optional)

### Usage

Place your SVG files in `mount/input` and run `make`. The output is placed in `mount/output`. The conversion is idempotent, so existing files in `mount/output` will not be overwritten in a future run.

For consistency, I recommend naming input files using the convention `ic_{name}.svg`, though the only requirement is that they end with `.svg`

### Android

The xml conversion code was manually extracted from AOSP by starting with `Svg2Vector` and fixing compiler errors until there weren't any more. I chose this path rather than using something like https://github.com/alexjlockwood/svg2vd because I want to use the canonical source.

### iOS

The pdf conversion code leverages Inkscape CLI. It also handles generating appropriate asset catalogue directories in addition to the `pdf` files. This makes it simple to drag and drop into a project.
