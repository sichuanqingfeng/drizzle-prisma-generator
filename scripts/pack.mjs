import { execFileSync } from 'node:child_process';
import { renameSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const dist = fileURLToPath(new URL('../dist/', import.meta.url));
const result = execFileSync('npm', ['pack', '--json', '--pack-destination', root], {
	cwd: dist,
	encoding: 'utf8',
	stdio: ['ignore', 'pipe', 'inherit'],
});
const [{ filename }] = JSON.parse(result);
renameSync(new URL(`../${filename}`, import.meta.url), new URL('../package.tgz', import.meta.url));
