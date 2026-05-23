CREATE TABLE user (
  user_id TEXT PRIMARY KEY,
  user_name TEXT UNIQUE NOT NULL,
  email TEXT UNIQUE NOT NULL,
  postcode TEXT,
  about TEXT,
  interests TEXT, --Stringified JSON, avoid categories, interests tables
  status TEXT,
  created_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,

  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT CURRENT TIMESTAMP
)


CREATE TABLE book (
  book_id TEXT PRIMARY KEY,
  owner_id TEXT NOT NULL,
  title TEXT NOT NULL,
  creator TEXT,
  work_id TEXT, --If using catch-all for a given title, all LoTR for example
  isbn TEXT, --Opt, but preferred. Not all books have
  format TEXT,
  condition TEXT,
  status TEXT,
  image TEXT, 
  created_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT CURRENT TIMESTAMP
  
  FOREIGN KEY (owner_id)
    REFERENCES user(user_id)

)

---Possible extension - if owner wants multiple image, or add damaged book pics/condition
CREATE TABLE book_images (
  image_id TEXT PRIMARY KEY,
  book_id TEXT NOT NULL,
  image_url TEXT NOT NULL,
  description TEXT,          -- e.g., "Tear on page 40" or "Front cover"
  uploaded_by TEXT NOT NULL, -- Tracks if owner or borrower uploaded it
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (book_id) REFERENCES books(book_id),
  FOREIGN KEY (uploaded_by) REFERENCES users(user_id)
);


CREATE TABLE loans (
  id TEXT PRIMARY KEY,
  book_id TEXT NOT NULL,
  owner_id TEXT NOT NULL,
  borrower_id TEXT NOT NULL,
  due_at TIMESTAMP NOT NULL,
  created_atTIMESTAMP DEFAULT CURRENT TIMESTAMP
  updated_at TIMESTAMP DEFAULT CURRENT TIMESTAMP
  active BOOLEAN,

  FOREIGN KEY (book_id)
    REFERENCES book(book_id)
  
  FOREIGN KEY (owner_id)
    REFERENCES user(user_id)
  
  FOREIGN KEY (borrower_id)
    REFERENCES user(user_id)
  
  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT CURRENT TIMESTAMP

)

----Possible extension; track book damage
CREATE TABLE condition_reports (
  report_id TEXT PRIMARY KEY,
  loan_id TEXT NOT NULL,
  reporter_id TEXT NOT NULL,  -- The user raising the issue (borrower or owner)
  type TEXT NOT NULL,         -- 'PICKUP' or 'RETURN'
  notes TEXT NOT NULL,        -- 'bloodstains on page 40, foxed throughout'
  severity TEXT,              -- 'MINOR', 'MAJOR', 'DESTRUCTIVE'
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  FOREIGN KEY (loan_id) 
    REFERENCES loans(loan_id),
  FOREIGN KEY (reporter_id) 
    REFERENCES users(user_id)
);

CREATE TABLE book_review (
 b_review_id TEXT PRIMARY KEY,
 user_id TEXT NOT NULL,
 book_id TEXT NOT NULL,
 format_variant TEXT,
 rating INTEGER CHECK(rating >=0 AND rating <=5), --You can have a 0 rated book
 comment TEXT,
 created_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,

 FOREIGN KEY (user_id)
  REFERENCES user(user_id)

 FOREIGN KEY (book_id)
  REFERENCES book(book_id) 

  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT CURRENT TIMESTAMP

)


CREATE TABLE user_review (
 u_review_id TEXT PRIMARY KEY,
 reviewer_id TEXT NOT NULL,
 user_id TEXT NOT NULL,
 rating INTEGER CHECK(rating >=0 AND rating <=5),
 comment TEXT,
 created_atTIMESTAMP DEFAULT CURRENT TIMESTAMP,
 updated_at TIMESTAMP DEFAULT CURRENT TIMESTAMP,

 FOREIGN KEY (user_id)
  REFERENCES user(user_id)

 FOREIGN KEY (reviewer_id)
  REFERENCES user(user_id) 

  is_deleted BOOLEAN DEFAULT FALSE,
  deleted_at TIMESTAMP DEFAULT CURRENT TIMESTAMP


)


CREATE TABLE follows (
  id TEXT PRIMARY KEY,
  follower_id TEXT NOT NULL,
  followed_id TEXT NOT NULL,

  FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (followed_id) REFERENCES users(user_id) ON DELETE CASCADE
)