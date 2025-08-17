import { Square } from '../App';

export default {
  component: Square,
};

export const squareClick = {
  args: {
    value: 'X',
    onSquareClick: () => alert('Clicked X square!'),
  },
  play: async ({ canvas, userEvent }) => {
    const button = canvas.getByRole('button', { name: 'X' });
    await userEvent.click(button);
  }
};