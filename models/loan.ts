export interface Loans {
  id: Number
  book_id: Number
  lender_id: Number
  borrower_id: Number
  status: String // Active || Completed || Overdue
  due_date: String
}