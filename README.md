# API TEST

For this test you will find the model `Conditions` present in the API.
The model is just here to provide you two hashmap : Operators and Fields

It allows us to perform some customised calculations, like this :

`connexion.percentage_read > 50`

`connexion.percentage_read > 50 && ( connexion.total_time > 2000 && connexion.total_time < 2020202020 ) && token.nb_connections < 10`

`connexion.percentage_read > 50 && ( connexion.total_time > 2000 && connexion.total_time < 2020202020 ) && token.nb_connections < 10 && project.nb_links >= 1 && token.name =~ 'id=12'`

etc.


# Things you'll need to do:

* Controller

Create a controller with a method that will allow us to validate/or not/ the strings we will received:

1) note: Every strings the controller is about to receive will always separate every condition and every operator by `ONE SPACE`;
2) note: You don't have to check if the conditions is logical, but the every fields, objects and orperators must be present in the hashmaps of the model Conditions;


Exemple :
```
Post /my_route
{
  string: "connexion.percentage_read > 50"
}
-> 200 ok
```
```
Post /my_route
{
  string: "connexion.percentage_red > 50"
}
-> 400 bad_request
```
```
Post /my_route
{
  string: "connexion.percentage_read > 50 && ( connexion.total_time > 2000 && connexion.total_time < 2020202020 )"
}
-> 200 ok
```
```
Post /my_route
{
  string: "connexion.percentage_read > 'bonjour'"
}
-> 400 bad_request
```
```
Post /my_route
{
  string: "token.name =~ 12"
}
-> 400 bad_request
```
```
Post /my_route
{
  string: "undefined_object.name =~ 'bonjour'"
}
-> 400 bad_request
```


# It could be nice to have

1) when a Bad_request is send, we could also send some message to specify where is the issue
2) some tests (Rspec)

# Return

You can submit a pull request with your code and some explanations if needed
