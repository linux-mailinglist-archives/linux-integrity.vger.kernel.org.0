Return-Path: <linux-integrity+bounces-6819-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55557B27248
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F511CC77E9
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C11245023;
	Thu, 14 Aug 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EVKk6fSW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43348280309
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212045; cv=none; b=WGdlVbE3Amz4sZd8iXQczqDRfV4537KdiponDwR09QI5XwpboG6BlXWckuOCLYjQoxlAOAiCZ77hgbh52DGXfv5n+8G+qS0K7ssn+keSsVyigPAeJcSCq0PibmQg5DBR2R2YLxpF7udZI5DMhIpqSrZWZLUNMgES0lWfyvxiDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212045; c=relaxed/simple;
	bh=Wn73RknbBgr1QIw6Tz7euisAl7ABlX4j7pwSavdXxBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bjq+JVk//4Wlymk+2gr76b8cErfao+4OmJauCfTSNp+CZntvLqHATEko954Objzx4tOh1bjtaNZCu6kWsc9db3P6/JcvnusELpqB2eiHHzGStQnHNKAoL6AVybSoCfE7gY7rkR4wobTYZtFCk7Wx6hK6mlt2k43JqM4duVhIGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EVKk6fSW; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b0faa6601cso26180351cf.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212043; x=1755816843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g10bP8ZlmKs/0zOHxfzovhas+VAEHBkR2PUCtJySu0=;
        b=EVKk6fSWxFW5qBymBklYuHyO7+sNAcr6QjYlp8jRMqNsH42rnNU8jg+mQcMtElsc4R
         sgPnfSPqa61hXz1jtbMzkSYb0DzLUclg0DjiaXuWkQuYG74bz56PEiAgjTlelhaLOWU2
         TnAWMtTzO1grhAyWsIKAvxavMJu+Tnx6vhxICeJncrE0fverwocxjuiE+QMPq7SRlIi+
         hJ5t94rWa2A/Rxy4Uxj1voxU169opp+9JXS3x6xaYAoeWYMGbsFOgFZlNpo+47dzDU83
         KRMGpDuXKbAEDAAWXq8BjsTQhy3AYJ+cQjS/pWFrX8fRg7i3FNSWDvfOA5ij7KhYu8AZ
         Ua4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212043; x=1755816843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3g10bP8ZlmKs/0zOHxfzovhas+VAEHBkR2PUCtJySu0=;
        b=fwPHJbhput6zrEhZfjG2gqBLevNyxkwtJ9GDM8D5/mGmfC/pdnIbcbSbpCQaamh5Ov
         wfyOZXtdGn8q4yolYDRECLbQ1jl2DL0yxGWID3fwc0XSJRlmiD8B4BEUVQgAtfs2TqA2
         HvqqwPWDO1tw+FsLwAbMgPjYv05qiM5GSielxDZ6hyVgGrOe5IXFTwVuwZQKZ3DBqg9+
         eN18HcE5EegK4Fa5qUtn1wfH4/2GWlVk9z5/7Vh6IkhWPHNk8Dpf9JDBnyYjIrHcq9vW
         Y3xEr7Cj4bXIlfG+8hPFK4c99qs/Aq36OGNl9a2+v5ILwnilOVhA0eXsRLdqQgBYS24r
         fMUg==
X-Forwarded-Encrypted: i=1; AJvYcCWQaz40Vj3tvlcWkoq9nwVuanOf7JiLle0fimdqLHOtZVjUtXdZ8ynlYThT/lQZ3C13gofMT9chTMhdSplRhTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdsWYjbGth74mudEZykAqw9d4YuOeyFkUyb47q9iMdn1d9YHlk
	8OBxPtnW1E2eFSlJWApa4F9aAzdefUcKJrxQDnxrjhSnE9rZV31Lg7CrUh4ajYxSTA==
X-Gm-Gg: ASbGncv0SW5lXx68qACLd0jvRWt077xxLKvw69bIndKEQSlgf4zIqXRlghmixrCY8bF
	FLtcNSVVo2uRNMIzwXoTI/+uBW05DNmaHErdw5uLeXjkMJhwyBgAojPPhOO4mpHEkCWugYbwc10
	jlOx6I4MVB+BXX9n00xjYCoOt6EXnV0Y7nw4KdQmaQz49G1/hGD5CWE4ga94wQ7+hzjlxCWEZ53
	PW14S/x0o/8uivlz1dox4QrZTnczaJg9pOIeolfPiH9I1aNJDloeF73FOTEjfJRfSxUtgc81Ad0
	YA5hJZMFYYqFncoRW+oRlfT7FzuMfslxRCj2L1CzkJncmFZGG4w0tmlup9rYTXtXiCoT2LwmDLV
	NHa0UGQEUM0IquAPfSG8UAzU2ulYWen3I3lED7wAqa9LfHgDvEjQbiDh2xdahDfqHSSM=
X-Google-Smtp-Source: AGHT+IGjVBoc2SF+l/JB8LV8nEA2GSkmViun4gq9Wgh6CZH5uAYfJW8tH2Z7Kko7Ody471rw67t8TQ==
X-Received: by 2002:a05:622a:2607:b0:4b1:180a:ad70 with SMTP id d75a77b69052e-4b1180aadb3mr27059651cf.28.1755212043104;
        Thu, 14 Aug 2025 15:54:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4ff1b3sm41478085a.78.2025.08.14.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 01/34] lsm: split the notifier code out into lsm_notifier.c
Date: Thu, 14 Aug 2025 18:50:10 -0400
Message-ID: <20250814225159.275901-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3528; i=paul@paul-moore.com; h=from:subject; bh=Wn73RknbBgr1QIw6Tz7euisAl7ABlX4j7pwSavdXxBI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmiPMuDToZWAkg+iuBzLvE1a6OwEbYAmAs9qx zXLMx1kYg+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5ojwAKCRDqIPLalzeJ c8OlD/0UPTuCpx91OBwGSJIo5EmQ6HVRyK5wMKqAp57IZRS0oXP3R+jqoX8HaDihXaYH4mLS/dp QvReWuLCRSmR07AkPHsU1RP3QzuF3kPTVKYURs1WnwJ96MwFTYB8q43HHHDn4tLaomSKxczkEOW 0icNF4TdFHmQkp5rVPlnuoiiXV9FmUqi0fpB7fnaUTAQATBRlSLE8Oxr/tvMBLhYRyoW/G+H9dd 1cma8taG4KS9BqJE9rDR47T7/jlR56j7XptmCIA0OIKk3tCtVAH4k3kHQI+Gaw4+OtZvwWgyLLV DOiumutFeqU/DjDzu7bov5pjuwtp7BEU4tG29i1e4+R8YwhlWZJ3LbaGluaRZGFkhaiFi3ftovX R34wSf4/bEUFJh3pxV0aMIteU8vv0STl+u8V7+Xvb2nNkgGkowTDjjW3zZTMfEq9SiOAoKWbHYw DM8gDaT3Vp48GEJeAOPCCLTDoVFn5JX9JW4aWetkQIUOWihtzptI+LjiiDw7ywb4kNp4IO9i8+0 X8RwlWe8zQHg76gnRPa3v21BPjeGIU3rss551E7MWns5DpHxSgw9NdonEHboahQXAOyyanhSpG1 WLmJmUgojDVFKYcuMM9lo8yM1GO2Hp1ZMPFdyFPPqUYMtW2hDctRiJTNaDfDguEb+mT3QOWS52H Xodefx4Ea5ZnG6w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/Makefile       |  2 +-
 security/lsm_notifier.c | 31 +++++++++++++++++++++++++++++++
 security/security.c     | 23 -----------------------
 3 files changed, 32 insertions(+), 24 deletions(-)
 create mode 100644 security/lsm_notifier.c

diff --git a/security/Makefile b/security/Makefile
index 22ff4c8bd8ce..14d87847bce8 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm_notifier.c b/security/lsm_notifier.c
new file mode 100644
index 000000000000..c92fad5d57d4
--- /dev/null
+++ b/security/lsm_notifier.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM notifier functions
+ *
+ */
+
+#include <linux/notifier.h>
+#include <linux/security.h>
+
+static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
+
+int call_blocking_lsm_notifier(enum lsm_event event, void *data)
+{
+	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
+					    event, data);
+}
+EXPORT_SYMBOL(call_blocking_lsm_notifier);
+
+int register_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
+						nb);
+}
+EXPORT_SYMBOL(register_blocking_lsm_notifier);
+
+int unregister_blocking_lsm_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
+						  nb);
+}
+EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
diff --git a/security/security.c b/security/security.c
index ca126b02d2fe..8cb049bebc57 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -649,27 +647,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
-int call_blocking_lsm_notifier(enum lsm_event event, void *data)
-{
-	return blocking_notifier_call_chain(&blocking_lsm_notifier_chain,
-					    event, data);
-}
-EXPORT_SYMBOL(call_blocking_lsm_notifier);
-
-int register_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_register(&blocking_lsm_notifier_chain,
-						nb);
-}
-EXPORT_SYMBOL(register_blocking_lsm_notifier);
-
-int unregister_blocking_lsm_notifier(struct notifier_block *nb)
-{
-	return blocking_notifier_chain_unregister(&blocking_lsm_notifier_chain,
-						  nb);
-}
-EXPORT_SYMBOL(unregister_blocking_lsm_notifier);
-
 /**
  * lsm_blob_alloc - allocate a composite blob
  * @dest: the destination for the blob
-- 
2.50.1


