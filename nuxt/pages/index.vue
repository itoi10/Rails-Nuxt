<template>
  <div>
    <h2>
      Usersテーブルの取得
    </h2>
    <table border="1" v-if="users.length">
      <thead>
        <tr>
          <th>id</th>
          <th>name</th>
          <th>email</th>
          <th>created_at</th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(user, i) in users"
          :key="`user-${i}`"
        >
          <td>{{ user.id }}</td>
          <td>{{ user.name }}</td>
          <td>{{ user.email }}</td>
          <td>{{ dateFormat(user.created_at) }}</td>
        </tr>
      </tbody>
    </table>

    <div v-else>
      <button
        type="button"
        name="button"
        @click="getUsers"
      >
        RailsAPIからUser一覧取得
      </button>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      users: []
    }
  },
  // ページのコンポーネントがロードされる前に呼ばれる
  // async asyncData ({ $axios }) {
  // },
  methods: {
    getUsers() {
      this.$axios.$get('/api/v1/users')
        .then(res => (this.users = res))
    }
  },
  computed: {
    // 日付フォーマット変換
    dateFormat () {
      return (date) => {
        const dateTimeFormat = new Intl.DateTimeFormat(
          'ja', { dateStyle: 'medium', timeStyle: 'short' }
        )
        return dateTimeFormat.format(new Date(date))
      }
    }
  }
}
</script>

