Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1E04AA0E0
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Feb 2022 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbiBDUGe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Feb 2022 15:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiBDUFm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Feb 2022 15:05:42 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E1C06136C;
        Fri,  4 Feb 2022 12:03:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d1so6054481plh.10;
        Fri, 04 Feb 2022 12:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+08pbFHIVqXtRgCRGwgS5N246tIcG+TXD3qRf9F36iw=;
        b=bLChGjEp7XV+zCb/FoJ9GfumEeTQWfhFGQCoozOt3GnA1ZXGkTjabAXozjimyeJn1E
         KN2x0h03YqXAJQmemhmLMK7okFXx4aG2gL5N6AWKYUDXP1Ib1G4nAU2XgE3FGJ+wsvjj
         PGUfpzMeb1mb0aKI88uLnyw5CsZwBhyV0VrhBy5N1s0jJOHsPL2D2O8d7btnmdOFGqnB
         fx6wlJdnJl1E7gOjFZ6GP52rdS/oQZQLapgi9XCzKIZnrA181p16a+chsTEUl9wSXTyx
         ETGS8vKjjgZ8YX+HpnxaVfRPSf+gis1Dnajdx/0RKyGQUonpOIhQG957i7ifE5G+xoj1
         gkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+08pbFHIVqXtRgCRGwgS5N246tIcG+TXD3qRf9F36iw=;
        b=DECZBPaF/I52tITQN8euI+K+lUzvWCmjwzOxaEpHL9Ivib970AUYGt385Ex6F+sFEH
         XlPjB/3XPZ+KREes9/Bk1t4rArdyXQXjINXXF6SWJ5gxo6aErn4NMhT9aFt4yp0qTkUq
         r8ybgR7fXFarN6dRWpEJgvfrkFVzLK9Bpo7JgGy/S01xduJdBInjpL+cswlAUQUBCxOV
         GmAb6t1f1ptUJRFjM1vQSg2VWzthFoAJkU9Gy2RzNE+XTjOmbA3xYfeFORrQU+lzJ+FP
         RELaCe4cdB3TQDdeQDyiBZI10OiMSjfckLKvxRmHE8+vmC0ZB0Y1WXocSQHZIC5Qe7no
         sv+Q==
X-Gm-Message-State: AOAM530RWTAaj9eJ8/44Z+J1JHw28QqeAcuK1+2W8ZLJO0E2HEgWClGs
        5GtQSTT0rnLehFpsFDMlpbBFoJ1f5v8P5g==
X-Google-Smtp-Source: ABdhPJxOMEo7JDvh78IhN7RDJ9a8jI4xihXjuwfJFEvaRs/On+QYsASo2DZPyYweZMIZSPRYqbB06A==
X-Received: by 2002:a17:902:c209:: with SMTP id 9mr4714497pll.119.1644005039317;
        Fri, 04 Feb 2022 12:03:59 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id j18sm3782566pfj.13.2022.02.04.12.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:03:58 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] KEYS: trusted: fix crash when TPM/TEE are built as module
Date:   Fri,  4 Feb 2022 12:03:42 -0800
Message-Id: <20220204200342.48665-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

when TCG_TPM and TEE are built as module, trusted_key_sources will be an
empty array, loading it won't do what it is supposed to do and unloading
it will cause kernel crash.

To reproduce:
$ modprobe trusted
$ modprobe -r trusted

[  173.749423] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[  173.755268] Backtrace:
[  173.755378]  cleanup_trusted [trusted] from sys_delete_module+0x15c/0x22c
[  173.755589]  sys_delete_module from ret_fast_syscall+0x0/0x1c

To fix this issue, we also need to check CONFIG_TCG_TPM_MODULE and
CONFIG_TEE_MODULE.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 security/keys/trusted-keys/trusted_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index d5c891d8d353..b3a3b2f2d4a4 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
 MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
 
 static const struct trusted_key_source trusted_key_sources[] = {
-#if defined(CONFIG_TCG_TPM)
+#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 	{ "tpm", &trusted_key_tpm_ops },
 #endif
-#if defined(CONFIG_TEE)
+#if defined(CONFIG_TEE) || defined(CONFIG_TEE_MODULE)
 	{ "tee", &trusted_key_tee_ops },
 #endif
 };
-- 
2.25.1

