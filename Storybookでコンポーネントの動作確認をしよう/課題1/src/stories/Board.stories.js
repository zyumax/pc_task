import { Board } from '../App'

export default {
  title: 'tic-tac-toe/Board',
  component: Board,
};

export const EmptyBoard = {
  args: {
    xIsNext: true,
    squares: Array(9).fill(null),
    onPlay: () => console.log('play'),
  },
};

export const ProgressBoard = {
  args: {
    xIsNext: false,
    squares: ['X', 'O', 'X', 'O', 'O', null, 'X', null, 'X'],
    onPlay: () => console.log('play'),
  },
};

export const TriangleBoard = {
  args: {
    xIsNext: true,
    squares: ['△', '△', '△', '△', '△', '△', '△', '△', '△'],
    onPlay: () => console.log('play'),
  },
};