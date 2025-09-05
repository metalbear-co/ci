#!/usr/bin/env rust-script
//! This is a script that edits the changelog to be suitable for the website docs. It performs the following changes:
//! 1. Remove links from main headings, which link to the (private) operator repo
//! 2. Remove sections that start "### Internal"
//! 3. Fix empty sections, replace with "No significant changes"
//! 4. Remove links to GitHub issues
//!
//! ```cargo
//! [dependencies]
//! regex = "1.11"
//! ```

use std::io::{self, Read};
use regex::Regex;

fn main() {
    // Read file contents from stdin
    let mut file_contents = String::new();
    io::stdin().read_to_string(&mut file_contents).expect("Failed to read from stdin");

    // Remove links from headings
    let heading_regex = Regex::new(r"## \[(.+)\]\(.+\)").unwrap();
    let file_contents = heading_regex.replace_all(&file_contents, "## $1");

    // Remove sections that start "### Internal"
    let internal_regex = Regex::new(r"### Internal[\s\S]*?(?=##)").unwrap();
    let file_contents = internal_regex.replace_all(&file_contents, "");

    // Fix empty sections, replace with "No significant changes"
    let empty_section_regex = Regex::new(r"(## .+)(\n\n\n)(?=## )").unwrap();
    let file_contents = empty_section_regex.replace_all(&file_contents, "$1\n\nNo significant changes.$2");

    // remove issue links
    let empty_section_regex = Regex::new(r"\s*\[#\d*\]\(.*issues.*\)").unwrap();
    let file_contents = empty_section_regex.replace_all(&file_contents, "");

    // Print the file contents
    println!("{}", file_contents);
}


