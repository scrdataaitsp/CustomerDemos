DECLARE @mymodel varbinary(max) = (select model from [dbo].[srram_rx_models] where model_name = 'modelv1.0');
EXEC sp_execute_external_script
    @language = N'R'
    , @script = N'
            current_model <- unserialize(as.raw(mymodel));
            testData <- data.frame(testData);
            predicted.val <- rxPredict(current_model, testData);
            OutputDataSet <- cbind(testData[,5, drop=FALSE], predicted.val);
            '
    , @input_data_1 = N'SELECT [horizon]
      ,[ID1]
      ,[ID2]
      ,[tstamp]
      ,[value]
      ,[RDPI]
      ,[year]
      ,[month]
      ,[weekofmonth]
      ,[weekofyear]
      ,[USNewYearsDay]
      ,[USLaborDay]
      ,[USThanksgivingDay]
      ,[CyberMonday]
      ,[ChristmasDay]
      ,[FreqCos1]
      ,[Freqsin1]
      ,[FreqCos2]
      ,[Freqsin2]
      ,[FreqCos3]
      ,[Freqsin3]
      ,[FreqCos4]
      ,[Freqsin4]
      ,[lag1]
      ,[lag2]
      ,[lag3]
      ,[lag4]
      ,[lag5]
      ,[lag6]
      ,[lag7]
      ,[lag8]
      ,[lag9]
      ,[lag10]
      ,[lag11]
      ,[lag12]
      ,[lag13]
      ,[lag14]
      ,[lag15]
      ,[lag16]
      ,[lag17]
      ,[lag18]
      ,[lag19]
      ,[lag20]
      ,[lag21]
      ,[lag22]
      ,[lag23]
      ,[lag24]
      ,[lag25]
      ,[lag26]
  FROM [Demo].[dbo].[testdata]'
    , @input_data_1_name = N'testData'
    , @parallel = 1
    , @params = N'@mymodel varbinary(max)'
    , @mymodel = @mymodel
WITH RESULT SETS (([value] decimal(12,10),[predicted.val] decimal(12,10)))