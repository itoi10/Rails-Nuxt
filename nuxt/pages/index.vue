<template>
  <v-container fluid>
    <v-card
      flat
      tile
      color="transparent"
    >
      <v-card-title>
        Users一覧取得
      </v-card-title>
      <v-card-text>
        <v-btn
          depressed
          color="success"
          class="mr-2"
          @click="getUsers"
        >
          APIからUser一覧取得
        </v-btn>
      </v-card-text>
      <v-card-text>
        <v-simple-table dense>
          <template
            v-if="users.length"
            v-slot:default
          >
            <thead>
              <tr>
                <th
                  v-for="(key, i) in userKeys"
                  :key="`key-${i}`"
                >
                  {{ key }}
                </th>
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
          </template>
        </v-simple-table>
      </v-card-text>
    </v-card>
  </v-container>
</template>


<script>
export default {
  data() {
    return {
      users: [],
      userKeys: [],
      colors: ['primary', 'info', 'success', 'warning', 'error', 'background'],
      customClass: [
        { name: 'hidden-ipad-and-down', color: 'error', des: 'ipad未満で隠す' },
        { name: 'hidden-ipad-and-up', color: 'info', des: 'ipad以上で隠す' },
        { name: 'hidden-mobile-and-down', color: 'success', des: 'mobile未満で隠す' },
        { name: 'hidden-mobile-and-up', color: 'warning', des: 'mobile以上で隠す' }
      ]
    }
  },
  // ページのコンポーネントがロードされる前に呼ばれる
  // async asyncData ({ $axios }) {
  // },
  methods: {
    getUsers() {
      this.$axios.$get('/api/v1/users')
        .then(res => {
          this.users = res;
          this.userKeys = Object.keys(users[0] || {})
        })
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

