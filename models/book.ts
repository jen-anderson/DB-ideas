export interface Book {
  id: string
  owner_id: string
  title: string
  creator: string
  work_id: string //If using catch-all for a given title, all LoTR for example
  isbn?: string // Opt, but preferred. Not all books have. String cuz 0 starts
  format: string
  condition?: string
  lending_terms?: string
  status: 'Available' | 'On loan' | 'In transit' | 'Reserved'
  image_urls: string[] //Array of condition images?
  created_at: string
  updated_at: string
}