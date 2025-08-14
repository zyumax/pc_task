import Game from '../App';

export default {
  component: Game,
};

export const gamePlay = {
  play: async ({ canvas, userEvent }) => {
    const delay = (ms) => new Promise(resolve => setTimeout(resolve, ms));
    const buttons = canvas.getAllByRole('button');

    for (let i = 0; i < 7; i++) {
      await userEvent.click(buttons[i]);
      await delay(500);
    }
  }
};