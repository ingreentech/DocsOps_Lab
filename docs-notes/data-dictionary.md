# Data dictionary: releases table

Source: GitHub Releases API, built by scripts/build_dataset.sh.
Date built: 15.11.2026

| Column | Type | Meaning | Example value |
|---|---|---|---|
| id | INTEGER | Numeric identifier GitHub assigns to the release. Unique across all projects; used as the primary key. | 1 |
| project | TEXT | Repository the release belongs to, in owner/name form. Derived from html_url by the build script. | simonw/datasette	 |
| tag_name | TEXT | Git tag the release is attached to, usually a version number. | 1.0a42 |
| name | TEXT | Title of the release as entered by the maintainers. Empty text when none was given. | 1.0a42 |
| published_at | TEXT | Date and time the release was published, in UTC, ISO 8601 format. | 2026-11-08T23:55:18Z |
| prerelease | INTEGER | 1 if the maintainers marked the release as a prerelease, 0 if not. | 1 |
| html_url | TEXT | Address of the release page on GitHub. | https://github.com/simonw/datasette/releases/tag/1.0a42 |

## Notes and quirks

- Missing release names are stored as empty text (''), not NULL. Query: select count(*) from releases where name is null; Result: 0. Query: select count(*) from releases where name = ''; Result: 22 (checked on DATE). Filter with name = '', not name is null.
- published_at is text in ISO 8601 format, UTC, ending in Z (example: 2017-11-16T16:01:35Z). Query: select min(published_at), max(published_at) from releases; Result: 2017-11-16T16:01:35Z to 2026-11-08T23:55:18Z. Dates sort and compare correctly as text.
- prerelease is stored as an integer, since SQLite has no boolean type. Query: select distinct prerelease from releases; Result: 0 and 1. Filter with prerelease = 1, not = true.
- Release counts per project on DATE: encode/httpx 51, pallets/click 31, simonw/datasette 176, simonw/sqlite-utils 129 (total 387). The GitHub sidebar showed 177 for simonw/datasette; the one-release difference is not explained. Counts change as projects publish new releases.
- Tag naming varies by project. Sampled tags: 0.28.1, 8.5.1, 1.0a42 (Datasette uses a suffix such as "a" for alpha), 4.2.1. Tags starting with "v": none (or: N in PROJECT, from the query above). Compare tags across projects with care.
