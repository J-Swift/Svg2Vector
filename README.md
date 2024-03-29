# Svg2Vector

This is intended to be an easy CLI to convert Svg files to vector assets for both ios and android. There are a couple online tools that can do this, but I wanted something more configurable and programmatic (i.e. CLI-driven).

### Requirements

- Docker
- Make (optional)

### Usage

Place your SVG files in `mounts/input` and run `make pristine` if its the very first time running the project, otherwise just run `make`. The output is placed in the approriate platform folder within `mounts/output`. The conversion is idempotent, so existing files in `mounts/output` will not be overwritten in a future run.

For consistency, I recommend naming input files using the convention `ic_{name}.svg`, though the only requirement is that they end with `.svg`

### Android

The xml conversion code was manually extracted from the JetBrains copy of AOSP by starting with `Svg2Vector` and fixing compiler errors until there weren't any more. I chose this path rather than using something like https://github.com/alexjlockwood/svg2vd because I want to use the canonical source.

### iOS

iOS supports both PDF and SVG vectors natively, depending on the OS version. We generate both, including asset catalog directories, and put them in mounts/output/ios-pdf and mounts/output/ios-svg respectively.

The pdf conversion code leverages Inkscape CLI.

