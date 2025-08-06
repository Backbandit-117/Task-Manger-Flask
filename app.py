from flask import Flask, render_template,request,url_for,redirect,flash,session,g
from flask_mysqldb import MySQL
import MySQLdb
from werkzeug.security import generate_password_hash, check_password_hash


app=Flask(__name__)

#mysql connection
app.config["MYSQL_HOST"]="localhost"
app.config["MYSQL_USER"]='root'
app.config["MYSQL_PASSWORD"]='root'            
app.config["MYSQL_DB"]='task_management'
app.config["MYSQL_CURSORCLASS"]="DictCursor"
mysql=MySQL(app)

@app.after_request
def add_header(response):
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, post-check=0, pre-check=0, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "0"
    return response



#login page
@app.route('/', methods=['POST','GET'])
@app.route('/login', methods=['POST','GET'])
def login():
    if request.method=='POST':
        username=request.form['username']
        password=request.form['password']
        con=mysql.connection.cursor()
        sql="select passwd,userid,is_admin from users where username=%s"
        con.execute(sql,[username])
        result=con.fetchone()
        con.close()
        
        if result and check_password_hash(result['passwd'],password):
            session["uname"]=username
            session["id"]=result["userid"]
            session["is_admin"] = result['is_admin']
            flash('Login Successfull','safe')
            return redirect(url_for("home"))
        else:
            flash("Invalid Login",'danger')
            return render_template('login.html')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    flash("You have been logged out.", 'info')
    return redirect(url_for('login'))


#add_user
@app.route('/adduser',methods=["POST","GET"])
def adduser():
    if request.method=='POST':
        username=request.form['username']
        password=request.form['password']
        passwd=generate_password_hash(password)
        email=request.form['email']
        fullname=request.form['fullname']
        
        try:
            con=mysql.connection.cursor()
            sql="insert into users (username,passwd,email,full_name) values(%s,%s,%s,%s)"
            con.execute(sql,[username,passwd,email,fullname])
            mysql.connection.commit()
            flash('New User Account Created Successfully')
            return redirect(url_for("login"))
        except MySQLdb.IntegrityError:
            flash('User Name already taken Please choose another username')
            return redirect(url_for("login"))
        finally:
            con.close()
    return render_template('adduser.html')



#homepage
@app.route('/home')
def home():
    c,p=0,0
    if 'uname' not in session:
        flash("Please log in first", 'warning')
        return redirect(url_for('login'))
    is_admin = session.get("is_admin", False)
    user_id=session["id"]
    con=mysql.connection.cursor()
    if is_admin:
        con.execute("SELECT * FROM task ORDER BY priority DESC, created_dt DESC")
    else:
        sql="SELECT * FROM task where userid=%s ORDER BY priority DESC, created_dt DESC"
        con.execute(sql,[user_id])
    res=con.fetchall()
    con.close()
    uname=session.get('uname')
    for i in res:
      if i["priority"]==0:
         i["priority"]='Least'
      elif i["priority"]==1:
         i['priority']='Normal'
      elif i['priority']==2:
         i['priority']='High'
      else :
         i['priority']='Extreme'
      if i['status']==0:
          p+=1
      else:
          c+=1
    status_bar={'completed':c,'pending':p}
    return render_template("home.html", data=res, uname=uname,status_bar=status_bar)

#add task page
@app.route('/addtask',methods=["POST",'GET'])
def addtask():
 if 'uname' not in session:
        flash("Please log in first", 'warning')
        return redirect(url_for('login'))
 if request.method=='POST':
        priority=request.form['priority']
        taskname=request.form['name']
        user_id=session["id"]
        con=mysql.connection.cursor()
        sql="insert into task(task_name,priority,userid) values(%s,%s,%s)"
        con.execute(sql,[taskname,priority,user_id])
        mysql.connection.commit()
        con.close()
        flash('New Task Added')
        return redirect(url_for("home"))
 return render_template('addtask.html')


#task completed
@app.route("/complete/<string:id>",methods=["POST",'GET'])
def complete(id):
 if 'uname' not in session:
        flash("Please log in first", 'warning')
        return redirect(url_for('login'))
 
 if request.method=='POST':
        status=request.form['Status']
        if status == "1":
         con=mysql.connection.cursor()
         sql="update task set status=True where id=%s"
         con.execute(sql,[id])
         mysql.connection.commit()
         con.close()
         flash('Task Completed Succuessfully!')
        return redirect(url_for("home"))
      
 return render_template("complete.html")


#task dlt
@app.route("/dlt/<string:id>",methods=["POST",'GET'])
def dlt(id):
   con=mysql.connection.cursor()
   sql="delete from task where id=%s"
   con.execute(sql,[id])
   mysql.connection.commit()
   con.close()
   flash('Task Deleted')
   return redirect(url_for("home"))

#task edit
@app.route("/edit/<string:id>",methods=["POST",'GET'])
def edit(id):
    if 'uname' not in session:
        flash("Please log in first", 'warning')
        return redirect(url_for('login'))
    con=mysql.connection.cursor()
    if request.method=='POST':
        name=request.form['name']
        priority=request.form['priority']
        status=request.form['status']
        sql="UPDATE task SET task_name = %s, created_dt = NOW() , priority=%s ,status=%s WHERE ID = %s"
        con.execute(sql,[name,priority,status,id])
        mysql.connection.commit()
        con.close()
        flash('Editted Task Scuccessfully!')
        return redirect(url_for("home"))
    
    con=mysql.connection.cursor()   
    sql="select * from task where ID=%s"
    con.execute(sql,[id])
    res=con.fetchone()
    return render_template("edit.html",data=res)


#main
if (__name__)=="__main__":
    app.secret_key="harish"
    app.run(debug=True)