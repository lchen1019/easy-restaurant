var password_ = new Vue({
    el: "#register",
    data: {
        waiting_code: false,
        time: 3,
        has_password: false,
        name: "",
        tel: "",
        code: "",
        password: "",
        password_again: "",
    },
    methods: {
        check: function () {
            // 修改按钮样式
            this.waiting_code = true
            console.log(this.waiting_code)
            let timer = setInterval(clock, 1000)
            let that = this;
            function clock() {
                console.log(that.time)
                that.time--
                if (that.time === 0) {
                    clearInterval(timer)
                    that.time = 3
                    that.waiting_code = false
                }
            }
            // 提交校验密码是否正确
            let str = Qs.stringify({
                "rid": this.tel,
                "type": 1
            });
            axios({
                method: 'post',
                url: 'http://127.0.0.1:9101/sendVerification',
                data: str
            }).then(function (response) {
                console.log(response.data)
            })
        },
        register: function () {
            // 检验输入的是否正确
            // 检验餐馆名
            let that = this;
            if (this.name == "") {
                alert('餐馆名不能为空')
                return
            } else if (this.password != this.password_again) {
                alert('密码不一致')
                return
            } else if (!check()) {
                return
            }
            // 检查password是否包含字母数字
            function check() {
                has_digit = false
                has_upper_letter = false
                has_lower_letter = false
                for (let i in that.password) {
                    if (that.password[i] >= '0' && that.password[i] <= '9') has_digit = true
                    if (that.password[i] >= 'a' && that.password[i] <= 'z') has_lower_letter = true
                    if (that.password[i] >= 'A' && that.password[i] <= 'Z') has_upper_letter = true
                }
                if (!has_digit) {
                    alert('密码中需包含数字')
                } else if (!has_lower_letter) {
                    alert('密码中需包含小写字母')
                } else if (!has_upper_letter) {
                    alert('密码中需包含大写字母')
                }
                return has_digit && has_lower_letter && has_upper_letter
            }
            // 检查验证码是否正确
            let str = {
                "rid": that.tel,
                "type": 1,
                "code": that.code,
            };
            axios({
                method: 'post',
                headers: {
                    "Content-Type": "application/json",
                },
                url: 'http://127.0.0.1:9101/checkVerification',
                data: str,
            }).then(function (response) {
                if (!response.data) {
                    alert('验证码错误或已失效')
                    return
                } else {
                    // 注册
                    axios({
                        method: 'post',
                        headers: {
                            "Content-Type": "application/json",
                        },
                        url: 'http://127.0.0.1:9101/register',
                        data: {
                            'name': that.name + "",
                            'password': that.password,
                            'tel': that.tel
                        }
                    }).then(function (response) {
                        alert("注册成功")
                    })
                }
            })
        }
    }
})