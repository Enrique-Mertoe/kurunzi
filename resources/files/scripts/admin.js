(function (w) {
    "use strict";
    let er = {
        init: () => {
            $(".splash").remove();
            er.mn();
        },
        md_comp(res) {
            let m = $(".modal-component");
            m.show();
            setTimeout(() => {
                m.addClass("show");
            });
            if (res.success) {
                let data = $(res.data)
                m.find(".modal-component-content").empty().html(data);
                data.find("[data-smv-dismiss=mdcomponent]").on("click", function (ev) {
                    ev.preventDefault();
                    m.removeClass("show");
                    setTimeout(() => {
                        m.hide()
                    }, 300)
                })
            }
        },
        mn() {
            $(document).on("submit", ".form-n-page", function (e) {
                e.preventDefault();
                let f = this;
                let fd = new FormData(this), pic;
                if ((pic = $("html").data("fp_ct"))) {
                    fd.append("profile_pic", pic, "image.png");
                    $("html").data("fp_ct", null);
                }
                $.post({
                    url:w._smv.smv_url("/_xhr/new_page"),
                    data: fd,
                    processData: false,
                    contentType: false
                }).then(res => {
                    if (res.success) {
                        f.reset()
                    }
                })

            }).on("click", "[data-md-component]", function (ev) {
                ev.preventDefault();
                // w._smv.prepare(m.find(".modal-component-content").empty());
                w._smv.bar_load()
                w._smv.xhr("admin", {target: $(this).data("md-component")}).then(res => {
                    er.md_comp(res);
                    w._smv.bar_load(!0)
                });
            }).on("click", ".new_acc_selector .option-item", function (ev) {
                $(".new_acc_selector").hide();
                $(".smv-page-option").find("." + $(this).data("smv-target")).fadeIn()
            });


        }
    }

    er.init();
    (() => {
        function o(fs) {
            fs.removeClass("open")
            setTimeout(() => {
                fs.find(".form-selector-options").hide();
            }, 150);
        }

        function n(fs) {
            fs.find(".form-selector-options").show();

            setTimeout(() => {
                fs.addClass("open")
            })
        }

        function s(f) {
            let d = $(f);
            f = $(f).closest(".form-selector");
            f.find(".m-selector-value").text(d.text());
            f.find(".input-selector").val(d.text().trim());
        }

        $(document).on("click", "[data-form-selector]", function (ev) {
            ev.preventDefault();
            n($(this).closest(".form-selector"));
        });
        $(document).on("click", ".option-item", function (ev) {
            ev.preventDefault();
            s(this);
        });
        $(document).on("click", function (e) {
            if (!$(e.target).closest("[data-form-selector]").length) {
                o($(".form-selector"));
            }

        })

    })()

})(window)