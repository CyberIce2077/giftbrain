// progressbar.js@1.1.1 downloaded from https://ga.jspm.io/npm:progressbar.js@1.1.1/dist/progressbar.js

var n="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var i={};(function(n){i=n()})((function(){var i;return function(){function r(n,i,z){function o(tt,et){if(!i[tt]){if(!n[tt]){var rt=null;if(!et&&rt)return rt(tt,!0);if(Z)return Z(tt,!0);var nt=new Error("Cannot find module '"+tt+"'");throw nt.code="MODULE_NOT_FOUND",nt}var it=i[tt]={exports:{}};n[tt][0].call(it.exports,(function(i){var z=n[tt][1][i];return o(z||i)}),it,it.exports,r,n,i,z)}return i[tt].exports}for(var Z=null,tt=0;tt<z.length;tt++)o(z[tt]);return o}return r}()({1:[function(i,z,Z){(function(i){(function(){var tt=200;var et="__lodash_hash_undefined__";var rt=800,nt=16;var it=9007199254740991;var at="[object Arguments]",ot="[object Array]",st="[object AsyncFunction]",ut="[object Boolean]",ct="[object Date]",ht="[object Error]",ft="[object Function]",pt="[object GeneratorFunction]",vt="[object Map]",gt="[object Number]",mt="[object Null]",wt="[object Object]",jt="[object Proxy]",kt="[object RegExp]",Ct="[object Set]",At="[object String]",xt="[object Undefined]",Tt="[object WeakMap]";var Mt="[object ArrayBuffer]",Et="[object DataView]",It="[object Float32Array]",Ft="[object Float64Array]",Dt="[object Int8Array]",Zt="[object Int16Array]",te="[object Int32Array]",ee="[object Uint8Array]",re="[object Uint8ClampedArray]",ne="[object Uint16Array]",ie="[object Uint32Array]";var ae=/[\\^$.*+?()[\]{}|]/g;var oe=/^\[object .+?Constructor\]$/;var se=/^(?:0|[1-9]\d*)$/;var ue={};ue[It]=ue[Ft]=ue[Dt]=ue[Zt]=ue[te]=ue[ee]=ue[re]=ue[ne]=ue[ie]=true;ue[at]=ue[ot]=ue[Mt]=ue[ut]=ue[Et]=ue[ct]=ue[ht]=ue[ft]=ue[vt]=ue[gt]=ue[wt]=ue[kt]=ue[Ct]=ue[At]=ue[Tt]=false;var ce="object"==typeof i&&i&&i.Object===Object&&i;var le="object"==typeof self&&self&&self.Object===Object&&self;var he=ce||le||Function("return this")();var fe="object"==typeof Z&&Z&&!Z.nodeType&&Z;var pe=fe&&"object"==typeof z&&z&&!z.nodeType&&z;var ve=pe&&pe.exports===fe;var ye=ve&&ce.process;var de=function(){try{var n=pe&&pe.require&&pe.require("util").types;return n||ye&&ye.binding&&ye.binding("util")}catch(n){}}();var _e=de&&de.isTypedArray;
/**
           * A faster alternative to `Function#apply`, this function invokes `func`
           * with the `this` binding of `thisArg` and the arguments of `args`.
           *
           * @private
           * @param {Function} func The function to invoke.
           * @param {*} thisArg The `this` binding of `func`.
           * @param {Array} args The arguments to invoke `func` with.
           * @returns {*} Returns the result of `func`.
           */function apply(n,i,z){switch(z.length){case 0:return n.call(i);case 1:return n.call(i,z[0]);case 2:return n.call(i,z[0],z[1]);case 3:return n.call(i,z[0],z[1],z[2])}return n.apply(i,z)}
/**
           * The base implementation of `_.times` without support for iteratee shorthands
           * or max array length checks.
           *
           * @private
           * @param {number} n The number of times to invoke `iteratee`.
           * @param {Function} iteratee The function invoked per iteration.
           * @returns {Array} Returns the array of results.
           */function baseTimes(n,i){var z=-1,Z=Array(n);while(++z<n)Z[z]=i(z);return Z}
/**
           * The base implementation of `_.unary` without support for storing metadata.
           *
           * @private
           * @param {Function} func The function to cap arguments for.
           * @returns {Function} Returns the new capped function.
           */function baseUnary(n){return function(i){return n(i)}}
/**
           * Gets the value at `key` of `object`.
           *
           * @private
           * @param {Object} [object] The object to query.
           * @param {string} key The key of the property to get.
           * @returns {*} Returns the property value.
           */function getValue(n,i){return null==n?void 0:n[i]}
/**
           * Creates a unary function that invokes `func` with its argument transformed.
           *
           * @private
           * @param {Function} func The function to wrap.
           * @param {Function} transform The argument transform.
           * @returns {Function} Returns the new function.
           */function overArg(n,i){return function(z){return n(i(z))}}var ge=Array.prototype,be=Function.prototype,me=Object.prototype;var we=he["__core-js_shared__"];var Se=be.toString;var Oe=me.hasOwnProperty;var je=function(){var n=/[^.]+$/.exec(we&&we.keys&&we.keys.IE_PROTO||"");return n?"Symbol(src)_1."+n:""}();var ke=me.toString;var Ce=Se.call(Object);var Ae=RegExp("^"+Se.call(Oe).replace(ae,"\\$&").replace(/hasOwnProperty|(function).*?(?=\\\()| for .+?(?=\\\])/g,"$1.*?")+"$");var xe=ve?he.Buffer:void 0,Pe=he.Symbol,Te=he.Uint8Array,Me=xe?xe.allocUnsafe:void 0,Ee=overArg(Object.getPrototypeOf,Object),Ie=Object.create,Fe=me.propertyIsEnumerable,Le=ge.splice,We=Pe?Pe.toStringTag:void 0;var De=function(){try{var n=getNative(Object,"defineProperty");n({},"",{});return n}catch(n){}}();var ze=xe?xe.isBuffer:void 0,qe=Math.max,Re=Date.now;var Ge=getNative(he,"Map"),Ve=getNative(Object,"create");
/**
           * The base implementation of `_.create` without support for assigning
           * properties to the created object.
           *
           * @private
           * @param {Object} proto The object to inherit from.
           * @returns {Object} Returns the new object.
           */var Ne=function(){function object(){}return function(n){if(!isObject(n))return{};if(Ie)return Ie(n);object.prototype=n;var i=new object;object.prototype=void 0;return i}}();
/**
           * Creates a hash object.
           *
           * @private
           * @constructor
           * @param {Array} [entries] The key-value pairs to cache.
           */function Hash(n){var i=-1,z=null==n?0:n.length;this.clear();while(++i<z){var Z=n[i];this.set(Z[0],Z[1])}}function hashClear(){(this||n).__data__=Ve?Ve(null):{};(this||n).size=0}
/**
           * Removes `key` and its value from the hash.
           *
           * @private
           * @name delete
           * @memberOf Hash
           * @param {Object} hash The hash to modify.
           * @param {string} key The key of the value to remove.
           * @returns {boolean} Returns `true` if the entry was removed, else `false`.
           */function hashDelete(i){var z=this.has(i)&&delete(this||n).__data__[i];(this||n).size-=z?1:0;return z}
/**
           * Gets the hash value for `key`.
           *
           * @private
           * @name get
           * @memberOf Hash
           * @param {string} key The key of the value to get.
           * @returns {*} Returns the entry value.
           */function hashGet(i){var z=(this||n).__data__;if(Ve){var Z=z[i];return Z===et?void 0:Z}return Oe.call(z,i)?z[i]:void 0}
/**
           * Checks if a hash value for `key` exists.
           *
           * @private
           * @name has
           * @memberOf Hash
           * @param {string} key The key of the entry to check.
           * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
           */function hashHas(i){var z=(this||n).__data__;return Ve?void 0!==z[i]:Oe.call(z,i)}
/**
           * Sets the hash `key` to `value`.
           *
           * @private
           * @name set
           * @memberOf Hash
           * @param {string} key The key of the value to set.
           * @param {*} value The value to set.
           * @returns {Object} Returns the hash instance.
           */function hashSet(i,z){var Z=(this||n).__data__;(this||n).size+=this.has(i)?0:1;Z[i]=Ve&&void 0===z?et:z;return this||n}Hash.prototype.clear=hashClear;Hash.prototype.delete=hashDelete;Hash.prototype.get=hashGet;Hash.prototype.has=hashHas;Hash.prototype.set=hashSet;
/**
           * Creates an list cache object.
           *
           * @private
           * @constructor
           * @param {Array} [entries] The key-value pairs to cache.
           */function ListCache(n){var i=-1,z=null==n?0:n.length;this.clear();while(++i<z){var Z=n[i];this.set(Z[0],Z[1])}}function listCacheClear(){(this||n).__data__=[];(this||n).size=0}
/**
           * Removes `key` and its value from the list cache.
           *
           * @private
           * @name delete
           * @memberOf ListCache
           * @param {string} key The key of the value to remove.
           * @returns {boolean} Returns `true` if the entry was removed, else `false`.
           */function listCacheDelete(i){var z=(this||n).__data__,Z=assocIndexOf(z,i);if(Z<0)return false;var tt=z.length-1;Z==tt?z.pop():Le.call(z,Z,1);--(this||n).size;return true}
/**
           * Gets the list cache value for `key`.
           *
           * @private
           * @name get
           * @memberOf ListCache
           * @param {string} key The key of the value to get.
           * @returns {*} Returns the entry value.
           */function listCacheGet(i){var z=(this||n).__data__,Z=assocIndexOf(z,i);return Z<0?void 0:z[Z][1]}
/**
           * Checks if a list cache value for `key` exists.
           *
           * @private
           * @name has
           * @memberOf ListCache
           * @param {string} key The key of the entry to check.
           * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
           */function listCacheHas(i){return assocIndexOf((this||n).__data__,i)>-1}
/**
           * Sets the list cache `key` to `value`.
           *
           * @private
           * @name set
           * @memberOf ListCache
           * @param {string} key The key of the value to set.
           * @param {*} value The value to set.
           * @returns {Object} Returns the list cache instance.
           */function listCacheSet(i,z){var Z=(this||n).__data__,tt=assocIndexOf(Z,i);if(tt<0){++(this||n).size;Z.push([i,z])}else Z[tt][1]=z;return this||n}ListCache.prototype.clear=listCacheClear;ListCache.prototype.delete=listCacheDelete;ListCache.prototype.get=listCacheGet;ListCache.prototype.has=listCacheHas;ListCache.prototype.set=listCacheSet;
/**
           * Creates a map cache object to store key-value pairs.
           *
           * @private
           * @constructor
           * @param {Array} [entries] The key-value pairs to cache.
           */function MapCache(n){var i=-1,z=null==n?0:n.length;this.clear();while(++i<z){var Z=n[i];this.set(Z[0],Z[1])}}function mapCacheClear(){(this||n).size=0;(this||n).__data__={hash:new Hash,map:new(Ge||ListCache),string:new Hash}}
/**
           * Removes `key` and its value from the map.
           *
           * @private
           * @name delete
           * @memberOf MapCache
           * @param {string} key The key of the value to remove.
           * @returns {boolean} Returns `true` if the entry was removed, else `false`.
           */function mapCacheDelete(i){var z=getMapData(this||n,i).delete(i);(this||n).size-=z?1:0;return z}
/**
           * Gets the map value for `key`.
           *
           * @private
           * @name get
           * @memberOf MapCache
           * @param {string} key The key of the value to get.
           * @returns {*} Returns the entry value.
           */function mapCacheGet(i){return getMapData(this||n,i).get(i)}
/**
           * Checks if a map value for `key` exists.
           *
           * @private
           * @name has
           * @memberOf MapCache
           * @param {string} key The key of the entry to check.
           * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
           */function mapCacheHas(i){return getMapData(this||n,i).has(i)}
/**
           * Sets the map `key` to `value`.
           *
           * @private
           * @name set
           * @memberOf MapCache
           * @param {string} key The key of the value to set.
           * @param {*} value The value to set.
           * @returns {Object} Returns the map cache instance.
           */function mapCacheSet(i,z){var Z=getMapData(this||n,i),tt=Z.size;Z.set(i,z);(this||n).size+=Z.size==tt?0:1;return this||n}MapCache.prototype.clear=mapCacheClear;MapCache.prototype.delete=mapCacheDelete;MapCache.prototype.get=mapCacheGet;MapCache.prototype.has=mapCacheHas;MapCache.prototype.set=mapCacheSet;
/**
           * Creates a stack cache object to store key-value pairs.
           *
           * @private
           * @constructor
           * @param {Array} [entries] The key-value pairs to cache.
           */function Stack(i){var z=(this||n).__data__=new ListCache(i);(this||n).size=z.size}function stackClear(){(this||n).__data__=new ListCache;(this||n).size=0}
/**
           * Removes `key` and its value from the stack.
           *
           * @private
           * @name delete
           * @memberOf Stack
           * @param {string} key The key of the value to remove.
           * @returns {boolean} Returns `true` if the entry was removed, else `false`.
           */function stackDelete(i){var z=(this||n).__data__,Z=z.delete(i);(this||n).size=z.size;return Z}
/**
           * Gets the stack value for `key`.
           *
           * @private
           * @name get
           * @memberOf Stack
           * @param {string} key The key of the value to get.
           * @returns {*} Returns the entry value.
           */function stackGet(i){return(this||n).__data__.get(i)}
/**
           * Checks if a stack value for `key` exists.
           *
           * @private
           * @name has
           * @memberOf Stack
           * @param {string} key The key of the entry to check.
           * @returns {boolean} Returns `true` if an entry for `key` exists, else `false`.
           */function stackHas(i){return(this||n).__data__.has(i)}
/**
           * Sets the stack `key` to `value`.
           *
           * @private
           * @name set
           * @memberOf Stack
           * @param {string} key The key of the value to set.
           * @param {*} value The value to set.
           * @returns {Object} Returns the stack cache instance.
           */function stackSet(i,z){var Z=(this||n).__data__;if(Z instanceof ListCache){var et=Z.__data__;if(!Ge||et.length<tt-1){et.push([i,z]);(this||n).size=++Z.size;return this||n}Z=(this||n).__data__=new MapCache(et)}Z.set(i,z);(this||n).size=Z.size;return this||n}Stack.prototype.clear=stackClear;Stack.prototype.delete=stackDelete;Stack.prototype.get=stackGet;Stack.prototype.has=stackHas;Stack.prototype.set=stackSet;
/**
           * Creates an array of the enumerable property names of the array-like `value`.
           *
           * @private
           * @param {*} value The value to query.
           * @param {boolean} inherited Specify returning inherited property names.
           * @returns {Array} Returns the array of property names.
           */function arrayLikeKeys(n,i){var z=Qe(n),Z=!z&&Ke(n),tt=!z&&!Z&&Ye(n),et=!z&&!Z&&!tt&&$e(n),rt=z||Z||tt||et,nt=rt?baseTimes(n.length,String):[],it=nt.length;for(var at in n)!i&&!Oe.call(n,at)||rt&&("length"==at||tt&&("offset"==at||"parent"==at)||et&&("buffer"==at||"byteLength"==at||"byteOffset"==at)||isIndex(at,it))||nt.push(at);return nt}
/**
           * This function is like `assignValue` except that it doesn't assign
           * `undefined` values.
           *
           * @private
           * @param {Object} object The object to modify.
           * @param {string} key The key of the property to assign.
           * @param {*} value The value to assign.
           */function assignMergeValue(n,i,z){(void 0!==z&&!eq(n[i],z)||void 0===z&&!(i in n))&&baseAssignValue(n,i,z)}
/**
           * Assigns `value` to `key` of `object` if the existing value is not equivalent
           * using [`SameValueZero`](http://ecma-international.org/ecma-262/7.0/#sec-samevaluezero)
           * for equality comparisons.
           *
           * @private
           * @param {Object} object The object to modify.
           * @param {string} key The key of the property to assign.
           * @param {*} value The value to assign.
           */function assignValue(n,i,z){var Z=n[i];Oe.call(n,i)&&eq(Z,z)&&(void 0!==z||i in n)||baseAssignValue(n,i,z)}
/**
           * Gets the index at which the `key` is found in `array` of key-value pairs.
           *
           * @private
           * @param {Array} array The array to inspect.
           * @param {*} key The key to search for.
           * @returns {number} Returns the index of the matched value, else `-1`.
           */function assocIndexOf(n,i){var z=n.length;while(z--)if(eq(n[z][0],i))return z;return-1}
/**
           * The base implementation of `assignValue` and `assignMergeValue` without
           * value checks.
           *
           * @private
           * @param {Object} object The object to modify.
           * @param {string} key The key of the property to assign.
           * @param {*} value The value to assign.
           */function baseAssignValue(n,i,z){"__proto__"==i&&De?De(n,i,{configurable:true,enumerable:true,value:z,writable:true}):n[i]=z}
/**
           * The base implementation of `baseForOwn` which iterates over `object`
           * properties returned by `keysFunc` and invokes `iteratee` for each property.
           * Iteratee functions may exit iteration early by explicitly returning `false`.
           *
           * @private
           * @param {Object} object The object to iterate over.
           * @param {Function} iteratee The function invoked per iteration.
           * @param {Function} keysFunc The function to get the keys of `object`.
           * @returns {Object} Returns `object`.
           */var Be=createBaseFor();
/**
           * The base implementation of `getTag` without fallbacks for buggy environments.
           *
           * @private
           * @param {*} value The value to query.
           * @returns {string} Returns the `toStringTag`.
           */function baseGetTag(n){return null==n?void 0===n?xt:mt:We&&We in Object(n)?getRawTag(n):objectToString(n)}
/**
           * The base implementation of `_.isArguments`.
           *
           * @private
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is an `arguments` object,
           */function baseIsArguments(n){return isObjectLike(n)&&baseGetTag(n)==at}
/**
           * The base implementation of `_.isNative` without bad shim checks.
           *
           * @private
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a native function,
           *  else `false`.
           */function baseIsNative(n){if(!isObject(n)||isMasked(n))return false;var i=isFunction(n)?Ae:oe;return i.test(toSource(n))}
/**
           * The base implementation of `_.isTypedArray` without Node.js optimizations.
           *
           * @private
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a typed array, else `false`.
           */function baseIsTypedArray(n){return isObjectLike(n)&&isLength(n.length)&&!!ue[baseGetTag(n)]}
/**
           * The base implementation of `_.keysIn` which doesn't treat sparse arrays as dense.
           *
           * @private
           * @param {Object} object The object to query.
           * @returns {Array} Returns the array of property names.
           */function baseKeysIn(n){if(!isObject(n))return nativeKeysIn(n);var i=isPrototype(n),z=[];for(var Z in n)"constructor"==Z&&(i||!Oe.call(n,Z))||z.push(Z);return z}
/**
           * The base implementation of `_.merge` without support for multiple sources.
           *
           * @private
           * @param {Object} object The destination object.
           * @param {Object} source The source object.
           * @param {number} srcIndex The index of `source`.
           * @param {Function} [customizer] The function to customize merged values.
           * @param {Object} [stack] Tracks traversed source values and their merged
           *  counterparts.
           */function baseMerge(n,i,z,Z,tt){n!==i&&Be(i,(function(et,rt){tt||(tt=new Stack);if(isObject(et))baseMergeDeep(n,i,rt,z,baseMerge,Z,tt);else{var nt=Z?Z(safeGet(n,rt),et,rt+"",n,i,tt):void 0;void 0===nt&&(nt=et);assignMergeValue(n,rt,nt)}}),keysIn)}
/**
           * A specialized version of `baseMerge` for arrays and objects which performs
           * deep merges and tracks traversed objects enabling objects with circular
           * references to be merged.
           *
           * @private
           * @param {Object} object The destination object.
           * @param {Object} source The source object.
           * @param {string} key The key of the value to merge.
           * @param {number} srcIndex The index of `source`.
           * @param {Function} mergeFunc The function to merge values.
           * @param {Function} [customizer] The function to customize assigned values.
           * @param {Object} [stack] Tracks traversed source values and their merged
           *  counterparts.
           */function baseMergeDeep(n,i,z,Z,tt,et,rt){var nt=safeGet(n,z),it=safeGet(i,z),at=rt.get(it);if(at)assignMergeValue(n,z,at);else{var ot=et?et(nt,it,z+"",n,i,rt):void 0;var st=void 0===ot;if(st){var ut=Qe(it),ct=!ut&&Ye(it),ht=!ut&&!ct&&$e(it);ot=it;if(ut||ct||ht)if(Qe(nt))ot=nt;else if(isArrayLikeObject(nt))ot=copyArray(nt);else if(ct){st=false;ot=cloneBuffer(it,true)}else if(ht){st=false;ot=cloneTypedArray(it,true)}else ot=[];else if(isPlainObject(it)||Ke(it)){ot=nt;Ke(nt)?ot=toPlainObject(nt):isObject(nt)&&!isFunction(nt)||(ot=initCloneObject(it))}else st=false}if(st){rt.set(it,ot);tt(ot,it,Z,et,rt);rt.delete(it)}assignMergeValue(n,z,ot)}}
/**
           * The base implementation of `_.rest` which doesn't validate or coerce arguments.
           *
           * @private
           * @param {Function} func The function to apply a rest parameter to.
           * @param {number} [start=func.length-1] The start position of the rest parameter.
           * @returns {Function} Returns the new function.
           */function baseRest(n,i){return Ue(overRest(n,i,identity),n+"")}
/**
           * The base implementation of `setToString` without support for hot loop shorting.
           *
           * @private
           * @param {Function} func The function to modify.
           * @param {Function} string The `toString` result.
           * @returns {Function} Returns `func`.
           */var He=De?function(n,i){return De(n,"toString",{configurable:true,enumerable:false,value:constant(i),writable:true})}:identity;
/**
           * Creates a clone of  `buffer`.
           *
           * @private
           * @param {Buffer} buffer The buffer to clone.
           * @param {boolean} [isDeep] Specify a deep clone.
           * @returns {Buffer} Returns the cloned buffer.
           */function cloneBuffer(n,i){if(i)return n.slice();var z=n.length,Z=Me?Me(z):new n.constructor(z);n.copy(Z);return Z}
/**
           * Creates a clone of `arrayBuffer`.
           *
           * @private
           * @param {ArrayBuffer} arrayBuffer The array buffer to clone.
           * @returns {ArrayBuffer} Returns the cloned array buffer.
           */function cloneArrayBuffer(n){var i=new n.constructor(n.byteLength);new Te(i).set(new Te(n));return i}
/**
           * Creates a clone of `typedArray`.
           *
           * @private
           * @param {Object} typedArray The typed array to clone.
           * @param {boolean} [isDeep] Specify a deep clone.
           * @returns {Object} Returns the cloned typed array.
           */function cloneTypedArray(n,i){var z=i?cloneArrayBuffer(n.buffer):n.buffer;return new n.constructor(z,n.byteOffset,n.length)}
/**
           * Copies the values of `source` to `array`.
           *
           * @private
           * @param {Array} source The array to copy values from.
           * @param {Array} [array=[]] The array to copy values to.
           * @returns {Array} Returns `array`.
           */function copyArray(n,i){var z=-1,Z=n.length;i||(i=Array(Z));while(++z<Z)i[z]=n[z];return i}
/**
           * Copies properties of `source` to `object`.
           *
           * @private
           * @param {Object} source The object to copy properties from.
           * @param {Array} props The property identifiers to copy.
           * @param {Object} [object={}] The object to copy properties to.
           * @param {Function} [customizer] The function to customize copied values.
           * @returns {Object} Returns `object`.
           */function copyObject(n,i,z,Z){var tt=!z;z||(z={});var et=-1,rt=i.length;while(++et<rt){var nt=i[et];var it=Z?Z(z[nt],n[nt],nt,z,n):void 0;void 0===it&&(it=n[nt]);tt?baseAssignValue(z,nt,it):assignValue(z,nt,it)}return z}
/**
           * Creates a function like `_.assign`.
           *
           * @private
           * @param {Function} assigner The function to assign values.
           * @returns {Function} Returns the new assigner function.
           */function createAssigner(n){return baseRest((function(i,z){var Z=-1,tt=z.length,et=tt>1?z[tt-1]:void 0,rt=tt>2?z[2]:void 0;et=n.length>3&&"function"==typeof et?(tt--,et):void 0;if(rt&&isIterateeCall(z[0],z[1],rt)){et=tt<3?void 0:et;tt=1}i=Object(i);while(++Z<tt){var nt=z[Z];nt&&n(i,nt,Z,et)}return i}))}
/**
           * Creates a base function for methods like `_.forIn` and `_.forOwn`.
           *
           * @private
           * @param {boolean} [fromRight] Specify iterating from right to left.
           * @returns {Function} Returns the new base function.
           */function createBaseFor(n){return function(i,z,Z){var tt=-1,et=Object(i),rt=Z(i),nt=rt.length;while(nt--){var it=rt[n?nt:++tt];if(false===z(et[it],it,et))break}return i}}
/**
           * Gets the data for `map`.
           *
           * @private
           * @param {Object} map The map to query.
           * @param {string} key The reference key.
           * @returns {*} Returns the map data.
           */function getMapData(n,i){var z=n.__data__;return isKeyable(i)?z["string"==typeof i?"string":"hash"]:z.map}
/**
           * Gets the native function at `key` of `object`.
           *
           * @private
           * @param {Object} object The object to query.
           * @param {string} key The key of the method to get.
           * @returns {*} Returns the function if it's native, else `undefined`.
           */function getNative(n,i){var z=getValue(n,i);return baseIsNative(z)?z:void 0}
/**
           * A specialized version of `baseGetTag` which ignores `Symbol.toStringTag` values.
           *
           * @private
           * @param {*} value The value to query.
           * @returns {string} Returns the raw `toStringTag`.
           */function getRawTag(n){var i=Oe.call(n,We),z=n[We];try{n[We]=void 0;var Z=true}catch(n){}var tt=ke.call(n);Z&&(i?n[We]=z:delete n[We]);return tt}
/**
           * Initializes an object clone.
           *
           * @private
           * @param {Object} object The object to clone.
           * @returns {Object} Returns the initialized clone.
           */function initCloneObject(n){return"function"!=typeof n.constructor||isPrototype(n)?{}:Ne(Ee(n))}
/**
           * Checks if `value` is a valid array-like index.
           *
           * @private
           * @param {*} value The value to check.
           * @param {number} [length=MAX_SAFE_INTEGER] The upper bounds of a valid index.
           * @returns {boolean} Returns `true` if `value` is a valid index, else `false`.
           */function isIndex(n,i){var z=typeof n;i=null==i?it:i;return!!i&&("number"==z||"symbol"!=z&&se.test(n))&&n>-1&&n%1==0&&n<i}
/**
           * Checks if the given arguments are from an iteratee call.
           *
           * @private
           * @param {*} value The potential iteratee value argument.
           * @param {*} index The potential iteratee index or key argument.
           * @param {*} object The potential iteratee object argument.
           * @returns {boolean} Returns `true` if the arguments are from an iteratee call,
           *  else `false`.
           */function isIterateeCall(n,i,z){if(!isObject(z))return false;var Z=typeof i;return!!("number"==Z?isArrayLike(z)&&isIndex(i,z.length):"string"==Z&&i in z)&&eq(z[i],n)}
/**
           * Checks if `value` is suitable for use as unique object key.
           *
           * @private
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is suitable, else `false`.
           */function isKeyable(n){var i=typeof n;return"string"==i||"number"==i||"symbol"==i||"boolean"==i?"__proto__"!==n:null===n}
/**
           * Checks if `func` has its source masked.
           *
           * @private
           * @param {Function} func The function to check.
           * @returns {boolean} Returns `true` if `func` is masked, else `false`.
           */function isMasked(n){return!!je&&je in n}
/**
           * Checks if `value` is likely a prototype object.
           *
           * @private
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a prototype, else `false`.
           */function isPrototype(n){var i=n&&n.constructor,z="function"==typeof i&&i.prototype||me;return n===z}
/**
           * This function is like
           * [`Object.keys`](http://ecma-international.org/ecma-262/7.0/#sec-object.keys)
           * except that it includes inherited enumerable properties.
           *
           * @private
           * @param {Object} object The object to query.
           * @returns {Array} Returns the array of property names.
           */function nativeKeysIn(n){var i=[];if(null!=n)for(var z in Object(n))i.push(z);return i}
/**
           * Converts `value` to a string using `Object.prototype.toString`.
           *
           * @private
           * @param {*} value The value to convert.
           * @returns {string} Returns the converted string.
           */function objectToString(n){return ke.call(n)}
/**
           * A specialized version of `baseRest` which transforms the rest array.
           *
           * @private
           * @param {Function} func The function to apply a rest parameter to.
           * @param {number} [start=func.length-1] The start position of the rest parameter.
           * @param {Function} transform The rest array transform.
           * @returns {Function} Returns the new function.
           */function overRest(i,z,Z){z=qe(void 0===z?i.length-1:z,0);return function(){var tt=arguments,et=-1,rt=qe(tt.length-z,0),nt=Array(rt);while(++et<rt)nt[et]=tt[z+et];et=-1;var it=Array(z+1);while(++et<z)it[et]=tt[et];it[z]=Z(nt);return apply(i,this||n,it)}}
/**
           * Gets the value at `key`, unless `key` is "__proto__" or "constructor".
           *
           * @private
           * @param {Object} object The object to query.
           * @param {string} key The key of the property to get.
           * @returns {*} Returns the property value.
           */function safeGet(n,i){if(("constructor"!==i||"function"!==typeof n[i])&&"__proto__"!=i)return n[i]}
/**
           * Sets the `toString` method of `func` to return `string`.
           *
           * @private
           * @param {Function} func The function to modify.
           * @param {Function} string The `toString` result.
           * @returns {Function} Returns `func`.
           */var Ue=shortOut(He);
/**
           * Creates a function that'll short out and invoke `identity` instead
           * of `func` when it's called `HOT_COUNT` or more times in `HOT_SPAN`
           * milliseconds.
           *
           * @private
           * @param {Function} func The function to restrict.
           * @returns {Function} Returns the new shortable function.
           */function shortOut(n){var i=0,z=0;return function(){var Z=Re(),tt=nt-(Z-z);z=Z;if(tt>0){if(++i>=rt)return arguments[0]}else i=0;return n.apply(void 0,arguments)}}
/**
           * Converts `func` to its source code.
           *
           * @private
           * @param {Function} func The function to convert.
           * @returns {string} Returns the source code.
           */function toSource(n){if(null!=n){try{return Se.call(n)}catch(n){}try{return n+""}catch(n){}}return""}
/**
           * Performs a
           * [`SameValueZero`](http://ecma-international.org/ecma-262/7.0/#sec-samevaluezero)
           * comparison between two values to determine if they are equivalent.
           *
           * @static
           * @memberOf _
           * @since 4.0.0
           * @category Lang
           * @param {*} value The value to compare.
           * @param {*} other The other value to compare.
           * @returns {boolean} Returns `true` if the values are equivalent, else `false`.
           * @example
           *
           * var object = { 'a': 1 };
           * var other = { 'a': 1 };
           *
           * _.eq(object, object);
           * // => true
           *
           * _.eq(object, other);
           * // => false
           *
           * _.eq('a', 'a');
           * // => true
           *
           * _.eq('a', Object('a'));
           * // => false
           *
           * _.eq(NaN, NaN);
           * // => true
           */function eq(n,i){return n===i||n!==n&&i!==i}
/**
           * Checks if `value` is likely an `arguments` object.
           *
           * @static
           * @memberOf _
           * @since 0.1.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is an `arguments` object,
           *  else `false`.
           * @example
           *
           * _.isArguments(function() { return arguments; }());
           * // => true
           *
           * _.isArguments([1, 2, 3]);
           * // => false
           */var Ke=baseIsArguments(function(){return arguments}())?baseIsArguments:function(n){return isObjectLike(n)&&Oe.call(n,"callee")&&!Fe.call(n,"callee")};
/**
           * Checks if `value` is classified as an `Array` object.
           *
           * @static
           * @memberOf _
           * @since 0.1.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is an array, else `false`.
           * @example
           *
           * _.isArray([1, 2, 3]);
           * // => true
           *
           * _.isArray(document.body.children);
           * // => false
           *
           * _.isArray('abc');
           * // => false
           *
           * _.isArray(_.noop);
           * // => false
           */var Qe=Array.isArray;
/**
           * Checks if `value` is array-like. A value is considered array-like if it's
           * not a function and has a `value.length` that's an integer greater than or
           * equal to `0` and less than or equal to `Number.MAX_SAFE_INTEGER`.
           *
           * @static
           * @memberOf _
           * @since 4.0.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is array-like, else `false`.
           * @example
           *
           * _.isArrayLike([1, 2, 3]);
           * // => true
           *
           * _.isArrayLike(document.body.children);
           * // => true
           *
           * _.isArrayLike('abc');
           * // => true
           *
           * _.isArrayLike(_.noop);
           * // => false
           */function isArrayLike(n){return null!=n&&isLength(n.length)&&!isFunction(n)}
/**
           * This method is like `_.isArrayLike` except that it also checks if `value`
           * is an object.
           *
           * @static
           * @memberOf _
           * @since 4.0.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is an array-like object,
           *  else `false`.
           * @example
           *
           * _.isArrayLikeObject([1, 2, 3]);
           * // => true
           *
           * _.isArrayLikeObject(document.body.children);
           * // => true
           *
           * _.isArrayLikeObject('abc');
           * // => false
           *
           * _.isArrayLikeObject(_.noop);
           * // => false
           */function isArrayLikeObject(n){return isObjectLike(n)&&isArrayLike(n)}
/**
           * Checks if `value` is a buffer.
           *
           * @static
           * @memberOf _
           * @since 4.3.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a buffer, else `false`.
           * @example
           *
           * _.isBuffer(new Buffer(2));
           * // => true
           *
           * _.isBuffer(new Uint8Array(2));
           * // => false
           */var Ye=ze||stubFalse;
/**
           * Checks if `value` is classified as a `Function` object.
           *
           * @static
           * @memberOf _
           * @since 0.1.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a function, else `false`.
           * @example
           *
           * _.isFunction(_);
           * // => true
           *
           * _.isFunction(/abc/);
           * // => false
           */function isFunction(n){if(!isObject(n))return false;var i=baseGetTag(n);return i==ft||i==pt||i==st||i==jt}
/**
           * Checks if `value` is a valid array-like length.
           *
           * **Note:** This method is loosely based on
           * [`ToLength`](http://ecma-international.org/ecma-262/7.0/#sec-tolength).
           *
           * @static
           * @memberOf _
           * @since 4.0.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a valid length, else `false`.
           * @example
           *
           * _.isLength(3);
           * // => true
           *
           * _.isLength(Number.MIN_VALUE);
           * // => false
           *
           * _.isLength(Infinity);
           * // => false
           *
           * _.isLength('3');
           * // => false
           */function isLength(n){return"number"==typeof n&&n>-1&&n%1==0&&n<=it}
/**
           * Checks if `value` is the
           * [language type](http://www.ecma-international.org/ecma-262/7.0/#sec-ecmascript-language-types)
           * of `Object`. (e.g. arrays, functions, objects, regexes, `new Number(0)`, and `new String('')`)
           *
           * @static
           * @memberOf _
           * @since 0.1.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is an object, else `false`.
           * @example
           *
           * _.isObject({});
           * // => true
           *
           * _.isObject([1, 2, 3]);
           * // => true
           *
           * _.isObject(_.noop);
           * // => true
           *
           * _.isObject(null);
           * // => false
           */function isObject(n){var i=typeof n;return null!=n&&("object"==i||"function"==i)}
/**
           * Checks if `value` is object-like. A value is object-like if it's not `null`
           * and has a `typeof` result of "object".
           *
           * @static
           * @memberOf _
           * @since 4.0.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is object-like, else `false`.
           * @example
           *
           * _.isObjectLike({});
           * // => true
           *
           * _.isObjectLike([1, 2, 3]);
           * // => true
           *
           * _.isObjectLike(_.noop);
           * // => false
           *
           * _.isObjectLike(null);
           * // => false
           */function isObjectLike(n){return null!=n&&"object"==typeof n}
/**
           * Checks if `value` is a plain object, that is, an object created by the
           * `Object` constructor or one with a `[[Prototype]]` of `null`.
           *
           * @static
           * @memberOf _
           * @since 0.8.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a plain object, else `false`.
           * @example
           *
           * function Foo() {
           *   this.a = 1;
           * }
           *
           * _.isPlainObject(new Foo);
           * // => false
           *
           * _.isPlainObject([1, 2, 3]);
           * // => false
           *
           * _.isPlainObject({ 'x': 0, 'y': 0 });
           * // => true
           *
           * _.isPlainObject(Object.create(null));
           * // => true
           */function isPlainObject(n){if(!isObjectLike(n)||baseGetTag(n)!=wt)return false;var i=Ee(n);if(null===i)return true;var z=Oe.call(i,"constructor")&&i.constructor;return"function"==typeof z&&z instanceof z&&Se.call(z)==Ce}
/**
           * Checks if `value` is classified as a typed array.
           *
           * @static
           * @memberOf _
           * @since 3.0.0
           * @category Lang
           * @param {*} value The value to check.
           * @returns {boolean} Returns `true` if `value` is a typed array, else `false`.
           * @example
           *
           * _.isTypedArray(new Uint8Array);
           * // => true
           *
           * _.isTypedArray([]);
           * // => false
           */var $e=_e?baseUnary(_e):baseIsTypedArray;
/**
           * Converts `value` to a plain object flattening inherited enumerable string
           * keyed properties of `value` to own properties of the plain object.
           *
           * @static
           * @memberOf _
           * @since 3.0.0
           * @category Lang
           * @param {*} value The value to convert.
           * @returns {Object} Returns the converted plain object.
           * @example
           *
           * function Foo() {
           *   this.b = 2;
           * }
           *
           * Foo.prototype.c = 3;
           *
           * _.assign({ 'a': 1 }, new Foo);
           * // => { 'a': 1, 'b': 2 }
           *
           * _.assign({ 'a': 1 }, _.toPlainObject(new Foo));
           * // => { 'a': 1, 'b': 2, 'c': 3 }
           */function toPlainObject(n){return copyObject(n,keysIn(n))}
/**
           * Creates an array of the own and inherited enumerable property names of `object`.
           *
           * **Note:** Non-object values are coerced to objects.
           *
           * @static
           * @memberOf _
           * @since 3.0.0
           * @category Object
           * @param {Object} object The object to query.
           * @returns {Array} Returns the array of property names.
           * @example
           *
           * function Foo() {
           *   this.a = 1;
           *   this.b = 2;
           * }
           *
           * Foo.prototype.c = 3;
           *
           * _.keysIn(new Foo);
           * // => ['a', 'b', 'c'] (iteration order is not guaranteed)
           */function keysIn(n){return isArrayLike(n)?arrayLikeKeys(n,true):baseKeysIn(n)}
/**
           * This method is like `_.assign` except that it recursively merges own and
           * inherited enumerable string keyed properties of source objects into the
           * destination object. Source properties that resolve to `undefined` are
           * skipped if a destination value exists. Array and plain object properties
           * are merged recursively. Other objects and value types are overridden by
           * assignment. Source objects are applied from left to right. Subsequent
           * sources overwrite property assignments of previous sources.
           *
           * **Note:** This method mutates `object`.
           *
           * @static
           * @memberOf _
           * @since 0.5.0
           * @category Object
           * @param {Object} object The destination object.
           * @param {...Object} [sources] The source objects.
           * @returns {Object} Returns `object`.
           * @example
           *
           * var object = {
           *   'a': [{ 'b': 2 }, { 'd': 4 }]
           * };
           *
           * var other = {
           *   'a': [{ 'c': 3 }, { 'e': 5 }]
           * };
           *
           * _.merge(object, other);
           * // => { 'a': [{ 'b': 2, 'c': 3 }, { 'd': 4, 'e': 5 }] }
           */var Je=createAssigner((function(n,i,z){baseMerge(n,i,z)}));
/**
           * Creates a function that returns `value`.
           *
           * @static
           * @memberOf _
           * @since 2.4.0
           * @category Util
           * @param {*} value The value to return from the new function.
           * @returns {Function} Returns the new constant function.
           * @example
           *
           * var objects = _.times(2, _.constant({ 'a': 1 }));
           *
           * console.log(objects);
           * // => [{ 'a': 1 }, { 'a': 1 }]
           *
           * console.log(objects[0] === objects[1]);
           * // => true
           */function constant(n){return function(){return n}}
/**
           * This method returns the first argument it receives.
           *
           * @static
           * @since 0.1.0
           * @memberOf _
           * @category Util
           * @param {*} value Any value.
           * @returns {*} Returns `value`.
           * @example
           *
           * var object = { 'a': 1 };
           *
           * console.log(_.identity(object) === object);
           * // => true
           */function identity(n){return n}
/**
           * This method returns `false`.
           *
           * @static
           * @memberOf _
           * @since 4.13.0
           * @category Util
           * @returns {boolean} Returns `false`.
           * @example
           *
           * _.times(2, _.stubFalse);
           * // => [false, false]
           */function stubFalse(){return false}z.exports=Je}).call(this||n)}).call(this||n,"undefined"!==typeof n?n:"undefined"!==typeof self?self:"undefined"!==typeof window?window:{})},{}],2:[function(z,Z,tt){!function(n,z){"object"==typeof tt&&"object"==typeof Z?Z.exports=z():"function"==typeof i&&i.amd?i("shifty",[],z):"object"==typeof tt?tt.shifty=z():n.shifty=z()}(self,(function(){return function(){var i={720:function(i,z,Z){Z.r(z),Z.d(z,{Scene:function(){return oe},Tweenable:function(){return Tt},interpolate:function(){return nn},processTweens:function(){return dt},setBezierFunction:function(){return $},shouldScheduleUpdate:function(){return bt},tween:function(){return Pt},unsetBezierFunction:function(){return L}});var tt={};Z.r(tt),Z.d(tt,{bounce:function(){return D},bouncePast:function(){return q},easeFrom:function(){return B},easeFromTo:function(){return Q},easeInBack:function(){return E},easeInCirc:function(){return j},easeInCubic:function(){return c},easeInExpo:function(){return w},easeInOutBack:function(){return T},easeInOutCirc:function(){return P},easeInOutCubic:function(){return l},easeInOutExpo:function(){return S},easeInOutQuad:function(){return s},easeInOutQuart:function(){return v},easeInOutQuint:function(){return d},easeInOutSine:function(){return b},easeInQuad:function(){return u},easeInQuart:function(){return h},easeInQuint:function(){return y},easeInSine:function(){return g},easeOutBack:function(){return A},easeOutBounce:function(){return M},easeOutCirc:function(){return k},easeOutCubic:function(){return f},easeOutExpo:function(){return O},easeOutQuad:function(){return a},easeOutQuart:function(){return p},easeOutQuint:function(){return _},easeOutSine:function(){return m},easeTo:function(){return N},elastic:function(){return I},linear:function(){return o},swingFrom:function(){return x},swingFromTo:function(){return F},swingTo:function(){return C}});var et={};Z.r(et),Z.d(et,{afterTween:function(){return Jt},beforeTween:function(){return Ht},doesApply:function(){return Wt},tweenCreated:function(){return Gt}});var o=function(n){return n},u=function(n){return Math.pow(n,2)},a=function(n){return-(Math.pow(n-1,2)-1)},s=function(n){return(n/=.5)<1?.5*Math.pow(n,2):-.5*((n-=2)*n-2)},c=function(n){return Math.pow(n,3)},f=function(n){return Math.pow(n-1,3)+1},l=function(n){return(n/=.5)<1?.5*Math.pow(n,3):.5*(Math.pow(n-2,3)+2)},h=function(n){return Math.pow(n,4)},p=function(n){return-(Math.pow(n-1,4)-1)},v=function(n){return(n/=.5)<1?.5*Math.pow(n,4):-.5*((n-=2)*Math.pow(n,3)-2)},y=function(n){return Math.pow(n,5)},_=function(n){return Math.pow(n-1,5)+1},d=function(n){return(n/=.5)<1?.5*Math.pow(n,5):.5*(Math.pow(n-2,5)+2)},g=function(n){return 1-Math.cos(n*(Math.PI/2))},m=function(n){return Math.sin(n*(Math.PI/2))},b=function(n){return-.5*(Math.cos(Math.PI*n)-1)},w=function(n){return 0===n?0:Math.pow(2,10*(n-1))},O=function(n){return 1===n?1:1-Math.pow(2,-10*n)},S=function(n){return 0===n?0:1===n?1:(n/=.5)<1?.5*Math.pow(2,10*(n-1)):.5*(2-Math.pow(2,-10*--n))},j=function(n){return-(Math.sqrt(1-n*n)-1)},k=function(n){return Math.sqrt(1-Math.pow(n-1,2))},P=function(n){return(n/=.5)<1?-.5*(Math.sqrt(1-n*n)-1):.5*(Math.sqrt(1-(n-=2)*n)+1)},M=function(n){return n<1/2.75?7.5625*n*n:n<2/2.75?7.5625*(n-=1.5/2.75)*n+.75:n<2.5/2.75?7.5625*(n-=2.25/2.75)*n+.9375:7.5625*(n-=2.625/2.75)*n+.984375},E=function(n){var i=1.70158;return n*n*((i+1)*n-i)},A=function(n){var i=1.70158;return(n-=1)*n*((i+1)*n+i)+1},T=function(n){var i=1.70158;return(n/=.5)<1?n*n*((1+(i*=1.525))*n-i)*.5:.5*((n-=2)*n*((1+(i*=1.525))*n+i)+2)},I=function(n){return-1*Math.pow(4,-8*n)*Math.sin((6*n-1)*(2*Math.PI)/2)+1},F=function(n){var i=1.70158;return(n/=.5)<1?n*n*((1+(i*=1.525))*n-i)*.5:.5*((n-=2)*n*((1+(i*=1.525))*n+i)+2)},x=function(n){var i=1.70158;return n*n*((i+1)*n-i)},C=function(n){var i=1.70158;return(n-=1)*n*((i+1)*n+i)+1},D=function(n){return n<1/2.75?7.5625*n*n:n<2/2.75?7.5625*(n-=1.5/2.75)*n+.75:n<2.5/2.75?7.5625*(n-=2.25/2.75)*n+.9375:7.5625*(n-=2.625/2.75)*n+.984375},q=function(n){return n<1/2.75?7.5625*n*n:n<2/2.75?2-(7.5625*(n-=1.5/2.75)*n+.75):n<2.5/2.75?2-(7.5625*(n-=2.25/2.75)*n+.9375):2-(7.5625*(n-=2.625/2.75)*n+.984375)},Q=function(n){return(n/=.5)<1?.5*Math.pow(n,4):-.5*((n-=2)*Math.pow(n,3)-2)},B=function(n){return Math.pow(n,4)},N=function(n){return Math.pow(n,.25)};function R(n,i,z,Z,tt,et){var rt,nt,it,at,ot,st=0,ut=0,ct=0,v=function(n){return((st*n+ut)*n+ct)*n},y=function(n){return(3*st*n+2*ut)*n+ct},_=function(n){return n>=0?n:0-n};return st=1-(ct=3*i)-(ut=3*(Z-i)-ct),it=1-(ot=3*z)-(at=3*(tt-z)-ot),rt=n,nt=function(n){return 1/(200*n)}(et),function(n){return((it*n+at)*n+ot)*n}(function(n,i){var z,Z,tt,et,rt,nt;for(tt=n,nt=0;nt<8;nt++){if(et=v(tt)-n,_(et)<i)return tt;if(rt=y(tt),_(rt)<1e-6)break;tt-=et/rt}if((tt=n)<(z=0))return z;if(tt>(Z=1))return Z;for(;z<Z;){if(et=v(tt),_(et-n)<i)return tt;n>et?z=tt:Z=tt,tt=.5*(Z-z)+z}return tt}(rt,nt))}var rt,U=function(){var n=arguments.length>0&&void 0!==arguments[0]?arguments[0]:.25,i=arguments.length>1&&void 0!==arguments[1]?arguments[1]:.25,z=arguments.length>2&&void 0!==arguments[2]?arguments[2]:.75,Z=arguments.length>3&&void 0!==arguments[3]?arguments[3]:.75;return function(tt){return R(tt,n,i,z,Z,1)}},$=function(n,i,z,Z,tt){var et=U(i,z,Z,tt);return et.displayName=n,et.x1=i,et.y1=z,et.x2=Z,et.y2=tt,Tt.formulas[n]=et},L=function(n){return delete Tt.formulas[n]};function V(n,i){if(!(n instanceof i))throw new TypeError("Cannot call a class as a function")}function W(n,i){for(var z=0;z<i.length;z++){var Z=i[z];Z.enumerable=Z.enumerable||!1,Z.configurable=!0,"value"in Z&&(Z.writable=!0),Object.defineProperty(n,Z.key,Z)}}function G(n){return G="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(n){return typeof n}:function(n){return n&&"function"==typeof Symbol&&n.constructor===Symbol&&n!==Symbol.prototype?"symbol":typeof n},G(n)}function H(n){return function(n){if(Array.isArray(n))return J(n)}(n)||function(n){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(n))return Array.from(n)}(n)||function(n,i){if(n){if("string"==typeof n)return J(n,i);var z=Object.prototype.toString.call(n).slice(8,-1);return"Object"===z&&n.constructor&&(z=n.constructor.name),"Map"===z||"Set"===z?Array.from(n):"Arguments"===z||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(z)?J(n,i):void 0}}(n)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}()}function J(n,i){(null==i||i>n.length)&&(i=n.length);for(var z=0,Z=new Array(i);z<i;z++)Z[z]=n[z];return Z}function K(n,i){var z=Object.keys(n);if(Object.getOwnPropertySymbols){var Z=Object.getOwnPropertySymbols(n);i&&(Z=Z.filter((function(i){return Object.getOwnPropertyDescriptor(n,i).enumerable}))),z.push.apply(z,Z)}return z}function X(n){for(var i=1;i<arguments.length;i++){var z=null!=arguments[i]?arguments[i]:{};i%2?K(Object(z),!0).forEach((function(i){Y(n,i,z[i])})):Object.getOwnPropertyDescriptors?Object.defineProperties(n,Object.getOwnPropertyDescriptors(z)):K(Object(z)).forEach((function(i){Object.defineProperty(n,i,Object.getOwnPropertyDescriptor(z,i))}))}return n}function Y(n,i,z){return i in n?Object.defineProperty(n,i,{value:z,enumerable:!0,configurable:!0,writable:!0}):n[i]=z,n}var nt,it,at,ot="linear",st="undefined"!=typeof window?window:Z.g,ut="afterTween",ct="afterTweenEnd",ht="beforeTween",ft="tweenCreated",pt="function",vt="string",gt=st.requestAnimationFrame||st.webkitRequestAnimationFrame||st.oRequestAnimationFrame||st.msRequestAnimationFrame||st.mozCancelRequestAnimationFrame&&st.mozRequestAnimationFrame||setTimeout,lt=function(){},mt=null,wt=null,jt=X({},tt),yt=function(n,i,z,Z,tt,et,rt){var nt,it,at,ot=n<et?0:(n-et)/tt,st=!1;for(var ut in rt&&rt.call&&(st=!0,nt=rt(ot)),i)st||(nt=((it=rt[ut]).call?it:jt[it])(ot)),at=z[ut],i[ut]=at+(Z[ut]-at)*nt;return i},_t=function(n,i){var z=n._timestamp,Z=n._currentState,tt=n._delay;if(!(i<z+tt)){var et=n._duration,rt=n._targetState,nt=z+tt+et,it=i>nt?nt:i;n._hasEnded=it>=nt;var at=et-(nt-it),ot=n._filters.length>0;if(n._hasEnded)return n._render(rt,n._data,at),n.stop(!0);ot&&n._applyFilter(ht),it<z+tt?z=et=it=1:z+=tt,yt(it,Z,n._originalState,rt,et,z,n._easing),ot&&n._applyFilter(ut),n._render(Z,n._data,at)}},dt=function(){for(var n,i=Tt.now(),z=mt;z;)n=z._next,_t(z,i),z=n},kt=Date.now||function(){return+new Date},Ct=!1,bt=function(n){n&&Ct||(Ct=n,n&&At())},At=function t(){nt=kt(),Ct&&gt.call(st,t,16.666666666666668),dt()},Ot=function(n){var i=arguments.length>1&&void 0!==arguments[1]?arguments[1]:ot,z=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};if(Array.isArray(i)){var Z=U.apply(void 0,H(i));return Z}var tt=G(i);if(jt[i])return jt[i];if(tt===vt||tt===pt)for(var et in n)z[et]=i;else for(var rt in n)z[rt]=i[rt]||ot;return z},St=function(n){n===mt?(mt=n._next)?mt._previous=null:wt=null:n===wt?(wt=n._previous)?wt._next=null:mt=null:(it=n._previous,at=n._next,it._next=at,at._previous=it),n._previous=n._next=null},xt="function"==typeof Promise?Promise:null;rt=Symbol.toStringTag;var Tt=function(){function t(){var i=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},z=arguments.length>1&&void 0!==arguments[1]?arguments[1]:void 0;V(this||n,t),Y(this||n,rt,"Promise"),(this||n)._config={},(this||n)._data={},(this||n)._delay=0,(this||n)._filters=[],(this||n)._next=null,(this||n)._previous=null,(this||n)._timestamp=null,(this||n)._hasEnded=!1,(this||n)._resolve=null,(this||n)._reject=null,(this||n)._currentState=i||{},(this||n)._originalState={},(this||n)._targetState={},(this||n)._start=lt,(this||n)._render=lt,(this||n)._promiseCtor=xt,z&&this.setConfig(z)}var i,z;return i=t,z=[{key:"_applyFilter",value:function(i){for(var z=(this||n)._filters.length;z>0;z--){var Z=(this||n)._filters[z-z][i];Z&&Z(this||n)}}},{key:"tween",value:function(){var i=arguments.length>0&&void 0!==arguments[0]?arguments[0]:void 0;return(this||n)._isPlaying&&this.stop(),!i&&(this||n)._config||this.setConfig(i),(this||n)._pausedAtTime=null,(this||n)._timestamp=t.now(),this._start(this.get(),(this||n)._data),(this||n)._delay&&this._render((this||n)._currentState,(this||n)._data,0),this._resume((this||n)._timestamp)}},{key:"setConfig",value:function(){var i=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},z=(this||n)._config;for(var Z in i)z[Z]=i[Z];var tt=z.promise,et=void 0===tt?(this||n)._promiseCtor:tt,rt=z.start,nt=void 0===rt?lt:rt,it=z.finish,at=z.render,ot=void 0===at?(this||n)._config.step||lt:at,st=z.step,ut=void 0===st?lt:st;(this||n)._data=z.data||z.attachment||(this||n)._data,(this||n)._isPlaying=!1,(this||n)._pausedAtTime=null,(this||n)._scheduleId=null,(this||n)._delay=i.delay||0,(this||n)._start=nt,(this||n)._render=ot||ut,(this||n)._duration=z.duration||500,(this||n)._promiseCtor=et,it&&((this||n)._resolve=it);var ct=i.from,ht=i.to,pt=void 0===ht?{}:ht,gt=(this||n)._currentState,mt=(this||n)._originalState,wt=(this||n)._targetState;for(var jt in ct)gt[jt]=ct[jt];var kt=!1;for(var Ct in gt){var At=gt[Ct];kt||G(At)!==vt||(kt=!0),mt[Ct]=At,wt[Ct]=pt.hasOwnProperty(Ct)?pt[Ct]:At}if((this||n)._easing=Ot((this||n)._currentState,z.easing,(this||n)._easing),(this||n)._filters.length=0,kt){for(var xt in t.filters)t.filters[xt].doesApply(this||n)&&(this||n)._filters.push(t.filters[xt]);this._applyFilter(ft)}return this||n}},{key:"then",value:function(i,z){var Z=this||n;return(this||n)._promise=new(this||n)._promiseCtor((function(n,i){Z._resolve=n,Z._reject=i})),(this||n)._promise.then(i,z)}},{key:"catch",value:function(n){return this.then().catch(n)}},{key:"finally",value:function(n){return this.then().finally(n)}},{key:"get",value:function(){return X({},(this||n)._currentState)}},{key:"set",value:function(i){(this||n)._currentState=i}},{key:"pause",value:function(){if((this||n)._isPlaying)return(this||n)._pausedAtTime=t.now(),(this||n)._isPlaying=!1,St(this||n),this||n}},{key:"resume",value:function(){return this._resume()}},{key:"_resume",value:function(){var i=arguments.length>0&&void 0!==arguments[0]?arguments[0]:t.now();return null===(this||n)._timestamp?this.tween():(this||n)._isPlaying?(this||n)._promise:((this||n)._pausedAtTime&&((this||n)._timestamp+=i-(this||n)._pausedAtTime,(this||n)._pausedAtTime=null),(this||n)._isPlaying=!0,null===mt?(mt=this||n,wt=this||n):((this||n)._previous=wt,wt._next=this||n,wt=this||n),this||n)}},{key:"seek",value:function(i){i=Math.max(i,0);var z=t.now();return(this||n)._timestamp+i===0||((this||n)._timestamp=z-i,_t(this||n,z)),this||n}},{key:"stop",value:function(){var i=arguments.length>0&&void 0!==arguments[0]&&arguments[0];if(!(this||n)._isPlaying)return this||n;(this||n)._isPlaying=!1,St(this||n);var z=(this||n)._filters.length>0;return i&&(z&&this._applyFilter(ht),yt(1,(this||n)._currentState,(this||n)._originalState,(this||n)._targetState,1,0,(this||n)._easing),z&&(this._applyFilter(ut),this._applyFilter(ct))),(this||n)._resolve&&this._resolve({data:(this||n)._data,state:(this||n)._currentState,tweenable:this||n}),(this||n)._resolve=null,(this||n)._reject=null,this||n}},{key:"cancel",value:function(){var i=arguments.length>0&&void 0!==arguments[0]&&arguments[0],z=(this||n)._currentState,Z=(this||n)._data,tt=(this||n)._isPlaying;return tt?((this||n)._reject&&this._reject({data:Z,state:z,tweenable:this||n}),(this||n)._resolve=null,(this||n)._reject=null,this.stop(i)):this||n}},{key:"isPlaying",value:function(){return(this||n)._isPlaying}},{key:"hasEnded",value:function(){return(this||n)._hasEnded}},{key:"setScheduleFunction",value:function(n){t.setScheduleFunction(n)}},{key:"data",value:function(){var i=arguments.length>0&&void 0!==arguments[0]?arguments[0]:null;return i&&((this||n)._data=X({},i)),(this||n)._data}},{key:"dispose",value:function(){for(var i in this||n)delete(this||n)[i]}}],z&&W(i.prototype,z),t}();function Pt(){var n=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{},i=new Tt;return i.tween(n),i.tweenable=i,i}Y(Tt,"now",(function(){return nt})),Y(Tt,"setScheduleFunction",(function(n){return gt=n})),Y(Tt,"filters",{}),Y(Tt,"formulas",jt),bt(!0);var Mt,Et,It=/(\d|-|\.)/,Ft=/([^\-0-9.]+)/g,Dt=/[0-9.-]+/g,Zt=(Mt=Dt.source,Et=/,\s*/.source,new RegExp("rgba?\\(".concat(Mt).concat(Et).concat(Mt).concat(Et).concat(Mt,"(").concat(Et).concat(Mt,")?\\)"),"g")),te=/^.*\(/,ee=/#([0-9]|[a-f]){3,6}/gi,re="VAL",qt=function(n,i){return n.map((function(n,z){return"_".concat(i,"_").concat(z)}))};function Qt(n){return parseInt(n,16)}var Bt=function(n){return"rgb(".concat((i=n,3===(i=i.replace(/#/,"")).length&&(i=(i=i.split(""))[0]+i[0]+i[1]+i[1]+i[2]+i[2]),[Qt(i.substr(0,2)),Qt(i.substr(2,2)),Qt(i.substr(4,2))]).join(","),")");var i},Nt=function(n,i,z){var Z=i.match(n),tt=i.replace(n,re);return Z&&Z.forEach((function(n){return tt=tt.replace(re,z(n))})),tt},Rt=function(n){for(var i in n){var z=n[i];"string"==typeof z&&z.match(ee)&&(n[i]=Nt(ee,z,Bt))}},zt=function(n){var i=n.match(Dt),z=i.slice(0,3).map(Math.floor),Z=n.match(te)[0];if(3===i.length)return"".concat(Z).concat(z.join(","),")");if(4===i.length)return"".concat(Z).concat(z.join(","),",").concat(i[3],")");throw new Error("Invalid rgbChunk: ".concat(n))},Ut=function(n){return n.match(Dt)},$t=function(n,i){var z={};return i.forEach((function(i){z[i]=n[i],delete n[i]})),z},Lt=function(n,i){return i.map((function(i){return n[i]}))},Vt=function(n,i){return i.forEach((function(i){return n=n.replace(re,+i.toFixed(4))})),n},Wt=function(n){for(var i in n._currentState)if("string"==typeof n._currentState[i])return!0;return!1};function Gt(n){var i=n._currentState;[i,n._originalState,n._targetState].forEach(Rt),n._tokenData=function(n){var i,z,Z={};for(var tt in n){var et=n[tt];"string"==typeof et&&(Z[tt]={formatString:(i=et,z=void 0,z=i.match(Ft),z?(1===z.length||i.charAt(0).match(It))&&z.unshift(""):z=["",""],z.join(re)),chunkNames:qt(Ut(et),tt)})}return Z}(i)}function Ht(n){var i=n._currentState,z=n._originalState,Z=n._targetState,tt=n._easing,et=n._tokenData;!function(n,i){var e=function(z){var Z=i[z].chunkNames,tt=n[z];if("string"==typeof tt){var et=tt.split(" "),rt=et[et.length-1];Z.forEach((function(i,z){return n[i]=et[z]||rt}))}else Z.forEach((function(i){return n[i]=tt}));delete n[z]};for(var z in i)e(z)}(tt,et),[i,z,Z].forEach((function(n){return function(n,i){var e=function(z){Ut(n[z]).forEach((function(Z,tt){return n[i[z].chunkNames[tt]]=+Z})),delete n[z]};for(var z in i)e(z)}(n,et)}))}function Jt(n){var i=n._currentState,z=n._originalState,Z=n._targetState,tt=n._easing,et=n._tokenData;[i,z,Z].forEach((function(n){return function(n,i){for(var z in i){var Z=i[z],tt=Z.chunkNames,et=Z.formatString,rt=Vt(et,Lt($t(n,tt),tt));n[z]=Nt(Zt,rt,zt)}}(n,et)})),function(n,i){for(var z in i){var Z=i[z].chunkNames,tt=n[Z[0]];n[z]="string"==typeof tt?Z.map((function(i){var z=n[i];return delete n[i],z})).join(" "):tt}}(tt,et)}function Kt(n,i){var z=Object.keys(n);if(Object.getOwnPropertySymbols){var Z=Object.getOwnPropertySymbols(n);i&&(Z=Z.filter((function(i){return Object.getOwnPropertyDescriptor(n,i).enumerable}))),z.push.apply(z,Z)}return z}function Xt(n){for(var i=1;i<arguments.length;i++){var z=null!=arguments[i]?arguments[i]:{};i%2?Kt(Object(z),!0).forEach((function(i){Yt(n,i,z[i])})):Object.getOwnPropertyDescriptors?Object.defineProperties(n,Object.getOwnPropertyDescriptors(z)):Kt(Object(z)).forEach((function(i){Object.defineProperty(n,i,Object.getOwnPropertyDescriptor(z,i))}))}return n}function Yt(n,i,z){return i in n?Object.defineProperty(n,i,{value:z,enumerable:!0,configurable:!0,writable:!0}):n[i]=z,n}var ne=new Tt,ie=Tt.filters,nn=function(n,i,z,Z){var tt=arguments.length>4&&void 0!==arguments[4]?arguments[4]:0,et=Xt({},n),rt=Ot(n,Z);for(var nt in ne._filters.length=0,ne.set({}),ne._currentState=et,ne._originalState=n,ne._targetState=i,ne._easing=rt,ie)ie[nt].doesApply(ne)&&ne._filters.push(ie[nt]);ne._applyFilter("tweenCreated"),ne._applyFilter("beforeTween");var it=yt(z,et,n,i,1,tt,rt);return ne._applyFilter("afterTween"),it};function en(n,i){(null==i||i>n.length)&&(i=n.length);for(var z=0,Z=new Array(i);z<i;z++)Z[z]=n[z];return Z}function rn(n,i){if(!(n instanceof i))throw new TypeError("Cannot call a class as a function")}function on(n,i){for(var z=0;z<i.length;z++){var Z=i[z];Z.enumerable=Z.enumerable||!1,Z.configurable=!0,"value"in Z&&(Z.writable=!0),Object.defineProperty(n,Z.key,Z)}}function un(n,i){var z=i.get(n);if(!z)throw new TypeError("attempted to get private field on non-instance");return z.get?z.get.call(n):z.value}var ae=new WeakMap,oe=function(){function t(){rn(this||n,t),ae.set(this||n,{writable:!0,value:[]});for(var i=arguments.length,z=new Array(i),Z=0;Z<i;Z++)z[Z]=arguments[Z];z.forEach((this||n).add.bind(this||n))}var i,z;return i=t,(z=[{key:"add",value:function(i){return un(this||n,ae).push(i),i}},{key:"remove",value:function(i){var z=un(this||n,ae).indexOf(i);return~z&&un(this||n,ae).splice(z,1),i}},{key:"empty",value:function(){return(this||n).tweenables.map((this||n).remove.bind(this||n))}},{key:"isPlaying",value:function(){return un(this||n,ae).some((function(n){return n.isPlaying()}))}},{key:"play",value:function(){return un(this||n,ae).forEach((function(n){return n.tween()})),this||n}},{key:"pause",value:function(){return un(this||n,ae).forEach((function(n){return n.pause()})),this||n}},{key:"resume",value:function(){return(this||n).playingTweenables.forEach((function(n){return n.resume()})),this||n}},{key:"stop",value:function(i){return un(this||n,ae).forEach((function(n){return n.stop(i)})),this||n}},{key:"tweenables",get:function(){return function(n){if(Array.isArray(n))return en(n)}(i=un(this||n,ae))||function(n){if("undefined"!=typeof Symbol&&Symbol.iterator in Object(n))return Array.from(n)}(i)||function(n,i){if(n){if("string"==typeof n)return en(n,i);var z=Object.prototype.toString.call(n).slice(8,-1);return"Object"===z&&n.constructor&&(z=n.constructor.name),"Map"===z||"Set"===z?Array.from(n):"Arguments"===z||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(z)?en(n,i):void 0}}(i)||function(){throw new TypeError("Invalid attempt to spread non-iterable instance.\nIn order to be iterable, non-array objects must have a [Symbol.iterator]() method.")}();var i}},{key:"playingTweenables",get:function(){return un(this||n,ae).filter((function(n){return!n.hasEnded()}))}},{key:"promises",get:function(){return un(this||n,ae).map((function(n){return n.then()}))}}])&&on(i.prototype,z),t}();Tt.filters.token=et}},z={};function e(n){if(z[n])return z[n].exports;var Z=z[n]={exports:{}};return i[n](Z,Z.exports,e),Z.exports}return e.d=function(n,i){for(var z in i)e.o(i,z)&&!e.o(n,z)&&Object.defineProperty(n,z,{enumerable:!0,get:i[z]})},e.g=function(){if("object"==typeof globalThis)return globalThis;try{return this||n||new Function("return this")()}catch(n){if("object"==typeof window)return window}}(),e.o=function(n,i){return Object.prototype.hasOwnProperty.call(n,i)},e.r=function(n){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(n,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(n,"__esModule",{value:!0})},e(720)}()}))},{}],3:[function(i,z,Z){var tt=i("./shape");var et=i("./utils");var rt=function Circle(i,z){(this||n)._pathTemplate="M 50,50 m 0,-{radius} a {radius},{radius} 0 1 1 0,{2radius} a {radius},{radius} 0 1 1 0,-{2radius}";(this||n).containerAspectRatio=1;tt.apply(this||n,arguments)};rt.prototype=new tt;rt.prototype.constructor=rt;rt.prototype._pathString=function _pathString(i){var z=i.strokeWidth;i.trailWidth&&i.trailWidth>i.strokeWidth&&(z=i.trailWidth);var Z=50-z/2;return et.render((this||n)._pathTemplate,{radius:Z,"2radius":2*Z})};rt.prototype._trailString=function _trailString(n){return this._pathString(n)};z.exports=rt},{"./shape":8,"./utils":10}],4:[function(i,z,Z){var tt=i("./shape");var et=i("./utils");var rt=function Line(i,z){(this||n)._pathTemplate=z.vertical?"M {center},100 L {center},0":"M 0,{center} L 100,{center}";tt.apply(this||n,arguments)};rt.prototype=new tt;rt.prototype.constructor=rt;rt.prototype._initializeSvg=function _initializeSvg(n,i){var z=i.vertical?"0 0 "+i.strokeWidth+" 100":"0 0 100 "+i.strokeWidth;n.setAttribute("viewBox",z);n.setAttribute("preserveAspectRatio","none")};rt.prototype._pathString=function _pathString(i){return et.render((this||n)._pathTemplate,{center:i.strokeWidth/2})};rt.prototype._trailString=function _trailString(n){return this._pathString(n)};z.exports=rt},{"./shape":8,"./utils":10}],5:[function(n,i,z){i.exports={Line:n("./line"),Circle:n("./circle"),SemiCircle:n("./semicircle"),Square:n("./square"),Path:n("./path"),Shape:n("./shape"),utils:n("./utils")}},{"./circle":3,"./line":4,"./path":6,"./semicircle":7,"./shape":8,"./square":9,"./utils":10}],6:[function(i,z,Z){var tt=i("shifty");var et=i("./utils");var rt=tt.Tweenable;var nt={easeIn:"easeInCubic",easeOut:"easeOutCubic",easeInOut:"easeInOutCubic"};var it=function Path(i,z){if(!((this||n)instanceof Path))throw new Error("Constructor was called without new keyword");z=et.extend({delay:0,duration:800,easing:"linear",from:{},to:{},step:function(){}},z);var Z;Z=et.isString(i)?document.querySelector(i):i;(this||n).path=Z;(this||n)._opts=z;(this||n)._tweenable=null;var tt=(this||n).path.getTotalLength();(this||n).path.style.strokeDasharray=tt+" "+tt;this.set(0)};it.prototype.value=function value(){var i=this._getComputedDashOffset();var z=(this||n).path.getTotalLength();var Z=1-i/z;return parseFloat(Z.toFixed(6),10)};it.prototype.set=function set(i){this.stop();(this||n).path.style.strokeDashoffset=this._progressToOffset(i);var z=(this||n)._opts.step;if(et.isFunction(z)){var Z=this._easing((this||n)._opts.easing);var tt=this._calculateTo(i,Z);var rt=(this||n)._opts.shape||this||n;z(tt,rt,(this||n)._opts.attachment)}};it.prototype.stop=function stop(){this._stopTween();(this||n).path.style.strokeDashoffset=this._getComputedDashOffset()};it.prototype.animate=function animate(i,z,Z){z=z||{};if(et.isFunction(z)){Z=z;z={}}var tt=et.extend({},z);var nt=et.extend({},(this||n)._opts);z=et.extend(nt,z);var it=this._easing(z.easing);var at=this._resolveFromAndTo(i,it,tt);this.stop();(this||n).path.getBoundingClientRect();var ot=this._getComputedDashOffset();var st=this._progressToOffset(i);var ut=this||n;(this||n)._tweenable=new rt;(this||n)._tweenable.tween({from:et.extend({offset:ot},at.from),to:et.extend({offset:st},at.to),duration:z.duration,delay:z.delay,easing:it,step:function(n){ut.path.style.strokeDashoffset=n.offset;var i=z.shape||ut;z.step(n,i,z.attachment)}}).then((function(n){et.isFunction(Z)&&Z()})).catch((function(n){console.error("Error in tweening:",n);throw n}))};it.prototype._getComputedDashOffset=function _getComputedDashOffset(){var i=window.getComputedStyle((this||n).path,null);return parseFloat(i.getPropertyValue("stroke-dashoffset"),10)};it.prototype._progressToOffset=function _progressToOffset(i){var z=(this||n).path.getTotalLength();return z-i*z};it.prototype._resolveFromAndTo=function _resolveFromAndTo(n,i,z){return z.from&&z.to?{from:z.from,to:z.to}:{from:this._calculateFrom(i),to:this._calculateTo(n,i)}};it.prototype._calculateFrom=function _calculateFrom(i){return tt.interpolate((this||n)._opts.from,(this||n)._opts.to,this.value(),i)};it.prototype._calculateTo=function _calculateTo(i,z){return tt.interpolate((this||n)._opts.from,(this||n)._opts.to,i,z)};it.prototype._stopTween=function _stopTween(){if(null!==(this||n)._tweenable){(this||n)._tweenable.stop(true);(this||n)._tweenable=null}};it.prototype._easing=function _easing(n){return nt.hasOwnProperty(n)?nt[n]:n};z.exports=it},{"./utils":10,shifty:2}],7:[function(i,z,Z){var tt=i("./shape");var et=i("./circle");var rt=i("./utils");var nt=function SemiCircle(i,z){(this||n)._pathTemplate="M 50,50 m -{radius},0 a {radius},{radius} 0 1 1 {2radius},0";(this||n).containerAspectRatio=2;tt.apply(this||n,arguments)};nt.prototype=new tt;nt.prototype.constructor=nt;nt.prototype._initializeSvg=function _initializeSvg(n,i){n.setAttribute("viewBox","0 0 100 50")};nt.prototype._initializeTextContainer=function _initializeTextContainer(n,i,z){if(n.text.style){z.style.top="auto";z.style.bottom="0";n.text.alignToBottom?rt.setStyle(z,"transform","translate(-50%, 0)"):rt.setStyle(z,"transform","translate(-50%, 50%)")}};nt.prototype._pathString=et.prototype._pathString;nt.prototype._trailString=et.prototype._trailString;z.exports=nt},{"./circle":3,"./shape":8,"./utils":10}],8:[function(i,z,Z){var tt=i("./path");var et=i("./utils");var rt="Object is destroyed";var nt=function Shape(i,z){if(!((this||n)instanceof Shape))throw new Error("Constructor was called without new keyword");if(0!==arguments.length){(this||n)._opts=et.extend({color:"#555",strokeWidth:1,trailColor:null,trailWidth:null,fill:null,text:{style:{color:null,position:"absolute",left:"50%",top:"50%",padding:0,margin:0,transform:{prefix:true,value:"translate(-50%, -50%)"}},autoStyleContainer:true,alignToBottom:true,value:null,className:"progressbar-text"},svgStyle:{display:"block",width:"100%"},warnings:false},z,true);et.isObject(z)&&void 0!==z.svgStyle&&((this||n)._opts.svgStyle=z.svgStyle);et.isObject(z)&&et.isObject(z.text)&&void 0!==z.text.style&&((this||n)._opts.text.style=z.text.style);var Z=this._createSvgView((this||n)._opts);var rt;rt=et.isString(i)?document.querySelector(i):i;if(!rt)throw new Error("Container does not exist: "+i);(this||n)._container=rt;(this||n)._container.appendChild(Z.svg);(this||n)._opts.warnings&&this._warnContainerAspectRatio((this||n)._container);(this||n)._opts.svgStyle&&et.setStyles(Z.svg,(this||n)._opts.svgStyle);(this||n).svg=Z.svg;(this||n).path=Z.path;(this||n).trail=Z.trail;(this||n).text=null;var nt=et.extend({attachment:void 0,shape:this||n},(this||n)._opts);(this||n)._progressPath=new tt(Z.path,nt);et.isObject((this||n)._opts.text)&&null!==(this||n)._opts.text.value&&this.setText((this||n)._opts.text.value)}};nt.prototype.animate=function animate(i,z,Z){if(null===(this||n)._progressPath)throw new Error(rt);(this||n)._progressPath.animate(i,z,Z)};nt.prototype.stop=function stop(){if(null===(this||n)._progressPath)throw new Error(rt);void 0!==(this||n)._progressPath&&(this||n)._progressPath.stop()};nt.prototype.pause=function pause(){if(null===(this||n)._progressPath)throw new Error(rt);void 0!==(this||n)._progressPath&&(this||n)._progressPath._tweenable&&(this||n)._progressPath._tweenable.pause()};nt.prototype.resume=function resume(){if(null===(this||n)._progressPath)throw new Error(rt);void 0!==(this||n)._progressPath&&(this||n)._progressPath._tweenable&&(this||n)._progressPath._tweenable.resume()};nt.prototype.destroy=function destroy(){if(null===(this||n)._progressPath)throw new Error(rt);this.stop();(this||n).svg.parentNode.removeChild((this||n).svg);(this||n).svg=null;(this||n).path=null;(this||n).trail=null;(this||n)._progressPath=null;if(null!==(this||n).text){(this||n).text.parentNode.removeChild((this||n).text);(this||n).text=null}};nt.prototype.set=function set(i){if(null===(this||n)._progressPath)throw new Error(rt);(this||n)._progressPath.set(i)};nt.prototype.value=function value(){if(null===(this||n)._progressPath)throw new Error(rt);return void 0===(this||n)._progressPath?0:(this||n)._progressPath.value()};nt.prototype.setText=function setText(i){if(null===(this||n)._progressPath)throw new Error(rt);if(null===(this||n).text){(this||n).text=this._createTextContainer((this||n)._opts,(this||n)._container);(this||n)._container.appendChild((this||n).text)}if(et.isObject(i)){et.removeChildren((this||n).text);(this||n).text.appendChild(i)}else(this||n).text.innerHTML=i};nt.prototype._createSvgView=function _createSvgView(n){var i=document.createElementNS("http://www.w3.org/2000/svg","svg");this._initializeSvg(i,n);var z=null;if(n.trailColor||n.trailWidth){z=this._createTrail(n);i.appendChild(z)}var Z=this._createPath(n);i.appendChild(Z);return{svg:i,path:Z,trail:z}};nt.prototype._initializeSvg=function _initializeSvg(n,i){n.setAttribute("viewBox","0 0 100 100")};nt.prototype._createPath=function _createPath(n){var i=this._pathString(n);return this._createPathElement(i,n)};nt.prototype._createTrail=function _createTrail(n){var i=this._trailString(n);var z=et.extend({},n);z.trailColor||(z.trailColor="#eee");z.trailWidth||(z.trailWidth=z.strokeWidth);z.color=z.trailColor;z.strokeWidth=z.trailWidth;z.fill=null;return this._createPathElement(i,z)};nt.prototype._createPathElement=function _createPathElement(n,i){var z=document.createElementNS("http://www.w3.org/2000/svg","path");z.setAttribute("d",n);z.setAttribute("stroke",i.color);z.setAttribute("stroke-width",i.strokeWidth);i.fill?z.setAttribute("fill",i.fill):z.setAttribute("fill-opacity","0");return z};nt.prototype._createTextContainer=function _createTextContainer(n,i){var z=document.createElement("div");z.className=n.text.className;var Z=n.text.style;if(Z){n.text.autoStyleContainer&&(i.style.position="relative");et.setStyles(z,Z);Z.color||(z.style.color=n.color)}this._initializeTextContainer(n,i,z);return z};nt.prototype._initializeTextContainer=function(n,i,z){};nt.prototype._pathString=function _pathString(n){throw new Error("Override this function for each progress bar")};nt.prototype._trailString=function _trailString(n){throw new Error("Override this function for each progress bar")};nt.prototype._warnContainerAspectRatio=function _warnContainerAspectRatio(i){if((this||n).containerAspectRatio){var z=window.getComputedStyle(i,null);var Z=parseFloat(z.getPropertyValue("width"),10);var tt=parseFloat(z.getPropertyValue("height"),10);if(!et.floatEquals((this||n).containerAspectRatio,Z/tt)){console.warn("Incorrect aspect ratio of container","#"+i.id,"detected:",z.getPropertyValue("width")+"(width)","/",z.getPropertyValue("height")+"(height)","=",Z/tt);console.warn("Aspect ratio of should be",(this||n).containerAspectRatio)}}};z.exports=nt},{"./path":6,"./utils":10}],9:[function(i,z,Z){var tt=i("./shape");var et=i("./utils");var rt=function Square(i,z){(this||n)._pathTemplate="M 0,{halfOfStrokeWidth} L {width},{halfOfStrokeWidth} L {width},{width} L {halfOfStrokeWidth},{width} L {halfOfStrokeWidth},{strokeWidth}";(this||n)._trailTemplate="M {startMargin},{halfOfStrokeWidth} L {width},{halfOfStrokeWidth} L {width},{width} L {halfOfStrokeWidth},{width} L {halfOfStrokeWidth},{halfOfStrokeWidth}";tt.apply(this||n,arguments)};rt.prototype=new tt;rt.prototype.constructor=rt;rt.prototype._pathString=function _pathString(i){var z=100-i.strokeWidth/2;return et.render((this||n)._pathTemplate,{width:z,strokeWidth:i.strokeWidth,halfOfStrokeWidth:i.strokeWidth/2})};rt.prototype._trailString=function _trailString(i){var z=100-i.strokeWidth/2;return et.render((this||n)._trailTemplate,{width:z,strokeWidth:i.strokeWidth,halfOfStrokeWidth:i.strokeWidth/2,startMargin:i.strokeWidth/2-i.trailWidth/2})};z.exports=rt},{"./shape":8,"./utils":10}],10:[function(n,i,z){var Z=n("lodash.merge");var tt="Webkit Moz O ms".split(" ");var et=.001;function render(n,i){var z=n;for(var Z in i)if(i.hasOwnProperty(Z)){var tt=i[Z];var et="\\{"+Z+"\\}";var rt=new RegExp(et,"g");z=z.replace(rt,tt)}return z}function setStyle(n,i,z){var Z=n.style;for(var et=0;et<tt.length;++et){var rt=tt[et];Z[rt+capitalize(i)]=z}Z[i]=z}function setStyles(n,i){forEachObject(i,(function(i,z){null!==i&&void 0!==i&&(isObject(i)&&true===i.prefix?setStyle(n,z,i.value):n.style[z]=i)}))}function capitalize(n){return n.charAt(0).toUpperCase()+n.slice(1)}function isString(n){return"string"===typeof n||n instanceof String}function isFunction(n){return"function"===typeof n}function isArray(n){return"[object Array]"===Object.prototype.toString.call(n)}function isObject(n){if(isArray(n))return false;var i=typeof n;return"object"===i&&!!n}function forEachObject(n,i){for(var z in n)if(n.hasOwnProperty(z)){var Z=n[z];i(Z,z)}}function floatEquals(n,i){return Math.abs(n-i)<et}function removeChildren(n){while(n.firstChild)n.removeChild(n.firstChild)}i.exports={extend:Z,render:render,setStyle:setStyle,setStyles:setStyles,capitalize:capitalize,isString:isString,isFunction:isFunction,isObject:isObject,forEachObject:forEachObject,floatEquals:floatEquals,removeChildren:removeChildren}},{"lodash.merge":1}]},{},[5])(5)}));var z=i;const Z=i.shifty,tt=i.Line,et=i.extend,rt=i.render,nt=i.setStyle,it=i.setStyles,at=i.capitalize,ot=i.isString,st=i.isFunction,ut=i.isObject,ct=i.forEachObject,ht=i.floatEquals,ft=i.removeChildren;export{tt as Line,at as capitalize,z as default,et as extend,ht as floatEquals,ct as forEachObject,st as isFunction,ut as isObject,ot as isString,ft as removeChildren,rt as render,nt as setStyle,it as setStyles,Z as shifty};

