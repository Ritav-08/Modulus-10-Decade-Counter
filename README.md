# 📘 Design: Decade Counter (dCounter)

## 🔷 Description

This design implements a **4-bit decade counter (MOD-10)** using sequential logic.

The counter:
✔ Counts from **0 → 9 (0000 → 1001)**
✔ Resets back to **0 after reaching 9**
✔ Supports both:

* **Asynchronous Reset**
* **Synchronous Preset (loads value 5)**

---

## 🔷 Inputs & Outputs

Inputs:

* preset_i → Synchronous preset (loads 0101)
* rst_i    → Asynchronous reset (active HIGH)
* clk_i    → Clock input

Output:

* dout_o[3:0] → 4-bit counter output

---

## 🔷 Working Principle

1️⃣ **Asynchronous Reset**

* Triggered immediately when `rst_i = 1`
* Independent of clock
* Forces output → `0000`

2️⃣ **Synchronous Preset**

* Activated when `preset_i = 1`
* Works only on **clock edge**
* Loads value → `0101 (decimal 5)`

3️⃣ **Normal Counting**

* Counter increments on every **posedge clk**
* Sequence:
  0000 → 0001 → ... → 1001

4️⃣ **MOD-10 Operation**

* When count reaches `1001 (9)`
* Next state → `0000`

---

## 🔷 Truth Behavior Summary

| Condition      | Output     |
| -------------- | ---------- |
| rst_i = 1      | 0000       |
| preset_i = 1   | 0101       |
| dout_o == 1001 | 0000       |
| Otherwise      | dout_o + 1 |

---

## 🔷 Important Concept

⚠️ **Why Reset is Asynchronous but Preset is Synchronous?**

✔ Reset:

* Used for **initialization**
* Must act **immediately**
* Ensures system starts from a known state

✔ Preset:

* Used for **controlled loading**
* Must be **clock synchronized**
* Prevents unwanted glitches

---

## 🔷 Metastability

📌 **What is Metastability?**
A condition where a flip-flop output becomes **unstable (neither 0 nor 1 temporarily)**.

📌 **Why it occurs?**

* When input changes **very close to clock edge**
* Violates **setup/hold time**

📌 **Where it happens here?**

* Asynchronous signals like `rst_i`

📌 **Effects:**

* Unpredictable output
* Timing violations
* System instability

📌 **Can we avoid it completely?**
❌ No (cannot be eliminated)
✔ But can be **minimized**

📌 **How to reduce it?**

* Use **synchronizers (2 flip-flop stages)**
```
//Removed part from the Design: 
reg rst_sync1, rst_sync2;

always @(posedge clk_i) begin
   rst_sync1 <= rst_i;
   rst_sync2 <= rst_sync1;
end
//and now we can use rst_sync2, to reduce probability of metastability.
//This may be used by me in the future, like in FIFO designs. check repo for more context.
```
* Avoid asynchronous inputs where possible
* Maintain proper timing constraints

---

## 🔷 Key Observations
<br>
✔ Reset acts immediately (no clock needed)
<br>✔ Preset waits for clock edge
<br>✔ Counter correctly wraps after 9
<br>✔ Design mixes synchronous + asynchronous behavior

---

## 🔷 Simulation Notes

* Reset dominates all conditions
* Preset only works on clock edge
* Counter resumes normal operation after preset

---

## 🔷 Conclusion

This design demonstrates: <br>
✔ Mod-10 counting <br>
✔ Difference between synchronous & asynchronous control <br>
✔ Real-world issue: **metastability** <br>
