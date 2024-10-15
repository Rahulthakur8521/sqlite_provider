import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqlite_provider/user_provider.dart';
import 'model_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        title: Text('User provider'),
        backgroundColor: Colors.purple,
      ),
      body: FutureProvider<List<User>>(
        create: (context) => UserProvider().getAllUsers() ,
        initialData: List<User>.empty(),
        child: Consumer<List<User>>(builder: (context, value, child) {

          var users  = value;
          if(users.isEmpty){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];

              return Card(
                color: Colors.orange.shade100,
                margin: EdgeInsets.all(10),
                elevation: 3,

                child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete,color: Colors.red,),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text('Are you sure you want to delete this user?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog and delete the user
                                        Navigator.of(context).pop();
                                        if (user.id != null) {
                                          UserProvider().deleteUser(user.id!);
                                        }
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),

                        IconButton (
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController nameController = TextEditingController(text: user.name);
                                TextEditingController emailController = TextEditingController(text: user.email);

                                return AlertDialog(
                                  title: Text('Edit User'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller: nameController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(labelText: 'Name',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                      ),
                                      SizedBox(
                                        height: 11,
                                      ),
                                      TextField(
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(labelText: 'Email',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10)
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancel'),
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        String newName = nameController.text;
                                        String newEmail = emailController.text;
                                        User updatedUser = User(id: user.id, name: newName, email: newEmail);
                                        Provider.of<UserProvider>(context, listen: false)
                                            .updateUser(updatedUser);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Update'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },

                          icon: Icon(Icons.edit, color: Colors.blue),
                        ),

                      ],
                    )
                ),
              );
            },
          );
        },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController emailController = TextEditingController();

              return AlertDialog(
                title: Text('Add User'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),

                    SizedBox(
                      height: 11,
                    ),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ],
                ),

                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),

                  TextButton(
                    onPressed: () {
                      String name = nameController.text;
                      String email = emailController.text;
                      User newUser = User(name: name, email: email,);
                      Provider.of<UserProvider>(context, listen: false)
                          .addUser(newUser);
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },

        child: Icon(Icons.add),backgroundColor: Colors.brown,
      ),
    );
    }
}
