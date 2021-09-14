| User                    | Task                 | Label           | 
| :---------------------: | :------------------: | :-------------: | 
| name(string)            | title(string)        | task_id(bigint) | 
| password_digest(string) | content(string)      | name(string)    | 
| email(string)           | user_id(bigint)      | -               | 
| -                       | task_limit_on(date)  | -               | 
| -                       | task_status(integer) | -               | 



| Herokuへのデプロイ方法                                    | 
| --------------------------------------------------------- | 
| :$ rails assets:precompile RAILS_ENV=production           | 
| 2.コミットする                                            | 
| :~/workspace/my_task_app3 (master) $ git add -A           | 
| :~/workspace/my_task_app3 (master) $ git commit -m "init" | 
| 3.Herokuに新しいアプリケーションを作成                    | 
| :$ heroku create                                          | 
| 4.Herokuにデプロイをする                                  | 
| :$ git push heroku master                                 | 