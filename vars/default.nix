{keys, ...}: {
  username = "diomedet";
  userfullname = "Diomede Tripicchio";
  useremail = "diomede.tripicchio@gmail.com";
  initialHashedPassword = "$7$CU..../....XxLmjXoU8BFQeQ9xNtbKx0$q7QZp0tgF0aGBYVZFveL0V8Nv6FpHDnc3Ey3zUziPF7";

  sshAuthorizedKeys = [
    keys.users.diomedet-at-applin
  ];
}
