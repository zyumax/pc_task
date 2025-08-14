import { Square } from '../App'

export default {
  title: 'tic-tac-toe/Square',
  component: Square,
};

export const FirstSquare = {
  args: {
    value: 'X',
    onSquareClick: () => console.log('clicked'),
  }
};

export const SecondSquare = {
  args: {
    value: 'O',
    onSquareClick: () => console.log('clicked'),
  }
};