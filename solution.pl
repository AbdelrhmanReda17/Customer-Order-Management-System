:-consult(data).
:-dynamic item/3.
:-dynamic alternative/2.
:-dynamic boycott_company/2.

% 1. List all items in the order given customer id and order id.
list_orders(CustomerName,Orders) :-
    customer(CustomerId, CustomerName),
    orders_by_customer(CustomerId,[],Orders).

orders_by_customer(CustomerId, OrdersAcc, [H|T]) :-
    order(CustomerId,OrderId,Items),
    \+ isMember(order(CustomerId,OrderId,_), OrdersAcc),
    H = order(CustomerId, OrderId, Items),
    orders_by_customer(CustomerId,[H|OrdersAcc],T).

orders_by_customer(_, _, []).

% Checks if X is in the List or No
isMember(X, [X|_]).
isMember(X, [_|T]) :-
    isMember(X, T).

% 2.Get the number of orders of a specific customer given customer id.
countOrdersOfCustomer(CustomerName, Count) :-
    list_orders(CustomerName, Orders),
    count_list(Orders, Count).

% 3. List all items in a specific customer order given customer id and order id.

getItemsInOrderById(CustomerName,OrderdID,Items):-
    customer(CustomerID, CustomerName),
    order(CustomerID,OrderdID,Items).

% 4. Get the num of items in a specific customer order given customer Name and order id.

getNumOfItems(CustomerName,OrderID,Count) :-
    customer(CustomerID, CustomerName),
    order(CustomerID, OrderID, Items),
    count_list(Items, Count).

% 5. Calculate the price of a given order given Customer Name and order id
calcPriceOfOrder(CustomerName, OrderID, TotalPrice) :-
    getItemsInOrderById(CustomerName, OrderID, Items),
    sumItemsPrice(Items, TotalPrice).


% 6. Given the item name or company name, determine whether we need to boycott or not.
isBoycott(CompanyName) :-
    boycott_company(CompanyName, _).
isBoycott(ItemName) :-
    item(ItemName,CompanyName,_),
    boycott_company(CompanyName, _).

% 7.Given the company name or an item name, find the justification why you need to boycott this company/item.
whyToBoycott(CompanyName, Justification) :-
    boycott_company(CompanyName, Justification).
whyToBoycott(ItemName, Justification) :-
    item(ItemName, CompanyName, _),
    boycott_company(CompanyName, Justification).

% 8. Given an username and order ID, remove all the boycott items from this order.

removeBoycottItemsFromAnOrder(Name, OrderNum, NewList) :-
    customer(Id,Name),
    order(Id, OrderNum, List),
    removeBoycottItems(List, NewList).

removeBoycottItems([], []).

removeBoycottItems([H|T], NewList) :-
    (isBoycott(H) ->  removeBoycottItems(T, NewList);
    NewList = [H|Remaining],
    removeBoycottItems(T , Remaining)).

% 9. Given an username and order ID, update the order such that all
% boycott items are replaced by an alternative (if exists).

replaceBoycottItemsFromAnOrder(CustUsername, OrderId, NewItems):-
    customer(CustomerId, CustUsername),
    order(CustomerId, OrderId, Items),
    replaceBoycottItems(Items, NewItems).

replaceBoycottItems([], []).

replaceBoycottItems([H|T], NewItems):-
    % if (H) is a Boycott items
    (isBoycott(H) -> alternative(H, AlternativeItem),
    NewItems = [AlternativeItem|Remaining],
    replaceBoycottItems(T, Remaining);
    % else
    NewItems = [H|Remaining],
    replaceBoycottItems(T, Remaining)).

% 10. Given an username and order ID, calculate the price of the order after
% replacing all boycott items by its alternative (if it exists).

calcPriceAfterReplacingBoycottItemsFromAnOrder(CustUsername, OrderId, NewItems, TotalPrice):-
    replaceBoycottItemsFromAnOrder(CustUsername, OrderId, NewItems),
    sumItemsPrice(NewItems, TotalPrice).

% 11.calculate the difference in price between the boycott item and its alternative.

getTheDifferenceInPriceBetweenItemAndAlternative(ItemName, Alternative, DiffPrice) :-
    item(ItemName, _, ItemPrice),
    alternative(ItemName, Alternative),
    item(Alternative, _, AltPrice),
    DiffPrice is ItemPrice - AltPrice.


% 12. Insert/Remove (1)item, (2)alternative and (3)new boycott company to/from the knowledge base. Hint: use assert to insert new fact and retract to remove a fact
% Insert a new item
add_item(ItemName, CompanyName, Price) :-
    assert(item(ItemName, CompanyName, Price)).

% Remove an item
remove_item(ItemName , CompanyName , Price) :-
    retract(item(ItemName, CompanyName, Price)).

% Insert a new alternative
insert_alternative(ItemName, AlternativeItem) :-
    assert(alternative(ItemName, AlternativeItem)).

% Remove an alternative
remove_alternative(ItemName, AlternativeItem) :-
    retract(alternative(ItemName, AlternativeItem)).

% Insert a new boycott company
insert_boycottCompany(CompanyName, Justification) :-
    assert(boycott_company(CompanyName, Justification)).

% Remove a boycott company
remove_boycottCompany(CompanyName ,Justification ) :-
    retract(boycott_company(CompanyName, Justification)).


% COMMON
% Count length
count_list([], 0).
count_list([_|Tail], Count) :-
    count_list(Tail, Counter),
    Count is Counter + 1.

% Sum up the prices of all items in the list
sumItemsPrice([], 0).

sumItemsPrice([ItemName|Remaining], TotalPrice) :-
    item(ItemName, _, Price),
    sumItemsPrice(Remaining, RemainingPrice),
    TotalPrice is RemainingPrice + Price.
