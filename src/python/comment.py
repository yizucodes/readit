import utils
import pymysql


def create_comment(post_id, parent_id, userName, text_body):
    connection = utils.create_connection()
    try:
        with connection.cursor() as cursor:
            cursor.callproc("createComment",
                            (post_id, parent_id, userName, text_body))
            cursor.fetchone()
            connection.commit()
    finally:
        connection.close()


def update_comment(comment_id, new_text_body):
    connection = utils.create_connection()
    try:
        with connection.cursor() as cursor:
            cursor.callproc("updateComment", (comment_id, new_text_body))
            cursor.fetchone()
            connection.commit()
    finally:
        connection.close()


def delete_comment(comment_id):
    connection = utils.create_connection()
    try:
        with connection.cursor() as cursor:
            cursor.callproc("deleteComment", (comment_id,))
            cursor.fetchone()
            connection.commit()
    finally:
        connection.close()


def read_comment(comment_id):
    connection = utils.create_connection()
    try:
        with connection.cursor() as cursor:
            cursor.callproc("readComment", (comment_id,))
            result = cursor.fetchone()
            connection.commit()
            return result
    finally:
        connection.close()


def read_comments_for_post(post_id):
    connection = utils.create_connection()
    try:
        with connection.cursor(pymysql.cursors.DictCursor) as cursor:
            sql = """
            SELECT
                c.id AS comment_id,
                c.textBody AS comment_text_body,
                c.parentId AS comment_parent_id,
                p.id AS post_id,
                p.title AS post_title,
                p.body AS post_body
            FROM
                comment AS c
            JOIN
                postHasCommentLink AS pcl
            ON
                c.id = pcl.commentId
            JOIN
                post AS p
            ON
                pcl.postId = p.id
            WHERE
                p.id = %s;
            """
            cursor.execute(sql, (post_id,))
            result = cursor.fetchall()
            connection.commit()
            return result
    finally:
        connection.close()


def print_comments(comments, parent_id=None, depth=0):
    for comment in comments:
        if comment['comment_parent_id'] == parent_id:
            print(" " * depth * 4, f"Comment ID: {comment['comment_id']}")
            print(" " * depth * 4, f"Comment: {comment['comment_text_body']}")
            print(" " * depth * 4, "----------------------------------------")
            print_comments(comments, comment['comment_id'], depth + 1)


def create_comment_prompt(post_id, user):
    parent_id = input("Enter the parent comment ID, or leave it blank if this is a top-level comment: ").strip()
    parent_id = None if parent_id == '' else int(parent_id)
    text_body = input("Enter the comment text: ").strip()

    create_comment(post_id, parent_id, user, text_body)
    print("Comment created successfully!")