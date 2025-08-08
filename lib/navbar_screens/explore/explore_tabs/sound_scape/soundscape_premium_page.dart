import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SoundScapePremiumPage extends StatefulWidget {
  @override
  _SoundScapePremiumPageState createState() => _SoundScapePremiumPageState();
}

class _SoundScapePremiumPageState extends State<SoundScapePremiumPage> {
  Offerings? _offerings;
  CustomerInfo? _customerInfo;
  bool _isLoading = true;
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    // Fetch offerings and customer info when page loads
    _fetchData();
  }

  // Fetch both offerings and customer info
  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // Get current offerings from RevenueCat
      Offerings offerings = await Purchases.getOfferings();
      // Get current customer info (subscription status)
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      setState(() {
        _offerings = offerings;
        _customerInfo = customerInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            'Error loading subscription information: ${e.toString()}';
        _isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  // Check if user has premium access
  bool get _hasPremiumAccess {
    if (_customerInfo == null) return false;
    return _customerInfo!.entitlements.all["premium_access"]?.isActive ?? false;
  }

  // Make a purchase
  Future<void> _purchasePackage(Package package) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      // Attempt to purchase the package
      CustomerInfo customerInfo = await Purchases.purchasePackage(package);
      setState(() {
        _customerInfo = customerInfo;
        _isLoading = false;
      });
      // Check if purchase was successful
      if (_hasPremiumAccess) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Subscription successful! You now have premium access.')));
      }
    } catch (e) {
      // Handle purchase errors
      if (e is PlatformException) {
        // This handles user cancellation
        setState(() {
          _errorMessage = e.message ?? 'Purchase canceled or failed';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Error during purchase: ${e.toString()}';
          _isLoading = false;
        });
      }
      print('Purchase error: $e');
    }
  }

  // Restore purchases
  Future<void> _restorePurchases() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      setState(() {
        _customerInfo = customerInfo;
        _isLoading = false;
      });
      // Show result to user
      String message = _hasPremiumAccess
          ? 'Purchases restored successfully! You have premium access.'
          : 'Purchases restored, but no active subscriptions found.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      setState(() {
        _errorMessage = 'Error restoring purchases: ${e.toString()}';
        _isLoading = false;
      });
      print('Restore error: $e');
    }
  }

  // Display a subscription package
  Widget _buildPackageItem(Package package) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              package.storeProduct.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(package.storeProduct.description),
            const SizedBox(height: 8),
            Text(
              'Price: ${package.storeProduct.priceString}',
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _purchasePackage(package),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Subscribe Now'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Subscription'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasPremiumAccess
              ? _buildPremiumContent()
              : _buildSubscriptionContent(),
    );
  }

  // Content to show when user has premium access
  Widget _buildPremiumContent() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 80,
              color: Colors.amber,
            ),
            SizedBox(height: 24),
            Text(
              'You are a Premium User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Thank you for your subscription. You have access to all premium features.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Content to show when user needs to subscribe
  Widget _buildSubscriptionContent() {
    return Column(
      children: [
        // Error message if any
        if (_errorMessage.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        // Show packages if available
        Expanded(
          child: _offerings == null || _offerings!.current == null
              ? const Center(child: Text('No subscription plans available.'))
              : ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Choose a Subscription Plan',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ..._offerings!.current!.availablePackages
                        .map(_buildPackageItem)
                        .toList(),
                  ],
                ),
        ),
        // Restore purchases button
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextButton(
            onPressed: _restorePurchases,
            child: const Text('Restore Purchases'),
          ),
        ),
      ],
    );
  }
}
