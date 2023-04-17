# readit

CS5200 Final Project

# How To Run

1. Change `user` and `password` field based on your MySQL credentials in `config.json` file

```
        "user": "",
        "password": "",

```

# TODO

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
  - Create comment and subcomment
  - Read one comment
  - Update one comment
  - Delete
    - Delete the top-level comment, child comments get deleted
    - Deleting sub-comment, only sub-comment gets deleted

# Maybe - TBD

- Award
  - Trigger to increase or decrease numAwardsReceived based posts
  - When post gets awarded by user
