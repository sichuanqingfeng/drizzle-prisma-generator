# Drizzle Prisma Generator

Automatically generate Drizzle schema from Prisma schema

## Usage

-  Install generator directly from GitHub:
```sh
npm install -D git+https://github.com/sichuanqingfeng/drizzle-prisma-generator.git
# Or with pnpm:
pnpm add -D git+https://github.com/sichuanqingfeng/drizzle-prisma-generator.git
```
Append `#<tag-or-commit>` to the URL to pin a version. Installation builds the package automatically through `prepare`, so lifecycle scripts must be enabled. The installed package is named `@sichuanqingfeng/drizzle-prisma-generator`; the generator command remains `drizzle-prisma-generator`.

-  Add generator to prisma:  
```Prisma
generator drizzle {
  provider = "drizzle-prisma-generator"
  output = "./src/schema.ts"
}
```
:warning: - if output doesn't end with `.ts`, it will be treated like a folder, and schema will be generated to `schema.ts` inside of it.  
:warning: - binary types in `MySQL`, `PostgreSQL` are not yet supported by `drizzle-orm`, therefore will throw an error.  
:warning: - generator only supports `postgresql`, `mysql`, `sqlite` data providers, others will throw an error.  

-  Install `drizzle-orm`: `pnpm add drizzle-orm`  
-  Import schema from specified output file\folder  
-  Congratulations, now you can use Drizzle ORM with generated schemas!
