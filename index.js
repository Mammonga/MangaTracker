import express from 'express';
import bodyParser from 'body-parser';
import methodOverride from 'method-override';
import pg from 'pg';
import path from 'path';
import { fileURLToPath } from 'url';
import axios from 'axios';
import { Image } from 'image-js';  

const app = express();
const port = 3000;

const pool = new pg.Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'MangaArchive',
    password: 'yourPassword',
    port: 5432,
});


const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(methodOverride('_method'));

async function fetchImageData(isbn) {
    const url = `https://covers.openlibrary.org/b/isbn/${isbn}-L.jpg`;
    try {
        const response = await axios.get(url, { responseType: 'arraybuffer' });
        const imgBuffer = Buffer.from(response.data, 'binary');
        const img = await Image.load(imgBuffer);
        return {
            url,
            width: img.width,
            height: img.height,
        };
    } catch (error) {
        console.error(`Error fetching image for ISBN ${isbn}:`, error);
        return null;
    }
}


app.get('/', async (req, res) => {
    const sortBy = req.query.sort_by || 'title';
    let query = 'SELECT * FROM Book';
    if (sortBy === 'rating') {
        query += ' ORDER BY Rating DESC';
    } else {
        query += ' ORDER BY Title';
    }
    try {
        const client = await pool.connect();
        const result = await client.query(query);
        const books = result.rows;

        for (const book of books) {
            if (book.cover_url) {
                const imageData = await fetchImageData(book.cover_url);
                book.coverImage = imageData;
            }
        }

        res.render('index', { books });
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error retrieving books');
    }
});

app.post('/books', async (req, res) => {
    const { title, author, genre, rating, review, cover_url, status } = req.body;
    const query = 'INSERT INTO Book (Title, Author, Genre, Rating, Review, Cover_URL, Status) VALUES ($1, $2, $3, $4, $5, $6, $7)';
    try {
        const client = await pool.connect();
        await client.query(query, [title, author, genre, rating, review, cover_url, status]);
        res.redirect('/');
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error adding book');
    }
});

app.get('/books/:id/edit', async (req, res) => {
    const query = 'SELECT * FROM Book WHERE ID = $1';
    try {
        const client = await pool.connect();
        const result = await client.query(query, [req.params.id]);
        client.release();
        if (result.rows.length > 0) {
            res.render('editBook', { book: result.rows[0] });
        } else {
            res.send('Book not found');
        }
    } catch (err) {
        console.error(err);
        res.send('Error retrieving book');
    }
});

app.put('/books/:id', async (req, res) => {
    const { title, author, genre, rating, review, cover_url, status } = req.body;
    const query = 'UPDATE Book SET Title = $1, Author = $2, Genre = $3, Rating = $4, Review = $5, Cover_URL = $6, Status = $7 WHERE ID = $8';
    try {
        const client = await pool.connect();
        await client.query(query, [title, author, genre, rating, review, cover_url, status, req.params.id]);
        res.redirect('/');
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error updating book');
    }
});

app.delete('/books/:id', async (req, res) => {
    const query = 'DELETE FROM Book WHERE ID = $1';
    try {
        const client = await pool.connect();
        await client.query(query, [req.params.id]);
        res.redirect('/');
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error deleting book');
    }
});

app.listen(port, () => {
    console.log(`Server is running on port: ${port}`);
});
