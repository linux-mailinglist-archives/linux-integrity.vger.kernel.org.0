Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B03492D79
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jan 2022 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbiARSgx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jan 2022 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348141AbiARSgx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jan 2022 13:36:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF07C06173E
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 10:36:52 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 188so24813pgf.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jan 2022 10:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iW16hd+cXQQsHyRP7rt+lJ5AICZ50nA5CTVDepKk1SY=;
        b=hkjqRWJ4GTUWf/fA1HqqRNXjXZBRWN0KbJB3mPlHa5YoKLe77jPKhe+wjGQu0WRXnp
         OKWGhgSC2QBrVgvIzuYh8G5csrAG3/M6LoMiY9y0yb9p4hkFmfAoDJFErBjEiWG1Qta5
         9IqRb58Pch9kVolf/Or7Uy7XlFzTIVmZXG018=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iW16hd+cXQQsHyRP7rt+lJ5AICZ50nA5CTVDepKk1SY=;
        b=1N6z65sUUxc7oi7uUy/PR6OKt8238IBpJXGrJtyIlye+lGnHigwhTpgAXHOIFCoKNd
         370YHjnb24xUEDfSQemP3zj5VHt3uRXHdUgfGxdt6Ax7XX51pbKd39vwO70a4zw8DwxI
         6/56lucxNp6rmr4lurnAq2Re6l9OzDqK8/Gdmagkr62k4Q/uhm9rGncfJ49rY2klAt7k
         Y+lf9E3rupLJPWQa4CTIfAEm86DForuNMKvkiRdGTaGJq8vAShvwlKDiiYWSOlo/ZDJ+
         YqA11NPJuj0Af1OLgnnjKrjwZpzSrgNceKhZ+tz9+prilrt8v/WjIC8pGxP838USRbX9
         LMog==
X-Gm-Message-State: AOAM533XYtuPTPg0btadX5kE9WKDZNoIOTJv9pKXA+xAVnGAwNqzytVu
        Rx0HE1OLd3MwlojYxEpSj8m7FA==
X-Google-Smtp-Source: ABdhPJzHBVHEaBUgvGyzi2wXWjc7xsYpLja7zuIEJVM5c8RiYPsKsQrWpZl0npooGeV7ZnjrOCpPVQ==
X-Received: by 2002:a63:7544:: with SMTP id f4mr24302719pgn.556.1642531012435;
        Tue, 18 Jan 2022 10:36:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm5509171pga.18.2022.01.18.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 10:36:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Date:   Tue, 18 Jan 2022 10:36:50 -0800
Message-Id: <20220118183650.3386989-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713; h=from:subject; bh=aQ56F/K9EivD7wwGaVgmtBlfGCGvsRBhNwMsTf+3QQw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh5wjCHVDaUYrsL2fGabA2P1j4qpg2fjljD/IAr3nW n6XxQjuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYecIwgAKCRCJcvTf3G3AJrcHEA CE9wB7dgJGERHXIitTtvTPL1be+tJVDIAl87bB3MwfS4vzZgOWJqNTJ/gt3zjvNgavNIcMn3EOd+ZS y9iiiTsLfmIAb0Yl7TQJgeqRMpKVf8OMPrw12CDawZ0/Ed/fWaFwfXxX8FSxDT5xOV3SsmQpZwRMUg S4JealaQ3hCb053471GPtUlthOGmjB+RKIDV++2l6mLXj0pPMQ31OaXlCuqQ27pUiOWibuVos5awWA ulS24UU3Y7cfuGXOwsOxk1Zwz9JF7Sll/40RKpQPhezoNSa7kDdIiUOwJGBWtvcCXBY09+CkU1AykC PuyAlIwJVkP7xm2to/ky6AuSHnu0a4yK6y1z0I72G3VDWmSWo2O2ocs5nfGkDWGGwSmU6SChFcGOC5 pTb3qlaHupazqOOyJSV0hBBMby4GXrSQbXA+giMXA4LfDQF2TwRo5Se5+X5FOk0mgMMPshtQ5chJnZ 6ORLeitCZgEP7QMFLJzVl675Htd6W7dOkSsyhlS0xZ/cGLnafcF2vtyXqgYtDfvnRYgbQDvyj93rb4 LulMmcwhdjpBt+w4rxDmrn321EciKzWZPJSdQrMWapDhDO7D+Xah5e87OvA93AdO1uXziDO8l9edfv HtrRkEQAIgGP/gYGiDdrF8oIGSACvoLIsNcLL7s+T0dsj/jzdeTZCYq2cFSw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When building with -Warray-bounds, this warning was emitted:

In function 'memset',
    inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
[-Warray-bounds]
   43 | #define __underlying_memset     __builtin_memset
      |                                 ^

There was no checking of the req_len value. To keep this code robust,
and to silence the compiler warning, check the size before attempting
a memset().

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/lkml/4b59d305-6858-1514-751a-37853ad777be@linux.ibm.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220113002727.3709495-1-keescook@chromium.org
v2: make commit log more accurate, add Reviewed-by
---
 drivers/char/tpm/tpm_vtpm_proxy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 91c772e38bb5..5c865987ba5c 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -91,7 +91,7 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
 
 	len = proxy_dev->req_len;
 
-	if (count < len) {
+	if (count < len || len > sizeof(proxy_dev->buffer)) {
 		mutex_unlock(&proxy_dev->buf_lock);
 		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
 			 count, len);
-- 
2.30.2

