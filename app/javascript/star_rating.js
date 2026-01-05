function applyStarRating(container) {
  if (!container || container.dataset.bound === "1") return;
  container.dataset.bound = "1";

  const max = Number(container.dataset.max || 5);
  const inputId = container.dataset.inputId;
  const input = document.getElementById(inputId);
  const stars = Array.from(container.querySelectorAll(".star"));

  const paint = (value) => {
    stars.forEach((s, idx) => {
      const on = idx < value;
      s.classList.toggle("is-on", on);
      s.setAttribute("aria-pressed", on ? "true" : "false");
    });
  };

  // 初期値があるなら反映（編集にも対応）
  const initial = input && input.value ? Number(input.value) : 0;
  paint(initial);

  // クリックで確定
  container.addEventListener("click", (e) => {
    const btn = e.target.closest(".star");
    if (!btn) return;
    const val = Number(btn.dataset.value);
    if (input) input.value = String(val);
    paint(val);
  });

  // hoverでプレビュー
  container.addEventListener("mouseover", (e) => {
    const btn = e.target.closest(".star");
    if (!btn) return;
    paint(Number(btn.dataset.value));
  });

  // hover終了で確定値に戻す
  container.addEventListener("mouseleave", () => {
    const val = input && input.value ? Number(input.value) : 0;
    paint(val);
  });

  // キーボード操作（左右/上下）
  container.addEventListener("keydown", (e) => {
    if (!input) return;
    const current = input.value ? Number(input.value) : 0;

    if (e.key === "ArrowRight" || e.key === "ArrowUp") {
      e.preventDefault();
      const next = Math.min(max, current + 1);
      input.value = String(next);
      paint(next);
    }
    if (e.key === "ArrowLeft" || e.key === "ArrowDown") {
      e.preventDefault();
      const next = Math.max(0, current - 1);
      input.value = String(next);
      paint(next);
    }
  });
}

function initStarRatings() {
  document.querySelectorAll(".star-rating").forEach(applyStarRating);
}

// Turbo対応（Rails 7で turbo-rails 使ってる想定）
document.addEventListener("turbo:load", initStarRatings);
// Turbo未使用でも動くように保険
document.addEventListener("DOMContentLoaded", initStarRatings);
