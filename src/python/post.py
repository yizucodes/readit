
import pymysql as msc

from image import image


mydb = msc.connect(host = "LocalHost", 
                   user=f"root", 
                   passwd = f"University@1",
                   db = "readit")

cursor = mydb.cursor()
post_id_list = []

def idList():
    cursor.execute(f"select post.id from uservotepostlink as upv RIGHT JOIN post ON post.id = upv.postId GROUP BY post.id;")
    for ids in cursor:
        # print(ids[0])
        post_id_list.append(ids[0])
    
idList()


def create_post(userName, title, body):
    cursor.execute(f"Select CUPost(NULL, '{userName}', '{title}', '{body}')")
    cursor.connection.commit()
    out = 0
    for c in cursor:
        out = c
    return out[0]



def update_post(id, userName, title, body):
    cursor.execute(f"select CUPost({id}, '{userName}', {title}, {body})")
    cursor.connection.commit()
    out = 0
    for d in cursor:
        out = d
    return out[0]

def delete_post(id, user):
    cursor.execute(f"CALL delete_post({id}, '{user}')")
    cursor.connection.commit()
def upvote(user, id):
    cursor.execute(f"CALL user_votes_post('{user}', {id})")
    cursor.connection.commit()

def undo_vote(user, id):
    cursor.execute(f"CALL undo_vote('{user}', {id})")
    cursor.connection.commit()

img = image(cursor)


def mainPage():
    cursor.execute(f"select post.title, post.id, post.userName, COUNT(upv.postId) as votes from uservotepostlink as upv RIGHT JOIN post ON post.id = upv.postId GROUP BY post.id;")
    
    for i in cursor:
        print("--------------------------------------------------|")
        print(f"Title: {i[0]}")
        print("--------------------------------------------------|")
        print(f"Author: {i[2]}")
        print("--------------------------------------------------|")
        print(f"Post ID: {i[1]}................Votes: {i[3]}")
        print("--------------------------------------------------|\n\n")

def readPost(postId):
    cursor.execute(f"select post.body, post.title, post.id, COUNT(upv.postId) as votes " +
                    f" from uservotepostlink as upv RIGHT JOIN post ON post.id = upv.postId"+
                    f" WHERE post.id = {postId}" + 
                    f" GROUP BY post.id;")
    
    for i in cursor:
        tempid = i[2]
        
        print("--------------------------------------------------|")
        print(f"Title: {i[1]}")
        print("--------------------------------------------------|")
        print(f"{i[0]}")
        print("--------------------------------------------------|")
        print(f"Img URL:   {img.get_img(tempid)}")
        print("------------------- -------------------------------|")
        print(f"Post ID: {i[2]}................Votes: {i[3]}")
        print("--------------------------------------------------|\n\n")

if __name__ == "__main__":
    print("Printing overall posts: ...")
    mainPage()
    # user = "amandasmith"
    user = "chrisbrown"

    while(True):
        inp = int(input("\n1) Create a post \n2) Display all the posts\n3)Update a post\n4)Delete Post\n5)Upvote a post\n6)Undo your vote\n7)Read post in detail\n10)Exit\n"))
        if(inp == 1):
           
            # user = "amandasmith"
            title = input("Give it a title...common!\n")
            txt_body = ""
            img_body = ""
            while(True):
                choice = int(input("\nAdd\n1)Text\n 2)Img \n3)done\n"))
                if(choice == 1):
                    txt_body += input("\nwhat do you want it to have?\n")
                elif (choice == 2):
                    img_body += input("\nAdd img url\n")
                elif(choice == 3):
                    break; 
            id = create_post(user, title, txt_body)
            img.add_img(id,img_body)
            
        elif (inp == 2):
            print("\nDisplaying Again: ....\n\n")
            mainPage()
        elif (inp == 3):
            print("\ncurrent list:\n\n")
            mainPage()
            opt = int(input("\nWhich of the following do you want to change/ update?\n"))
            if opt not in post_id_list:
                print("\nInvalid id request\n")
                continue
            
            titUp = input("\nWhat's the change in title? Write null if no changes!\n")
            # bodUp = input("\nWhat's the change in body? Write null if no changes!\n")
            if(titUp.lower() != 'null'):
                titUp = f"'{titUp}'"
            txt_body = 'null'
            img_body = 'null'
            
            choice = int(input("\nUpdate 1)Text\n 2)Img \n3)remove img\n"))
            if(choice == 1):
                txt_body = input("\nwhat do you want it to have? Write null if no changes!\n")
                if(txt_body.lower() != 'null'):
                    txt_body = f"'{txt_body}'"
            elif (choice == 2):
                img_body = input("\nAdd img url\n")
                if(img_body.lower() != 'null'):
                    img_body = f"'{img_body}'"
            elif (choice == 3):
                img.delete_img(opt,img.get_img(opt))
                continue
            

            print(f"{img_body}, {txt_body}, {opt}")

            try:    
                update_post(opt, user, titUp,txt_body)
                img.change_img(opt,img_body)

            except Exception as e:
                print(f"\n{e}\n")
        elif(inp == 4):
            dele = int(input("\nWhich post do you want to delete? Note: you can only delete your posts!\n"))
            try:
                delete_post(dele, user)
            except:
                print("\nInvalid delete attempt!\n")
                continue
        elif(inp == 5):
            vote = int(input("\nEnter the post ID to upvote!: \n"))
            print("\nChecking if the vote is valid.....\n")
            try:
                upvote(user, vote)
            except:
                print("\nAlready upvoted the post...cannot upvote again!...\n")
        elif(inp == 6):
            undo = int(input("\nWhich vote do you want to undo?\n"))
            try:
                undo_vote(user, undo)
                print("\nVote undone\nNew list is: \n\n")
                mainPage()
            except:
                print("\nYou never upvoted this so you cannot undo this as well\n")
        elif(inp == 7):
            post = int(input("Which post do you want to read?"))
            readPost(post)
        elif(inp == 10):
            break
        else:
            print("\nInvalid Option selected!\n")

