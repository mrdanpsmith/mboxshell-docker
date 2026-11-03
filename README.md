# mrdanpsmith/mboxshell

A community-maintained, lightweight Dockerized wrapper for mboxShell—a fast terminal viewer (TUI/CLI) built in Rust for MBOX files of any size. This image allows you to open, search, index, and export emails from massive archives (like 50 GB+ Gmail Takeout backups) without loading them entirely into system memory.

## Source Code

* **Docker Packaging Repository:** [mrdanpsmith/mboxshell-docker on GitHub](https://github.com/mrdanpsmith/mboxshell-docker)
* **Upstream Project:** [dcarrero/mboxshell on GitHub](https://github.com/dcarrero/mboxshell)

## Quick Start

To read or process local MBOX files, you must mount your local mail directory into the container using a volume mount (`-v`).

### Open an MBOX file in the Interactive TUI

Run the container interactively with a pseudo-TTY (`-it`) and pass the internal path to your file:

```bash
docker run --rm -it \
  -v /path/to/local/mail/dir:/data \
  mrdanpsmith/mboxshell:latest \
  /data/your-backup.mbox
```

### CLI Command Examples

You can execute arbitrary CLI tasks by appending the subcommands directly to your run command:

**Build or rebuild the binary index:**
```bash
docker run --rm \
  -v /path/to/local/mail/dir:/data \
  mrdanpsmith/mboxshell:latest \
  index /data/your-backup.mbox
```

**Get mailbox statistics:**
```bash
docker run --rm \
  -v /path/to/local/mail/dir:/data \
  mrdanpsmith/mboxshell:latest \
  stats /data/your-backup.mbox
```

**Search messages from the command line:**
```bash
docker run --rm \
  -v /path/to/local/mail/dir:/data \
  mrdanpsmith/mboxshell:latest \
  search /data/your-backup.mbox "your search query"
```

**Export messages to a specific format:**
```bash
docker run --rm \
  -v /path/to/local/mail/dir:/data \
  mrdanpsmith/mboxshell:latest \
  export /data/your-backup.mbox -f eml -o /data/exported_emails
```

## Supported Formats

* MBOX (mboxrd/mboxo) standard format (Google Takeout, Thunderbird, Unix servers)
* Google Groups export (topics.mbox)
* Apple Mail package (Name.mbox/mbox)

## License

This Docker packaging repository is licensed under the MIT License. The underlying mboxShell application code is owned and licensed by its original authors under the MIT License.
