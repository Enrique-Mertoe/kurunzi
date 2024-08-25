!function (e,f){
    f(e)
}(window,function (w){
    ((w) => {
        /**
         * SMV Cropper js v-1
         */
        let crp = function (e, callback) {
            return new crp.fn.init(e, callback)
        }
        crp.prototype = crp.fn = {
            constructor: crp,
            set_source(src, a, b) {
                a.src = src;
                b.src = src;
            }
        };
        (crp.fn.init = function (ctn, cb) {
            ctn = $(ctn);
            let cand = false, startX, startY;
            let md = ctn.find(".media-drag img"),
                ms = ctn.find(".media-static img");
            this.set_source(cb.src, md[0], ms[0])
            let mdc = ctn.find(".media-drag"),
                cont = ctn.find(".smv-cropper-media"),
                close = ctn.find("[data-bs-dismiss=modal]"),
                iniY = mdc.offset().top - md.offset().top,
                iniX = mdc.offset().left - md.offset().left,
                lastY = 0, lastX = 0, sc = 1;

            setTimeout(() => {
                iniY = mdc.offset().top - md.offset().top;
                iniX = mdc.offset().left - md.offset().left
            }, 200);
            ctn.on("contextmenu", function (e) {
                e.preventDefault();
            });
            cont.on("mousedown", function (e) {
                cand = true;
                startX = (e.clientX - lastX);
                startY = (e.clientY - lastY);
            });
            $(document).on("mouseup", function () {
                cand = false;
            });
            $(document).on("mousemove", function (e) {
                if (cand) {
                    let newX = e.clientX - startX;
                    let newY = e.clientY - startY;
                    // Calculate boundaries
                    let minX = -iniX,
                        maxX = -minX,
                        maxY = iniY,
                        minY = -maxY;

                    newX = Math.max(minX, Math.min(newX, maxX));
                    newY = Math.max(minY, Math.min(newY, maxY));
                    lastX = newX;
                    lastY = newY
                    ms.css({
                        transform: `translate(${newX}px, ${newY}px)`,
                    });
                    md.css({
                        transform: `translate(${newX}px, ${newY}px)`,
                    });
                }
            });

            function nMax() {
                return md.width() >= mdc.width() || md.height() >= mdc.height();
            }

            ctn.find("[data-action-zoom]").on("click", function (e) {
                e.preventDefault();
                e.stopPropagation();
                let w1 = ms.width() * sc, h1 = ms.height() * sc,
                    hm = mdc.height();
                let w_max = Math.max(hm, Math.min(w1, w1 * 3));
                let h_max = Math.max(hm, Math.min(h1, h1 * 2));
                let v = Number($(this).data("action-zoom"));
                if ((w_max === hm || h_max === hm) && v < 0) {
                    console.log(w_max, h_max)
                    return
                }

                sc = sc + (0.05 * v);
                let s_min = Math.max(hm / ms.height(), hm / ms.width());
                sc = Math.max(s_min, Math.min(sc, 2));


                function n1() {
                    let referenceDiv = mdc[0],
                        scaledDiv = ms[0]

                    // Get dimensions and position
                    const refRect = referenceDiv.getBoundingClientRect();
                    const scaledRect = scaledDiv.getBoundingClientRect();
                    // Ensure scaledDiv stays within referenceDiv boundaries
                    const offsetX = Math.max(0, refRect.left - scaledRect.left);
                    const offsetY = Math.max(0, refRect.top - scaledRect.top);
                    return [offsetX, offsetY];
                }

                [ms, md].forEach(el => {
                    el.css({
                        scale: sc,

                    });

                });
                let [x, y] = n1();
                if (x <= 2 || y <= 2) {
                    [ms, md].forEach(el => {
                        el.css({
                            transform: `translate(0,0)`
                        })
                    });
                    iniY=iniX=0;
                } else {
                    iniY = (mdc.offset().top - ms.offset().top) / sc;
                    iniX = (mdc.offset().left - ms.offset().left) / sc;
                    lastX = lastX / sc;
                    lastY = (lastY / s_min);
                }
            });
            close.on("click", function (ev) {
                if (cb.onclose) cb.onclose();
            });
            $("#resize-btn").on("click", function () {
                const canvas = document.createElement("canvas");
                const ctx = canvas.getContext("2d");
                const img = md[0];
                if (!img) {
                    console.error("Image element not found.");
                    return;
                }
                let img1 = new Image();
                img1.src = img.src;
                let scale = img1.naturalWidth / ms.width();

                const cropSize = mdc.width(); // Square size
                canvas.width = cropSize;
                canvas.height = cropSize;
                let x = mdc.offset().left - ms.offset().left;
                let y = mdc.offset().top - ms.offset().top;
                ctx.drawImage(img1, x * scale / sc, y * scale / sc, cropSize * scale / sc, cropSize * scale / sc, 0, 0, cropSize, cropSize);
                canvas.toBlob(function (blob) {
                    $("html").data("fp_ct", blob);
                })
                const croppedImage = canvas.toDataURL("image/png");
                if (cb.onresult) cb.onresult(croppedImage);
            });
        }).prototype = crp.fn;
        w.SmvCropper = crp;
    })(window);
});