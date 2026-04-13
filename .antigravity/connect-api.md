# 🔌 Connect API Workflow (Flutter + Clean Architecture + Fold Pattern)

---

## 🎯 Trigger

Use this workflow when connecting a feature to a real API or implementing API integration.

---

## ✅ Pre-flight Checklist

* [ ] Identify endpoint (method, URL, headers, params, body)
* [ ] Check if Model already exists → reuse or extend
* [ ] Verify ApiConsumer setup in `lib/core/network/`
* [ ] Confirm response structure (success + error)
* [ ] Identify the Cubit/Feature using this API

---

## 🧱 Steps (STRICT ORDER)

---

### 🔹 Step 1 — Model (Data Mapping)

📁 Location:

```
data/model/
```

#### Rules:

* Must include:

  * `fromJson`
  * `toJson`
  * `copyWith`
* Handle null safety
* No business logic

---

### 🔹 Step 2 — Remote Data Source

📁 Location:

```
data/data_source/
```

#### Rules:

* Use `ApiConsumer` ONLY (no direct Dio usage)
* One method per endpoint
* Keep it thin (no logic)

#### Example:

```dart
Future<Map<String, dynamic>> getUserData() async {
  final response = await apiConsumer.get(EndPoints.user);
  return response;
}
```

---

### 🔹 Step 3 — Repository Implementation

📁 Location:

```
data/repo/
```

#### Rules:

* Call DataSource only
* Convert response → Model
* Wrap using `ApiResult`

#### Example:

```dart
@override
Future<ApiResult<UserModel>> getUser() async {
  try {
    final response = await remoteDataSource.getUserData();
    final model = UserModel.fromJson(response);
    return ApiResult.success(model);
  } catch (e) {
    return ApiResult.failure(ErrorHandler.handle(e));
  }
}
```

---

### 🔹 Step 4 — Error Handling (MANDATORY)

#### Rules:

* Use centralized `ErrorHandler`
* Never return raw exceptions
* Always return Failure model

---

### 🔹 Step 5 — Cubit Integration (Fold Pattern)

📁 Location:

```
cubit/
```

#### Rules:

* No API calls directly
* Always go through Repo
* MUST use `fold()`
* No try/catch هنا

#### Example:

```dart
Future<void> getUser() async {
  emit(UserLoading());

  final result = await repo.getUser();

  result.fold(
    (failure) => emit(UserError(failure.message)),
    (data) => emit(UserSuccess(data)),
  );
}
```

---

### 🔹 Step 6 — UI Handling

#### Rules:

* UI listens to states فقط
* No API calls
* No parsing
* No business logic

---

## 🚫 Strict Rules (DO NOT BREAK)

* ❌ No Dio outside ApiConsumer
* ❌ No API inside Cubit
* ❌ No parsing inside UI
* ❌ No try/catch inside Cubit
* ❌ No raw JSON to UI
* ❌ No mixing layers

---

## 🧠 Architecture Flow

### Request Flow:

```
UI → Cubit → Repo → DataSource → API
```

### Response Flow:

```
API → DataSource → Repo (ApiResult) → Cubit (fold) → UI
```

---

## 🧪 Verification Checklist

* [ ] API returns correct data
* [ ] Errors handled via ErrorHandler
* [ ] No crashes on bad response
* [ ] Fold pattern applied correctly
* [ ] Clean architecture respected
* [ ] `dart analyze` → 0 issues

---

## 🧩 Naming Convention

* Method: `getUser`, `createOrder`, `updateProfile`
* Cubit: `UserCubit`
* States: `UserLoading`, `UserSuccess`, `UserError`

---

## 💡 Pro Tips

* Log API in debug mode
* Add TODO for pagination if needed
* Design models for scalability (nested objects)
* Keep DataSource thin, Repo smart

---

## 🔥 Golden Rule

**"API integration is NOT about calling endpoints — it's about controlling data flow safely."**
