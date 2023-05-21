const express = require('express');
const postRoutes = require('./routes/postRoutes');
const { notFoundMiddleware, errorMiddleware } = require('./middleware/errorMiddleware');

const app = express();
const port = process.env.PORT || 4000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use('/api/posts', postRoutes);

app.use(notFoundMiddleware);
app.use(errorMiddleware);

app.listen(port, () => console.log(`Blog app listening on port ${port}`));
