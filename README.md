# readit

CS5200 Final Project

# Demo Video
[Video Link](https://www.loom.com/share/48db54bd1bb04e7d92ba0ce0c1b474b4)

# How To Run

- Change `user` and `password` field based on your MySQL credentials in `config.json` file

```
        "user": "",
        "password": "",

```

- Go the terminal and go to the python directory.
- On terminal type "python login.py" to run the login python script. -- That is the start point of our application.
- Create a new user by following the instructions.
- Login using the newly created user.
- You will see the main post page with different operations listed.
- To create a post Click on create post and follow the instructions.
- To delete the post, come back to the main page and select on delete the post.
- To upvote a post, you select upvote and vote it. You can also remove your vote from the main page itself.
- To comment on the post, go to Read/Comment option and comment then you have three options, 1.Create Comment 2.Update a comment
  - According to our design decision, a comment can only be deleted when a post is deleted. This would make people comment only when they mean to say something important.
- To Check the user profile, select the option.
  - Now you should see options to delete and update the user profile.
- Finally to log out you have option 10 that closes all the cursors and connections and loggs the user out of both the database and the applicaiton.

# Everything that we have done:

- Showing profile page

- Hashing and storing password

- CRUD User

  - Create
  - Read profile page
    - Function to return one profile based on userName
  - Update any fields of user
    - Procedure
  - Delete user --> user can delete itself
    - Procedure

- CRUD Post

  - Create Post
  - Read post
  - Update post
  - Update IS ONLY increasing or decreasing Vote
  - Delete post will delete its comments

- CRUD Comment
  - Create comment and subcomment
  - Read thread of comment of a post
  - Update one comment
  - Delete - TO DO --> Changed
    -- only deleting post can delete comments
    - Delete the top-level comment, child comments get deleted
    - Deleting sub-comment, only sub-comment gets deleted

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
