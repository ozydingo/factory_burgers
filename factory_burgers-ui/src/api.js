export function index() {
  return fetch("./data")
    .then(res => res.json())
    .then(data => console.log(data))
}
