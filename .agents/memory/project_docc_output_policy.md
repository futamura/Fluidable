# DocC output policy investigation

Date: 2026-05-20
Branch: `docs/docc-output-policy`
Decision: publish DocC with GitHub Pages Actions from `main`; do not commit generated `docs/` to source branches.

## Scope

Task #10 covers DocC generated output reproducibility, local preview, GitHub Pages publication, and `docs/` commit policy.

Do not create `Docs/`. The existing lowercase `docs/` directory is reserved for Swift-DocC local generated output and is ignored by Git.

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

## Publication Decision

Publish the DocC site with GitHub Pages Actions from `main`.

- Public URL: `https://gumob.github.io/Fluidable/`
- Pages source: GitHub Actions
- Source branch policy: do not commit generated `docs/`
- Generation command: `DOCC_HOSTING_BASE_PATH=Fluidable bundle exec fastlane ios create_doc`
- Artifact path: `docs`

This avoids noisy source branch diffs from DocC generated JSON key order, binary index files, and generated JS whitespace.

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

## Root URL Note

After publishing through GitHub Pages, `https://gumob.github.io/Fluidable/` can serve the DocC app shell with HTTP 200 while still displaying DocC's internal "The page you're looking for can't be found." screen.

This is not a Pages deployment failure. It happens because the DocC SPA has documentation content at `/documentation/fluidable/`, while the project root `/Fluidable/` is not a documentation node.

Decision: do not post-process DocC output for root redirects. Link readers directly to `https://gumob.github.io/Fluidable/documentation/fluidable/`.

## Policy

Selected baseline:

- Do not commit generated `docs/` to source branches.
- Publish from `main` through GitHub Pages Actions.
- Do not include incidental DocC regeneration in unrelated work.
- Preview committed output through an HTTP server that serves `docs/` under `/Fluidable/`.
- Treat `file://.../docs/index.html` as unsupported for this repository's current DocC output.

Open decisions before implementation:

- Whether to add a documented local preview command/script.
- Whether to add post-processing for generated JSON key ordering and JS trailing whitespace.
- Whether to accept generated binary index churn, exclude it from routine review, or change publication flow.
- Whether `git diff --check` should keep blocking generated `docs/js/*.js` trailing whitespace or gain a generated-output exception.

No Swift, Xcode, Ruby gem, Fastlane plugin, SPM dependency, UI, or Example behavior change was approved during this investigation.
