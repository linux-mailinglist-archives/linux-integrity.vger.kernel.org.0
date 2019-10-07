Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F49CDB66
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Oct 2019 07:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfJGF1M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Oct 2019 01:27:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37519 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfJGF1L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Oct 2019 01:27:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so5696413pgi.4
        for <linux-integrity@vger.kernel.org>; Sun, 06 Oct 2019 22:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=81Smj8hEjVGZHa4t6tbqbgnCLHuFdqzlQro1oH/HrWE=;
        b=h/O3xMpUwWq/84IHsFn0f1wsmeFp6l/lXM6wk1IKB2yFpbWbFwgsGKF07b6Oy1bNaw
         98+TuHEY5HGOKxMvjQ7UM9BXpiEeIY/E4awa0Gw1SQlgYWZsdh7deVaJzeXY/ya9EmrL
         xtLzQPW2k6jFmhDKK6j/aJ5Y5ZWSM8gwizf5J/K5GpyZn3z8Aij7XudOFnPFgOjEjoa8
         Qasoj27SoitHl/kyZNOQEgV1He5ai5BqSslxqtESb1kDV4BU7/Tw2Jf5vAkNLvOl8RbM
         4WMu3k/HtYhQ3uaF18NZE7ukIzNLQzkrhlHsylHC/LnLoFl9kJjawSezDlgDSn6d1GV7
         kpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=81Smj8hEjVGZHa4t6tbqbgnCLHuFdqzlQro1oH/HrWE=;
        b=UK44XebY2Uj3LzsWq/Kvd905hA0NWu/p6L1j/8S+EFZ5np3yPTzBcxxNZnJ622pgbR
         mMbhEFaONL4a/5/5MakyxRphbVKPtSLzncRnT8iHZh/GDa3blbL7kzIKHdkkUSER/7yA
         Mq2ZGaMiLX20QbINndzaiw0MLWvP5Qv8jN8wbwAM/08LhwMPDGB8mQR324PbRug6OlyR
         0YO/lPIPC6WVzm4r6+LdTxWZfGX1b+g7sW1RealEktEUct3AfLzPnE4l84S2Yq2QAlWQ
         ssTqKX+q9JfNJDX3CiGqmADUf1/A4fapP++BLLvyEtFkqnFBOr76WZ+Uu3MLYBhkdRmi
         sq8Q==
X-Gm-Message-State: APjAAAXF5xV6Gj3txpdrzsGSlKzNsB30yP5zUam4QTAshPUjPLUZN9zZ
        St525t+ziLjgW1wj5lg8YkFZuQ==
X-Google-Smtp-Source: APXvYqyRNqJ06//nRMubKhETtxAwMtTO1w4GuLHFW5ezS0nHTQ6j61rcYui0PinfddcGIRIFiqS5gg==
X-Received: by 2002:a17:90a:65c8:: with SMTP id i8mr30974101pjs.51.1570426029641;
        Sun, 06 Oct 2019 22:27:09 -0700 (PDT)
Received: from localhost.localdomain ([117.252.65.194])
        by smtp.gmail.com with ESMTPSA id x9sm15895448pje.27.2019.10.06.22.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Oct 2019 22:27:08 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v7 3/4] KEYS: trusted: Create trusted keys subsystem
Date:   Mon,  7 Oct 2019 10:55:34 +0530
Message-Id: <1570425935-7435-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move existing code to trusted keys subsystem. Also, rename files with
"tpm" as suffix which provides the underlying implementation.

Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 crypto/asymmetric_keys/asym_tpm.c                        | 2 +-
 include/Kbuild                                           | 1 -
 include/keys/{trusted.h => trusted_tpm.h}                | 7 +++++--
 security/keys/Makefile                                   | 2 +-
 security/keys/trusted-keys/Makefile                      | 7 +++++++
 security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} | 2 +-
 6 files changed, 15 insertions(+), 6 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (96%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (99%)

diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
index a2b2a61..d16d893 100644
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
 
diff --git a/include/Kbuild b/include/Kbuild
index ffba794..6f9ec5a 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -65,7 +65,6 @@ header-test-			+= keys/asymmetric-subtype.h
 header-test-			+= keys/asymmetric-type.h
 header-test-			+= keys/big_key-type.h
 header-test-			+= keys/request_key_auth-type.h
-header-test-			+= keys/trusted.h
 header-test-			+= kvm/arm_arch_timer.h
 header-test-			+= kvm/arm_pmu.h
 header-test-$(CONFIG_ARM)	+= kvm/arm_psci.h
diff --git a/include/keys/trusted.h b/include/keys/trusted_tpm.h
similarity index 96%
rename from include/keys/trusted.h
rename to include/keys/trusted_tpm.h
index 29e3e9b..7b9d7b4 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted_tpm.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __TRUSTED_KEY_H
-#define __TRUSTED_KEY_H
+#ifndef __TRUSTED_TPM_H
+#define __TRUSTED_TPM_H
+
+#include <keys/trusted-type.h>
+#include <linux/tpm_command.h>
 
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
index 0000000..1a24680
--- /dev/null
+++ b/security/keys/trusted-keys/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for trusted keys
+#
+
+obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
+trusted-y += trusted_tpm1.o
diff --git a/security/keys/trusted.c b/security/keys/trusted-keys/trusted_tpm1.c
similarity index 99%
rename from security/keys/trusted.c
rename to security/keys/trusted-keys/trusted_tpm1.c
index 7071011..e3155fd 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -27,7 +27,7 @@
 #include <linux/tpm.h>
 #include <linux/tpm_command.h>
 
-#include <keys/trusted.h>
+#include <keys/trusted_tpm.h>
 
 static const char hmac_alg[] = "hmac(sha1)";
 static const char hash_alg[] = "sha1";
-- 
2.7.4

