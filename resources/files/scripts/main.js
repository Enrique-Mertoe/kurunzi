!function (e, f) {
    f(e);
}(window, function (w) {
    "use strict";
    let eActions = {};
    let e = {
        init: function () {
            $(document).ready(function () {
                e.load_pages();
                e.ui.load()
                // e.scroll_effect()
                e.rd()
            });
        },
        on(action, callback) {
            eActions[action] = callback
        },
        smv_url(url) {
            return location.origin + "/" + url;
        },
        body: $(document.body),
        alert(msg, cb) {
            e.ui.dialog({
                type: "alert",
                action: cb,
                content: msg
            }).show()
        },
        confirm(c, cb, options) {
            e.ui.dialog({
                type: "confirm",
                content: c,
                action: cb,
                options: options
            }).show();
        },
        get_path() {
            let p = w.location.href.replace(w.location.origin, "");
            p.length > 1 && p.startsWith("/") ? p = p.slice(1) : null;
            return arguments.length ? p === arguments[0] : p;
        },
        rd() {
            $(w).on("popstate", function (ev) {
                ev.preventDefault();
                e.s_r(e.pn(w.location.pathname))
            });
            $(document).on("click", "[data-page-state]", function (ev) {
                ev.preventDefault();
                let l = e.flags.states.length;
                if (l) {
                    if (l === 1 && e.flags.states[l - 1] === w.location.pathname) return;
                    let s = e.flags.states[e.flags.states.length - 1];
                    e.flags.back = !0;
                    e.flags.states.pop();
                    e.s_r(s);
                } else {
                    // !e.get_path("/")?e.s_r(e.get_path()):null;
                }
            })
        },
        pn(d) {
            return d.startsWith("/") && d.length > 1 ? d.slice(1) : d;
        },
        bar_load(c) {
            if (c)
                $("[data-page-loader]").removeClass("show")
            else
                $("[data-page-loader]").addClass("show")
        },
        prepare(e, r) {
            if (r) e.find(".prep-area").remove();
            else
                e.append(
                    `<div class="vstack prep-area py-4 justify-content-center align-items-center">
                    <span class="border-spinner"></span>
                </div>`);
        },
        prepare1(e, r) {
            if (r) e.find(".prep-area").remove();
            else
                e.append(
                    `<div class="vstack prep-area justify-content-center align-items-center">
                    <span class="border-spinner"></span>
                </div>`);
        },
        prepare2(e, r) {
            if (r) e.find(".prep-area").remove();
            else
                e.html(
                    `<div class="vstack prep-area justify-content-center align-items-center">
                    <span class="border-spinner"></span>
                </div>`);
        },
        load_pages: () => {
            $.post(
                window.location.href,
                {xhr_init: true}
            ).then(res => {
                if (res.success) {
                    e.page_options(res)
                    e.update_page(res.data, res.auth);
                    if (res.auth) e.auth();
                    e.fl(res)
                    cubic($(".try-container"))

                }
            }).catch(reason => {
                console.log(reason)
            });
        },
        handle(c) {
            if (arguments.length > 1) {
                for (let i = 0; i < arguments.length; i++) {
                    e.handle(arguments[i]);
                }
                return;
            }
            arguments.length === 1 && (() => {
                c.find("[data-tag]").each((i, e) => {
                    let t = $(e).data("tag");
                    $(e).removeAttr("data-tag").data("tag", t);
                });
                c.find("[data-url]").each((i, e) => {
                    let t = $(e).data("url");
                    $(e).removeAttr("data-url").data("url", t);
                }).on("click", function (ev) {
                    ev.preventDefault();
                    e.s_r($(this).data("url"));

                });
                c.find("[data-fl]").each((i, e) => {
                    let t = $(e).data("fl");
                    $(e).removeAttr("data-fl").data("fl", t);
                }).on("click", function (ev) {
                    ev.preventDefault();
                    ev.stopPropagation()
                    e.fl_o(this)
                });
                e.lazy(c);
                if (c.find(".video-player").length) {
                    c.find(".video-player").each(function () {
                        e._vid(this);
                    });
                }

            })();

        },
        lazy(c) {
            c.find("img.lazy-load").each(function () {
                let el = $(this);
                el.removeClass("lazy-load");
                let observer =
                    new IntersectionObserver(entries => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                if (!el.data('loaded')) {
                                    e.lazy_load(this, {
                                        src: el.data("src"),
                                        placeholder: null
                                    })
                                    el.removeAttr('data-src').removeClass('loading');
                                    el.data('loaded', true);
                                }
                                observer.disconnect();
                            }
                        });
                    });
                observer.observe(this)
            });

            c.find("[data-v-track]").each(function () {
                let el = $(this),
                    tg = el.data("v-track");
                el.removeAttr("data-v-track");
                let observer =
                    new IntersectionObserver(entries => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                if (!el.data('loaded')) {
                                    e.v_track(this, tg)
                                    el.data('loaded', true);
                                }
                                observer.disconnect();
                            }
                        });
                    });
                observer.observe(this)
            });
            c.find("[data-file-loader]").each(function () {
                let el = $(this),
                    tg = el.data("file-loader");
                el.removeAttr("data-file-loader");
                let observer =
                    new IntersectionObserver(entries => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                if (!el.data('loaded')) {
                                    e.dfl(this, tg)
                                    el.data('loaded', true);
                                }
                                observer.disconnect();
                            }
                        });
                    });
                observer.observe(this)
            });
        },
        v_track(el, tg) {
            el = $(el);
            e.xhr("view_track", {target: tg}).then(res => {
                if (res.success) {
                    let n = Number(el.find(".r-views").text()) + 1;
                    el.find(".r-views").text(n)
                }
            });
        },
        dfl(el, pdfURL) {
            el = $(el);
            let container = el;
            const loadingTask = pdfjsLib.getDocument(pdfURL);
            loadingTask.promise.then(function (pdf) {
                const totalPages = pdf.numPages;
                for (let pageNumber = 1; pageNumber <= totalPages; pageNumber++) {
                    pdf.getPage(pageNumber).then(function (page) {
                        const viewport = page.getViewport({scale: 1.5}); // Adjust the scale as needed

                        const canvas = document.createElement('canvas');
                        const ctx = canvas.getContext('2d');
                        canvas.height = viewport.height;
                        canvas.width = viewport.width;
                        container.append(canvas);

                        const renderContext = {
                            canvasContext: ctx,
                            viewport: viewport
                        };
                        page.render(renderContext);
                    });
                }
            }, function (reason) {
                console.error(reason);
            });
        },
        lazy_load(e, p) {
            let at = 0;

            function n() {
                let xhl = new XMLHttpRequest()
                xhl.open("GET", p.src, true);
                xhl.responseType = "blob";
                xhl.addEventListener("load", function () {
                    if (xhl.status === 200) {
                        var r = new FileReader()
                        r.onload = function () {
                            e.src = r.result;
                        }
                        r.readAsDataURL(xhl.response);
                    }
                });
                xhl.send();
            }

            function o() {
                if ($(e).closest(".__transitioning_").length) {
                    if (at > 5) return;
                    at++;
                    setTimeout(() => {
                        o();
                    }, 300)
                    return
                }
                n()
            }

            o();
        },
        s_r(u) {
            eActions?.navigate.call();
            if (e.flags.page && e.flags.page.lock) return;
            let args = u.slice(u.indexOf("?")).slice(1);
            args = args ? "&" + args : "";
            // u = u.slice(0, u.indexOf("?"));
            u = u.indexOf("?") !== -1 ? u.slice(0, u.indexOf("?")) : u;
            e.bar_load();
            $.post(u + "?xhr=1" + args).then(res => {
                e.bar_load(!0)
                if (res.success && res.redirect) {
                    e.flags.to(res.redirect || "self");
                } else e._p(res)


            });
        },
        _p(r) {
            e.page_options(r)
            let d = r.data, c = $(d.content);
            document.title = d.title
            e.pushState(d.url)

            $(".main-content").html(c);
            e.handle(c);
            e.fl(r)


        },
        fl_o(el) {
            e.xhr("fl_o", {target: $(el).data("fl")})
                .then(res => {
                    if (res.success) {
                        $(el).html(res.data)
                    }
                })
        },
        page_options(r) {
            if (r.flags)
                e.flags.page = r.flags;
            if (r.mini_sidebar)
                $(".main-layout").addClass("small-sidebar")
            else
                $(".main-layout").removeClass("small-sidebar")
            if (r.collapse_endbar)
                $(".main-layout").addClass("endbar-collapsed")
            else
                $(".main-layout").removeClass("endbar-collapsed")

            if (r.fl_sg) {
                e.fl_sg()
            }


        },
        fl(r) {
            if (r.load_notes) {
                e.load_notes()
            }
            if (r.load_posts) e.load_posts(0, r.load_posts);
        },
        fl_sg() {
            e.xhr("fl_sg").then(res => {
                let fl = $(".follow-suggest-list").empty()
                res.data.forEach(sg => {
                    sg = $(sg);
                    e.inject(sg, fl);
                })
            })
        },
        load_notes() {
            let p = $(".note-list").empty();
            e.prepare(p)
            e.xhr("notifications").then(res => {
                if (res.success) {
                    let d = res.data, c = d.content;
                    p.empty();
                    if (d.empty) {

                    } else {
                        c.forEach(c => {
                            c = $(c);
                            p.append(c)
                            e.handle(c)
                        })
                    }
                }
            })
        },
        update_page: (a, t) => {

            if (t) {
                let c = $(a.content)
                $(a.parent).empty().html(c);
                e.handle(c)
            } else {
                let {aside, header, main, end} = a.content;
                aside = $(aside), header = $(header), main = $(main), end = $(end);
                $(a.parent).empty()
                    .append(header, aside, main, end);
                e.handle(aside, header, main, end)
            }
            // console.log(a.content)
        },
        auth: () => {
            $(document).on("submit", ".form-signup,.form-login", function (event) {
                event.preventDefault();
                e.form(this).s()
            });
        },
        load_posts(i, tc) {
            if (!e.load_posts.fn.cl) return;
            e.load_posts.fn.cl = !1;
            e.prepare($(".feed-list"));
            $.post(e.smv_url("_xhr/posts"), {from: i || 0, ...tc || null}).then(res => {
                if (res.success) {
                    this.prep_posts(res.data)
                    e.prepare($(".feed-list"), !0);
                    e.load_posts.fn.cl = !0;
                }
            }).catch(reason => {
                console.log(reason)
            });
        },
        prep_posts(d) {
            if ($(".feed-filter-docs").length)
                e.filter_doc_post($(".feed-filter-docs"))
            let c = d.content, ep = d.empty;
            let fl = $(".feed-list"), pr = fl.find(".prep-area");
            let n;
            if (pr.length) n = pr;
            if (!ep) {
                c.forEach(c => {
                    c = $(c);
                    if (!n) {
                        fl.append(c);
                        n = c;
                    } else n.after(c);
                    this.handle(c)
                    e.post(c);
                });
            }
        },
        inject(el, into) {
            into.append(el)
            e.handle(el)
        },
        pushState(url) {
            if (!e.flags.back) {
                let s = e.flags.states, l = s.length;
                l = l && s[l - 1] === this.get_path() ? null :
                    e.flags.states.push(e.get_path());
            } else e.flags.back = !1;
            window.history.pushState({state: 'new'}, '', url);
            let sb = $(".state-button");
            e.flags.states.length ? sb.show() : sb.hide();
        },
        xhr(u, d) {
            return $.post({
                url: e.smv_url('_xhr/' + u),
                data: d
            })
        },
        filter_doc_post(el, target) {
            target = target || ".allocations_disbursements"
            setTimeout(_ => {
                el.find(".feed-item").hide()
                el.find(target).show();
                if (!el.find(target).length) {
                    el.next().removeClass("d-none")
                } else {
                    el.next().addClass("d-none")
                }
            })
        }
    };

    e.load_posts.fn = {
        cl: !0
    };

    //post handler
    (e.post = function (p) {
        return new e.post.init(p);
    }).prototype = e.post.fn = {
        reaction() {
            let s = this, c = this.lb.find("[data-lct]");
            this.lb.on("click", function (e) {
                e.preventDefault();
                $(this).toggleClass("active animate")
                s.s_r('rpl').then(res => {
                    if (res.success) {
                        if (s.lb.hasClass("active")) {
                            c.html(Number((c.text() || 0) + 1))
                        } else {
                            c.html(Number((c.text() || 0) - 1) || "")
                        }
                    }
                })
            });
            this.nc.on("click", function (ev) {
                ev.preventDefault();
                let ca = $(this).next().slideDown(200);
                $(this).hide()
                // e.comment(s.tg, s.p)
            });
            this.p.find("[data-pst-rmv]").on("click", function (ev) {
                ev.preventDefault();
                let c = $(this).html();
                e.prepare1($(this).empty().html("Deleting...").addClass("d-flex gap-2"));
                e.xhr("post_actions", {type: "dl", target: s.tg}).then(res => {
                    if (res.success) {
                        s.p.slideUp(200)
                        setTimeout(_ => s.p.remove(), 300);
                    }
                })
            });
            s.p.find("[data-cmt-sec] form")
                .submit(function (ev) {
                    ev.preventDefault();
                    let si = $(this).find(".smart-input"),
                        st = e.ui.form.process_smart_input(si),
                        fl = $(this).find(".form-loader");
                    if (!st) return;
                    fl.toggleClass("loading")
                    e.xhr("new_comment", {target: s.tg, status: st})
                        .then(res => {
                            fl.toggleClass("loading")
                            if (res.success) {
                                si.empty().removeClass("has-content");
                                this.reset();
                                s.r_c()
                            }
                        });
                });
        },
        s_r(t) {
            return e.xhr("post_reaction", {
                type: t,
                target: this.tg
            });
        },
        r_c() {
            let cs = this.ca, t = this.tg;

            function lct() {
                e.xhr("load_comments", {target: t}).then(res => {
                    cs.empty();
                    if (res.success) {
                        let dt = $(res.data)
                        cs.html(dt)
                    }
                });
            }

            lct();
        }
    };
    (e.post.init = function (p) {
        this.p = p;
        this.tg = p.data("tag");
        p.removeAttr("data-tag").data("tag", this.tg);

        this.lb = p.find("[data-rpl]").removeAttr("data-rpl");
        // this.sb = p.find(".r-comment .btn");
        // this.cb = p.find(".r-like .btn");
        this.ca = p.find(".comment-list");
        this.nc = p.find("[data-new-comment]");
        this.reaction();
        this.r_c()
    }).prototype = e.post.fn;
    //comment handler
    (e.comment = function (t, p) {
        return new e.comment.init(t, p)
    }).prototype = e.comment.fn = {
        launch() {
            let s = this;
            this.o(s.layout);
            s.layout.find("form")
                .submit(function (ev) {
                    ev.preventDefault();
                    let si = $(this).find(".smart-input"),
                        st = e.ui.form.process_smart_input(si),
                        fl = $(this).find(".form-loader");
                    if (!st) return;
                    fl.toggleClass("loading")
                    e.xhr("new_comment", {target: s.tg, status: st})
                        .then(res => {

                            fl.toggleClass("loading")
                            if (res.success) {
                                si.empty().removeClass("has-content");
                                this.reset();
                            }
                        });
                });
            let cs = s.layout.find(".comment-section");
            e.prepare(cs);

            function lct() {
                e.xhr("load_comments", {target: s.tg}).then(res => {
                    cs.empty();
                    if (res.success) {
                        let dt = $(res.data)
                        cs.html(dt)
                    }
                });
            }

            lct();
        },
        o(l) {
            e.inject(l, $("body"));
            l.find(".m-lightbox-media").html(this.p.find(".feed-media").clone());
            setTimeout(() => {
                l.addClass("show");
            });
        },
        c() {
            this.layout.removeClass("show");
            setTimeout(() => {
                this.layout.remove();
            }, 300)
        }
    };
    (e.comment.init = function (t, p) {
        this.tg = t;
        this.p = p;
        let d = e.ui.comp.get("dialogs");
        d && (() => {
            let a = this.layout = e.ui.toHtml(d).find(".modal-comment");
            if (a.length) {
                this.launch();
                a.find("[data-bs-dismiss]").on("click", () => {
                    this.c();
                });
            }
        })();
    }).prototype = e.comment.fn;

    // form handler
    (e.form = function (f) {
        return new e.form.init(f);
    }).prototype = e.form.fn = {
        s() {
            if (this.f.data(this.st)) return
            this.rl();
            this.f.data(this.st, !0)
            this.p();
        },
        rl() {
            this.fl.toggleClass("loading")
        },
        p() {
            let s = this, ags;
            ags = (() => {
                let f = e.flags.args();
                return f.length ? "&" + f : ""
            })();
            $.post(
                e.smv_url("_xhr/auth?tag=" + this.t + ags),
                this.f.serialize(),
                function success(res) {
                    s.rl();
                    s.hs()
                    if (res.success) {
                        s.m(res.message, !0)
                        e.flags.to(res.redirect || "self");
                    } else {
                        s.m(res.message)
                    }
                }
            )
        },
        m(m, e) {
            let c = e ? "text-success" : "text-danger";
            this.fm.html(m).removeClass("text-success text-danger").addClass(c)
        },
        hs() {
            this.f.data(this.st, !1)
        }

    };
    (e.form.init = function (f) {
        this.f = $(f);
        this.fl = this.f.find(".form-loader");
        this.fm = this.f.find(".form-message")
        this.t = this.f.data("tag");
        this.st = "cs?";
    }).prototype = e.form.fn;
    e.flags = {
        states: [],
        args: () => {
            let s = "";
            (new URLSearchParams(w.location.search)).forEach(function (value, key) {
                s += `${key}=${value}&`;
            });
            s = e.str.r_strip(s, "&")
            return s;
        },
        to(l) {
            if (l === "self")
                w.location.reload();
            else
                w.location.href = l;
        },
        page: {}
    };
    e.str = {
        r_strip: (str, pattern) => {
            return str.replace(new RegExp(pattern.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + "+$"), "");
        }
    }
    e.comp = {};
    e.ui = {
        load: () => {
            e.xhr("ui_components").then(res => {
                if (res.success) {
                    e.ui.comp.set(res.data);
                }
            });
        },
        dialog: (n) => {
            if (!n) {
                let d = e.ui.comp.get("dialogs");
                return d ? e.ui.toHtml(d) : d;

            }
            let t = `[data-main-dialog]`,
                d = e.ui.comp.get("dialogs");
            d && (() => {
                d = $("<div>").html(d);
                d = d.find(t).length ? d.find(t) : null;
            })();
            let c, o, ds, hd, ct, dr;
            d && (() => {
                c = d.find("[data-dl-cancel]");
                dr = d.find("[data-dl-close]");
                o = d.find("[data-dl-ok]");
                ds = d.find("[data-dl-dismiss]");
                hd = d.find("[data-dl-header]");
                ct = d.find("[data-dl-content]");
                ct.text(n.content || "");
                hd.text("");
                d.on("contextmenu", function (e) {
                    e.preventDefault()
                })
                c.on("click", function () {
                    rmv()
                });
                dr.on("click", rmv);
                o.on("click", function () {
                    rmv();
                    n.action ? n.action.call() : null;
                })
                if (n.type === "confirm") {
                    hd.text("");
                }
                if (n.type === "alert") {
                    c.remove();
                    dr.remove();
                }

                if (n.options) {
                    if (n.options.ok) {
                        o.text(n.options.ok)
                    }
                }

            })();

            function sh() {
                $(document.body).append(d);
                d.css({display: "block"})
                setTimeout(() => {
                    d.addClass("show");
                });
            }

            function rmv() {
                d.removeClass("show").css({opacity: .5});

                setTimeout(() => {
                    d.modal("hide")
                    d.remove()
                }, 100)
            }

            return {
                show() {
                    sh()
                },
                dismiss() {

                }
            }
        },
        modal(m, c) {
            if (m && typeof m === "string" && !c) {
                let d = this.dialog();
                return d && d.length ? d.find(m) : !0;
            }
            // m = $(m);
            if (c === "show") {

                m.show();
                setTimeout(() => {
                    m.addClass("show")
                })
            } else {
                m.removeClass("show")
                setTimeout(() => {
                    m.hide();
                }, 300);
            }
        },
        modal_default(cb) {
            let m = e.ui.modal(".modal-default"), st, cl;

            function onStart(fn) {
                st = fn;
            }

            function onClose(fn) {
                cl = fn;
            }

            function ct(content) {
                content = typeof content === "string" || typeof content === "undefined" ? content || "" : $(content)
                m.find("[data-md-content]").empty().html(content)
            }

            if (m && m.length) {
                e.body.append(m);
                m.show();
                cb({
                    onStart: onStart,
                    onClose: onClose,
                    content: ct,
                    dismiss() {
                        m.removeClass("show");
                        if (cl) {
                            cl();
                        }
                        setTimeout(() => {
                            m.remove()
                        }, 300);
                    }
                });
                setTimeout(() => {
                    m.addClass("show");
                    if (st) {
                        st.call({
                            setContent: ct
                        })
                    }
                });
                m.find("[data-smv-dismiss]").on("click", function (ev) {
                    ev.preventDefault();
                    m.removeClass("show");
                    if (cl) {
                        cl();
                    }
                    setTimeout(() => {
                        m.remove()
                    }, 300);
                })
            }
        },
        form: {
            empty(f) {
                let ep = 0;

                function o(v) {
                    return typeof v !== "undefined" && String(v).trim().length > 0;
                }

                $(f).find("input,[contenteditable],textarea").each(function (e) {
                    if (['radio', 'checkbox'].includes(this.type)) return;
                    if ((o(this.value) || o(this.textContent))) {
                        ep += 1;
                    }
                });
                return ep === 0;
            },
            has_empty(f) {
                let ep = 0;

                function o(v) {
                    return typeof v !== "undefined" && String(v).trim().length > 0;
                }

                $(f).find("input,[contenteditable],textarea").each(function (e) {
                    if (['radio', 'checkbox'].includes(this.type)) return;
                    if (!(o(this.value) || o(this.textContent))) {
                        ep += 1;
                    }
                });
                return ep > 0;
            },
            process_smart_input(el) {
                let rg = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]+))$/g,
                    s = el.html();
                let p = rg.exec(s), n;
                if (p && (n = p[0])) {
                    let b = document.createElement("base");
                    b.innerHTML = n;
                    let l = "";
                    b.childNodes.forEach(c => {
                        if ($(c).hasClass("hash-tag"))
                            l += "__hash__"
                        if ($(c).hasClass("hs-link"))
                            l += "__link__"
                        l += c.textContent
                    });
                    return l;
                }
                return s;
            }
        }
    };
    e.ui.comp = (() => {
        let a = {},
            p = {
                has: (v) => {
                    return a.hasOwnProperty(v);
                },
                get: (v) => {
                    return p.has(v) ? a[v] : null
                },
                set(v) {
                    a = v;
                }
            }
        return p;
    })();
    e.ui.toHtml = (v) => {
        return $("<div>").html(v);
    };
    e._vid = function (e) {
        e = $(e);
        let p, v, t, ov;
        p = e.find(".btn-play"), v = e.find("video")[0], t = e.find(".play-played"),
            ov = e.find(".video-overlay");
        v.muted = !0;

        function pl() {
            $("video").not(v).each(function () {
                this.pause()
            })

            if (v.paused) {
                v.play().then(_ => {
                    ov.addClass("hidden")
                });
                p.find("i").html(`<svg xmlns="http://www.w3.org/2000/svg" width="34" height="34" fill="currentColor" class="bi bi-pause-fill" viewBox="0 0 16 16">
                      <path d="M5.5 3.5A1.5 1.5 0 0 1 7 5v6a1.5 1.5 0 0 1-3 0V5a1.5 1.5 0 0 1 1.5-1.5m5 0A1.5 1.5 0 0 1 12 5v6a1.5 1.5 0 0 1-3 0V5a1.5 1.5 0 0 1 1.5-1.5"/>
                    </svg>`);

            } else {
                v.pause();
                psd()
            }

        }

        function psd() {
            p.find("i").html(`<svg xmlns="http://www.w3.org/2000/svg" width="34" height="34"
                                         fill="currentColor" class="bi bi-play-fill" viewBox="0 0 16 16">
                                  <path d="m11.596 8.697-6.363 3.692c-.54.313-1.233-.066-1.233-.697V4.308c0-.63.692-1.01 1.233-.696l6.363 3.692a.802.802 0 0 1 0 1.393"/>
                                </svg>`);
        }

        function no(t = 300, mv = !1) {
            setTimeout(() => {
                ov.removeClass("hidden")
            }, t)
        }

        function tr() {
            // let v = document.createElement("video")

            var currentTime = v.currentTime;
            var duration = v.duration;
            var percentage = (currentTime / duration) * 100;
            ptu(percentage)
        }

        function ptu(v) {
            t.css({width: v + "%"})
        }

        function vtu(t) {
            // let v = document.createElement("video")
            v.currentTime = t / 100 * v.duration;
        }

        $(v).on("pause", function () {
            psd()
        });

        ov.on("mousemove", function (e) {
            ov.removeClass("hidden")
        });
        // ov.on("mouseleave", function (e) {
        //     e.preventDefault();
        //     e.stopPropagation();
        //     no()
        // });
        $(v).on("timeupdate", function () {
            tr()
        })
        p.on("click", function () {
            pl()
        });
        t.parent().on("click", function (e) {
            let x = e.clientX, s = $(this);
            let w = x - s.offset().left + 6, p = w / s.width() * 100;
            ptu(p);
            vtu(p)
        });
        let ct;
        e.find(".btn-mute").on("click", function () {
            if (v.muted) {
                this.innerHTML = `<svg width="26" height="26" viewBox="0 0 24 24" fill="none"
                                     xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g
                                        id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g
                                        id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd"
                                                                        d="M6.48492 14.9509C5.61278 14.8941 4.95044 14.1433 5.00292 13.2709V10.6709C4.95044 9.79849 5.61278 9.04766 6.48492 8.9909H7.59092C7.92246 8.98881 8.24208 8.867 8.49092 8.6479L10.0339 7.3169C10.503 6.94728 11.1485 6.8965 11.6696 7.18823C12.1907 7.47997 12.4848 8.0568 12.4149 8.6499V15.2919C12.4848 15.885 12.1907 16.4618 11.6696 16.7536C11.1485 17.0453 10.503 16.9945 10.0339 16.6249L8.48892 15.2939C8.24008 15.0748 7.92046 14.953 7.58892 14.9509H6.48492Z"
                                                                        stroke="currentColor" stroke-width="1.5"
                                                                        stroke-linecap="round"
                                                                        stroke-linejoin="round"></path> <path
                                        d="M18.0651 6.93681C17.8159 6.60591 17.3457 6.53964 17.0148 6.78879C16.6839 7.03794 16.6176 7.50817 16.8668 7.83907L18.0651 6.93681ZM16.8668 16.1038C16.6176 16.4347 16.6839 16.9049 17.0148 17.1541C17.3457 17.4032 17.8159 17.337 18.0651 17.0061L16.8668 16.1038ZM15.545 8.04427C15.2746 7.73052 14.801 7.69542 14.4873 7.96585C14.1735 8.23629 14.1384 8.70987 14.4088 9.02361L15.545 8.04427ZM14.4088 14.9193C14.1384 15.233 14.1735 15.7066 14.4873 15.977C14.801 16.2475 15.2746 16.2124 15.545 15.8986L14.4088 14.9193ZM16.8668 7.83907C18.7092 10.286 18.7092 13.6569 16.8668 16.1038L18.0651 17.0061C20.3097 14.0249 20.3097 9.91794 18.0651 6.93681L16.8668 7.83907ZM14.4088 9.02361C15.869 10.7176 15.869 13.2253 14.4088 14.9193L15.545 15.8986C17.4903 13.6418 17.4903 10.301 15.545 8.04427L14.4088 9.02361Z"
                                        fill="currentColor"></path> </g></svg>`;
            } else {
                this.innerHTML = `<svg width="26" height="26" viewBox="0 0 24 24" fill="none"
                                     xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g
                                        id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g
                                        id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd"
                                                                        d="M6.48492 14.9509C5.61278 14.8941 4.95044 14.1433 5.00292 13.2709V10.6709C4.95044 9.79849 5.61278 9.04766 6.48492 8.9909H7.59092C7.92246 8.98881 8.24208 8.867 8.49092 8.6479L10.0339 7.3169C10.503 6.94728 11.1485 6.8965 11.6696 7.18823C12.1907 7.47997 12.4848 8.0568 12.4149 8.6499V15.2919C12.4848 15.885 12.1907 16.4618 11.6696 16.7536C11.1485 17.0453 10.503 16.9945 10.0339 16.6249L8.48892 15.2939C8.24008 15.0748 7.92046 14.953 7.58892 14.9509H6.48492Z"
                                                                        stroke="currentColor" stroke-width="1.5"
                                                                        stroke-linecap="round"
                                                                        stroke-linejoin="round"></path> <path
                                        d="M14.4726 13.4406C14.1797 13.7335 14.1797 14.2084 14.4726 14.5013C14.7655 14.7942 15.2404 14.7942 15.5333 14.5013L14.4726 13.4406ZM17.5333 12.5013C17.8262 12.2084 17.8262 11.7335 17.5333 11.4406C17.2404 11.1477 16.7655 11.1477 16.4726 11.4406L17.5333 12.5013ZM16.4726 11.4406C16.1797 11.7335 16.1797 12.2084 16.4726 12.5013C16.7655 12.7942 17.2404 12.7942 17.5333 12.5013L16.4726 11.4406ZM19.5333 10.5013C19.8262 10.2084 19.8262 9.73351 19.5333 9.44062C19.2404 9.14772 18.7655 9.14772 18.4726 9.44062L19.5333 10.5013ZM17.5333 11.4406C17.2404 11.1477 16.7655 11.1477 16.4726 11.4406C16.1797 11.7335 16.1797 12.2084 16.4726 12.5013L17.5333 11.4406ZM18.4726 14.5013C18.7655 14.7942 19.2404 14.7942 19.5333 14.5013C19.8262 14.2084 19.8262 13.7335 19.5333 13.4406L18.4726 14.5013ZM16.4726 12.5013C16.7655 12.7942 17.2404 12.7942 17.5333 12.5013C17.8262 12.2084 17.8262 11.7335 17.5333 11.4406L16.4726 12.5013ZM15.5333 9.44062C15.2404 9.14772 14.7655 9.14772 14.4726 9.44062C14.1797 9.73351 14.1797 10.2084 14.4726 10.5013L15.5333 9.44062ZM15.5333 14.5013L17.5333 12.5013L16.4726 11.4406L14.4726 13.4406L15.5333 14.5013ZM17.5333 12.5013L19.5333 10.5013L18.4726 9.44062L16.4726 11.4406L17.5333 12.5013ZM16.4726 12.5013L18.4726 14.5013L19.5333 13.4406L17.5333 11.4406L16.4726 12.5013ZM17.5333 11.4406L15.5333 9.44062L14.4726 10.5013L16.4726 12.5013L17.5333 11.4406Z"
                                        fill="currentColor"></path> </g></svg>
                                        `;

            }
            v.muted = !v.muted;
        })
    }
    e.studio = {

        init(el, ev) {
            // let cm = e.ui.modal(".m-studio");
            // this.sr(cm)
            // return
            let fp = $(el).closest(".feed-plant"),
                options = fp.find(".feed-creator-options"),
                bgn = options.html();

            function ldr(e) {
                if (e) return fp.find(".fp-loader").hide();
                fp.find(".fp-loader").show();
            }

            function en() {
                fp.find("[data-ct-option]").on("click", function (ev) {
                    ev.preventDefault();
                    ev.stopPropagation()
                    est($(this).data("ct-option"));
                })
            }

            function est(op) {
                if (op === 0) {
                    return e.studio.close(fp[0]);
                }
                let ui = $(e.ui.comp.get("fp"));
                options.html(ui);
                fp.addClass("creating").find(".creator-input").focus();
                fp.data("bgn", bgn);
            }

            if (!fp.hasClass("open")) {
                ev.preventDefault();
                fp.addClass("open");
                fp.find(".feed-creator-options").slideDown(150);
                en();
            }
        },
        sr(cm, cb) {
            $("body").append(cm);
            e.ui.modal(cm, "show");
            cm.find("[data-dcl]").on("click", function (ev) {
                e.ui.modal(cm, "hide");
            });
        },
        close(f) {
            function n() {
                f = $(f).removeClass("open creating");
                f.find(".feed-creator-options").slideUp(150);
                $("body").removeClass("modal-open");
                if (f.data("bgn")) {
                    f.find(".feed-creator-options").html(f.data("bgn"));
                }

            }

            if (!e.ui.form.empty(f)) {
                return e.confirm("You have unsaved changes.", function () {
                    n()
                }, {
                    ok: "discard"
                });
            }
            return n();
        }
    }

    e.init();
    w._smv = e;


    (() => {
        $(document).on("click", ".creator-ignitor", function (ev) {
            // body...
            e.studio.init(this, ev);
        });
        $(document).on("click", ".feed-plant", function (ev) {
            // body...
            if (!$(ev.target).closest(".creator-ignitor").length) {
                e.studio.close(this)
            }
        }).on("click", ".creator-trigger", function (ev) {
            ev.preventDefault();
            $(".creator-ignitor")[0].click()
        });

    })();


    (() => {

        function scroll_snap(p, d) {
            let i = p.width(),
                sl = p.find(".feed-media-inner").scrollLeft();
            p.addClass("__transitioning_");
            p.find(".feed-media-inner").scrollLeft(sl + i * d);
            setTimeout(() => {
                p.removeClass("__transitioning_");
            }, 300)
        }

        $(document).on("click", ".feed-media .scroll-left", function (e) {
            e.preventDefault();
            scroll_snap($(this).closest(".feed-media"), -1);
        });
        $(document).on("click", ".feed-media .scroll-right", function (e) {
            e.preventDefault();
            scroll_snap($(this).closest(".feed-media"), 1);
        });
        $(document).on("click", ".hs-nav .nav-link", function (e) {
            e.preventDefault()
            $(this).closest(".header-nav").find(".nav-link").removeClass("active")
            $(this).addClass("active")
        });
        $(document).on("click", "[data-url-out]", function (ev) {
            ev.preventDefault();
            setInterval(() => {
                let i = 0;
                console.log(i);
                i++;
            });

            e.confirm("Confirm logout?", () => {
                e.s_r($(this).data("url-out"));
            })
        })
    })();

    (() => {
        //upload manager
        w.upm = function () {
            let ps = []

            function st() {
                $(".feed-plant .upload-progress").empty().html(`<div class="h-100">
                                <div class="up-loader border-spinner"></div>
                                <div class="vstack h-100 justify-content-center align-items-center">
                                    <span class="p-counter">1</span>
                                </div>
                            </div>`)
                    .show()
                    .on("click", function (e) {
                        e.preventDefault();
                        e.stopPropagation();
                    });
            }

            function ts() {
                $(".feed-plant .upload-progress").hide().empty()
            }

            let up = function () {

            };
            (up.init = function () {

            }).prototype = up.prototype = up.fn = {
                uploading() {
                    if (ps.length === 0) st();
                    ps[ps.length - 1] = this
                },
                terminate() {
                    if (ps.length > 0) {
                        ps[ps.length - 1] = null
                    } else {

                    }
                    ts()
                }
            }
            return function () {
                return new up.init();
            }
        }();


        let dz = function (e, m) {
            return new dz.init(e, m);
        };
        (dz.init = function (e, m) {
            this.fs = e.target.files
            this.m = m || 5;


        }).prototype = dz.prototype = dz.fn = {
            reflect: function (e) {
                this.rf = $(e).empty().append(`<div class="row dz-content g-1"></div>`)
                this.build()
            },
            build() {
                let l = this.fs.length > 3 ? this.m : this.fs.length;
                for (let i = 0; i < l; i++) {
                    this.show(dz.file(this.fs[i]).content)
                }
            },
            show(f) {
                this.rf.find(".dz-content").append(f)
            }

        };

        dz.file = function (f) {
            let gc = function () {
                let fc = f.type.startsWith("image") ? `<img src="${URL.createObjectURL(f)}" alt="" class="card-img">` :
                    `<video src="${URL.createObjectURL(f)}" loop autoplay muted class="card-img"></video>`;

                fc = $(`
                <div class="col-6">
                     <div class="card">${fc}</div>
                </div>`);
                fc.find("video").on("click", function (e) {
                    e.preventDefault()
                    $("video").not(this).each(function () {
                        this.muted = true;
                    })
                    this.muted = !this.muted;
                    this.volume = .1
                })
                return fc;
            }
            return {
                type: f.type,
                size: f.size,
                content: gc()
            }
        };

        let studio = function (f) {
            return new studio.init(f)
        };
        (studio.init = function (f) {
            this.f = $(f);
        }).prototype = studio.prototype = studio.fn = {
            create: function () {
                let ui = upm();
                ui.uploading()
                let fd = new FormData(this.f[0]);
                let med = this.f.find("[data-media-input]").val();
                if (!med) {
                    e.alert("Select media file (Image/Video)")
                    return
                }
                fd.append("status", this.gfs())
                $.post({
                    url: e.smv_url("_xhr/studio"),
                    data: fd,
                    processData: false,
                    contentType: false
                }).then(res => {
                    if (res.success) {
                        let c = $(res.data)
                        $(".feed-list").prepend(c);
                        e.handle(c);
                        e.post(c)
                    } else {
                        e.alert("Unable to create post!");
                    }
                    ui.terminate()
                })
                this.rs()
            },
            rs() {
                this.f[0].reset();
                this.f.find("[data-dz-display],.creator-input").empty()
                e.studio.close(this.f.closest(".feed-plant")[0])

            },
            gfs() {
                return e.ui.form.process_smart_input(this.f.find(".creator-input"));
            }
        }


        $(document).on("change", "[data-media-input]", function (e) {
            e.preventDefault();
            dz(e, 3).reflect("[data-dz-display]");
        });

        $(document).on("input", ".smart-input", function (ev) {

            let s = $(this);
            if (this.textContent.trim().length > 0)
                s.addClass("has-content")
            else {
                ev.preventDefault();
                s.html("");
                return s.removeClass("has-content");
            }
            ErInput(this);
            // alert(2)
        });
        $(document).on("keydown", ".smart-input", function (ev) {
            if (ev.key === "Enter" && ev.shiftKey) {
                ev.preventDefault();
                const selection = window.getSelection();
                const range = selection.getRangeAt(0);
                let r2 = range.cloneRange();
                const br1 = document.createElement('br');
                const br2 = document.createElement('br');

                range.deleteContents();
                range.insertNode(new Text("\n"));
                range.collapse(false);
                range.insertNode(br1);
                let p = range.commonAncestorContainer;
                p = p.nodeType === 3 ? p.parentNode : p;
                if ($(p).find("br").length === 1) {
                    range.collapse(false)
                    range.insertNode(br2);
                }
                range.collapse(false);
                selection.removeAllRanges();
                selection.addRange(range);
                $(this).data("nl", !0);
            }
        });

        $(document).on("submit", ".form-studio", function (e) {
            e.preventDefault();
            studio(this).create()
        })
    })();
    // zoom
    (() => {
        $(document).on("click", "[data-img-zoom]", function (e) {
            e.preventDefault();
            zoom(this);
        });
        let zoom = function (e) {
            // e = document.querySelector("div")
            e = $(e);


            let o = e.offset()
            let cl = e.clone(),
                bd = $(document.body),
                v = $(`<div class="zoom-container">
                        <div class="zoom-content">
                            <div class="vstack h-100">
                                <div class="hstack py-2 align-items-center border-bottom justify-content-center">
                                    <span class="me-auto"></span>
                                    <span data-header class="fw-bold text-capitalize">Abuti martin</span>
                                    <div class="ms-auto px-4">
                                        <div class="btn rounded-circle bg-secondary-soft-hover p-3 btn-close">
                                        </div>
                                    </div>
                                </div>
                                <div class="vstack align-items-center __pld justify-content-center">
                                        <img src="" alt="">
                                </div>
                            </div>
                        </div>
                    </div>`);


            e.css({opacity: 0});
            let ft = (t) => {
                // alert($(document).scrollTop())
                return t - $(document).scrollTop()
            }
            // console.log(cl.style)
            $(cl).css({
                position: "fixed",
                top: ft(o.top),
                left: o.left,
                "z-index": 1001,
                width: e.width(),
                height: e.height(),
                "border-radius": e.css("border-radius"),
                transition: ".3s"
            });
            bd.append(cl).append(v).addClass("zoom-overlay")
            cl = $(cl);
            let im2 = v.find("img")
            im2.attr("src", cl.attr("src"));
            v.find("[data-header]").text(cl.attr("alt"))
            let o2 = im2.offset();

            im2.css({opacity: 0})
            setTimeout(() => {
                cl.css({
                    width: im2.innerWidth(),
                    height: im2.height(),
                    left: o2.left,
                    top: ft(o2.top),

                });

            });
            setTimeout(() => {
                v.css({opacity: 1});
                cl.css({"border-radius": 0});
            }, 55);
            setTimeout(() => {
                im2.css({opacity: 1});
                cl.css({display: "none"});
            }, 300);

            function n() {
                cl.css({display: "initial"});
                im2.css({opacity: 0});
                o = e.offset()
                cl.css({
                    left: o.left,
                    top: ft(o.top),
                    width: e.width(),
                    height: e.height()
                })
                v.css({opacity: 0});
                bd.removeClass("zoom-overlay")

                setTimeout(() => {
                    cl.css({"border-radius": e.css("border-radius")});
                    v.remove();
                }, 100);
                setTimeout(() => {
                    cl.remove()
                    e.css({opacity: 1})
                }, 320);

            }

            v.on("click", function (e) {
                if ($(e.target).hasClass("__pld")) n();
            }).find(".btn-close").on("click", function (e) {
                e.preventDefault();
                n()
            });


        }

    })();
    (() => {
        /**
         * ErInput
         */
        let er = function (e) {
            return new er.fn.init(e);
        };
        er.prototype = er.fn = {
            constructor: er,
            sv(el) {
                let doc = el.ownerDocument,
                    win = doc.defaultView;
                let range = win.getSelection()
                    .getRangeAt(0);
                let preSelRange = range.cloneRange();
                preSelRange.selectNodeContents(el);
                preSelRange.setEnd(range.startContainer, range.startOffset);
                let start = preSelRange.toString().length;
                return {
                    start: start, end: start + range.toString().length
                }
            },
            mk(el) {
                let txt = el.textContent;

                function o(w, c) {
                    return `<span class="${c}">${w}</span>`;
                }

                el.innerHTML = txt.replace(/(\S+|\s+)/g, function (word) {
                    let n;
                    if ((n = word.match(/\n+/g))) {
                        // alert(
                        let l = n[0].length - 1;
                        return "\n<br>".repeat($(el).data("nl") ? l + 1 : l);
                    }
                    let word1 = word.trim();
                    let isLink = (() => {
                        return word1.startsWith("http://") || word1.startsWith("https://")
                    })();
                    if (isLink)
                        return o(word, "hs-link")
                    else if (word1.startsWith("#") || word1.startsWith("@"))
                        return o(word, "hash-tag")
                    else return o(word, "")
                });
                return this;
            },
            up(e) {
                e.focus();
                if (typeof w.getSelection != "undefined"
                    && typeof w.createRange != "undefined") {
                    let range = w.createRange();
                    range.selectNodeContents(e);
                    range.collapse(false)
                    let sel = w.getSelection();
                    sel.removeAllRanges();
                    sel.addRange(range);
                }
                return this;
            },
            rc(e, s) {
                let saved = s, el = e;
                let charIndex = 0, range = document.createRange();
                range.setStart(el, 0);
                range.collapse(true);
                let stack = [el], node, fStart = false, stop = false;
                while (!stop && (node = stack.pop())) {
                    if (node.nodeType === 3) {
                        let ncI = charIndex + node.length;
                        if (!fStart && saved.start >= charIndex && saved.start <= ncI) {
                            range.setStart(node, saved.start - charIndex);
                            fStart = true;
                        }
                        if (fStart && saved.end >= charIndex && saved.end <= ncI) {
                            range.setEnd(node, saved.end - charIndex)
                            stop = true;
                        }
                        charIndex = ncI;
                    } else {
                        let i = node.childNodes.length;
                        while (i--) {
                            stack.push(node.childNodes[i]);
                        }
                    }
                }
                let sel = window.getSelection();
                sel.removeAllRanges();
                sel.addRange(range)
            }
        };
        (er.fn.init = function (e) {
            let s = this.sv(e);
            this.mk(e).up(e).rc(e, s)
        }).prototype = er.fn;
        w.ErInput = er;
    })();

    (() => {
        let cubic = function (c) {
            return new cubic.init(c);
        };
        (cubic.init = function (e) {
            this.c = e;
            let initialX, ready,
                active = e.find(".try-face.active"),
                cb = e.find(".try-slider"), trn,
                nxt, prev, lock_to, locked, vm = 0,
                zd = this.mo(e);
            spwn();
            km(active)
            let _nd = () => {
                zd = this.mo(e);
            }
            e.on("mousedown", function (ev) {
                initialX = ev.clientX;
                ready = !0;
                _nd()
                nxt = active.next(), prev = active.prev();
                if (prev.length) {
                    prev.addClass("previous");
                    km(prev, -90);
                }
                if (nxt.length) {
                    nxt.addClass("next");
                    km(nxt, 90);
                }
            });
            e.on("click", function (ev) {
                if (trn) return;
                trn = !0;
                let x = Math.abs((ev.clientX - e.offset().left) / cb.width());
                cb.css({transition: ".3s"})
                if (x > 0.2) {
                    if (nxt.length) {
                        os(-90);
                        let tri = $(".try-indicator-item.active");
                        if (tri.next().length)
                            tri.removeClass("active").next().addClass("active")
                        setTimeout(() => {
                            em()
                        }, 250)
                    }
                } else {
                    if (prev.length) {
                        os(90)
                        let tri = $(".try-indicator-item.active");
                        if (tri.prev().length)
                            tri.removeClass("active").prev().addClass("active")
                        setTimeout(() => {
                            em(!0)
                        }, 250)
                    }
                }

                setTimeout(() => {
                    cb.css({transition: "none"});
                    trn = !1;
                }, 300)
            })

            function d(v) {
                return {
                    left: v > 0,
                    right: v < 0
                }
            }

            function os(v) {
                cb.css({transform: `rotateY(${v}deg)`});
            }

            function em(b) {
                if (!b && nxt.length) {
                    active.removeClass("active")
                    active = nxt.toggleClass("next active");
                    cb.removeAttr("style")
                }
                if (b && prev.length) {
                    active.removeClass("active")
                    active = prev.toggleClass("previous active");
                    cb.removeAttr("style")
                }
                km(active)
            }

            function km(a, y = 0) {
                a.css({
                    transform: `rotateY(${y}deg) translateZ(${zd}px)`,
                });
            }

            function spwn() {
                let l = e.find(".try-face").length;
                if (l > 1)
                    for (let i = 0; i < l; i++) {
                        let s = $(`<div class =try-indicator-item>`);
                        e.find(".try-indicator-display").append(s)
                        if (i === 0) s.addClass("active")
                    }
            }


        }).prototype = cubic.prototype = cubic.fn = {
            mo(el) {
                let sld = el.find(".try-slider .try-face"),
                    wd = sld.width();
                return Math.ceil(wd / 2);
            }
        };
        w.cubic = cubic;
        // cubic($(".try-container"));
    })();


    (() => {
        let vf = function (e) {
            return new vf.init(e)
        };
        vf.init = function (t) {
            t = $(t);
            let p = t.closest(".v-fade"),
                ac = t.closest(".v-fade-item"),
                tr = $(t.attr("href") || t.data("bs-target"));

            function dr() {
                return ac.next().is(tr);
            }

            function fwd() {
                ac.toggleClass("previous active");
                tr.css({display: "block"})
                setTimeout(() => {
                    tr.addClass("active")
                });
                setTimeout(() => {
                    tr.removeAttr("style")
                }, 300)
            }

            function rvs() {
                ac.toggleClass("active next");
                tr.css({display: "block"})
                setTimeout(() => {
                    tr.toggleClass("active previous")
                });
                setTimeout(() => {
                    ac.removeClass("next")
                }, 100)
                setTimeout(() => {
                    tr.removeAttr("style")
                }, 300)
            }

            if (dr()) {
                fwd()
            } else rvs()
        }
        w.vFade = vf;
        $(document).on("click", "[data-bs-toggle=vFade]", function (e) {
            e.preventDefault();
            vFade(this);
        });

    })();
    (() => {
        function o(fs) {
            fs.removeClass("open")
            setTimeout(() => {
                fs.find(".form-selector-options").hide();
            }, 150);
        }

        function n(fs) {
            fs.find(".form-selector-options").show()

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
        }).on("click", function (e) {
            if (!$(e.target).closest("[data-form-selector]").length || !$(e.target).hasClass(".form-selector.open")) {
                o($(".form-selector.open"));
            }

        })

    })();
    (() => {
        function get_file_src(files) {
            return URL.createObjectURL(files[0]);
        }

        function cl(d) {
            e.ui.modal(d, "hide");
            setTimeout(() => {
                d.remove();
            }, 300)
        }

        function s(cb) {
            let input = $(`<input type="file" accept="image/*">`).on("change", function (ev) {
                if (!this.value.length) {
                    return $("html").data("fp_ct", null);
                }
                ;
                let d = e.ui.modal(".modal-cropper");
                $("body").append(d);
                e.ui.modal(d, "show");
                SmvCropper(d.find(".smv-cropper"), {
                    src: get_file_src(this.files),
                    onresult: (res) => {
                        cl(d)
                        cb(res);
                    },
                    onclose: () => {
                        cl(d)
                    }
                });


            });
            input[0].click();
        }

        $(document).on("click", ".ersn", function (ev) {
            s(res => {
                $(this).find("img").attr("src", res)
            })
        });
    })();


    $(document).on("submit", ".form-st1", function (ev) {
        ev.preventDefault();
        if (!e.ui.form.empty(this) && !$(this).data("submitting")) {
            $(this).data("submitting", !0);
            let fld = $(this).find(".form-loader").addClass("loading");

            let fd = new FormData(this), pic;
            if ((pic = $("html").data("fp_ct"))) {
                fd.append("profile_pic", pic, "image.png");
                $("html").data("fp_ct", null);
            }
            $.post({
                url: e.smv_url("_xhr/auth?tag=start-up"),
                data: fd,
                processData: false,
                contentType: false
            }).then(res => {
                fld.removeClass("loading");
                $(this).data("submitting", !0);
                if (res.success) {
                    e.alert("You are good to go !", () => {
                        location.href = "/"
                    });
                }
            })
        }
    }).on("click", "[data-smv-toggle=modal]", function (ev) {
        e.ui.modal_default(modal => {
            modal.onClose(function () {

            });
            modal.onStart(function () {
                let cont = e.ui.comp.get("updateTag")
                this.setContent(cont)
            })
        });
    });

    $(document).on("submit", ".form-groupy", function (ev) {
        ev.preventDefault();
        let form = $(this), msg = form.find(".smv-form-errors").hide();

        function addMessage(message, suc) {
            if (!msg.length) return;
            if (suc)
                msg.addClass("smv-success")
            msg.show().find("span").text(message)
        }

        if (e.ui.form.has_empty(this)) {
            addMessage("All fields required.")
            return
        }
        let step = $(this).data("form-step");
        if (!step)
            $(this).data("form-step", 1) && (() => {
                step = 1;
            })();
        let loader = $(this).find(".form-loader").addClass("loading");
        let data = $(this).data("form-data");
        if (!data) {
            data = $(this).serialize();
            $(this).data("form-data", data);
        } else {
            data += "&" + $(this).serialize();
            $(this).data("form-data", data);
        }
        if (form.data("can_send")) {
            if (form.data("action-tag") === "register")
                e.xhr(form.data("action"), data).then(res => {
                    if (res.success)
                        e.flags.to(res.redirect || "self");
                });
            return;
        }
        $.post(
            {
                url: e.smv_url("_xhr/form_register?step=" + $(this).data("form-step")),
                data: data
            }
        ).then(res => {
            loader.removeClass("loading");
            if (res.error) addMessage(res.error);
            if (res.can_send) {
                form.data("can_send", !0);
                let btn = form.find("button[type=submit]");
                btn.text(btn.data("finish-text"));
            }
            if (res.success) {
                let d = $(res.data).html()
                form.find(".smv-groupy-content").html(d);
                form.data("form-step", step + 1);
            }
        })


    }).on("click", ".smv-password-toggler", function (ev) {
        ev.preventDefault()
        let inp = $(this).next(), span = $(this).find("span");
        if (inp.length && inp.attr("type") === "password") {
            inp.attr("type", "text");
            span.html(`<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
              <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8M1.173 8a13 13 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5s3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5s-3.879-1.168-5.168-2.457A13 13 0 0 1 1.172 8z"/>
              <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5M4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0"/>
            </svg>`);
        } else {
            inp.attr("type", "password");
            span.html(`<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-eye-slash" viewBox="0 0 16 16">
                                                  <path d="M13.359 11.238C15.06 9.72 16 8 16 8s-3-5.5-8-5.5a7 7 0 0 0-2.79.588l.77.771A6 6 0 0 1 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13 13 0 0 1 14.828 8q-.086.13-.195.288c-.335.48-.83 1.12-1.465 1.755q-.247.248-.517.486z"/>
                                                  <path d="M11.297 9.176a3.5 3.5 0 0 0-4.474-4.474l.823.823a2.5 2.5 0 0 1 2.829 2.829zm-2.943 1.299.822.822a3.5 3.5 0 0 1-4.474-4.474l.823.823a2.5 2.5 0 0 0 2.829 2.829"/>
                                                  <path d="M3.35 5.47q-.27.24-.518.487A13 13 0 0 0 1.172 8l.195.288c.335.48.83 1.12 1.465 1.755C4.121 11.332 5.881 12.5 8 12.5c.716 0 1.39-.133 2.02-.36l.77.772A7 7 0 0 1 8 13.5C3 13.5 0 8 0 8s.939-1.721 2.641-3.238l.708.709zm10.296 8.884-12-12 .708-.708 12 12z"/>
                                                </svg>`)
        }
        inp.focus();
    }).on("click", "[data-update-link]", function (ev) {
        ev.preventDefault();
        e.prepare($(".update-content").empty());
        e.xhr("update_link", {target: $(this).data("update-link")}).then(res => {
            if (res.success) {
                let d = $(res.data)
                $(".update-content").html(d)
            }
        })
    }).on("click", "[data-smv-toggle=collapse]", function (e) {
        e.preventDefault();
        let it = $(this);
        let t = $(this).data("smv-target") || $(this).attr("href");
        if ($(this).hasClass("show")) {
            $(t).slideUp(200);
            setTimeout(_ => it.removeClass("show"))
        } else {
            $(t).slideDown(200);
            setTimeout(_ => it.addClass("show"), 300)
        }
    }).on("click", "[data-s-p]", function (ev) {
        ev.preventDefault();
        let user = $(this).data("");
        e.ui.modal_default(function (md) {
            let c = $("<div></div>")
            md.content(c)
            e.prepare(c)
            e.xhr("up_manager")
                .then(res => {
                    if (res.success) {
                        let d = $(res.data);
                        c.empty().html(d);
                        mdf(d, md.dismiss)
                    }
                })
        })

        function mdf(d, cb) {
            d.find("[data-tg]").on("click", function (ev) {
                ev.preventDefault()
                let val = $(this).data("v");

                $(".up-search").val(val)
                cb()
            })
        }
    }).on("click", "[data-tg]", function (ev) {
        ev.preventDefault()
        let val = $(this).data("tg"),
            out = $(".up-r-p"),
            target = $(this).data("tg-target");
        e.prepare2(out);
        let bc = ($(this).data("breadcramp") || "").split("/");
        if (bc.length) {
            $(".mdpl .breadcrumb").empty()
            bc.forEach(bcn => {
                $(".mdpl .breadcrumb").append(
                    $(`<li class="breadcrumb-item"><a href="#">${bcn}</a></li>`)
                )
            })
            $(".mdpl .breadcrumb").append(
                $(`<li class="breadcrumb-item"><a href="#">${$(this).text()}</a></li>`)
            )
        }

        e.xhr("update_item_content", {target: val, value: target})
            .then(res => {
                if (res.success) {
                    let data = $(res.data)
                    out.html(data)
                    e.load_posts(0, res.load_posts)
                } else {
                    out.html("")
                }
            })
    }).on("click", "[data-smv-toggle=endbar]", function (ev) {
        ev.preventDefault();
        let bar = $(".main-end-bar"),
            expanded = $(this).attr("aria-expanded") === "true";

        let ic = `<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                      <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
                    </svg>`,
            i_n = `<svg width="30" height="30" viewBox="0 0 24 24" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                           stroke-linejoin="round"></g>
                                        <g id="SVGRepo_iconCarrier">
                                            <g id="Menu / More_Grid_Big">
                                                <g id="Vector">
                                                    <path d="M17 18C17 18.5523 17.4477 19 18 19C18.5523 19 19 18.5523 19 18C19 17.4477 18.5523 17 18 17C17.4477 17 17 17.4477 17 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 18C11 18.5523 11.4477 19 12 19C12.5523 19 13 18.5523 13 18C13 17.4477 12.5523 17 12 17C11.4477 17 11 17.4477 11 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 18C5 18.5523 5.44772 19 6 19C6.55228 19 7 18.5523 7 18C7 17.4477 6.55228 17 6 17C5.44772 17 5 17.4477 5 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M17 12C17 12.5523 17.4477 13 18 13C18.5523 13 19 12.5523 19 12C19 11.4477 18.5523 11 18 11C17.4477 11 17 11.4477 17 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 12C11 12.5523 11.4477 13 12 13C12.5523 13 13 12.5523 13 12C13 11.4477 12.5523 11 12 11C11.4477 11 11 11.4477 11 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 12C5 12.5523 5.44772 13 6 13C6.55228 13 7 12.5523 7 12C7 11.4477 6.55228 11 6 11C5.44772 11 5 11.4477 5 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M17 6C17 6.55228 17.4477 7 18 7C18.5523 7 19 6.55228 19 6C19 5.44772 18.5523 5 18 5C17.4477 5 17 5.44772 17 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 6C11 6.55228 11.4477 7 12 7C12.5523 7 13 6.55228 13 6C13 5.44772 12.5523 5 12 5C11.4477 5 11 5.44772 11 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 6C5 6.55228 5.44772 7 6 7C6.55228 7 7 6.55228 7 6C7 5.44772 6.55228 5 6 5C5.44772 5 5 5.44772 5 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>`;
        if (!expanded) {
            $(this).attr("aria-expanded", true)
            bar.addClass("open");
            $(this).find("i").html(ic);
        } else {
            $(this).attr("aria-expanded", false)
            bar.removeClass("open");
            $(this).find("i").html(i_n);
        }


    }).on("click", "[data-mg-page]", function (ev) {
        ev.preventDefault();
        let content = $(".ep-docs"),
            target = $(this).data("mg-page");
        e.prepare2(content);
        e.xhr("d_page_management", {target})
            .then(res => {
                if (res.success) {
                    let data = $(res.data)
                    content.html(data)
                    e.load_posts(0, res.load_posts)
                }
            })
    }).on("submit", ".ward-user", function (ev) {
        ev.preventDefault();
        e.bar_load();
        let form = $(this),
            modal = form.closest(".modal");
        e.xhr("ward_user", $(this).serialize()).then(res => {
            e.bar_load(!0)
            if (res.success) {
                form[0].reset();
                modal.modal("hide")
            }
        })
    }).on("click", "[data-doc-viewer]", function (ev) {
        ev.preventDefault();
        let modal = e.ui.modal(".modal-doc-view")
            .attr("data-tag", $(this).data("tag"))
        modal.modal("show");
        let file = $(this).data("doc-viewer"),
            filename = file.split('/').pop();
        modal.find(".title").text(filename)
        e.dfl(modal.find(".place-items")[0], file);
        e.post(modal)


    }).on("click", "[data-post-filter]", function (ev) {
        ev.preventDefault();
        e.filter_doc_post($(".feed-filter-docs"), $(this).data("post-filter"))
    })
    ;
    e.on("navigate", function () {
        $("[data-smv-toggle=endbar]").find("i").html(`<svg width="30" height="30" viewBox="0 0 24 24" fill="none"
                                         xmlns="http://www.w3.org/2000/svg">
                                        <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                                        <g id="SVGRepo_tracerCarrier" stroke-linecap="round"
                                           stroke-linejoin="round"></g>
                                        <g id="SVGRepo_iconCarrier">
                                            <g id="Menu / More_Grid_Big">
                                                <g id="Vector">
                                                    <path d="M17 18C17 18.5523 17.4477 19 18 19C18.5523 19 19 18.5523 19 18C19 17.4477 18.5523 17 18 17C17.4477 17 17 17.4477 17 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 18C11 18.5523 11.4477 19 12 19C12.5523 19 13 18.5523 13 18C13 17.4477 12.5523 17 12 17C11.4477 17 11 17.4477 11 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 18C5 18.5523 5.44772 19 6 19C6.55228 19 7 18.5523 7 18C7 17.4477 6.55228 17 6 17C5.44772 17 5 17.4477 5 18Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M17 12C17 12.5523 17.4477 13 18 13C18.5523 13 19 12.5523 19 12C19 11.4477 18.5523 11 18 11C17.4477 11 17 11.4477 17 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 12C11 12.5523 11.4477 13 12 13C12.5523 13 13 12.5523 13 12C13 11.4477 12.5523 11 12 11C11.4477 11 11 11.4477 11 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 12C5 12.5523 5.44772 13 6 13C6.55228 13 7 12.5523 7 12C7 11.4477 6.55228 11 6 11C5.44772 11 5 11.4477 5 12Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M17 6C17 6.55228 17.4477 7 18 7C18.5523 7 19 6.55228 19 6C19 5.44772 18.5523 5 18 5C17.4477 5 17 5.44772 17 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M11 6C11 6.55228 11.4477 7 12 7C12.5523 7 13 6.55228 13 6C13 5.44772 12.5523 5 12 5C11.4477 5 11 5.44772 11 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                    <path d="M5 6C5 6.55228 5.44772 7 6 7C6.55228 7 7 6.55228 7 6C7 5.44772 6.55228 5 6 5C5.44772 5 5 5.44772 5 6Z"
                                                          stroke="#000000" stroke-width="2" stroke-linecap="round"
                                                          stroke-linejoin="round"></path>
                                                </g>
                                            </g>
                                        </g>
                                    </svg>`);
        if ($(".main-end-bar").hasClass("open")) {
            $(".main-end-bar").removeClass("open")
        }
        $("[data-smv-toggle=endbar]").attr("aria-expanded", false)

    })

});