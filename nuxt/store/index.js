export const state = () => ({
  loggedIn: true,

  styles: {
    beforeLogin: {
      appBarHeight: 56
    }
  },

  // プロジェクト
  current: {
    project: null
  },
  projects: [
    { id: 1, name: 'MyProject01', updatedAt: '2022-01-01T12:00:00+09:00' },
    { id: 2, name: 'MyProject02', updatedAt: '2022-01-05T12:00:00+09:00' },
    { id: 3, name: 'MyProject03', updatedAt: '2022-01-03T12:00:00+09:00' },
    { id: 4, name: 'MyProject04', updatedAt: '2022-01-04T12:00:00+09:00' },
    { id: 5, name: 'MyProject05', updatedAt: '2022-01-01T12:00:00+09:00' }
  ]
})

export const getters = {}

export const mutations = {
  setLoggedIn (state, payload) {
    state.loggedIn = payload
  }
}

export const actions = {
  login ({ commit }) {
    commit('setLoggedIn', true)
  },
  logout ({ commit }) {
    commit('setLoggedIn', false)
  }
}
