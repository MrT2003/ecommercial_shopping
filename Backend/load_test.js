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
// 3
// Điều khiển theo RPS, không phải VU
// export const options = {
//   scenarios: {
//     shock_wave: {
//       executor: "ramping-vus", // Đổi về test User (VUs) cho dễ kiểm soát
//       startVUs: 0,
//       stages: [
//         // --- Giai đoạn 1: Warm-up & Cao điểm sáng ---
//         { duration: "2m", target: 1000 }, // Ramp-up nhanh (2p lên 1000 user)
//         { duration: "5m", target: 1000 }, // GIỮ (Hold) tải 1000 user trong 5p để ép hệ thống

//         // --- Giai đoạn 2: Giờ nghỉ trưa (Scale-in) ---
//         { duration: "2m", target: 200 }, // Giảm nhanh xuống 200
//         { duration: "5m", target: 200 }, // GIỮ mức thấp để dụ hệ thống tắt bớt server (Scale-in)

//         // --- Giai đoạn 3: Cú sốc chiều (Spike/Shock) ---
//         { duration: "1m", target: 1500 }, // SỐC! Tăng vọt từ 200 -> 1500 chỉ trong 1p (Cực gắt)
//         { duration: "5m", target: 1500 }, // GIỮ mức đỉnh điểm này để xem server mới có kịp cứu ko?

//         // --- Kết thúc ---
//         { duration: "2m", target: 0 }, // Giảm dần về 0
//       ],
//       gracefulRampDown: "30s",
//     },
//   },
// };
// 2
export const options = {
  scenarios: {
    spike_test: { // Đặt tên là Spike Test
      executor: "ramping-vus", // QUAN TRỌNG: Dùng User làm chuẩn
      startVUs: 0,
      stages: [
        // Giai đoạn 1: Warm-up nhẹ nhàng (giả lập traffic bình thường)
        { duration: "2m", target: 100 }, 
        
        // Giai đoạn 2: CÚ SỐC (Spike) - Tăng gấp 15 lần trong 1 phút
        // Đây là lúc xem AI hay AWS phản ứng nhanh hơn
        { duration: "3m", target: 1500 }, 
        
        // Giai đoạn 3: Duy trì áp lực (Sustain)
        // Xem hệ thống nào ổn định Memory tốt hơn khi giữ tải cao
        { duration: "10m", target: 1500 }, 
        
        // Giai đoạn 4: Kết thúc
        { duration: "5m", target: 0 }, 
      ],
      gracefulRampDown: "30s",
    },
  },
};
// 1
// export const options = {
//   scenarios: {
//     capacity_ramp_up: { // Tên scenario: Kiểm tra sức chứa
//       executor: "ramping-vus", // Dùng User ảo (VUs) làm chuẩn
//       startVUs: 0,
//       stages: [
//         // Giai đoạn 1: Khởi động nhẹ (Warm up)
//         // Tăng từ 0 lên 50 user trong 5 phút. 
//         // Mục đích: Để cache được làm nóng, hệ thống thoát khỏi trạng thái ngủ.
//         { duration: "5m", target: 50 },

//         // Giai đoạn 2: Tăng tốc (Ramp up)
//         // Tăng từ 50 lên 500 user trong 10 phút.
//         // Mục đích: Xem hệ thống bắt đầu scale ở mốc nào (ví dụ ở user thứ 200 hay 300?).
//         { duration: "10m", target: 500 },

//         // Giai đoạn 3: Về đích (Stress / Peak)
//         // Tăng từ 500 lên 1000 user trong 15 phút.
//         // Mục đích: Ép hệ thống lên tải cực đại. Quan sát xem 5 tasks của Custom AI có chịu nổi 1000 user không.
//         { duration: "15m", target: 1000 },

//         // Giai đoạn 4: Hạ nhiệt (Cool down)
//         // Giảm từ từ về 0.
//         // Mục đích: Xem hệ thống scale-in (tắt bớt máy) có mượt không hay bị lỗi.
//         { duration: "10m", target: 0 },
//       ],
//       gracefulRampDown: "30s", // Cho phép 30s để các request cuối cùng hoàn tất
//     },
//   },
// };

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

  // ❌ KHÔNG sleep ở đây để k6 bắn đúng RPS target
  // sleep(1);
}
