// var Module = require('module');
// var _require = Module.prototype.require;
// Module.prototype.require = new Proxy(Module.prototype.require, {
//   apply(target, thisA, AList) {
//     let moduleName = AList[0];
//     return new Proxy(function(){}.bind(this), {
//       apply(_, thisArg, args) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.apply(module, thisArg, args)
//       },
//       get(_, name, receiver) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.get(module, name, receiver)
//       },
//       construct(_, args) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return new module(...args);
//       },
//       has(_, name) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.has(module, name)
//       },
//       ownKeys(_) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         let ownKeys = Reflect.ownKeys(module);
//         return ownKeys;
//       },
//       getOwnPropertyDescriptor(_, key) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         let descriptor = Reflect.getOwnPropertyDescriptor(module, key)
//         if (key = '__esModule') {
//           descriptor.configurable = true;
//         }
//         return descriptor;
//       },
//       defineProperty(_, p, description) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.defineProperty(module, p, description);
//       },
//       getPrototypeOf(_) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.getPrototypeOf(module);
//       },
//       set(_, prop, value) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.set(module, prop, value);
//       },
//       isExtensible(_) {
//         let moduleToLoad = Module._resolveFilename(moduleName, thisA);
//         let module = _require.apply(thisA, [moduleToLoad]);
//         return Reflect.isExtensible(module);
//       },
//     });
//   }
// });

