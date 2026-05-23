export interface Book {
  id: Number
  owner_id: Number
  title: String
  creator: String
  work_id: Number //If using catch-all for a given title, all LoTR for example
  isbn?: Number // Opt, but preferred. Not all books have
  format: String
  condition?: String
  status: String
  image: String[] //Array of condition images?
}