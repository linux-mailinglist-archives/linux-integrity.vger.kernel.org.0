Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A614D48CFA6
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 01:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiAMA1b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jan 2022 19:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiAMA1a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jan 2022 19:27:30 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35566C06173F
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jan 2022 16:27:30 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso15738707pjo.5
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jan 2022 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnWdHb/O4tg2rZy0DeOCwdDNZkf1ttSr6PBlJ/VLHgk=;
        b=e6XWspE1KVaal2tHOEmNdeId93XRO18ynm35iGb6jMs0XmVKjWv8XAyXQFI3rRFrbj
         LQVptWt+OY61VaozdFa6MV593rWbu3A7qRXeiLp5fkCOuocoJVDdAWhCZx65+fmIFiuG
         DSOb8PSq4bZbrXkRq7TPlKD2anrZfuqMfofJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BnWdHb/O4tg2rZy0DeOCwdDNZkf1ttSr6PBlJ/VLHgk=;
        b=cpTD4BWFv5qmnc2c0A5+cdi0zlVMdLxj0lHmshPY3F2XX6uYycAeC7qPsR7yz6EV6d
         aJYGnPIGGhaj2gH5i9JhUNwGmpaPdHWZELO6zZiHsEyLiL0TYkAs9iGYe6pYRHPWFOq+
         K0nQvmuQTJMNfHI/CBuhS8QCNWCEGxjNHsCK5FiDndJk7h+GoarPSN66vCIUgYs2xT3E
         1jl/35Ll4Royf8JwEwuKRSCpBBPhHVBsChtA6XbUEhrlZLVKsitDtpGl0FPtlQ/rKXd1
         7jauKcCD7Va5MfnKXXvHJ/WxTD6OXFpKkyEiSEzFHKh62NJKrfuAFUEsR9n7WXReeraP
         XmCQ==
X-Gm-Message-State: AOAM533Ch/tC34oi0FeMUW0anKuo6tZECOmBKQQW36Tr94/ODfFeSBA3
        JNN1Gt/LrmAZ1aistJpko5ExDw==
X-Google-Smtp-Source: ABdhPJwH9+x+rvKqh/pxtdiEk+Bph9GI+MIDGw2BkHfsOYUgQm8RXBA8sZZmZ7eYjFQSKgZ86re+yQ==
X-Received: by 2002:a17:902:8345:b0:14a:1a98:4288 with SMTP id z5-20020a170902834500b0014a1a984288mr2172148pln.79.1642033649636;
        Wed, 12 Jan 2022 16:27:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l21sm666438pgk.41.2022.01.12.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 16:27:29 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] tpm: vtpm_proxy: Avoid device-originated buffer overflow
Date:   Wed, 12 Jan 2022 16:27:27 -0800
Message-Id: <20220113002727.3709495-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465; h=from:subject; bh=/0wOI/ECBPLd8YZPRwoi2hotPW3s6qwXwBX0NNQI6Ig=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBh33Hv5dMkyjt5VdVIF846gjbAf8rxOtNrn4wK2JlU yiUqQcCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYd9x7wAKCRCJcvTf3G3AJgewD/ 42BxF4A8IwxjMvJ+KeG4mIf/ZKbHUEJcblSgWPbvnI6gZ4o64fFPYuS8ftfl+HScbhDdJ8lpu45CKP y8kRbESOrriCvGILlgRqUvbONa4B+LkRNI0vBdC8Ei8+98SBdfxu2XSd8D9lI/QIlS1ggzaj+G1hjq e7Qx7jnoyxkyGeiZX041f3fZ/tNVFMColUoTywf1TrydJuGr3p91zjn8h8H40PNMTiQzPQqPJqxO2X x5Cwyd7d9Ra3zXhjdakphZd0FQGSIUlKjh4NW7j9H8WijwkQHYZ/reFNUveuA+PapEwU9AwFKDNYex 4AyMFEFpTa48K8bfgkqZSGkcDdpJMMZx+Z7j7woe9acA/UQMC+VhXrFdYfbOheZZSCl5ghz0T8psIw Tz0hVnIUWtidc67EHRDqSoVv5FGaC4V9OQuq6/IG1HhEUJOI/ZLQhOMVKyB0heOl2QvAikKr/hv4nW XTrpgcB67Qk93LD1qKCTloRrwgSQMRFY0WNxFUoiixcpFaM+vMui11RwiC+ZaU7O/M7nE0FL9oJe6F pysduZHlM1spUk5yE/eZz9S70N3oks9HRnKQOwaM00irRHnFVR2gBPNIV9Rpbu47OQBWoM2hDWoTv2 alVJANPvn6XP/cF/evAcbOhrCUBdiBie0UnC9J1MKP8rWctjgppuF7AaF0zg==
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

There was no checking of the req_len value from the device. A malicious
(or buggy) device could end up leaking (and when wiping) memory contents
beyond the end of the proxy buffer.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
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

