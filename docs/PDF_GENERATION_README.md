# PDF Generation Script

This repository includes an automated script to convert all Markdown files to professional PDF documents.

## Files Generated

The script `generate_pdfs.sh` automatically converts the following files:

- ✅ **README.md** → `pdf/README.pdf` (GitHub profile overview)
- ✅ **resume-en.md** → `pdf/resume-en.pdf` (English resume)
- ✅ **resume-es.md** → `pdf/resume-es.pdf` (Spanish resume)  
- ✅ **resume-pt-br.md** → `pdf/resume-pt-br.pdf` (Portuguese resume)
- ✅ **summary.md** → `pdf/summary.pdf` (Project summary/completion status)

## Usage

### Quick Start

```bash
# Make the script executable (only needed once)
chmod +x generate_pdfs.sh

# Generate all PDFs
./generate_pdfs.sh
```

### What the Script Does

1. **Creates PDF Directory**: Automatically creates a `pdf/` folder if it doesn't exist
2. **Smart Engine Selection**: 
   - First tries `pdflatex` for optimal output quality
   - Falls back to `xelatex` for files containing Unicode characters (emojis, special symbols)
3. **Professional Formatting**:
   - 1-inch margins on all sides
   - 11pt font size with 1.15 line spacing
   - Clickable blue links
   - Automatic table of contents
   - Standalone document formatting

### Requirements

The script requires the following packages (automatically installed during setup):

- `pandoc` - Document converter
- `texlive-latex-base` - Basic LaTeX support
- `texlive-fonts-recommended` - Additional fonts
- `texlive-latex-extra` - Extra LaTeX packages
- `texlive-xetex` - XeTeX engine for Unicode support

### Output

The script provides:

- ✅ **Color-coded progress indicators**
- 📊 **Conversion statistics** 
- 📁 **File size information**
- 🔄 **Automatic fallback** for Unicode content
- 📝 **Detailed error reporting**

### Example Output

```bash
=== Markdown to PDF Converter ===
Starting conversion process...

Converting: README.md → pdf/README.pdf
  Attempting with pdflatex...
  pdflatex failed, trying xelatex for Unicode support...
✓ Successfully converted with xelatex: README.md

=== Conversion Summary ===
Successfully converted: 5 files
PDF files saved in: pdf/ directory
```

## File Sizes

- README.pdf: ~58KB
- resume-en.pdf: ~158KB  
- resume-es.pdf: ~160KB
- resume-pt-br.pdf: ~161KB
- summary.pdf: ~52KB

## Notes

- The script handles both ASCII and Unicode content automatically
- PDFs are generated with professional formatting suitable for printing or digital sharing
- All generated PDFs include clickable links and proper document structure
- The script can be run multiple times safely - it will overwrite existing PDFs with updated versions
