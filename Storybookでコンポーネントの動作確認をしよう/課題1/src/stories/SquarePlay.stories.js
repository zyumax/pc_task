import { Square } from '../App';
import { userEvent, within } from '@storybook/test';

export default {
  component: Square,
};

export const squareClick = {
  args: {
    value: 'X',
    onSquareClick: () => alert('Clicked X square!'),
  },
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement);
    const button = canvas.getByRole('button', { name: 'X' });
    await userEvent.click(button);
  }
};