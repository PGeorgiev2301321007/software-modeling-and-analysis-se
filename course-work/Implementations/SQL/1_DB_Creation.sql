﻿CREATE DATABASE WoltDB

USE WoltDB

CREATE TABLE Customer (
    customerID      INT NOT NULL PRIMARY KEY,
    username        VARCHAR(50) NOT NULL,
    email           VARCHAR(50) NOT NULL,
    phone           VARCHAR(10) NULL,
    address         VARCHAR(50) NULL,
    cardnumber      VARCHAR(16) NULL
);
GO


CREATE TABLE Restaurant (
    restaurantId        INT NOT NULL PRIMARY KEY,
    address             VARCHAR(50) NOT NULL,
    name                VARCHAR(50) NOT NULL,
    rating              INT NULL,
    avgDeliveryTime     TIME NULL
);
GO


CREATE TABLE CourierRegion (
    courierRegionId     INT NOT NULL,
    courierId           INT NOT NULL,
    neighborhoodName    VARCHAR(50) NOT NULL,
    avgDeliveryTime     TIME NULL,

    PRIMARY KEY (courierRegionId, courierId)
);
GO


CREATE TABLE Courier (
    courierId           INT NOT NULL PRIMARY KEY,
    restaurantId        INT NOT NULL,
    courierRegionId     INT NULL,
    avgDeliveryTime     TIME NULL,

    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId),
    FOREIGN KEY (courierRegionId, courierId)
        REFERENCES CourierRegion(courierRegionId, courierId)
);
GO


CREATE TABLE Reviews (
    reviewId        INT NOT NULL,
    customerId      INT NOT NULL,
    courierId       INT NOT NULL,
    restaurantId    INT NOT NULL,
    picture         VARBINARY(MAX) NULL,
    comment         VARCHAR(50) NULL,
    rating          INT NOT NULL,

    PRIMARY KEY (reviewId, customerId),

    FOREIGN KEY (customerId) REFERENCES Customer(customerID),
    FOREIGN KEY (courierId) REFERENCES Courier(courierId),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);
GO


CREATE TABLE Orders (
    orderId         INT NOT NULL,
    customerId      INT NOT NULL,
    restaurantId    INT NOT NULL,
    orderedItems    NVARCHAR(MAX) NOT NULL,

    PRIMARY KEY (orderId, customerId),

    FOREIGN KEY (customerId) REFERENCES Customer(customerID),
    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);
GO


CREATE TABLE Delivery (
    deliveryId          INT NOT NULL,
    restaurantId        INT NOT NULL,
    courierId           INT NOT NULL,
    status              INT NOT NULL,
    address             VARCHAR(50) NOT NULL,
    estDeliveryTime     TIME NOT NULL,
    deliveryItems       NVARCHAR(MAX) NOT NULL,
    price               DECIMAL(18,2) NOT NULL,
    courierRegionId     INT NOT NULL,

    PRIMARY KEY (deliveryId, restaurantId),

    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId),
    FOREIGN KEY (courierId) REFERENCES Courier(courierId),
    FOREIGN KEY (courierRegionId, courierId)
        REFERENCES CourierRegion(courierRegionId, courierId)
);
GO


CREATE TABLE MenuItem (
    menuItemId      INT NOT NULL,
    restaurantId    INT NOT NULL,
    price           DECIMAL(18,2) NOT NULL,
    name            VARCHAR(50) NOT NULL,
    picture         VARBINARY(MAX) NULL,
    description     VARCHAR(500) NULL,

    PRIMARY KEY (menuItemId, restaurantId),

    FOREIGN KEY (restaurantId) REFERENCES Restaurant(restaurantId)
);
GO
