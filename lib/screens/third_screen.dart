import 'package:flutter/material.dart';
import 'package:flutter_mobile_magang/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.fetchUsers(refresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          provider.hasMore &&
          !provider.isLoading) {
        provider.fetchUsers();
      }
    });
  }

  Future<void> _onRefresh() async {
    await Provider.of<UserProvider>(context, listen: false)
        .fetchUsers(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final users = provider.users;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Third Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF554AF0), 
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Color(0xFFE0E0E0), 
            height: 1,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: users.isEmpty && !provider.isLoading
            ? const Center(child: Text('No users found.'))
            : ListView.builder(
                controller: _scrollController,
                itemCount: users.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < users.length) {
                    final user = users[index];
                    return Column(
                      children: [
                        Container(
                          height: 95,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 24.5,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: user.avatar.isNotEmpty
                                  ? NetworkImage(user.avatar) as ImageProvider
                                  : const AssetImage('assets/images/photo.jpg'),
                            ),
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
                            onTap: () {
                              provider.selectUser(
                                  '${user.firstName} ${user.lastName}');
                              Navigator.pop(context);
                              
                            },
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Color(0xFFE0E0E0),
                          indent: 72,
                          endIndent: 16,
                        ),
                      ],
                    );
                  } else if (provider.isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator(color: Color(0xFF554AF0))),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
      ),
    );
  }
}
