import { useEffect, useRef } from "react";

export function classes(...classNames) {
  return classNames.filter(x => x).join(" ");
}

export function indexBy(items, func) {
  const indexed = {};
  items.forEach(item => indexed[func(item)] = item);
  return indexed;
}

export function usePrevious(value) {
  const ref = useRef();
  useEffect(() => {
    ref.current = value;
  });
  return ref.current;
}
