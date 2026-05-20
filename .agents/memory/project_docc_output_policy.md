# DocC output policy investigation

Date: 2026-05-20
Branch: `docs/docc-output-policy`

## Scope

Task #10 covers DocC generated output reproducibility, local preview, GitHub Pages publication, and `docs/` commit policy.

Do not create `Docs/`. The existing lowercase `docs/` directory is reserved for Swift-DocC generated output.

## Findings

`docs/index.html` is not intended to be opened directly via `file://`.

The generated HTML sets `baseUrl = "/Fluidable/"` and loads assets from root-relative URLs such as:

- `/Fluidable/js/chunk-vendors.0b7dc663.js`
- `/Fluidable/js/index.b232e9de.js`
- `/Fluidable/css/index.19043b1e.css`
- `/Fluidable/data/...`

When opened as `file:///Users/kojirof/Documents/Workspace/Projects/pj-github/Fluidable/docs/index.html`, the browser resolves those paths from filesystem root, not from the repository's `docs/` directory. That makes `file://` direct open fail even when generation is complete.

The current `fastlane ios create_doc` lane uses:

- `--transform-for-static-hosting`
- `--hosting-base-path #{docc_hosting_base_path}`
- default `DOCC_HOSTING_BASE_PATH=Fluidable`
- `docs/.nojekyll`

This matches GitHub Pages project-site hosting, where the site is served below `/<repositoryname>`.

## Local Preview

Correct local preview for committed static-hosting output must use HTTP and preserve the `/Fluidable/` base path.

Validated during investigation:

- local server mapping `/Fluidable/` to `docs/`
- `GET /Fluidable/` returned `200`
- `GET /Fluidable/js/chunk-vendors.0b7dc663.js` returned `200`
- `GET /Fluidable/data/documentation/fluidable.json` returned `200`
- `GET /Fluidable/documentation/fluidable/` returned `200`

Alternative preview path from Swift-DocC plugin:

```sh
swift package --disable-sandbox preview-documentation --target Fluidable
```

Use that for generated preview, not for validating already committed `docs/` with the GitHub Pages base path.

## Reproducibility

`bundle exec fastlane ios create_doc` completed successfully in two consecutive runs.

Observed generated diffs after regeneration:

- `docs/data/**/*.json`: JSON key order changes.
- `docs/metadata.json`: JSON key order changes.
- `docs/index/availability.index`: binary hash changes.
- `docs/index/data.mdb`: binary hash changes.
- `docs/index/navigator.index`: binary hash changes.
- `docs/js/chunk-vendors.0b7dc663.js`: stable between the two investigation runs, but different from committed baseline.
- `git diff --check`: fails on generated trailing whitespace in `docs/js/chunk-vendors.0b7dc663.js`.

Representative failure:

```text
docs/js/chunk-vendors.0b7dc663.js:12: trailing whitespace.
+ * vue-i18n v8.28.2 
```

The generated output is therefore not cleanly reproducible enough for routine commit without an explicit policy.

## Policy Options

Recommended baseline:

- Keep `docs/` committed only for intentional publication updates.
- Do not include incidental DocC regeneration in unrelated work.
- Preview committed output through an HTTP server that serves `docs/` under `/Fluidable/`.
- Treat `file://.../docs/index.html` as unsupported for this repository's current DocC output.

Open decisions before implementation:

- Whether to add a documented local preview command/script.
- Whether to add post-processing for generated JSON key ordering and JS trailing whitespace.
- Whether to accept generated binary index churn, exclude it from routine review, or change publication flow.
- Whether to keep publishing from committed `docs/` or move publication to GitHub Actions artifact / `gh-pages` flow.
- Whether `git diff --check` should keep blocking generated `docs/js/*.js` trailing whitespace or gain a generated-output exception.

No Swift, Xcode, Ruby gem, Fastlane plugin, SPM dependency, UI, or Example behavior change was approved during this investigation.
