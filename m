Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3F494019
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jan 2022 19:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356877AbiASSn7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jan 2022 13:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356833AbiASSn6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jan 2022 13:43:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADEC06161C
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jan 2022 10:43:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v11-20020a17090a520b00b001b512482f36so617194pjh.3
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jan 2022 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf8NqUotnPuLOWKkBWsY7N81hJI6QC97c/XS/gK1dQY=;
        b=N11ilHklzSQ0WWZfPdc6FtRUXJEdv0DcNOeFFxW6n8UwZ6OBlsA41AZ5W6YfGpPZie
         hLnDFxME2FPL8SCyEnpHfiMyvAjK5WJYQUeLgwO5x4P3hj4gOVSl1jCZxc+tP2mBGdnQ
         nOiQWgORh9ni/MDeF86SNSP9VS0es0qqzEmjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Jf8NqUotnPuLOWKkBWsY7N81hJI6QC97c/XS/gK1dQY=;
        b=u56GDUIkOcbQkIAtI2t5EQt3q0uEJ3XaAklgStDbRqru2h1cb21Tt9qGMztpyVjrAe
         ButfmZ+Bicf4NgExPIGtaJPlzpBBTqtiq431uE/LSJ0xVv/CHVXBruPRvwTYu2799k2y
         I8vY3KPq43r5X2IVhO5XKyaRwm6K9sNFz6Vex4upiakfMFWK0zh0J9xP8CI/WA8C3zk8
         vnBfwkVxuDZjVg/aynoESaqI9ZrAEaoEQDRONxJnKrAQz+MHUVuG19ldNOfbFARYJIb3
         GoY+ovcK5Gy9Ek7NvuCTSPi0Bi+STIuKgb57HWP5AisfQx0r60H5dOuV7yaAfNB3bA6Z
         xAKA==
X-Gm-Message-State: AOAM5321PefyBFiJHo5LlgRh/EDV/rrQ6zpIjbA2grsnI1mAXhoxkMed
        HxJ4lTP3zlG8njebcPz+Yfr/9w==
X-Google-Smtp-Source: ABdhPJyj7rW9pev+19vkk1VY5IFms56pLKvuPJZzE3rnS4Rp81EcueRnKnSBiRJV3777NFMGoInxwA==
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr5873335pjs.41.1642617837196;
        Wed, 19 Jan 2022 10:43:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm430620pfe.20.2022.01.19.10.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:43:56 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] tpm: vtpm_proxy: Check length to avoid compiler warning
Date:   Wed, 19 Jan 2022 10:43:54 -0800
Message-Id: <20220119184354.3367603-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2200; h=from:subject; bh=FIuPYqfJGsu4u4fPlDiJiKGwPnqpxta/IfVuwmIgSHA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh6FvpqUwHqXWWTKf52yeH1LE75+2AeiESR7YMnXap ySxSr4eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYehb6QAKCRCJcvTf3G3AJnOOD/ kBaMTOE3rFxJhqQiUJQqXi842KK2oyPTv7vXm9evBfQQ869APWfk/2BMgwO+jwdCl74tn9O0zWVg8z V+QnZSbLG4OLBXpn37q9PkB6cX06ZBiEeNNXor6nFEisZ3mOu25ecEaDsS3vUdTYcObjFKA9+/qHo9 KmRU1hBolXTp59eoCGkt9fWWDEMNXfcnz/O8a50cjOFMWI05O/0m2x9Q+JzVRpCKhmqH31mGNAJz3U mT3qYf/lKuUWnK5JZX/1pivFIzm3R8F3+SiQPSzlmPmmjI/XnEsjqo6lSvFZyYEfwSYkv7LJiqfAy5 ztIGElJRu+U+kL9cuaDxpUXP9IyNR+aDrdU4INhOyfjSbUS4ct+4xIv7YjOFyqI/9U3Jx/CalcYHet fDSFRVR+yklGYhHeiVDVmNA9kuwRWq97/IveqifJ71fJE7RK9TmO+GrD/5B9rewgjs8iL5WSGpetaU 5wuoV0W3L8oj5rim+ADX/c+xh/7V906rk2UJzcobRmjg/IzUPxYMPZjtxK0hQEJKlPk81KbwDconmS NVc+WN7KgkgL384tnmByElenJG41lFW5oy8pHSnnezm2g0Tfeo+kzFWYRw5RvoPQ7EBtb1uvmMmKEo yRfVCvq8hErY4dKJns87ys7J3CdF5Vnem5UDKkLVFir5+mD2VaPbTiBJ04tw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When building with -Warray-bounds under GCC 11.2, this warning was
emitted:

In function 'memset',
    inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
[-Warray-bounds]
   43 | #define __underlying_memset     __builtin_memset
      |                                 ^

This warning appears to be triggered due to the "count < len"
check in vtpm_proxy_fops_read() splitting the CFG[1], and the compiler
attempting to reason about the possible value range in len compared
to the buffer size.

In order to silence this warning, and to keep this code robust if the
use of proxy_dev->req_len ever changes in the future, explicitly check
the size of len before reaching the memset().

[1] https://lore.kernel.org/lkml/CAG48ez1iTF9KegKJrW5a3WzXgCPZJ73nS2_e5esKJRppdzvv8g@mail.gmail.com

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/lkml/4b59d305-6858-1514-751a-37853ad777be@linux.ibm.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220113002727.3709495-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220118183650.3386989-1-keescook@chromium.org
v3: Add more details to the commit log, including a link to Jann's analysis
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

