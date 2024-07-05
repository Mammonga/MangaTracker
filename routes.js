import express from 'express';
import axios from 'axios';
import { Image } from 'image-js';
import pg from 'pg';
import dotenv from 'dotenv';

const app= express();

dotenv.config();
const router = express.Router();

app.set('view engine', 'ejs');

const pool = new pg.Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_DATABASE,
    password: process.env.DB_PASSWORD.toString(), // Ensure password is handled as a string
    port: parseInt(process.env.DB_PORT, 10), // Parse port as integer
});

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

router.get('/', async (req, res) => {
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

router.get('/addBook', (req, res) => {
    res.render('addBook', function(err, html) {
        if (err) {
            console.log(err);
            res.send('Error rendering page');
        } else {
            res.send(html);
        }
    });
});

router.post('/books', async (req, res) => {
    const { title, author, genre, rating, review, cover_url, status, chapter } = req.body;
    const query = 'INSERT INTO Book (Title, Author, Genre, Rating, Review, Cover_URL, Status, Chapter) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)';
    try {
        const client = await pool.connect();
        await client.query(query, [title, author, genre, rating, review, cover_url, status, chapter]);
        res.redirect('/');
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error adding book');
    }
});

router.get('/books/:id/edit', async (req, res) => {
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

router.put('/books/:id', async (req, res) => {
    const { title, author, genre, rating, review, cover_url, status, chapter } = req.body;
    const query = 'UPDATE Book SET Title = $1, Author = $2, Genre = $3, Rating = $4, Review = $5, Cover_URL = $6, Status = $7, Chapter = $8 WHERE ID = $9';
    try {
        const client = await pool.connect();
        await client.query(query, [title, author, genre, rating, review, cover_url, status, chapter, req.params.id]);
        res.redirect('/');
        client.release();
    } catch (err) {
        console.error(err);
        res.send('Error updating book');
    }
});

router.delete('/books/:id', async (req, res) => {
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

export default router;
