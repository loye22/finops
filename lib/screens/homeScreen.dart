import 'package:finops/models/staticVar.dart';
import 'package:finops/screens/adaugaFacturi.dart';
import 'package:finops/screens/listScreen.dart';
import 'package:finops/screens/midLVL/entities.dart';
import 'package:finops/widgets/alertsWidget.dart';
import 'package:finops/widgets/notidicationsAnimationIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:tabbed_view/tabbed_view.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late TabbedViewController _controller;
  List<TabData> tabs = [];

  @override
  void initState() {
    super.initState();

    _controller = TabbedViewController(tabs);
  }

  void openTab(String tabTitle, Widget tabContent) {
    // Check if the tab is already open
    int? existingIndex;
    for (int i = 0; i < tabs.length; i++) {
      if (tabs[i].text == tabTitle) {
        existingIndex = i;
        break;
      }
    }

    if (existingIndex != null) {
      // Navigate to the existing tab
      // Ensure the index is valid before accessing
      if (existingIndex >= 0 && existingIndex < tabs.length) {
        _controller.selectedIndex = existingIndex;
      }
    } else {
      // Add a new tab and navigate to it
      tabs.add(TabData(
        draggable: false,
        text: tabTitle,
        content: Padding(
          padding: EdgeInsets.all(8),
          child: tabContent,
        ),
      ));

      // Ensure we are setting the index to the last tab
      if (tabs.isNotEmpty) {
        _controller.selectedIndex = tabs.length - 1;
      }
    }

    // Update the state to reflect changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /// test
    openTab("tabTitle", TabBarExample());

    TabbedView tabbedView = TabbedView(
      controller: _controller,
      closeButtonTooltip: "Close tab",
    );

    Widget TabsWidgetDisplay = TabbedViewTheme(
      child: tabbedView,
      data: TabbedViewThemeData.mobile(accentColor: staticVar.themeColor!),
    );

    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leadingWidth: 10,
          automaticallyImplyLeading: true,
          backgroundColor: staticVar.themeColor,
          // Use your custom blue color here
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "FINOPS", // Title of the app
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
              SizedBox(width: staticVar.fullWidth(context) * .15),
              Flexible(
                child: Container(
                  width: staticVar.fullWidth(context) * .5,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NotificationIcon(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM8LrGjiUDcvYjUMk7jUJJZo0kK4Y4NzKxmQ&s', // Replace with profile image URL
                ),
              ),
            ),
          ],
        ),
        sideBar: SideBar(
          backgroundColor: Colors.white,
          //const Color(0xFFEEEEEE), // Light gray
          activeBackgroundColor: Colors.black26,
          iconColor: staticVar.themeColor,
          // Light gray for icons
          activeIconColor: Colors.blue,
          // Keep active icon blue if needed
          textStyle: TextStyle(color: staticVar.themeColor),
          scrollController: ScrollController(),
          items: const [
            AdminMenuItem(
              title: 'Dashboard',
              icon: Icons.dashboard,
              children: [
                AdminMenuItem(
                  icon: Icons.group, // Icon representing a group
                  title: 'Statistici Grup',
                  route: '/s',
                ),
                AdminMenuItem(
                  icon: Icons.person,
                  title: 'Statistici Individuale',
                  route: '/s2',
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Operatiuni',
              icon: Icons.work, // A more specific icon for "Operations"
              children: [
                AdminMenuItem(
                  icon: Icons.add_circle_outline,
                  // To indicate adding an operation
                  title: 'Adauga',
                  route: '/screen2',
                ),
                AdminMenuItem(
                  icon: Icons.visibility,
                  // A more intuitive icon for viewing or listing operations
                  title: 'Vizualizeaza',
                  route: '/screen2',
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Tranzactii', // Main menu item
              icon: Icons.swap_horiz, // Icon representing transactions
              children: [
                AdminMenuItem(
                  icon: Icons.add_circle_outline,
                  // Icon for adding transactions
                  title: 'Adauga',
                  route: '/adauga', // Route for adding transactions
                ),
                AdminMenuItem(
                  icon: Icons.visibility, // Icon for viewing transactions
                  title: 'Vizualizeaza',
                  route: '/vizualizeaza', // Route for viewing transactions
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Documente', // Main menu item for documents
              icon: Icons.folder, // Icon representing documents or files
              children: [
                AdminMenuItem(
                  icon: Icons.add_circle_outline, // Icon for adding documents
                  title: 'Adauga',
                  route: '/adauga_documente', // Route for adding documents
                ),
                AdminMenuItem(
                  icon: Icons.visibility, // Icon for viewing documents
                  title: 'Vizualizeaza',
                  route:
                      '/vizualizeaza_documente', // Route for viewing documents
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Nomenclatoare',
              // Main menu item
              icon: Icons.library_books,
              // Icon representing catalogs or directories
              children: [
                AdminMenuItem(
                  icon: Icons.business, // Icon for entities
                  title: 'Entitati',
                  route: '/entitati', // Route for entities
                ),
                AdminMenuItem(
                  icon: Icons.directions_car, // Icon for automobiles
                  title: 'Automobile',
                  route: '/automobile', // Route for automobiles
                ),
                AdminMenuItem(
                  icon: Icons.person, // Icon for employees (angajati)
                  title: 'Angajati',
                  route: '/angajati', // Route for employees
                ),
                AdminMenuItem(
                  icon: Icons.account_balance, // Icon for bank accounts
                  title: 'Conturi Bancare',
                  route: '/conturi_bancare', // Route for bank accounts
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Tools', // Main menu item
              icon: Icons.build, // Icon representing tools or utilities
              children: [
                AdminMenuItem(
                  icon: Icons.calculate, // Icon for utility calculations
                  title: 'Calcul Utilitati',
                  route: '/calcul_utilitati', // Route for utility calculations
                ),
                AdminMenuItem(
                  icon: Icons.payments, // Icon for payments and receipts
                  title: 'Situatie Plati & Incasi',
                  route:
                      '/situatie_plati_incasi', // Route for payment and receipt situation
                ),
                AdminMenuItem(
                  icon: Icons.verified_user, // Icon for SPV verification
                  title: 'Verificare SPV',
                  route: '/verificare_spv', // Route for SPV verification
                ),
                AdminMenuItem(
                  icon: Icons.input, // Icon for index registration
                  title: 'Inregistrare Index',
                  route: '/inregistrare_index', // Route for index registration
                ),
                AdminMenuItem(
                  icon: Icons.business_center, // Icon for business calculator
                  title: 'Calculator Afaceri',
                  route: '/calculator_afaceri', // Route for business calculator
                ),
                AdminMenuItem(
                  icon: Icons.beach_access, // Icon for vacation registration
                  title: 'Inregistrare Concedii',
                  route:
                      '/inregistrare_concedii', // Route for vacation registration
                ),
                AdminMenuItem(
                  icon: Icons.car_repair, // Icon for service registration
                  title: 'Inregistrare Service',
                  route:
                      '/inregistrare_service', // Route for service registration
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Rapoarte', // Main menu item for reports
              icon: Icons.bar_chart, // Icon representing reports or charts
              children: [
                AdminMenuItem(
                  icon: Icons.trending_up, // Icon for Profit & Loss (P&L)
                  title: 'P&L',
                  route: '/rapoarte_pl', // Route for P&L report
                ),
                AdminMenuItem(
                  icon: Icons.money, // Icon for cash flow
                  title: 'Cashflow',
                  route: '/rapoarte_cashflow', // Route for cash flow report
                ),
                AdminMenuItem(
                  icon: Icons.attach_money, // Icon for expenses
                  title: 'Cheltuieli',
                  route: '/rapoarte_cheltuieli', // Route for expenses report
                ),
                AdminMenuItem(
                  icon: Icons.show_chart, // Icon for profit and loss
                  title: 'Profit / Pierdere',
                  route:
                      '/rapoarte_profit_pierdere', // Route for profit and loss report
                ),
              ],
            ),
            AdminMenuItem(
              title: 'Setari', // Main menu item for settings
              icon: Icons.settings, // Icon representing settings
              children: [
                AdminMenuItem(
                  icon: Icons.person, // Icon for user settings
                  title: 'User',
                  route: '/setari_user', // Route for user settings
                ),
                AdminMenuItem(
                  icon: Icons.list, // Icon for lists settings
                  title: 'Liste',
                  route: '/setari_liste', // Route for lists settings
                ),
              ],
            ),
          ],
          selectedRoute: '/',
          onSelected: (item) {
            switch (item.title) {
              case 'Adauga Facturi':
                openTab('Adauga Facturi', adaugaFacturi());
                break;

              case 'Liste':
                openTab(
                    'Liste',
                    listScreen(
                      openTabCallback: openTab,
                    ));
                break;

              default:
                // Handle cases where the item title doesn't match any expected values
                openTab('Unknown', Text('No content available for this item.'));
                break;
            }
          },
        ),
        body: Stack(
          children: [
            // Main content area with tabs
            Positioned.fill(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: TabsWidgetDisplay,
                ),
              ),
            ),
            //   SizedBox.shrink()
            // Alerts aria   area to fill the red area
            AlertsWidget(
              alertText: 'txt',
              alertType: AlertType.noAlert,
            ),
          ],
        ));
  }
}
