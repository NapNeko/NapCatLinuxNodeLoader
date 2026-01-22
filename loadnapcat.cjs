const path = require('path');
const { pathToFileURL } = require('url');
require('./loadenv.cjs');
const BASE_DIR = __dirname;
const NAPCAT_MJS_PATH = path.join(BASE_DIR, 'napcat', 'napcat.mjs');
import(pathToFileURL(NAPCAT_MJS_PATH).href);