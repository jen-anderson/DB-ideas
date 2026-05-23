export interface User {
  id: string
  user_name: string
  email: string
  postcode: number
  interests?: string[]
  status: 'Active' | 'Banned' | 'On Hiatus' | 'Deleted'
  //User manual toggle active, on hiatus on profile to cover holiday/unavailability. Use this to make their collection hidden
  //Deleted - make placeholder name and deets, retain archive
  borrowed_count?: number //Opt, number of books borrowed
  loaned_count?: number //Opt, number of books lent
  rating?: number //Ratings
  created_at: string
  updated_at: string
}