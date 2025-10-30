#!/bin/bash

# Script to convert all .md files in current directory to PDF
# Created: $(date)
# Author: Eduardo Garcia

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Markdown to PDF Converter ===${NC}"
echo -e "${BLUE}Starting conversion process...${NC}\n"

# Create pdf directory if it doesn't exist
if [ ! -d "pdf" ]; then
    echo -e "${YELLOW}Creating 'pdf' directory...${NC}"
    mkdir pdf
fi

# Counter for processed files
processed=0
failed=0

# Ensure required tools are installed (pandoc, xelatex) using `which`
missing=()
if ! which pandoc >/dev/null 2>&1; then
    missing+=("pandoc")
fi
if ! which xelatex >/dev/null 2>&1; then
    missing+=("xelatex")
fi

if [ ${#missing[@]} -eq 0 ]; then
    echo -e "${GREEN}All required tools are already installed.${NC}"
else
    echo -e "${YELLOW}Missing: ${missing[*]}${NC}"
    read -p "Install missing packages now? [Y/n] " ans
    ans=${ans:-Y}
    if [[ $ans =~ ^[Yy]$ ]]; then
        if which apt-get >/dev/null 2>&1; then
            echo -e "${BLUE}Using apt to install packages...${NC}"
            sudo apt-get update
            sudo apt-get install -y pandoc texlive-xetex
        else
            echo -e "${RED}No supported package manager found. Please install: ${missing[*]}${NC}"
        fi
    else
        echo -e "${YELLOW}Skipping installation; conversion may fail if dependencies are missing.${NC}"
    fi
fi

for md_file in eduardo-pereira-garcia-*.md; do
    if [ -f "$md_file" ]; then
        # Get filename without extension
        filename=$(basename "$md_file" .md)
        pdf_output="pdf/${filename}.pdf"
        
        echo -e "${BLUE}Converting: ${NC}$md_file ${BLUE}→${NC} $pdf_output"
        
        # Convert using xelatex for Unicode support
        if pandoc "$md_file" -o "$pdf_output" --pdf-engine=xelatex -V geometry:margin=1in 2>/dev/null; then
            echo -e "${GREEN}✓ Successfully converted: $md_file${NC}"
            ((processed++))
        else
            echo -e "${RED}✗ Failed to convert: $md_file${NC}"
            ((failed++))
        fi
        echo
    fi
done

# Summary
echo -e "${BLUE}=== Conversion Summary ===${NC}"
echo -e "${GREEN}Successfully converted: $processed files${NC}"
if [ $failed -gt 0 ]; then
    echo -e "${RED}Failed conversions: $failed files${NC}"
fi
echo -e "${BLUE}PDF files saved in: pdf/ directory${NC}"

# List generated PDF files
if [ $processed -gt 0 ]; then
    echo -e "\n${YELLOW}Generated PDF files:${NC}"
    ls -la pdf/*.pdf 2>/dev/null | awk '{print "  " $9 " (" $5 " bytes)"}'
fi

echo -e "\n${GREEN}Conversion process completed!${NC}"