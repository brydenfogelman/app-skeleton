from django.contrib.auth.models import AbstractUser


class UserModel(AbstractUser):
    class Meta:
        ordering = ["date_joined"]
