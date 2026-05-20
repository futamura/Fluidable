fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios test

```sh
[bundle exec] fastlane ios test
```

Run SwiftPM build, coverage-enabled Xcode unit tests, and SwiftLint

### ios coverage

```sh
[bundle exec] fastlane ios coverage
```

Run Xcode coverage and export an xccov text report

### ios lint

```sh
[bundle exec] fastlane ios lint
```

Run SwiftLint

### ios create_doc

```sh
[bundle exec] fastlane ios create_doc
```

Create DocC documentation

### ios reset_simulator

```sh
[bundle exec] fastlane ios reset_simulator
```

Reset Simulator

### ios reset_derived_data

```sh
[bundle exec] fastlane ios reset_derived_data
```

Reset Derived Data

### ios remove_ds_store

```sh
[bundle exec] fastlane ios remove_ds_store
```

Remove .DS_Store

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
