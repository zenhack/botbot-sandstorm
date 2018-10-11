@0xcc76f33f1d3395e8;

using Spk = import "/sandstorm/package.capnp";
using Util = import "/sandstorm/util.capnp";

const pkgdef :Spk.PackageDefinition = (
  id = "0x75azvuf3kg2n8d2vedhjn8jk16amk9ed058gukct7drtqvashh",

  manifest = (
    appTitle = (defaultText = "BotBot"),

    appVersion = 0,

    appMarketingVersion = (defaultText = "1.0-1"),
    # The convetion we use here is ${upstream_version}-${release_no}, where
    # we increment ${release_no} every time we re-pacakge the same version,
    # resetting it to 1 on a new upstream release; the same policy is used
    # by many Linux distros.
    #
    # Note that a new upstream release is unlikely given that Lincoln Loop
    # is no longer running the service themselves.

    actions = [
      ( nounPhrase = (defaultText = "bot"),
        command = .firstRunCmd,
      )
    ],

    continueCommand = .launchCmd,

    metadata = (
      # Data which is not needed specifically to execute the app, but is useful
      # for purposes like marketing and display.  These fields are documented at
      # https://docs.sandstorm.io/en/latest/developing/publishing-apps/#add-required-metadata
      # and (in deeper detail) in the sandstorm source code, in the Metadata section of
      # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/package.capnp
      icons = (
        # Various icons to represent the app in various contexts.
        #appGrid = (svg = embed "path/to/appgrid-128x128.svg"),
        #grain = (svg = embed "path/to/grain-24x24.svg"),
        #market = (svg = embed "path/to/market-150x150.svg"),
        #marketBig = (svg = embed "path/to/market-big-300x300.svg"),
      ),

      website = "http://example.com",
      # This should be the app's main website url.

      codeUrl = "http://example.com",
      # URL of the app's source code repository, e.g. a GitHub URL.
      # Required if you specify a license requiring redistributing code, but optional otherwise.

      license = (openSource = mit),

      categories = [
        communications,
      ],

      author = (
        # Fields relating to the author of this app.

        contactEmail = "ian@zenhack.net",
        # Email address to contact for any issues with this app. This includes end-user support
        # requests as well as app store administrator requests, so it is very important that this be a
        # valid address with someone paying attention to it.

        #pgpSignature = embed "path/to/pgp-signature",
        # PGP signature attesting responsibility for the app ID. This is a binary-format detached
        # signature of the following ASCII message (not including the quotes, no newlines, and
        # replacing <app-id> with the standard base-32 text format of the app's ID):
        #
        # "I am the author of the Sandstorm.io app with the following ID: <app-id>"
        #
        # You can create a signature file using `gpg` like so:
        #
        #     echo -n "I am the author of the Sandstorm.io app with the following ID: <app-id>" | gpg --sign > pgp-signature
        #
        # Further details including how to set up GPG and how to use keybase.io can be found
        # at https://docs.sandstorm.io/en/latest/developing/publishing-apps/#verify-your-identity

        upstreamAuthor = "Lincoln Loop",
      ),

      #pgpKeyring = embed "path/to/pgp-keyring",
      # A keyring in GPG keyring format containing all public keys needed to verify PGP signatures in
      # this manifest (as of this writing, there is only one: `author.pgpSignature`).
      #
      # To generate a keyring containing just your public key, do:
      #
      #     gpg --export <key-id> > keyring
      #
      # Where `<key-id>` is a PGP key ID or email address associated with the key.

      #description = (defaultText = embed "path/to/description.md"),
      # The app's description in Github-flavored Markdown format, to be displayed e.g.
      # in an app store. Note that the Markdown is not permitted to contain HTML nor image tags (but
      # you can include a list of screenshots separately).

      shortDescription = (defaultText = "one-to-three words"),
      # A very short (one-to-three words) description of what the app does. For example,
      # "Document editor", or "Notetaking", or "Email client". This will be displayed under the app
      # title in the grid view in the app market.

      screenshots = [
        # Screenshots to use for marketing purposes.  Examples below.
        # Sizes are given in device-independent pixels, so if you took these
        # screenshots on a Retina-style high DPI screen, divide each dimension by two.

        #(width = 746, height = 795, jpeg = embed "path/to/screenshot-1.jpeg"),
        #(width = 640, height = 480, png = embed "path/to/screenshot-2.png"),
      ],
      #changeLog = (defaultText = embed "path/to/sandstorm-specific/changelog.md"),
      # Documents the history of changes in Github-flavored markdown format (with the same restrictions
      # as govern `description`). We recommend formatting this with an H1 heading for each version
      # followed by a bullet list of changes.
    ),
  ),

  #bridgeConfig = (
  #  # Used for integrating permissions and roles into the Sandstorm shell
  #  # and for sandstorm-http-bridge to pass to your app.
  #  # Uncomment this block and adjust the permissions and roles to make
  #  # sense for your app.
  #  # For more information, see high-level documentation at
  #  # https://docs.sandstorm.io/en/latest/developing/auth/
  #  # and advanced details in the "BridgeConfig" section of
  #  # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/package.capnp
  #  viewInfo = (
  #    # For details on the viewInfo field, consult "ViewInfo" in
  #    # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp
  #
  #    permissions = [
  #    # Permissions which a user may or may not possess.  A user's current
  #    # permissions are passed to the app as a comma-separated list of `name`
  #    # fields in the X-Sandstorm-Permissions header with each request.
  #    #
  #    # IMPORTANT: only ever append to this list!  Reordering or removing fields
  #    # will change behavior and permissions for existing grains!  To deprecate a
  #    # permission, or for more information, see "PermissionDef" in
  #    # https://github.com/sandstorm-io/sandstorm/blob/master/src/sandstorm/grain.capnp
  #      (
  #        name = "editor",
  #        # Name of the permission, used as an identifier for the permission in cases where string
  #        # names are preferred.  Used in sandstorm-http-bridge's X-Sandstorm-Permissions HTTP header.
  #
  #        title = (defaultText = "editor"),
  #        # Display name of the permission, e.g. to display in a checklist of permissions
  #        # that may be assigned when sharing.
  #
  #        description = (defaultText = "grants ability to modify data"),
  #        # Prose describing what this role means, suitable for a tool tip or similar help text.
  #      ),
  #    ],
  #    roles = [
  #      # Roles are logical collections of permissions.  For instance, your app may have
  #      # a "viewer" role and an "editor" role
  #      (
  #        title = (defaultText = "editor"),
  #        # Name of the role.  Shown in the Sandstorm UI to indicate which users have which roles.
  #
  #        permissions  = [true],
  #        # An array indicating which permissions this role carries.
  #        # It should be the same length as the permissions array in
  #        # viewInfo, and the order of the lists must match.
  #
  #        verbPhrase = (defaultText = "can make changes to the document"),
  #        # Brief explanatory text to show in the sharing UI indicating
  #        # what a user assigned this role will be able to do with the grain.
  #
  #        description = (defaultText = "editors may view all site data and change settings."),
  #        # Prose describing what this role means, suitable for a tool tip or similar help text.
  #      ),
  #      (
  #        title = (defaultText = "viewer"),
  #        permissions  = [false],
  #        verbPhrase = (defaultText = "can view the document"),
  #        description = (defaultText = "viewers may view what other users have written."),
  #      ),
  #    ],
  #  ),
  #  #apiPath = "/api",
  #  # Apps can export an API to the world.  The API is to be used primarily by Javascript
  #  # code and native apps, so it can't serve out regular HTML to browsers.  If a request
  #  # comes in to your app's API, sandstorm-http-bridge will prefix the request's path with
  #  # this string, if specified.
  #),
);

const env :List(Util.KeyValue) = [
    (key = "PATH", value = "/usr/local/bin:/usr/bin:/bin"),
    (key = "SANDSTORM", value = "1"),

    (key = "HOME", value = "/var"),
    # Work around a bug in python; see
    # https://docs.sandstorm.io/en/latest/developing/raw-python/
  ];

const firstRunCmd :Spk.Manifest.Command = (
  argv = ["/app/launch.sh", "firstrun"],
  environ = .env,
);

const launchCmd :Spk.Manifest.Command = (
  argv = ["/app/launch.sh", "restart"],
  environ = .env,
);
