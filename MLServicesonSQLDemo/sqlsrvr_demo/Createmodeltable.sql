USE demo;
CREATE TABLE srram_rx_models (
    model_name varchar(30) not null default('modelv1.0') primary key,
    model varbinary(max) not null);
GO