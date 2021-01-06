# Vue Tricky Stuff

> All of tricks are my own ways.

# Adding Loader

Create `Loader.vue` in `src/components` directory.
I am using `Vuetify`.
So,I will use `Vuetify`'s ready made component.
(You can use others.)

```javascript
// src/components/Loader.vue

<template>
  <div class="text-center">
    <v-overlay>
      <v-progress-circular
 indeterminate
 size="64"
 ></v-progress-circular>
    </v-overlay>
</div>
</template>

```

Add route navigator in `main.js`.
(`app.js` in Laravel.)

```javascript
/*
assign `app` and add `loading` property.Loading property will control the Loader.vue
*/

const app = new Vue({
 data: {
  loading: false
 },
 router,
 vuetify,
 render: h => h(App)
}).$mount('#app')

router.beforeEach((to, from, next) => {
 app.loading = true
 next()
})

router.afterEach(() => {
 setTimeout(() => app.loading = false, 1000) // timeout for Loading
})
```

I was added `router-view` in `App.vue`.
So,I will add `Loader` component in `App.vue`.

```vue

<v-main>
<loader v-if="$root.loading"></loader>
<router-view v-else></router-view>
</v-main>

<script>
import Loader from '@/components/Loader';
export default {
name: 'App',
components: {
Loader
},
}
</script>
```

**Note**
You can control `loading` globally by `this.$root.loading`.