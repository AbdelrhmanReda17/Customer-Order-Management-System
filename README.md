# Customer Order Management System
This Prolog code implements a customer order management system using Prolog predicates. It includes functionalities such as listing orders, counting orders, getting items in an order, calculating order prices, boycotting items or companies, removing boycott items from an order, calculating price differences between items and their alternatives, and allowing for the insertion and removal of items, alternatives, and boycott companies from the knowledge base.

## Facts (data.pl file)
The assignment requires the use of a data file named `data.pl`, which contains facts about customers, items, orders, boycotted companies, and alternatives.
  ### Example Facts:
  - `customer(CustID, CustUserName).`
  - `item(ItemName, CompanyName, Price).`
  - `order(CustID, OrderID, [Items]).`
  - `boycott_company(CompanyName, Justification).`
  - `alternative(ItemName, AlternativeItem).`

## Core Functionalities:

### 1. List Orders of a Specific Customer
   - Lists all orders of a specific customer.
   **Example:**
   ```prolog
   ?- list_orders(shahd_ghazal2002, Orders).
   ```

### 2. Count Orders of a Specific Customer
  - Gets the number of orders of a specific customer given their ID
**Example:**
  ```prolog
  ?- countOrdersOfCustomer(101, Count).
  ```

### 3. Get Items in a Specific Customer Order
  - Lists all items in a specific customer order given the customer ID and order ID.
  **Example:**
  ```prolog
  ?- getItemsInOrderById(101, 1, Items).
  ```

### 4. Get Number of Items in a Specific Customer Order
  - Gets the number of items in a specific customer order given the customer name and order ID.
 **Example:**
  ```prolog
  ?- getNumOfItems(shahd_ghazal2002, 2, Count).
  ```
  

### 5. Calculate Price of a Given Order
  - Calculates the price of a given order given the customer name and order ID.
  **Example:**
  
  ```prolog
  ?- calcPriceOfOrder(shahd_ghazal2002, 2, TotalPrice).
  ```

### 6. Check if an Item or Company Should be Boycotted
  - Determines whether to boycott an item or company.
  **Example:**
  ``` prolog
  ?- isBoycott(sunbites).
  ```

### 7. Justification for Boycotting an Item or Company
  - Provides the justification for boycotting a specific item or company.
  **Example:**
``` prolog
  ?- whyToBoycott(dasani, Justification).
```
### 8. Remove Boycott Items from an Order
  - Removes all the boycott items from a specific order given the username and order ID.
  **Example:**
  ```prolog
  ?- removeBoycottItemsFromAnOrder(abu_juliaa, 1, NewList).
  ```

### 9. Calculate the Difference in Price Between Item and Alternative
  - Calculates the price difference between a boycott item and its alternative.
 **Example:**
  ```prolog
  ?- getTheDifferenceInPriceBetweenItemAndAlternative(lipton, Alternative, DiffPrice).
  ```

###  10. Insert/Remove Item, Alternative, or New Boycott Company
  - allowing insertion and removal of items, alternatives, and boycott companies from the knowledge base.
  **Examples:**
  ```prolog
  ?- add_item(alpella_wafer, 'Alpella', 4).
  ?- item(alpella_wafer, 'Alpella', 4).
  ?- remove_item(alpella_wafer, 'Alpella', 4).
  ?- item(alpella_wafer, 'Alpella', 4).
  ```

## License:
This project is licensed under the [MIT] License - see the LICENSE.md file for details.
