# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.4] - 2023-04-06

### Fixed

- Removed leading slash from base documentation URL.

## [1.0.3] - 2023-04-06

### Fixed

- Fixed base URL for documentation.

## [1.0.2] - 2023-04-06

### Removed

- Swift setup from deploy action. Swift is included in the runner.

## [1.0.1] - 2023-04-06

### Added

- Documentation publishing to GitHub pages.
- Swift Package Index manifest to allow SPI to host documentation. 

## [1.0.0] - 2023-04-06
                                                  
### Added
- The base `Matrix` type.
- `Collection` protocol to `Matrix`.
- Math extensions to `Matrix` for when elements are `Numeric`.
