#Creating empty vectors
ev <- vector()

#Creating unempty vectors
car_brands <- c('Toyota', 'Honda', 'BMW', 'Ford')
print(car_brands)

#Length
length <- length(car_brands)
print(length)

#Accessing Elements
first_brand <- car_brands[1]
last_brand <- car_brands[length(car_brands)]
print(c(first_brand, last_brand))

#Slicing
subset <- car_brands[2:3]
print(subset)

#Concatenation
more_brands <- c('Mercedes', 'Audi')
combined <- c(car_brands, more_brands)
print(combined)

#Modifying Elements
car_brands[2] <- 'Chevrolet'
print(car_brands)

#Appending Elements
car_brands <- c(car_brands, 'Nissan')
print(car_brands)

#Inserting Elements
car_brands <- append(car_brands, 'Tesla', after = 2)
print(car_brands)

#Removing Elements
car_brands <- car_brands[car_brands != 'BMW']
print(car_brands)

#Sorting
car_brands <- sort(car_brands)
print(car_brands)

#Reversing
car_brands <- rev(car_brands)
print(car_brands)