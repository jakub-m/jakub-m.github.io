To deploy a React app from other directory do:

1. Choose base path like `/the-foo-app`
2. Set basepath in the app to `the-foo-app`
3. `npm build`
4. `./deploy_app.sh ../the-app-dir app_foo`
5. Add a boilerplate post:

```
---
layout: app_foo
title:  The Foo app
date:   2024-07-04 00:00:00 -0000
permalink: the-foo-app

---
```


