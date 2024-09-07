const rootRoute = "/";

const overviewPageDisplayName = "Dashboard";
const overviewPageRoute = "/overview";

const driversPageDisplayName = "Usuarios";
const driversPageRoute = "/drivers";

const clientsPageDisplayName = "Proyecto";
const clientsPageRoute = "/clients";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}



List<MenuItem> sideMenuItemRoutes = [
 MenuItem(overviewPageDisplayName, overviewPageRoute),
 MenuItem(driversPageDisplayName, driversPageRoute),
 MenuItem(clientsPageDisplayName, clientsPageRoute),
 MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
