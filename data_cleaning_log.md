# Data Cleaning Log

## Initial Dataset
- Initial records: 7,691
- Initial columns: 10

## Data Quality Checks
- Checked missing values.
- Checked duplicate records.
- Reviewed inconsistent property descriptions.
- Extracted property types from house_type.
- Investigated records with zero bathrooms.
- Flagged properties with areas above 10,000 sq. ft.
- Flagged properties with rent above ₹500,000.
- Reviewed numerical column data types.

## Final Dataset
- Final records: 7,684
- Final columns: 14
- Missing values: 0
- Duplicate rows: 0

## Important Notes
- Seven records with zero bathrooms were excluded,
  if confirmed by the cleaning process.
- Large areas and high rents were flagged for review.
- Unusual values were not automatically deleted solely
  because they were unusually large.
