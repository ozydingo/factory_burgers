export function index() {
  return fetch("./data")
    .then(res => res.json());
}
