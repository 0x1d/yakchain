// THIS FILE IS GENERATED AUTOMATICALLY. DO NOT MODIFY.

import _0X1DYakchain0X1DYakchainYakchain from './0x1d/yakchain/_0x1d.yakchain.yakchain'


export default { 
  _0X1DYakchain0X1DYakchainYakchain: load(_0X1DYakchain0X1DYakchainYakchain, '_0x1d.yakchain.yakchain'),
  
}


function load(mod, fullns) {
    return function init(store) {        
        if (store.hasModule([fullns])) {
            throw new Error('Duplicate module name detected: '+ fullns)
        }else{
            store.registerModule([fullns], mod)
            store.subscribe((mutation) => {
                if (mutation.type == 'common/env/INITIALIZE_WS_COMPLETE') {
                    store.dispatch(fullns+ '/init', null, {
                        root: true
                    })
                }
            })
        }
    }
}
