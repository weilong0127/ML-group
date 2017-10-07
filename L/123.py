import numpy as np
from numpy.linalg import cholesky
from sklearn import neighbors  
from sklearn.metrics import precision_recall_curve  
from sklearn.metrics import classification_report  
from sklearn.cross_validation import train_test_split  
import matplotlib.pyplot as plt

sampleN1=11000
mu1 = np.array([[0, 0]])
Sigma1 = np.array([[1, 0], [0, 1]])
R1 = cholesky(Sigma1)
s1 = np.dot(np.random.randn(sampleN1, 2), R1) + mu1

sampleN2=11000
mu2 = np.array([[3, 3]])
Sigma2 = np.array([[2, 0], [0, 2.5]])
R2 = cholesky(Sigma2)
s2 = np.dot(np.random.randn(sampleN2, 2), R2) + mu2

#ss1=np.hstack((s1[1000:],[[0]]*10000))
#ss2=np.hstack((s2[1000:],[[1]]*10000))

x=np.vstack((s1[1000:],s2[1000:]))
y=[0]*10000+[1]*10000
#y=np.vstack(([[0]]*10000,[[1]]*10000))

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size = 0.2)  

h = .01  
x_min, x_max = x[:, 0].min() - 0.1, x[:, 0].max() + 0.1  
y_min, y_max = x[:, 1].min() - 1, x[:, 1].max() + 1  
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),  
                     np.arange(y_min, y_max, h))
#k value
clf = neighbors.KNeighborsClassifier(n_neighbors=1)  
clf.fit(x_train, y_train)

precision, recall, thresholds = precision_recall_curve(y_train, clf.predict(x_train))  
answer = clf.predict_proba(x)[:,1]  
print(classification_report(y, answer, target_names = ['Gauss1', 'Gauss2']))  

answer = clf.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:,1]  
z = answer.reshape(xx.shape)  
plt.contourf(xx, yy, z, cmap=plt.cm.Paired, alpha=0.8)  
plt.scatter(x_train[:, 0], x_train[:, 1], c=y_train, cmap=plt.cm.Paired)    
plt.show()  

#random.shuffle(list) 
#noise
