class UserDetailsPref{


   String? token;
   String? userName;
   String? id;

   String? role;
 int? status;
   String? deviceToken;

   UserDetailsPref(
       {this.token,
      this.id,
      this.userName,
      this.deviceToken,
      this.role,
      this.status
   });
}