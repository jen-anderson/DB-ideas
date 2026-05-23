export interface User {
  id: Number
  user_name: String
  email: String
  postcode: Number
  status: String //Active, Banned, On Hiatus, Deleted (make placeholder name and deets)
  borrowed?: Number //Opt, number of books borrowed
  loaned?: Number //Opt, number of books lent
  rating?: Number //Ratings
}