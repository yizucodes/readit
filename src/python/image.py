import pymysql as msc

class image():
    def __init__(self, cursor):
        self.cursor = cursor
    
    def add_img(self, postId, img_url):
        querry = f"CALL create_img('{img_url}', {postId})"
        self.cursor.execute(querry)
        self.cursor.connection.commit()

    
    def delete_img(self, postId, img_url):
        self.cursor.execute(f"CALL delete_image_from_post('{img_url}', {postId})")
        self.cursor.connection.commit()
    def change_img(self, postId, img_url):
        self.cursor.execute(f"CALL change_img({img_url}, {postId})")
        self.cursor.connection.commit()
    
    def get_img(self, postId):
        self.cursor.execute(f"SELECT url FROM postcontainsimagelink WHERE postId = {postId}")

        self.cursor.connection.commit()
        res = ""
        for cur in self.cursor:
            res += cur[0]
        return res




# mydb = msc.connect(host = "LocalHost", 
#                    user=f"root", 
#                    passwd = f"University@1",
#                    db = "readit")

# cursor = mydb.cursor()

# im = image(cursor)

# im.change_img(None, 1)