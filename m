Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6B5FE559
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJMWhA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMWg7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:36:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808A4BA938
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c24so3121871plo.3
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKnBh/rdccA0d/5kVDkVm6ZffK/rrsQm1/mENkeAGwY=;
        b=MRwg26DsZVrrk+VGAgo/rSdkC/qC7KiEipRVjOFTuBqV9YnpOxXq7E9su5tYXVzB5g
         nYaDzinYZhQP2TEUi4jYSOCbNfOziDti66Jt/gbuqcSNDZW1aI5wNfEX4pS1AlWJoAkB
         n3TZsGwPtpDgaZdB04jwByap6i2mjq1+rmKSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKnBh/rdccA0d/5kVDkVm6ZffK/rrsQm1/mENkeAGwY=;
        b=ChxFvCPnMC4sNwY8vSezWb60ALxvWGpd9PxjQho+e2wYcrwV5KILOiGcVauVHaOFhO
         +f6ZHTymmrxvR634r+wRYrCcpzInXDZKklCk7DASnskQrRBImK7sBXgc0c3SCaHEnO9Q
         xa5Cr3kgKRd5Dt8t9NNqAAOa/8GXy0AWo8v0rgVsvzlywwIpGfKaGKCu3efs8zQf9Zsa
         om3WNVtCmzjnBV1QPWcFucrlfv9dVslqN0pFT7UIsxIcyW1i/t3YD3YSbHIv79KfcuCu
         yIHbeE5EKBydHAkHkFxlO6MG68u8HQb/D/82n5GjYz5/eXM9IYkk0Sv0Jmkug8UlATgj
         1RUw==
X-Gm-Message-State: ACrzQf04T8tYEAPUf40cYc07wK/YvmxldxSHX2QfB4BIvxaXGI3rGmG7
        xlxBvmEi4joQKzJaX7Q31Mncjw==
X-Google-Smtp-Source: AMsMyM6AR8Y27aSqTIfnLE/BszoK27vRlaEd7LbSvPopybAXc6YTPDuZpOauIOTSzwLP5wpPYw1+Fw==
X-Received: by 2002:a17:90b:4b47:b0:20a:cfcb:8561 with SMTP id mi7-20020a17090b4b4700b0020acfcb8561mr2139159pjb.55.1665700616917;
        Thu, 13 Oct 2022 15:36:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902dacd00b00176a715653dsm336002plx.145.2022.10.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:36:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 1/9] integrity: Prepare for having "ima" and "evm" available in "integrity" LSM
Date:   Thu, 13 Oct 2022 15:36:46 -0700
Message-Id: <20221013223654.659758-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4972; h=from:subject; bh=X25ar5cnDAOImSwIPi4dRS33/W6S8V04RVdvF3svy1g=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMEI4he7aV1fUMbAUP8+xOlSU/Mc/mejIzZVgwZ MgicjxaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBAAKCRCJcvTf3G3AJi2ID/ 9IBaUFqXWRxmua4MK2h4HUvB+6dgAfWu8nN+BNz69h5r6S4m+jTtsTJ4xDfUgtPrnzzm8Z6rL/5UzJ R1QclfS45ROQRyvcqlyzKJqsxMZIRjzbWLmW0wnmOktcinGIbcvzYoVNZHTvmD+ALd2KNfkHIrXX6J 97OKhNAwRpbcLcitq566kjcbJvGDwYdRwlUa5Ft5l3a6cGqES+sm3RSc95zLLf5UBLgFq/sVPDacYt RdKywXjefO9oqFW54hg2ehfZEHkRENdcZvfIeIrNiJibJ9KYGamJ9xAY4HEFfcCns8CVpiRjdl9dhq zmgmyFKvwDFcZWE1qwxgsuVRQDVxqKEhozcV26CoiS5SzYhZqiTEoOzNv/ZyNjVGLVIiGI3dQpggTA bckOlVsVLymnQw1ab3sddZ4I9MCjbCYTwIQBw76dqO4MfgaHbejC6naXOaI5SDxxIeH9a58xHLsnV5 OeSpsGDa4xAWuQejlQMVcJA5/CodmZiWoScJ7ALKEuLwHahBlNzxsPL48hu3zYfimHTArbc34fvgyr 5R8O7Sfp1ApmjbKchmAIfdZoK6AqzMECbgiBAAAVfIcRms6TP4OJF9O6jSPHHBzfmnk9vSJ2rMVDML y/8VotNFwVeFAazDw8bmqdealoYdhDXNGpWOoxUOSg7LufhqzZlv4hZymShA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move "integrity" LSM to the end of the Kconfig list and prepare for
having ima and evm LSM initialization called from the top-level
"integrity" LSM.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig                  | 10 +++++-----
 security/integrity/evm/evm_main.c |  4 ++++
 security/integrity/iint.c         | 17 +++++++++++++----
 security/integrity/ima/ima_main.c |  4 ++++
 security/integrity/integrity.h    |  6 ++++++
 5 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index e6db09a779b7..d472e87a2fc4 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -246,11 +246,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf,integrity" if DEFAULT_SECURITY_SMACK
+	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,bpf,integrity" if DEFAULT_SECURITY_APPARMOR
+	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,bpf,integrity" if DEFAULT_SECURITY_TOMOYO
+	default "landlock,lockdown,yama,loadpin,safesetid,bpf,integrity" if DEFAULT_SECURITY_DAC
+	default "landlock,lockdown,yama,loadpin,safesetid,selinux,smack,tomoyo,apparmor,bpf,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2e6fb6e2ffd2..1ef965089417 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -904,3 +904,7 @@ static int __init init_evm(void)
 }
 
 late_initcall(init_evm);
+
+void __init integrity_lsm_evm_init(void)
+{
+}
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 8638976f7990..4f322324449d 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -18,7 +18,6 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
-#include <linux/lsm_hooks.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
@@ -172,19 +171,29 @@ static void init_once(void *foo)
 	mutex_init(&iint->mutex);
 }
 
-static int __init integrity_iintcache_init(void)
+void __init integrity_add_lsm_hooks(struct security_hook_list *hooks,
+				    int count)
+{
+	security_add_hooks(hooks, count, "integrity");
+}
+
+static int __init integrity_lsm_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
 			      0, SLAB_PANIC, init_once);
+
+	integrity_lsm_ima_init();
+	integrity_lsm_evm_init();
+
 	return 0;
 }
+
 DEFINE_LSM(integrity) = {
 	.name = "integrity",
-	.init = integrity_iintcache_init,
+	.init = integrity_lsm_init,
 };
 
-
 /*
  * integrity_kernel_read - read data from the file
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 040b03ddc1c7..e617863af5ff 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1076,3 +1076,7 @@ static int __init init_ima(void)
 }
 
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
+
+void __init integrity_lsm_ima_init(void)
+{
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bdc..3707349271c9 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -18,6 +18,7 @@
 #include <crypto/hash.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/lsm_hooks.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -191,6 +192,11 @@ extern struct dentry *integrity_dir;
 
 struct modsig;
 
+void __init integrity_lsm_ima_init(void);
+void __init integrity_lsm_evm_init(void);
+void __init integrity_add_lsm_hooks(struct security_hook_list *hooks,
+				    int count);
+
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
-- 
2.34.1

