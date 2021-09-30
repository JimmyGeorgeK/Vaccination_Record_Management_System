from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,logout_user,login_manager,LoginManager
from flask_login import login_required,current_user


# MY db connection
local_server= True
app = Flask(__name__)
app.secret_key='jimmy'


# this is for getting unique user access
login_manager=LoginManager(app)
login_manager.login_view='login'




@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))




# app.config['SQLALCHEMY_DATABASE_URL']='mysql://username:password@localhost/databas_table_name'
app.config['SQLALCHEMY_DATABASE_URI']='mysql://root:@localhost/hms'
db=SQLAlchemy(app)



# here we will create db models that is tables
class Test(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    name=db.Column(db.String(100))
    email=db.Column(db.String(100))

class User(UserMixin,db.Model):
    id=db.Column(db.Integer,primary_key=True)
    username=db.Column(db.String(50))
    email=db.Column(db.String(50),unique=True)
    password=db.Column(db.String(1000))

class Patients(db.Model):
    pid=db.Column(db.Integer,primary_key=True)
    email=db.Column(db.String(50))
    pemail=db.Column(db.String(50))
    name=db.Column(db.String(50))
    gender=db.Column(db.String(50))
    slot=db.Column(db.String(50))
    disease=db.Column(db.String(50))
    time=db.Column(db.String(50),nullable=False)
    date=db.Column(db.String(50),nullable=False)
    vaccine=db.Column(db.String(50))
    cost=db.Column(db.String(50))
    number=db.Column(db.String(50))
    doctor=db.Column(db.String(50))

class Patient(db.Model):
    id=db.Column(db.Integer,primary_key=True)
    pemail=db.Column(db.String(50))
    pname=db.Column(db.String(20))
    pgender=db.Column(db.String(20))
    page=db.Column(db.String(10))
    pphone=db.Column(db.String(20))
    pcity=db.Column(db.String(20))
    

class Vaccine(db.Model):
    vid=db.Column(db.Integer,primary_key=True)
    disease=db.Column(db.String(50))
    vacname=db.Column(db.String(50))
    cost=db.Column(db.String(50))

class Doctor(db.Model):
    did=db.Column(db.Integer,primary_key=True)
    doctorname=db.Column(db.String(50))
    demail=db.Column(db.String(50))
    dept=db.Column(db.String(50))

class Trigr(db.Model):
    tid=db.Column(db.Integer,primary_key=True)
    pid=db.Column(db.Integer)
    email=db.Column(db.String(50))
    name=db.Column(db.String(50))
    action=db.Column(db.String(50))
    timestamp=db.Column(db.String(50))
    pemail=db.Column(db.String(50))





# here we will pass endpoints and run the fuction
@app.route('/')
def index():
    return render_template('index.html')

@app.route('/base')
def base():
    return render_template('base.html')
    


@app.route('/vaccine',methods=['POST','GET'])
def vaccine():

    if request.method=="POST":

        disease=request.form.get('disease')
        vacname=request.form.get('vacname')
        cost=request.form.get('cost')

        query=db.engine.execute(f"INSERT INTO `vaccine` (`disease`,`vacname`,`cost`) VALUES ('{disease}','{vacname}','{cost}')")
        flash("Information is Stored","primary")

    return render_template('vaccine.html')



@app.route('/doctor',methods=['POST','GET'])
def doctor():

    if request.method=="POST":

        email=request.form.get('email')
        dept=request.form.get('dept')
        doctorname=request.form.get('doctorname')
        user=Doctor.query.filter_by(demail=email).first()
        if user:
            flash("Email Already Exist","warning")
            return render_template('/doctor.html')

        query=db.engine.execute(f"INSERT INTO `doctor` (`demail`,`dept`,`doctorname`) VALUES ('{email}','{dept}','{doctorname}')")
        flash("Information is Stored","primary")

    return render_template('doctor.html')


@app.route('/register',methods=['POST','GET'])
@login_required
def register():
    if request.method=="POST":
        email=request.form.get('email')
        name=request.form.get('name')
        gender=request.form.get('gender')
        age=request.form.get('age')
        city=request.form.get('city')
        phone=request.form.get('phone')
        query=db.engine.execute(f"INSERT INTO `patient` (`pemail`,`pname`,	`pgender`,`page`,`pcity`,`pphone`) VALUES ('{email}','{name}','{gender}','{age}','{city}','{phone}')")
        flash("Patient Registered","info")
    return render_template('register.html')


@app.route('/patients',methods=['POST','GET'])
@login_required
def patients():
    vac=db.engine.execute("SELECT * FROM `vaccine`")
    pat=db.engine.execute("SELECT * FROM `patient`")
    doct=db.engine.execute("SELECT * FROM `doctor`")
    if request.method=="POST":
        email=request.form.get('email')
        pemail=request.form.get('pemail')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        vaccine=request.form.get('vaccine')
        cost=request.form.get('cost')
        number=request.form.get('number')
        doctor=request.form.get('doctor')
        subject="HOSPITAL MANAGEMENT SYSTEM"
        query=db.engine.execute(f"INSERT INTO `patients` (`pemail`,`email`,`name`,	`gender`,`slot`,`disease`,`time`,`date`,`vaccine`,`cost`,`number`,`doctor`) VALUES ('{pemail}','{email}','{name}','{gender}','{slot}','{disease}','{time}','{date}','{vaccine}','{cost}','{number}','{doctor}')")
        
# mail starts from here

        # mail.send_message(subject, sender=params['gmail-user'], recipients=[email],body=f"YOUR bOOKING IS CONFIRMED THANKS FOR CHOOSING US \nYour Entered Details are :\nName: {name}\nSlot: {slot}")



        flash("Booking Confirmed","info")


    return render_template('patient.html',vac=vac,pat=pat,doct=doct)


@app.route('/bookings')
@login_required
def bookings(): 
    em=current_user.email
    query=db.engine.execute(f"SELECT * FROM `patients` WHERE email='{em}'")
    return render_template('booking.html',query=query)


@app.route('/vacsearech')
@login_required
def vacsearch(): 
    query=db.engine.execute(f"SELECT * FROM `vaccine`")
    return render_template('vacsearch.html',query=query)



@app.route("/edit/<string:pid>",methods=['POST','GET'])
@login_required
def edit(pid):
    posts=Patients.query.filter_by(pid=pid).first()
    if request.method=="POST":
        email=request.form.get('email')
        pemail=request.form.get('pemail')
        name=request.form.get('name')
        gender=request.form.get('gender')
        slot=request.form.get('slot')
        disease=request.form.get('disease')
        time=request.form.get('time')
        date=request.form.get('date')
        cost=request.form.get('cost')
        number=request.form.get('number')
        doctor=request.form.get('doctor')
        db.engine.execute(f"UPDATE `patients` SET `email` = '{email}',`pemail` = '{pemail}', `name` = '{name}', `gender` = '{gender}', `slot` = '{slot}', `disease` = '{disease}', `time` = '{time}', `date` = '{date}', `cost` = '{cost}', `number` = '{number}',`doctor` = '{doctor}' WHERE `patients`.`pid` = {pid}")
        flash("Slot is Updates","success")
        return redirect('/bookings')
    
    return render_template('edit.html',posts=posts)


@app.route("/delete/<string:pid>",methods=['POST','GET'])
@login_required
def delete(pid):
    db.engine.execute(f"DELETE FROM `patients` WHERE `patients`.`pid`={pid}")
    flash("Slot Deleted Successful","danger")
    return redirect('/bookings')






@app.route('/signup',methods=['POST','GET'])
def signup():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()
        if user:
            flash("Email Already Exist","warning")
            return render_template('/signup.html')
        encpassword=generate_password_hash(password)

        new_user=db.engine.execute(f"INSERT INTO `user` (`username`,`email`,`password`) VALUES ('{username}','{email}','{encpassword}')")

        # this is method 2 to save data in db
        # newuser=User(username=username,email=email,password=encpassword)
        # db.session.add(newuser)
        # db.session.commit()
        flash("Signup Succes Please Login","success")
        return render_template('index.html')

          

    return render_template('signup.html')

@app.route('/login',methods=['POST','GET'])
def login():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("Login Success","primary")
            return redirect(url_for('register'))
        else:
            flash("invalid credentials","danger")
            return render_template('index.html')    





    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logout SuccessFul","warning")
    return redirect(url_for('index'))



@app.route('/test')
def test():
    try:
        Test.query.all()
        return 'My database is Connected'
    except:
        return 'My db is not Connected'
    

@app.route('/details')
@login_required
def details():
    # posts=Trigr.query.all()
    posts=db.engine.execute("SELECT * FROM `trigr`")
    return render_template('trigers.html',posts=posts)

@app.route('/search',methods=['POST','GET'])
@login_required
def search():
    if request.method=="POST":
        query=request.form.get('search')
        vac=Vaccine.query.filter_by(vacname=query).first()
        if vac:

            flash("Vaccine is Available","info")
            return redirect(url_for('vacsearch'))
        else:

            flash("Vaccine is Not Available","danger")
            return redirect(url_for('vacsearch'))
    return render_template('register.html')





app.run(debug=True)    


# username=current_user.username