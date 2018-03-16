# Sephora

Simple inventory management system

### Usage

1. Clone this repository by running `git clone https://github.com/sooyang/sephora.git`
2. Enter this repository directory using `cd sephora`
3. Run `bundle install` to install all the required gems.
4. Create the database by running `rails db:create && rails db:migrate`
5. Run `rails db:seed` to populate the database with the required data
6. Start the server `rails s`

### APIs

1. Registering SKU's </br>
` POST http://localhost:3000/api/stock_keeping_units` </br>
Pass parameters in the following format: </br>
```{"stock_keeping_unit": {"code": "SKU_UNIQUE_CODE"}}```</br>
2. Adding Inventories to Warehouse </br>
` POST http://localhost:3000/api/inventories/addition` </br>
Pass parameters in the following format: </br>
	```
	{
    	"inventory": {
      	"distribution_center": "COUNTRY_OF_CENTER",
      	"stock_keeping_unit": "SKU_UNIQUE_CODE",
      	"quantity": "QUANTITY_TO_ADD"
    	}
 	}
	```
3. Reducing Inventories to Warehouse </br>
` POST http://localhost:3000/api/inventories/reduction` </br>
Pass parameters in the following format: </br>
	```
	{
    	"inventory": {
      	"distribution_center": "COUNTRY_OF_CENTER",
      	"stock_keeping_unit": "SKU_UNIQUE_CODE",
      	"quantity": "QUANTITY_TO_REDUCE"
    	}
 	}
	```
4. Reserving Inventories in Warehouse </br>
` POST http://localhost:3000/api/inventories/reserve` </br>
Pass parameters in the following format: </br>
	```
	{
    	"inventory": {
      	"distribution_center": "COUNTRY_OF_CENTER",
      	"stock_keeping_unit": "SKU_UNIQUE_CODE",
      	"quantity": "QUANTITY_TO_RESERVE"
    	}
 	}
	```
 5. Generate Current Stock on Hand Inventory </br>
` GET http://localhost:3000/api/inventories/current_stock_on_hand` </br>
	No Parameters needed
 6. Generate Current pending shipped Inventory </br>
` GET http://localhost:3000/api/inventories/current_pending_shipped` </br>
	No Parameters needed
