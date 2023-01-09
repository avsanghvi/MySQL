#!/usr/bin/env python
# coding: utf-8

# # The Weather Analysis
# 

# In[6]:


import pandas as pd


# In[7]:


Data = pd.read_csv(r'E:\DOWNLOAD\Portfolio Content\Python Files\1. Weather Data.csv')


# In[8]:


Data.head()


# ### 1. Find all the unique 'Wind Speed' values in the data.

# In[20]:


Data["Wind Speed_km/h"].unique()


# ### 2. Find the number of times when the 'Weather is exactly Clear'.

# In[24]:


Data.loc[Data["Weather"] == 'Clear']


# In[26]:


Data.groupby("Weather").get_group("Clear")


# ### 3.  Find the number of times when the 'Wind Speed was exactly 4 km/h'.

# In[28]:


Data[Data['Wind Speed_km/h'] == 4]


# ### 4. Find out all the Null Values in the data.

# In[30]:


Data.isnull().sum()


# ### 5. Rename the column name 'Weather' of the dataframe to 'Weather Condition'.

# In[32]:


Data.rename(columns = {"Weather" : "Weather Condition"}, inplace = True)
Data.head()


# ### 6.  What is the mean 'Visibility' ?
# 

# In[33]:


Data["Visibility_km"].mean()


# ### 7. What is the Standard Deviation of 'Pressure'  in this data?

# In[38]:


Data["Press_kPa"].std()


# ### 8. What is the Variance of 'Relative Humidity' in this data ?

# In[39]:


Data.head(2)


# In[40]:


Data["Rel Hum_%"].var()


# ### 9. Find all instances when 'Snow' was recorded.

# In[61]:


Data["Weather Condition"].value_counts().head()


# In[46]:


Data[Data["Weather Condition"].str.contains("Snow")]


# ### 10. Find all instances when 'Wind Speed is above 24' and 'Visibility is 25'.

# In[50]:


Data[(Data["Wind Speed_km/h"] >= 24) & (Data['Visibility_km'] == 25.0)]


# ### 11. What is the Mean value of each column against each 'Weather Condition ?

# In[62]:


Data.groupby("Weather Condition").mean().head(10)


# ### 12. What is the Minimum & Maximum value of each column against each 'Weather Condition ?

# In[54]:


Data.groupby("Weather Condition").min().head()


# In[55]:


Data.groupby("Weather Condition").max().head()


# ### 13. Show all the Records where Weather Condition is Fog.

# In[57]:


Data[Data["Weather Condition"] == "Fog"]


# ### 14. Find all instances when 'Weather is Clear' or 'Visibility is above 40'.

# In[60]:


Data[(Data["Weather Condition"] == "Clear") | (Data["Visibility_km"] > 40)]


# ### 15. Find all instances when :
# ### A. 'Weather is Clear' and 'Relative Humidity is greater than 50'
# ### or
# ### B. 'Visibility is above 40'

# In[63]:


Data[(Data["Weather Condition"] == 'Clear') & (Data["Rel Hum_%"] > 50) | (Data["Visibility_km"] > 40)]


# In[ ]:




