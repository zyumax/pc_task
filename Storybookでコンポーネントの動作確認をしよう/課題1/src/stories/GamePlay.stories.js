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

export const getByLabelPlay = {
  play: async ({ canvas, userEvent }) => {
    const x5 = canvas.getByLabelText('square5');
    const x1 = canvas.getByLabelText('square1');
    const x2 = canvas.getByLabelText('square2');
    const x3 = canvas.getByLabelText('square3');
    const x8 = canvas.getByLabelText('square8');

    await userEvent.click(x2);
    await userEvent.click(x1);
    await userEvent.click(x5);
    await userEvent.click(x3);
    await userEvent.click(x8);
  }
};