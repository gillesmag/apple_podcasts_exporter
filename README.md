# `apple_podcasts_exporter`

A simple tool that exports the podcasts stored by Apple's Podcasts app
into a directory structure where each podcast has its own directory.

This tool is meant to be used with Apple Podcasts on macOS Catalina.

## Why?

I used iTunes to manage the podcasts that I listened to in my car (as
it only has a USB/AUX port and no Apple CarPlay or Android
Auto). After upgrading to macOS Catalina, I noticed that the Podcasts
app doesn't have an option to "Show files in Finder". That's why this
script exists.

## Usage
```
$ ./apple_podcasts_exporter.sh
USAGE: ./apple_podcasts_exporter.sh DESTINATION
$ ./apple_podcasts_exporter.sh podcasts
```

## Contributing

If you encounter a problem with this script, please submit an issue or
make a pull request and I will try my best to resolve it.

## License

This project is licensed under the MIT license.
