obj <- salaries%>%
  filter(full_or_part_time == "F", salary_or_hourly == "Salary")%>%
  select(department, annual_salary)%>%
  group_by(department)%>%
  drop_na(annual_salary)%>%
  summarize(salary = parse_double(annual_salary))%>%
  mutate(total=n())%>%
  summarize(avg_salary=sum(salary)/(1000*total))%>%
  slice(1)%>%
  arrange(avg_salary)%>%
  ungroup(department)%>%
  mutate(newDepart = parse_factor(department))%>%
  ggplot(mapping=aes(x=newDepart,y=avg_salary, fill=department))+geom_col(show.legend = FALSE)+coord_flip()+
  labs(title="Average Department Salary in Chicago", subtitle="Disabilities receive the greatest average salary in the city,\nwhile Board of Election has the smallest average salary.", x="", y="Average Salary (in thousands)", caption="Chicago Data Portal (2021)")+theme_bw()+theme(axis.text = element_text(size = 7),plot.background = element_rect(fill = "beige"))
