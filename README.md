# ☕ Coffee Shop - Flutter Mobile App

> Your favorite coffee, delivered right to your door! A modern, full-featured coffee shop application with real-time ordering, Firebase backend, and beautiful UI.

[![Flutter](https://img.shields.io/badge/Flutter-3.10.0-02569B?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?logo=firebase)](https://firebase.google.com)
[![Tests](https://img.shields.io/badge/Tests-26%20Passing-success)](./test/TEST.md)

---

## 📖 Table of Contents
- [What's This App About?](#whats-this-app-about)
- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Admin Panel](#admin-panel)
- [How It Works](#how-it-works)
- [Common Issues](#common-issues)
- [Contributing](#contributing)
- [License](#license)

---

## 🎯 What's This App About?

Welcome to the Coffee Shop app! This is a fully functional mobile application that brings the coffee shop experience to your fingertips. Whether you're a caffeine enthusiast looking for your daily fix or a coffee shop owner wanting to manage orders, this app has you covered.

**Built with love using Flutter and Firebase** ❤️

### Why This App?

- **For Coffee Lovers**: Browse, order, and track your favorite coffee drinks
- **For Business Owners**: Manage products, orders, and customers from one place
- **For Developers**: Learn modern Flutter development with Firebase integration

---

## ✨ Features

### 🙋 For Customers

#### 🔐 Authentication & Profile
- **Sign up & Login**: Create your account with email and password
- **Profile Management**: Update your name, email, and phone number
- **Secure**: Firebase Authentication keeps your data safe

#### ☕ Browse & Shop
- **Coffee Menu**: View all available coffee products
- **Categories**: Filter by Hot Coffee, Iced Coffee, Specialty Drinks, etc.
- **Product Details**: See descriptions, prices, and beautiful product images
- **Favorites**: Save your favorite drinks for quick reordering
- **Search & Filter**: Find exactly what you're craving

#### 🛒 Cart & Checkout
- **Smart Cart**: Add items, adjust quantities, see running total
- **Multiple Addresses**: Save home, work, and other delivery locations
- **Easy Checkout**: Simple, streamlined ordering process
- **Order Confirmation**: Get instant confirmation when you place an order

#### 📦 Order Tracking
- **Order History**: View all your past orders
- **Live Status**: Track your current order (Pending, Preparing, Delivered)
- **Reorder**: Quickly reorder from your history

#### 🎨 Beautiful UI
- **Modern Design**: Clean, intuitive interface
- **Smooth Animations**: Delightful micro-interactions
- **Dark Mode Ready**: Easy on the eyes (coming soon!)
- **Responsive**: Works great on all screen sizes

---

### 👨‍💼 For Admins

**Access the admin panel by logging in with**: `admin@mail.com`

#### 📊 Dashboard
- **Overview**: See total products, orders, and users at a glance
- **Quick Stats**: Monitor your business in real-time
- **Easy Navigation**: Jump to any admin function quickly

#### ☕ Product Management
- **Add Products**: Upload new coffee items with images and details
- **Edit Products**: Update prices, descriptions, categories anytime
- **Delete Products**: Remove discontinued items
- **Categories**: Organize products by type (Hot, Iced, Specialty, etc.)
- **Image URLs**: Add beautiful product photos

#### 📋 Order Management
- **All Orders**: View complete order history
- **Live Orders**: See incoming orders in real-time
- **Order Actions**: Accept or decline orders
- **Customer Details**: See who ordered what, when, and where
- **Status Updates**: Mark orders as preparing, delivered, etc.

---

## 🛠 Tech Stack

### Frontend
- **Framework**: [Flutter](https://flutter.dev) - Build beautiful native apps
- **Language**: Dart - Fast, modern, and developer-friendly
- **State Management**: [Provider](https://pub.dev/packages/provider) - Simple and effective
- **UI Components**: Material Design with custom styling
- **Fonts**: [Google Fonts](https://pub.dev/packages/google_fonts) - Beautiful typography

### Backend
- **Authentication**: [Firebase Auth](https://firebase.google.com/products/auth) - Secure user management
- **Database**: [Cloud Firestore](https://firebase.google.com/products/firestore) - Real-time NoSQL database
- **Analytics**: [Firebase Analytics](https://firebase.google.com/products/analytics) - Track user behavior

### Architecture
- **Pattern**: Provider-based state management
- **Structure**: Feature-first organization
- **Models**: Clean data models with Firebase serialization
- **Testing**: Comprehensive unit test coverage (26 tests!)

---

## 🚀 Getting Started

### Prerequisites

Before you begin, make sure you have:

- ✅ **Flutter SDK** (3.10.0 or higher) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- ✅ **Dart SDK** (comes with Flutter)
- ✅ **Android Studio** or **VS Code** with Flutter extensions
- ✅ **Git** for version control
- ✅ **Firebase Account** (free tier works great!)

### Installation

Follow these steps to get the app running on your machine:

#### 1️⃣ Clone the Repository
```bash
git clone <repository-url>
cd untitled\ folder
```

#### 2️⃣ Install Dependencies
```bash
flutter pub get
```

This downloads all the packages the app needs (Provider, Firebase, Google Fonts, etc.)

#### 3️⃣ Firebase Setup

**Important**: The app needs Firebase to work!

1. **Create a Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project"
   - Follow the setup wizard

2. **Enable Authentication**
   - In Firebase Console, go to Authentication
   - Click "Get Started"
   - Enable "Email/Password" sign-in method

3. **Enable Firestore Database**
   - Go to Firestore Database
   - Click "Create Database"
   - Start in **production mode** or **test mode**
   - Choose your region

4. **Configure Flutter App**
   - The app already has `firebase_options.dart` configured
   - If you need to reconfigure, use [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup):
   ```bash
   flutterfire configure
   ```

#### 4️⃣ Run the App
```bash
flutter run
```

**First time?** It might take a few minutes to build. Grab a coffee! ☕

---

## 📂 Project Structure

Here's how the code is organized (makes it easy to find what you need):

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase configuration
├── models/                            # Data models
│   ├── product.dart                   # Coffee product model
│   └── order.dart                     # Order model
├── providers/                         # State management
│   ├── auth_provider.dart            # User authentication
│   ├── product_provider.dart         # Product data
│   ├── cart_provider.dart            # Shopping cart
│   ├── favorites_provider.dart       # Favorite products
│   ├── order_provider.dart           # Order management
│   ├── address_provider.dart         # Delivery addresses
│   └── admin_provider.dart           # Admin functions
├── screens/                           # UI screens
│   ├── onboarding_screen.dart        # Welcome screen
│   ├── login_screen.dart             # Login
│   ├── signup_screen.dart            # Registration
│   ├── home_screen.dart              # Main menu
│   ├── product_detail_screen.dart    # Product details
│   ├── cart_screen.dart              # Shopping cart
│   ├── checkout_screen.dart          # Order checkout
│   ├── order_success_screen.dart     # Order confirmation
│   ├── order_history_screen.dart     # Past orders
│   ├── favorites_screen.dart         # Favorite items
│   ├── profile_screen.dart           # User profile
│   ├── address_screen.dart           # Manage addresses
│   └── admin/                        # Admin screens
│       ├── admin_dashboard_screen.dart
│       ├── admin_products_screen.dart
│       ├── add_edit_product_screen.dart
│       ├── admin_orders_screen.dart
│       ├── live_orders_screen.dart
│       └── admin_users_screen.dart
└── widgets/                           # Reusable components
    └── product_card.dart             # Product display card

test/                                  # Unit tests
├── TEST.md                           # Test documentation
├── models/
│   ├── product_test.dart             # Product model tests
│   └── order_test.dart               # Order model tests
└── providers/
    └── address_provider_test.dart    # Address provider tests
```

---

## 🧪 Testing

We take quality seriously! The app has **26 comprehensive unit tests** covering core functionality.

### Run All Tests
```bash
flutter test
```

### Run Specific Tests
```bash
flutter test test/models/product_test.dart
flutter test test/providers/address_provider_test.dart
```

### Test Coverage
```bash
flutter test --coverage
```

### What's Tested?
- ✅ **Product Model** (7 tests) - Data serialization and Firebase integration
- ✅ **Address Provider** (10 tests) - Address management and state
- ✅ **Order Model** (9 tests) - Order calculations and status tracking

**Want to learn more about our tests?** Check out the detailed [Test Documentation](./test/TEST.md)!

---

## 🔑 Admin Panel

The app has a powerful admin dashboard for managing your coffee shop!

### How to Access Admin Features

1. **Login with admin email**: `admin@mail.com` (with your password)
2. The app automatically recognizes admin users
3. You'll see admin-only navigation options

### Admin Capabilities

**Dashboard**
- See total products, orders, and users
- Quick links to all admin functions

**Products**
- ➕ Add new coffee items
- ✏️ Edit existing products
- 🗑️ Delete discontinued items
- 📸 Manage product images
- 🏷️ Organize by categories

**Orders**
- 📋 View all orders (past and present)
- 🔴 Live order feed with real-time updates
- ✅ Accept orders and start preparing
- ❌ Decline orders if needed
- 📊 Track order status

**Users**
- 👥 View all registered customers
- 📧 See user contact information
- 📈 Monitor user activity

---

## 🎯 How It Works

### User Journey

1. **Onboarding**: Welcome screen introduces the app
2. **Sign Up/Login**: Create account or log in
3. **Browse**: Explore coffee products by category
4. **Select**: Tap a product to see details, add to favorites
5. **Add to Cart**: Choose quantity, add to cart
6. **Checkout**: Select delivery address, review order
7. **Place Order**: Confirm and submit
8. **Track**: Monitor order status in real-time
9. **Enjoy**: Receive your delicious coffee! ☕

### Admin Journey

1. **Login**: Access admin panel with admin credentials
2. **Dashboard**: See business overview
3. **Manage Products**: Add, edit, or remove items
4. **Process Orders**: Accept/decline incoming orders
5. **Track Users**: Monitor customer base
6. **Analytics**: View business metrics

---

## 🔥 Firebase Structure

### Collections

**users/**
```json
{
  "userId": {
    "name": "John Doe",
    "email": "john@example.com",
    "phone": "+1234567890",
    "cart": [...],
    "favorites": {...}
  }
}
```

**products/**
```json
{
  "productId": {
    "name": "Espresso",
    "description": "Strong and bold",
    "price": 3.99,
    "imageUrl": "https://...",
    "category": "Hot Coffee"
  }
}
```

**orders/**
```json
{
  "orderId": {
    "userId": "...",
    "products": [...],
    "amount": 26.48,
    "status": "Pending",
    "address": "...",
    "dateTime": "2024-11-30T..."
  }
}
```

---

## ⚠️ Common Issues

### Issue 1: Firebase Not Initialized
**Error**: `[core/no-app] No Firebase App '[DEFAULT]' has been created`

**Solution**:
```bash
flutterfire configure
flutter pub get
flutter run
```

### Issue 2: Build Fails
**Error**: Gradle errors or build failures

**Solution**:
```bash
flutter clean
flutter pub get
flutter run
```

### Issue 3: Hot Reload Not Working
**Solution**: Stop the app and run again
```bash
# Press 'q' in terminal to quit
flutter run
```

### Issue 4: Images Not Loading
**Solution**: Check your internet connection and Firebase Storage rules

### Issue 5: Tests Failing
**Solution**: Make sure you're in the project directory
```bash
cd /path/to/untitled\ folder
flutter test
```

---

## 🎨 Customization

Want to make this app your own? Here's what you can customize:

### Colors & Theme
- Edit the theme in `main.dart`
- Change primary color, accent color, fonts

### Products
- Add your own product categories
- Upload custom product images
- Set your own prices

### Features
- Add payment integration (Stripe, PayPal)
- Implement loyalty points
- Add push notifications
- Enable dark mode

---

## 🤝 Contributing

Want to make the app better? We'd love your help!

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Write tests** for new features
5. **Commit your changes**
   ```bash
   git commit -m "Add amazing feature"
   ```
6. **Push to your branch**
   ```bash
   git push origin feature/amazing-feature
   ```
7. **Open a Pull Request**

### Contribution Ideas
- 🎨 UI/UX improvements
- 🧪 More tests
- 📱 New features
- 🐛 Bug fixes
- 📝 Documentation improvements
- 🌍 Internationalization (multiple languages)

---

## 📚 Learn More

### Flutter Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)

### Firebase Resources
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Firestore Guide](https://firebase.google.com/docs/firestore)
- [Firebase Auth](https://firebase.google.com/docs/auth)

### State Management
- [Provider Documentation](https://pub.dev/packages/provider)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt)

---

## 📄 License

This project is open source and available under the MIT License.

---

## 💡 Acknowledgments

Built with:
- ☕ Coffee (lots of it!)
- ❤️ Passion for great apps
- 🚀 Flutter framework
- 🔥 Firebase platform
- 📚 Amazing open-source packages

---

## 📞 Support

Need help? Have questions?

- 📖 Check the [Test Documentation](./test/TEST.md)
- 🐛 Report bugs via Issues
- 💬 Ask questions in Discussions
- 📧 Contact the maintainers

---

## 🎉 What's Next?

### Planned Features
- [ ] Push notifications for order updates
- [ ] Payment integration (Stripe/PayPal)
- [ ] Loyalty rewards program
- [ ] Dark mode
- [ ] Multiple languages
- [ ] Order rating and reviews
- [ ] Chat with customer support
- [ ] Advanced analytics dashboard
- [ ] QR code ordering

---

**Made with ❤️ and ☕**

*Happy coding! May your coffee be strong and your code bug-free!* 🚀

---

**Last Updated**: November 30, 2024  
**Version**: 1.0.0  
**Flutter Version**: 3.10.0+
