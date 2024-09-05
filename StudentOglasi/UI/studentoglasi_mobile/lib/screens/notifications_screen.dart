import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Obavijesti/obavijesti.dart';
import '../models/search_result.dart';
import '../providers/obavijesti_provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isLoading = true;
  bool _hasError = false;
  SearchResult<Obavijesti> _notifications = SearchResult();

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      // Call your provider's getObavijesti() method to fetch data
      var data = await Provider.of<ObavijestiProvider>(context, listen: false).get();
      setState(() {
        _notifications = data;  // Store fetched notifications in the SearchResult
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(child: Text('Failed to load notifications.'))
              : _notifications.result.isEmpty
                  ? Center(child: Text('No notifications found.'))
                  : ListView.builder(
                      itemCount: _notifications.result.length,
                      itemBuilder: (ctx, index) {
                        final notification = _notifications.result[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            title: Text(notification.naziv ?? 'No Title'),
                            subtitle: Text(notification.opis ?? 'No Description'),
                            trailing: Text(notification.datumKreiranja.toString()),
                          ),
                        );
                      },
                    ),
    );
  }
}
