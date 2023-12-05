enum BadgeType {
  // *** static
  static([], ""),

  // *** Social Badges
  // github
  github1gist1stars(["gistId"], "github"),
  github1followers(["user"], "github"),
  github1forks(["user", "repo"], "github"),
  github1stars(["users", "repo"], "github"),

  // hacker news
  hackernews1user2karma(["id"], ""),

  // lemmy
  lemmy(["community"], "lemmy"),

  // mastodon
  mastodon1follow(["id"], "mastodon"),

  // reddit
  reddit1subreddit2subscribers(["subreddit"], "reddit"),

  // twitch
  twitch1status(["user"], "twitch"),

  // twitter
  twitter1url(["url"], "twitter"),
  twitter1follow(["user"], "twitter"),

  // youtube
  youtube1channel1views(["channelId"], "youtube"),
  youtube1channel1subscribers(["channelId"], "youtube"),
  youtube1views(["videoId"], "youtube"),
  youtube1comments(["videoId"], "youtube"),
  youtube1likes(["videoId"], "youtube"),

  // *** Activity
  github1gist1last2commit(["gistId"], "github"),
  github1all2contributors(["user", "repo"], "github"),
  // github1commit2activity(["interval", "user", "repo"], "github"),

  npm1collaborators(["packageName"], "npm"),

  visual2studio2marketplace1release2date(["extensionId"], "visualstudio"),

  steam1release2date(["fileId"], "steam"),

  // *** Analysis
  github1languages1count(["user", "repo"], "github"),
  github1languages1top(["user", "repo"], "github"),

  // npms2io(["type", "packageName"], "npm"),

  // *** Downloads
  chocolatey1dt(["packageName"], "chocolatey"),

  chrome2web2store1users(["storeId"], "googlechrome"),

  jetbrains1plugin1d(["pluginId"], "jetbrains"),

  // npm(["interval", "packageName"], "npm"),

  nuget1dt(["packageName"], "nuget"),

  // pypi(["period", "packageName"], "pypi"),

  steam1downloads(["fileId"], "steam"),

  visual2studio2marketplace1d(["extensionId"], "visualstudio"),

  // *** Funding
  chrome2web2store1price(["storeId"], "googlechrome"),

  github1sponsors(["user"], "githubsponsors"),

  // *** Issue Tracking
  bitbucket1issues(["user", "repo"], "bitbucket"),

  github1issues(["user", "repo"], "github"),

  // *** License
  cocoapods1l(["spec"], "cocoapods"),

  conda1l(["channel", "package"], "anaconda"),

  github1license(["user", "repo"], "github"),

  npm1l(["packageName"], "npm"),

  pypi1l(["packageName"], "pypi"),

  // *** Others
  date(["timestamp"], ""),

  freecodecamp1points(["username"], "freecodecamp"),

  github1deployments(["user", "repo", "environment"], "github"),
  github1discussions(["user", "repo"], "github"),

  // maintenance(["maintained", "year"], ""),

  pub1publisher(["packageName"], "dart"),

  steam1views(["fileId"], "steam"),

  // *** Platform Support
  cocoapods1p(["spec"], "cocoapods"),

  node1v(["packageName"], "nodedotjs"),

  pypi1pyversions(["packageName"], "pypi"),

  // *** Rating
  chrome2web2store1rating(["storeId"], "googlechrome"),

  docker1stars(["user", "repo"], "docker"),

  jetbrains1plugin1r1rating(["pluginId"], "jetbrains"),

  pub1points(["packageName"], "dart"),
  pub1likes(["packageName"], "dart"),
  pub1popularity(["packageName"], "dart"),

  steam1favorites(["fileId"], "steam"),
  steam1subscriptions(["fileId"], "steam"),

  visual2studio2marketplace1r(["extensionId"], "visualstudio"),

  // *** Size
  tokei1lines(["provider", "user", "repo"], ""),

  // bundlephobia(["format", "packageName"], ""),

  docker1image2size(["user", "repo"], "docker"),

  github1repo2size(["user", "repo"], "github"),

  steam1size(["fileId"], "steam"),

  // *** Version
  chrome2web2store1v(["storeId"], "googlechrome"),

  cocoapods1v(["spec"], "cocoapods"),

  conda1v(["channel", "package"], "anaconda"),

  docker1v(["user", "repo"], "docker"),

  homebrew1v(["formula"], "homebrew"),

  itunes1v(["bundleId"], "itunes"),

  jetbrains1plugin1v(["pluginId"], "jetbrains"),

  npm1v(["packageName"], "npm"),

  nuget1v(["packageName"], "nuget"),

  pub1v(["packageName"], "dart"),

  pypi1v(["packageName"], "pypi");

  final List<String> params;
  final String? logo;
  const BadgeType(this.params, this.logo);
}
