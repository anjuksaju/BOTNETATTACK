import nltk
import random as conf
##from pywsd.allwords_wsd import disambiguate
##from pywsd.lesk import simple_lesk
from sklearn.ensemble import ExtraTreesClassifier
from sklearn import cross_validation
##from sklearn.model_selection import cross_validate
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import VotingClassifier
from sklearn import decomposition
from sklearn.feature_extraction.text  import CountVectorizer
from sklearn.feature_extraction.text  import TfidfTransformer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_selection import  SelectKBest, chi2
##from sklearn import cross_validation
from sklearn.metrics import accuracy_score
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics import classification_report
from sklearn.tree import DecisionTreeClassifier
from sklearn.pipeline import Pipeline
from sklearn.svm import LinearSVC
import numpy as np
import sklearn_crfsuite
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB
from sklearn.ensemble import RandomForestClassifier
import warnings

from models import *
import os
from django.contrib.sessions.models import Session
from django.http import HttpResponse
from django.core.files.storage import FileSystemStorage
from django.conf import settings
# from django.contrib.auth.models import User
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def firstpg(request):
    return render(request,BASE_DIR+'\\templates\\index.html')

def loginpg(request):
    return render(request,'contact.html')

def home(request):
    return render(request,'index.html')

def athome(request):
    return render(request, 'attacker/attackerhome.html')

def userhome(request):
    return render(request, 'user/userhome.html')

def gallery(request):
    return render(request,'gallery.html')

def about(request):
    return render(request,'about.html')

def trainpg(request):
    return render(request,'user/train.html')

def reguser(request):
    print "In User Registration"
    if request.method=="POST":
        nam = request.POST.get("name")
        email = request.POST.get("email")
        address = request.POST.get("address")
        uname = request.POST.get("uname")
        password = request.POST.get("password")
        cpassword = request.POST.get("cpassword")
        if password==cpassword:
            print "match"
            print nam, "  ", email, "  ", address, "  ", uname, "  ", password
            s = User(name=nam, email=email, address=address, username=uname, password=password)

            s.save()
            return render(request, 'contact.html')
        else:
            print "Password Mismatch"
            return render(request, 'contact.html')

def loginreq(request):
    if request.method=="POST":
        print "In login Request"
        uname = request.POST.get("uname")
        password = request.POST.get("password")
        print uname,"  ",password
        if(uname=="attacker" and password=="attacker"):
            print "Attacker"
            return render(request, 'attacker/attackerhome.html')
        else:
            print "Checking user"
            usr = User.objects.all()
            for i in usr:
                if uname==i.username and password==i.password:
                    request.session['uid']=i.id
                    return render(request,'user/userhome.html')
    return render(request,'index.html',{})

def logout(request):
    for s in Session.objects.all():
        s.delete()
    return render(request, 'index.html')
