import os
BASE_DIR = os.path.dirname(os.path.dirname(__file__))


# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '6^g!mf82gu3=vg!_x+l_4f(k2!u!e3q6g+5)0rb#%0-$lop&t3'
#https://console.developers.google.com/project/dulcet-bastion-779/apiui/credential?clientType&authuser=0
GOOGLE_OAUTH2_CLIENT_ID = '779040052387-5d0mo39muqgesmluhkpo93fhpgnl7a2j.apps.googleusercontent.com'
GOOGLE_OAUTH2_CLIENT_SECRET = 'cCNBdaQECY6oLeRxs_2-YqWA'

DEBUG = TEMPLATE_DEBUG = True

ALLOWED_HOSTS = []

INSTALLED_APPS = (
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.core.files',
    'social_auth',
    'myapp',
)

MIDDLEWARE_CLASSES = (
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'project.urls'
WSGI_APPLICATION = 'project.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

AUTHENTICATION_BACKENDS = (
'social_auth.backends.google.GoogleOAuth2Backend',
'django.contrib.auth.backends.ModelBackend',
)
LOGIN_REDIRECT_URL = '/'
SOCIAL_AUTH_USER_MODEL = 'auth.User'

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_L10N = True
USE_TZ = True

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'statics')

TEMPLATE_DIRS = (
    os.path.join(BASE_DIR, 'templates'),
)
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
