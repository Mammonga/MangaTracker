import dotenv from 'dotenv';
dotenv.config();

import express from 'express';
import bodyParser from 'body-parser';
import methodOverride from 'method-override';
import path from 'path';
import { fileURLToPath } from 'url';
import router from './routes.js';

const app = express();
const port = 3000;

const pool = new pg.Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'MangaArchive',
    password: 'elvis39545',
    port: 5432,
});


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride('_method'));

app.use('/', router);

app.listen(port, () => {
    console.log(`Server is running on port: ${port}`);
});
