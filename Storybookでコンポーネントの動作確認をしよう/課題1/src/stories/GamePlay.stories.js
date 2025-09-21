import Game from '../App';
import { userEvent, within } from '@storybook/test';

export default {
  component: Game,
};

export const gamePlay = {
  play: async ({ canvasElement }) => {
    const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));
    const canvas = within(canvasElement);
    const buttons = canvas.getAllByRole('button');

    for (let i = 0; i < 7; i++) {
      await userEvent.click(buttons[i]);
      await delay(500);
    }
  }
};