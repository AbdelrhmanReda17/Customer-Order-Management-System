:-consult(data).
:-dynamic item/3.
:-dynamic alternative/2.
:-dynamic boycott_company/2.

% 3. List all items in a specific customer order given customer id and order id.
getItemsInOrderById(CustomerId,OrderdId,Items):-
    order(CustomerId,OrderdId,Items).


% 7.Given the company name or an item name, find the justification why you need to boycott this company/item. 
whyToBoycott(ItemName, Justification) :-
    item(ItemName, CompanyName, _),
    boycott_company(CompanyName, Justification).   

% 6. Given the item name or company name, determine whether we need to boycott or not.
isBoycott(CompanyName) :-
    boycott_company(CompanyName, _).
isBoycott(ItemName) :-
    item(ItemName,CompanyName,_),
    boycott_company(CompanyName, _).

% 11.calculate the difference in price between the boycott item and its
%alternative.
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
remove_item(ItemName) :-
    retract(item(ItemName, _, _)).

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
remove_boycottCompany(CompanyName) :-
    retract(boycott_company(CompanyName, _)).



% 4. Get the num of items in a specific customer order given customer Name and order id.

getNumOfItems(Name,OrderNum,Count) :-
    customer(Id, Name),
    order(Id, OrderNum, Items),
    len(Items, Count).

len([],0).

len([_|Tail], Count) :- 
    len(Tail, Y),  
    Count is Y + 1.


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




