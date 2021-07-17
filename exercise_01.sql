select items.*, categories.name from items 
left join item_categories on items.id = item_categories.item_id
left join categories on categories.id = item_categories.category_id; 

select items.id, items.name from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
where categories.name = 'main dish'; 

select items.* from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
where categories.name = 'main dish' and items.price > 30000; 

select items.* from items 
left join item_categories on items.id = item_categories.item_id
where item_categories.category_id is null; 

select categories.*, group_concat(items.name separator ',') as item_name, max(items.price) as max_price from items 
join item_categories on items.id = item_categories.item_id
join categories on categories.id = item_categories.category_id
group by categories.id; 




