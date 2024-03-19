:-consult(data).

% 6. Given the item name or company name, determine whether we need to boycott or not.
isBoycott(CompanyName) :-
    boycott_company(CompanyName, _).
isBoycott(ItemName) :-
    item(ItemName,CompanyName,_),
    boycott_company(CompanyName, _).


