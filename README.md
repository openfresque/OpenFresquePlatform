<a href="https://github.com/yourusername/open_fresk">
  <img src="app/assets/images/open_fresk/favicon.png" width="100px" alt="OpenFresk Logo">
</a>

# OpenFresk

OpenFresk is a 100% open-source project for non-profit organizations to deploy and manage interactive "Fresque" workshops on a self-hosted web platform.

> **Self-hosted.** Deploy on your own infrastructure and retain full control over your data.
> **Extensible.** Customize views, controllers, and assets to match your brand and workflow.
> **Rapid setup.** Launch a platform in minutes with the built-in dummy host app.
> **100% Open source.** Free to use, modify, and contribute.

---

**With OpenFresk, you can:**

- 📅 **Create and schedule workshops** to manage time slots and sessions.
- 🙍 **Manage participant registration and authentication** with built-in user flows.
- 💳 **Sell tickets and manage payments** (via Stripe, PayPal, etc.).
- 🤝 **Facilitate collaborative exercises and collect feedback** during workshops.

---

## Key Benefits

- 🔒 **Ownership.** Fully self-hosted and branded.
- ⚡️ **Speed.** Rapid deployment with minimal configuration.
- 🛠️ **Flexibility.** Override any part of the engine to fit your needs.
- ❤️ **Community.** Backed by a growing open-source community.

---

## Prerequisites

- Git (https://git-scm.com/)
- Ruby 3.2.2 (recommended via rbenv or RVM)
- Bundler (`gem install bundler`)
- PostgreSQL >= 9.3 with development headers (`libpq-dev` on Debian/Ubuntu or `postgresql` on macOS)
- Node.js and Yarn (optional, for JavaScript dependencies)

---

## Getting Started

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/open_fresk.git
   cd open_fresk
   ```

2. **Install dependencies**:

   ```bash
   bundle install
   ```

3. **Switch to the dummy host app**:

   ```bash
   cd test/dummy
   ```

4. **Set up the app** (gems, database, assets):

   ```bash
   bin/setup
   ```

5. **Run the server**:

   ```bash
   bin/rails server
   ```

6. **Visit** `http://localhost:3000/open_fresk` in your browser.

To run on a different port (e.g., 3001):

```bash
bin/rails server -p 3001
```

---

## Deployment to Production

After deploying the OpenFresk codebase to your production server, follow these steps to configure and run the application:

1.  **Set Environment Variables:**

    - `DATABASE_URL`: Configure your PostgreSQL database connection. This variable should follow the format: `postgresql://user:password@host:port/database_name`.
    - `RAILS_ENV`: Set this variable to `production`. This ensures Rails runs with production-specific optimizations and configurations.
    - `RAILS_MASTER_KEY`: Provide the master key to decrypt `config/credentials.yml.enc`. This key is stored in `config/master.key` (ensure this file is kept secure and not committed to your repository if it contains your actual production key). If you need to access or set new credentials for production, you can use `RAILS_ENV=production bin/rails credentials:edit`.

2.  **Database Setup:**

    - Run database migrations to set up or update your database schema:
      ```bash
      RAILS_ENV=production bundle exec rails db:migrate
      ```

3.  **Asset Precompilation:**

        - Precompile your assets (JavaScript, CSS, images) for production:
          `bash

    RAILS_ENV=production bundle exec rails assets:precompile
    `
    This step prepares your assets for efficient serving in a production environment.

4.  **Run the Server:**
    For a production deployment, you typically need two main processes running:

    1.  **Web Process (Puma):** Handles incoming HTTP requests and serves your application.
    2.  **Worker Process (Sidekiq):** Processes background jobs, such as sending emails, performing calculations, or other tasks that don't need to block the web request-response cycle.

    - Start the Rails server in production mode.
      Below is an example command demonstrating how to set common Puma configuration options via environment variables. You should adjust these values based on your server's resources and expected load:

      ```bash
      RAILS_ENV=production \
      PORT=3000 \
      RAILS_MIN_THREADS=5 \
      RAILS_MAX_THREADS=16 \
      WEB_CONCURRENCY=2 \
      bundle exec puma -C config/puma.rb
      ```

      - `RAILS_ENV=production`: Sets the application environment to production.
      - `PORT=3000`: Specifies the port Puma will listen on.
      - `RAILS_MIN_THREADS=5`: Sets the minimum number of threads per Puma worker.
      - `RAILS_MAX_THREADS=16`: Sets the maximum number of threads per Puma worker.
      - `WEB_CONCURRENCY=2`: Sets the number of Puma worker processes (if using clustered mode; ensure `workers ENV.fetch("WEB_CONCURRENCY")` is uncommented in `config/puma.rb`).

      To start the Sidekiq worker process, use a command similar to the one found in the `Procfile`:

      ```bash
      RAILS_ENV=production WORKER_THREADS=5 bundle exec sidekiq -q default -q mailers
      ```

      - `RAILS_ENV=production`: Ensures Sidekiq runs in the production environment.
      - `WORKER_THREADS=5`: (Example) Sets the number of threads Sidekiq will use for processing jobs. Adjust this based on your needs and server capacity. This value is often passed via an environment variable like `$WORKER_THREADS` in `Procfile` contexts.
      - `-q default -q mailers`: Specifies the queues Sidekiq should process. In this example, it processes jobs from the `default` queue and the `mailers` queue.

---

## Email Configuration (SMTP)

This application needs to send emails for features like password recovery. In production, SMTP (Simple Mail Transfer Protocol) is used for sending emails. The SMTP settings are dynamically loaded from the database.

**Managing SMTP Settings:**

You can configure the SMTP settings through the built-in admin interface:

1.  Navigate to `/admin` in your browser (e.g., `http://yourdomain.com/admin`).
2.  Log in with your admin credentials.
3.  Find the "Smtp Settings" section (the exact naming might vary slightly depending on the Administrate dashboard configuration).
4.  Create or update the SMTP record with your mail server details, including:
    - Domain (e.g., `smtp.example.com`)
    - Port (e.g., `587`)
    - Authentication type (e.g., `plain`, `login`, `cram_md5`)
    - Username
    - Password
    - Enable StartTLS Auto (usually `true` for secure connections)

Ensure that only one `SmtpSetting` record exists in the database for the production environment, as the initializer (`config/initializers/smtp_config.rb`) will use the first one it finds.

**Note for Development & Test Environments:**

- In the **development** environment, emails are typically opened in your browser via the `letter_opener` gem, so no actual SMTP server configuration is needed.
- In the **test** environment, emails are not delivered but are collected in an array for testing purposes.

---

## Built With

- Ruby on Rails 7
- Puma (web server)
- PostgreSQL (database)
- Sprockets & Importmap (asset management)
- Stimulus (JavaScript controllers)
- FontAwesome5 (icons)

---

## Contributing

We welcome contributions! To get started:

1. Fork the repository on GitHub.
2. Clone your fork and create a branch:
   ```bash
   git clone https://github.com/yourusername/open_fresk.git
   cd open_fresk
   git checkout -b my-feature
   ```
3. Follow the **Getting Started** guide to run the dummy host app.
4. Implement your feature or bugfix, and add tests.
5. Run the test suite:
   ```bash
   bundle exec rails test
   ```
6. Commit your changes and push to your fork.
7. Open a Pull Request on GitHub.

Please adhere to the existing code style and write tests for new functionality.

---

## Security

Please report any security issues via GitHub Issues or by contacting the maintainers directly.

---

## License

OpenFresk is released under the MIT License. See the [MIT-LICENSE](MIT-LICENSE) file for details.
