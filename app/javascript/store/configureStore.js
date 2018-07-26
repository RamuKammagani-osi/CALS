import rootReducer from 'reducers'
import createSagaMiddleware from 'redux-saga'
import { composeWithDevTools } from 'redux-devtools-extension/developmentOnly'
import {createStore, applyMiddleware, compose} from 'redux'
import {initSagas} from 'initSagas'
import {loadState, saveState} from './browserStorage'

function configureStore (initialState) {
  const sagaMiddleware = createSagaMiddleware()
  const persistedState = loadState()
  const store = createStore(
    rootReducer,
    persistedState,
    composeWithDevTools(applyMiddleware(sagaMiddleware))
  )
  initSagas(sagaMiddleware)
  return store
}

export const store = configureStore()

store.subscribe(() => {
  saveState(store.getState())
})
