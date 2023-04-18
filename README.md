# readit

CS5200 Final Project

# How To Run

1. Change `user` and `password` field based on your MySQL credentials in `config.json` file

```
        "user": "",
        "password": "",

```

# TODO

- Showing profile page

- Hashing and storing password - DONE

- CRUD User

  - Create - Done
  - Read profile page - DONE
    - Function to return one profile based on userName
  - Update any fields of user - Done
    - Procedure
  - Delete user --> user can delete itself - DONE
    - Procedure

- CRUD Post

  - Create Post --x
  - Read post
  - Update post --X
  - Update IS ONLY increasing or decreasing Vote --X
  - Delete post will delete its comments

- CRUD Comment
  - Create comment and subcomment - DONE
  - Read thread of comment of a post  - DONE
  - Update one comment 
  - Delete - TO DO
    - Delete the top-level comment, child comments get deleted
    - Deleting sub-comment, only sub-comment gets deleted

# Maybe - TBD

- Award
  - Trigger to increase or decrease numAwardsReceived based posts
  - When post gets awarded by user

# Changes

After successful user creation, user is prompted back to screen asking for login

- In activity diagram, after successful signup, user goes directly to home page with newly signed up user name

# Extra Credit

- Login with hashed password
- Recursive relationship of comment --> Overly complicated translations from user operations to database operations
- CRUD for 3 entities
    - User
    - Post
    - Comment
