The scoop manifest is used to track the tools that I use, so that they can be moved around/replicated to other machines I need to use.


```
scoop import scoop_manifest.json 
```

After installing any files out of band, run 


```
scoop export > scoop_manifest.json
```
