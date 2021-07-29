const sum = require('./main');

test('adds 1 + 2 to equal 3', () => {
  expect(sum(1, 2)).toBe(3)
});

test('another test', () => {
    expect(sum(1,1)).toBe(4)
})

test('another one', () => {
    expect("2").toBe("2")
})

test('aaaa', () => {
    expect("2").toBe("2")
})
