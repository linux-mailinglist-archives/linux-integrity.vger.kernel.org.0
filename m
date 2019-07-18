Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5226CD53
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 13:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbfGRLZw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 07:25:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35850 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbfGRLZw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 07:25:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so12766984pgm.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vl9Wpi/Syv/6aGqe6I7JLyQ+9QJLPAtQrqCkcLZrp+g=;
        b=ZVxxx4aH7tiwIZZX6ha29tmaFr6/HgoWPmFp2Qrs2EBIVLFKHFPUCqqsTn9SOPG1iT
         DdwYoh82VbeiWbEJqbD9K4JQr1TV1v5X3pYrVjc8cbKNRuzd6+00QDYJebqZgkIVmaju
         v1SOPO2aq0jjSzEAxxJMpbecMn0bOxA3BJZ2CGYHs6pq+gs680AL+PREqHTBYUZHpWzZ
         Pf4mEnUkopEFVbmCId0DIOmoNAnBH4sscjRHsKa4Tk3K4JtdU/CPHjXEvdZLU7/+T/8p
         pfhj+vcX1FPtLs6uhKljY0oWWIJLof6uonJBx88IdwFIMSfq9UVJd3+BBxU8khso7Mfj
         RsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vl9Wpi/Syv/6aGqe6I7JLyQ+9QJLPAtQrqCkcLZrp+g=;
        b=t4lWoMCxkUFQmKCUa+IiGEHkHlxxCNOYVEZ0RBPRvH3Y9qYMM0LdM0NcWDmNTPcIYd
         mLTE+R1DZcdsmuYmTjadr9UN/G/lYMvNsryy6AF9nhI+Mc+7kSPOPxqZ/SCDObcFhitV
         +LFU8LrqNzG4sS7bxN/BEBPdh0Rz+WpeLHLP8yP0hqKtRh+ExEfJ7fiZYlGEMsArfG/6
         t/bhytBak9x8upwP1BR9N+KluX9WCkYXwe0+J8dw24e/oU/cQ93LJq/ePFwBRwvGgBhm
         IkPWmorWCLy/dpNJ2KJaEO1yfs7uh0s0aOLzWLAjzfZZIrdzwz1dH/8AYpbDs5Nskz5J
         kEag==
X-Gm-Message-State: APjAAAXqQAW1NAc21/3/C41FI+8JamMEYrdVs0P6HEkQrMzUh/o2V1QS
        aG1uoK7sgJpZv5Bf8S/+t9zERQ==
X-Google-Smtp-Source: APXvYqxf3gavFVQkl+Tf0/f74JuJjIbVpT5K6OoQiIkeSyC2aPMIrLFXOyzOaXm/Eatr2V/nLYw0Ug==
X-Received: by 2002:a63:5c15:: with SMTP id q21mr25567919pgb.199.1563449151425;
        Thu, 18 Jul 2019 04:25:51 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.63])
        by smtp.gmail.com with ESMTPSA id 3sm29648436pfg.186.2019.07.18.04.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jul 2019 04:25:50 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jejb@linux.ibm.com,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        ard.biesheuvel@linaro.org, daniel.thompson@linaro.org,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [RFC/RFT v2 1/2] KEYS: trusted: create trusted keys subsystem
Date:   Thu, 18 Jul 2019 16:54:45 +0530
Message-Id: <1563449086-13183-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
References: <1563449086-13183-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move existing code to trusted keys subsystem. Also, rename files with
"tpm" as suffix which provides the underlying implementation.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 crypto/asymmetric_keys/asym_tpm.c                       | 2 +-
 include/keys/{trusted.h => trusted_tpm.h}               | 4 ++--
 security/keys/Makefile                                  | 2 +-
 security/keys/trusted-keys/Makefile                     | 6 ++++++
 security/keys/{trusted.c => trusted-keys/trusted-tpm.c} | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (98%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted-tpm.c} (99%)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index 76d2ce3..ec3f309 100644
--- a/crypto/asymmetric_keys/asym_tpm.c
+++ b/crypto/asymmetric_keys/asym_tpm.c
@@ -13,7 +13,7 @@
 #include <crypto/sha.h>
 #include <asm/unaligned.h>
 #include <keys/asymmetric-subtype.h>
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 #include <crypto/asym_tpm_subtype.h>
 #include <crypto/public_key.h>
 
diff --git a/include/keys/trusted.h b/include/keys/trusted_tpm.h
similarity index 98%
rename from include/keys/trusted.h
rename to include/keys/trusted_tpm.h
index 0071298..7d7b108 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted_tpm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TRUSTED_KEY_H
-#define __TRUSTED_KEY_H
+#ifndef __TRUSTED_TPM_H
+#define __TRUSTED_TPM_H
 
 /* implementation specific TPM constants */
 #define MAX_BUF_SIZE			1024
diff --git a/security/keys/Makefile b/security/keys/Makefile
index 9cef540..074f275 100644
--- a/security/keys/Makefile
+++ b/security/keys/Makefile
@@ -28,5 +28,5 @@ obj-$(CONFIG_ASYMMETRIC_KEY_TYPE) += keyctl_pkey.o
 # Key types
 #
 obj-$(CONFIG_BIG_KEYS) += big_key.o
-obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+obj-$(CONFIG_TRUSTED_KEYS) += trusted-keys/
 obj-$(CONFIG_ENCRYPTED_KEYS) += encrypted-keys/
diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
new file mode 100644
index 0000000..ad34d17
--- /dev/null
+++ b/security/keys/trusted-keys/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for trusted keys
+#
+
+obj-$(CONFIG_TRUSTED_KEYS) += trusted-tpm.o
diff --git a/security/keys/trusted.c b/security/keys/trusted-keys/trusted-tpm.c
similarity index 99%
rename from security/keys/trusted.c
rename to security/keys/trusted-keys/trusted-tpm.c
index 9a94672..b7e53a3 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted-keys/trusted-tpm.c
@@ -27,7 +27,7 @@
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
-- 
2.7.4

