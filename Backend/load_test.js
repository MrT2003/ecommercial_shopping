// import http from "k6/http";
// import { check, sleep } from "k6";

// // Dễ dàng đổi URL khi chạy trong Docker hoặc local
// // - Local: "http://localhost:8000"
// // - Docker gọi host: "http://172.17.0.1:8000"
// // - Docker cùng network: "http://api:8000"
// // const BASE_URL = "http://api:8000";
// const BASE_URL= "http://my-api-alb-469487783.ap-northeast-1.elb.amazonaws.com";

// // export let options = {
// //   stages: [
// //     { duration: "8m", target: 300 }, // ramp-up 0 → 100 VU trong 10 phút
// //     { duration: "10m", target: 400 }, // steady 20 phút
// //     { duration: "5m", target: 800 },  // spike 5 phút
// //     { duration: "10m", target: 0 },   // cooldown về 0 VU
// //   ],
// // };

// // export let options = { vus: 800, duration: "2m", };

// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 100 },  // Tăng từ 0 đến 1000 VUs trong 2 phút
// //     { duration: "5m", target: 6000 },  // Tạo spike 5000 VUs trong 1 phút
// //     { duration: "2m", target: 1000 },  // Giảm tải về mức ổn định
// //   ],
// // };

// // Day 1: Morning
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 200 },   // Tăng từ 0 đến 200 VUs
// //     { duration: "15m", target: 500 },  // Steady ở 500 VUs
// //     { duration: "10m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };
// // Day 1: Evening
// // export let options = {
// //   stages: [
// //     { duration: "10m", target: 500 },   // Tăng từ 0 đến 500 VUs
// //     { duration: "20m", target: 3000 },  // Steady ở 3000 VUs
// //     { duration: "5m", target: 4000 },   // Spike lên 6000 VUs
// //     { duration: "10m", target: 0 },     // Giảm về 0 VUs
// //   ],
// // };
// // Day 2: Morning
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 300 },   // Tăng từ 0 đến 300 VUs
// //     { duration: "15m", target: 1000 }, // Steady ở 1000 VUs
// //     { duration: "10m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };
// // Day 2: Evening
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 500 },   // Tăng từ 0 đến 500 VUs
// //     { duration: "15m", target: 2000 }, // Steady ở 2000 VUs
// //     { duration: "10m", target: 4000 }, // Spike lên 4000 VUs
// //     { duration: "10m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };
// // Day 3: Morning
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 500 },   // Tăng từ 0 đến 500 VUs
// //     { duration: "5m", target: 1000 }, // Steady ở 1000 VUs
// //     { duration: "5m", target: 3000 },  // Spike đột ngột lên 3000 VUs
// //     { duration: "5m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };

// export let options = {
//   stages: [
//     { duration: "5m", target: 100 },  // warm-up nhẹ
//     { duration: "10m", target: 300 }, // steady vừa
//     { duration: "10m", target: 600 }, // steady cao hơn
//     { duration: "10m", target: 100 }, // giảm xuống nhẹ
//     { duration: "5m", target: 0 },    // về 0
//   ],
// };

// // Day 3: Evening
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 1000 },  // Tăng từ 0 đến 1000 VUs
// //     { duration: "15m", target: 3000 }, // Steady ở 3000 VUs
// //     { duration: "5m", target: 6000 },  // Spike lên 6000 VUs
// //     { duration: "10m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };
// // Day 4: Morning
// // export let options = {
// //   stages: [
// //     { duration: "10m", target: 500 },   // Tăng từ 0 đến 500 VUs
// //     { duration: "25m", target: 1500 },  // Steady ở 1500 VUs
// //     { duration: "15m", target: 0 },     // Giảm về 0 VUs
// //   ],
// // };
// // Day 4: Evening
// // export let options = {
// //   stages: [
// //     { duration: "15m", target: 3000 },  // Tăng từ 0 đến 3000 VUs
// //     { duration: "30m", target: 6000 },  // Steady ở 6000 VUs
// //     { duration: "15m", target: 0 },     // Giảm về 0 VUs
// //   ],
// // };
// // Day 5: Morning
// // export let options = {
// //   stages: [
// //     { duration: "5m", target: 500 },   // Tăng từ 0 đến 500 VUs
// //     { duration: "15m", target: 1000 }, // Steady ở 1000 VUs
// //     { duration: "10m", target: 0 },    // Giảm về 0 VUs
// //   ],
// // };
// // Day 5: Evening
// // export let options = {
// //   stages: [
// //     { duration: "10m", target: 1000 },  // Tăng từ 0 đến 1000 VUs
// //     { duration: "15m", target: 2000 },  // Steady ở 2000 VUs
// //     { duration: "5m", target: 4000 },   // Spike mạnh lên 4000 VUs
// //     { duration: "15m", target: 0 },     // Giảm về 0 VUs
// //   ],
// // };

// const endpoints = [
//   { method: "GET", url: "/api/products/", weight: 0.5 },
//   { method: "GET", url: "/api/categories/", weight: 0.2 },
//   { method: "GET", url: "/api/carts/", weight: 0.1 },
//   { method: "GET", url: "/api/orders/", weight: 0.1 },
//   { method: "GET", url: "/health", weight: 0.05 },

//   { method: "GET", url: "/api/not-exist", weight: 0.025 },
//   { method: "POST", url: "/api/products/", weight: 0.025 },
// ];

// function weightedRandom(arr) {
//   let sum = arr.reduce((acc, cur) => acc + cur.weight, 0);
//   let r = Math.random() * sum;
//   for (let ep of arr) {
//     if (r < ep.weight) return ep;
//     r -= ep.weight;
//   }
// }

// export default function () {
//   const ep = weightedRandom(endpoints);

//   try {
//     if (ep.method === "GET") {
//       http.get(`${BASE_URL}${ep.url}`);
//     } else if (ep.method === "POST") {
//       http.post(`${BASE_URL}${ep.url}`, null, {
//         headers: { "Content-Type": "application/json" },
//       });
//     }
//   } catch (err) {
//     console.error(`🚫 Lỗi kết nối: ${ep.method} ${ep.url} → ${err.message}`);
//   }

//   sleep(1); // mỗi VU đợi 1s trước vòng lặp tiếp theo
// }

// { duration: "5m", target: 50 },
// { duration: "10m", target: 500},
// { duration: "15m", target: 1000 },
// { duration: "10m", target: 0 },

import http from "k6/http";

const BASE_URL = "http://my-api-alb-469487783.ap-northeast-1.elb.amazonaws.com";

// DEMO
// export const options = {
//   scenarios: {
//     demo_shock_wave: {
//       executor: "ramping-vus",
//       startVUs: 0,
//       stages: [
//         // 1) Ramp up to 50 VUs (2m)
//         { duration: "2m", target: 100 },

//         // 2) Hold 50 VUs (2m)
//         { duration: "2m", target: 100 },

//         // 3) Spike to 80 VUs (2m)
//         { duration: "2m", target: 200 },

//         // 4) Ramp down to 0 (2m)
//         { duration: "2m", target: 0 },
//       ],
//       gracefulRampDown: "30s",
//     },
//   },
// };

// 3
// export const options = {
//   scenarios: {
//     shock_wave: {
//       executor: "ramping-vus",
//       startVUs: 0,
//       stages: [
//         // --- Stage 1: Warm up  ---
//         { duration: "2m", target: 1000 },
//         { duration: "5m", target: 1000 },

//         // --- Stage 2: Cool down ---
//         { duration: "2m", target: 200 },
//         { duration: "5m", target: 200 },

//         // --- Stage 3: Spike/Shock ---
//         { duration: "1m", target: 1500 },
//         { duration: "5m", target: 1500 },

//         // --- Stage 4: End ---
//         { duration: "2m", target: 0 },
//       ],
//       gracefulRampDown: "30s",
//     },
//   },
// };

// 2
<<<<<<< Updated upstream
// export const options = {
//   scenarios: {
//     spike_test: { // Đặt tên là Spike Test
//       executor: "ramping-vus", // QUAN TRỌNG: Dùng User làm chuẩn
//       startVUs: 0,
//       stages: [
//         // Giai đoạn 1: Warm-up nhẹ nhàng (giả lập traffic bình thường)
//         { duration: "2m", target: 100 },

//         // Giai đoạn 2: CÚ SỐC (Spike) - Tăng gấp 15 lần trong 1 phút
//         // Đây là lúc xem AI hay AWS phản ứng nhanh hơn
//         { duration: "3m", target: 1500 },

//         // Giai đoạn 3: Duy trì áp lực (Sustain)
//         // Xem hệ thống nào ổn định Memory tốt hơn khi giữ tải cao
//         { duration: "10m", target: 1500 },

//         // Giai đoạn 4: Kết thúc
//         { duration: "5m", target: 0 },
=======
export const options = {
  scenarios: {
    spike_test: {
      executor: "ramping-vus",
      startVUs: 0,
      stages: [
        // --- Stage 1: Warm up  ---
        { duration: "2m", target: 100 },

        // --- Stage 2: Spike up ---
        { duration: "3m", target: 1500 },

        // --- Stage 3: Sustain ---
        { duration: "10m", target: 1500 },

        // --- Stage 4: End ---
        { duration: "5m", target: 0 },
      ],
      gracefulRampDown: "30s",
    },
  },
};

// 1
// export const options = {
//   scenarios: {
//     capacity_ramp_up: {
//       executor: "ramping-vus",
//       startVUs: 0,
//       stages: [
//         // --- Stage 1: Warm up ---
//         { duration: "5m", target: 50 },

//         // --- Stage 2: Ramp up ---
//         { duration: "10m", target: 500 },

//         // --- Stage 3: Stress / Peak ---
//         { duration: "15m", target: 1000 },

//         // --- Stage 4: End ---
//         { duration: "10m", target: 0 },
>>>>>>> Stashed changes
//       ],
//       gracefulRampDown: "30s",
//     },
//   },
// };

// 1
export const options = {
  scenarios: {
    capacity_ramp_up: {
      // Tên scenario: Kiểm tra sức chứa
      executor: "ramping-vus", // Dùng User ảo (VUs) làm chuẩn
      startVUs: 0,
      stages: [
        // Giai đoạn 1: Khởi động nhẹ (Warm up)
        { duration: "5m", target: 50 },

        // Giai đoạn 2: Tăng tốc (Ramp up)
        { duration: "10m", target: 500 },

        // Giai đoạn 3: Về đích (Stress / Peak)
        { duration: "15m", target: 1000 },

        // Giai đoạn 4: Hạ nhiệt (Cool down)
        { duration: "10m", target: 0 },
      ],
      gracefulRampDown: "30s", // Cho phép 30s để các request cuối cùng hoàn tất
    },
  },
};

const endpoints = [
  { method: "GET", url: "/api/products/", weight: 0.5 },
  { method: "GET", url: "/api/categories/", weight: 0.2 },
  { method: "GET", url: "/api/carts/", weight: 0.1 },
  { method: "GET", url: "/api/orders/", weight: 0.1 },
  { method: "GET", url: "/health", weight: 0.05 },

  // một ít request lỗi/bad để xem error rate
  { method: "GET", url: "/api/not-exist", weight: 0.025 },
  { method: "POST", url: "/api/products/", weight: 0.025 },
];

function weightedRandom(arr) {
  let sum = arr.reduce((acc, cur) => acc + cur.weight, 0);
  let r = Math.random() * sum;
  for (let ep of arr) {
    if (r < ep.weight) return ep;
    r -= ep.weight;
  }
  // fallback (không bao giờ tới nếu weight chuẩn)
  return arr[0];
}

// =======================================
// VU FUNCTION
// =======================================

export default function () {
  const ep = weightedRandom(endpoints);

  try {
    if (ep.method === "GET") {
      http.get(`${BASE_URL}${ep.url}`);
    } else if (ep.method === "POST") {
      http.post(`${BASE_URL}${ep.url}`, null, {
        headers: { "Content-Type": "application/json" },
      });
    }
  } catch (err) {
    console.error(`🚫 Lỗi kết nối: ${ep.method} ${ep.url} → ${err.message}`);
  }
}
