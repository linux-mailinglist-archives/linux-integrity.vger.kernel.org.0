Return-Path: <linux-integrity+bounces-7448-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECEABEBAD6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B09D7460FF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F1354ADD;
	Fri, 17 Oct 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MnHzkBtB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F6354ACC
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732930; cv=none; b=ZvSNIRPHmddlfBeK1l7JYRG24wZ0POFlO7LvDar3NRYnqZLCAwjB8jQI0NX04DsXoqjG8rMY0P6OJzOvnbgLFr+HenBuP5MaOsjiwuN9YVKFoD3sa9Bt1rrEUzO4kbYEW5N1gTXk/wB5GNDDwtVs2B5ltSm39iypLdjEcKVmK9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732930; c=relaxed/simple;
	bh=MRGM52AqEsf9Z+LXMMXpA/bYEwQJ2hQVih+OOqO3InE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9yCZRyJ0p6dieYm3KHoYknWUdPBk8Fa89Hq9sRbtomvw1OzgUyWuWz6uSXWpGTwqeL/qyy9OPPuinO/7HBwcnQwHDRA5bCfqX2l9b6UIMhAKbEZJti/edqoSc9JHRE9L6Wc2O+geoxAaZ2KlVbcqM4glAlGYD5iIHiLtmc+4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MnHzkBtB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso48110606d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732927; x=1761337727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80RF/oVAJBAd+QSyQNgUIOfWs8Q3n/gCRoXqutYVYoc=;
        b=MnHzkBtBCNNE4+vLA4aaXFrLo37qAeYMxSIcA2rWQy7KOkuDaMF3Wynu4I8YZiqmVt
         gs4c85r+FemTvKEQ5JeNrdBE96l7B12ch0NreQH611MJWMTVJnzeRPdg9C3duFOUTghk
         FT5y99WSmwOGDbtN1EopxdtAxDvktcEeIuQA7zy/VT7to5adcP07zdz99K6Nxgv8et5M
         TQ6VOOim0+YxQWmSFDim9cxeCeN/x7Cd5+zFkWF5A7MJRrATrWvqgICX7Y/WLKEuU/u5
         956BD9V9KJ/2SCEn/TvZgi/p1HLPQFjOYFs/ptAdyWOed1yUVGIzAbkDdyaJabbQPhmA
         dykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732927; x=1761337727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80RF/oVAJBAd+QSyQNgUIOfWs8Q3n/gCRoXqutYVYoc=;
        b=L/z4D/KNWVX3CUKMYJ5ZfXpLrlZHDv/MDIOr7CSk4NwZzbbhMlQfUQYdoAc2z7vDTg
         AacbhWfCBbllNDLcmtU+tY/CYPG0Byqc1HK8WZLVRNW221tNEVbzOB9VpCt4X33Vx3ZK
         QqtagrjgbAkqvfayicKYFMr8X0FJtuBkO/DbwPckVbOvADT3mdh0BuZ3sWfuTAhS99wd
         drO1kZjBapn0eRJ1QpLQjU0txJtU+ya4VIZFsXAnJxsW+oZpTs+fKDD9ePPjZZc+LM81
         lifQacjwkVFLTsRDQl+Q+a9Vd1b59Wb3Ukm0NBe3nra8kZJ3Xm5drlNAgzr1LDHUMRDF
         suNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD2ny+rKsR4p0ZBIVaJDpqrGcwwTeie8gy7xsrgDjf7vIaLjCEWszIuJsbIEQgInMGQOru/M/cdnv4EAgF/7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOdE+u92G20STKO1wdITBc6lCMQm8PlrmA+gIOsBqTVRKXVOB1
	QZZOiIJeUMogyi0Ytzd0RJe8Y8E8MgDlcKMSrNKHnIiItsPYvf8O0rSjlaKg5DS+HQ==
X-Gm-Gg: ASbGncsp5onprl6PMqP3JNFV3bgjCe/6v2pfBrzoX2IP930L3F02S3DJF6EKluIbcM0
	5804Sf3UH0yVPvh6TNmmiAENZCBSayDRiWCUOmrIKZUwjEm8P7bV9br1L4vsPDXuIBjMWkV83cH
	EGi3i5VikL6PAmarTaxmmPZCLHdEnVsCViqQugRJedaZnfZmoryuZkefTVbb8Q6Rwz28hME/3tX
	o07pAEJBDkZKAQXCD02pTY+WRgyg/acHOlW3fezO3b79QuC8VYkVuurnko/Svm7LumBjZF1qSsr
	uV/CYizGXFEySZbNc8roUR0lbAvMuUEL2myOvkT0GE/68+OPcfYlsJyVBsasMDqYJogscVuV3yE
	GrPBMBlHSPEXzslWy0EH47ZTOPh37MZ6M5Jnpc0DoTw/V+Zb2S3G2PrRqJuAiIPspjwcDhglo4E
	y6DirngG+XpFde3yERCkdsvYrbWHm2f0fkt3fDHmyIR9UNlC7c3CFEg8cW
X-Google-Smtp-Source: AGHT+IHyKvhqf4oRXwb4UIxToUbyQbx0fDMr72QMdpZ+WhNdai5Jch1SIpJ65sxJ7v2ZuIRNIvpgGA==
X-Received: by 2002:ad4:4ea1:0:b0:87c:a721:42f7 with SMTP id 6a1803df08f44-87ca7214384mr17288166d6.22.1760732926058;
        Fri, 17 Oct 2025 13:28:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521b309sm4902366d6.17.2025.10.17.13.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:44 -0700 (PDT)
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
Subject: [PATCH v5 01/34] lsm: split the notifier code out into lsm_notifier.c
Date: Fri, 17 Oct 2025 16:24:29 -0400
Message-ID: <20251017202456.484010-37-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3581; i=paul@paul-moore.com; h=from:subject; bh=MRGM52AqEsf9Z+LXMMXpA/bYEwQJ2hQVih+OOqO3InE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYYShYFAcgaFd7bg9zaKYxEFxv7tTdKN4Scx gnVyFix8xaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmGAAKCRDqIPLalzeJ c8sBD/9oK0DPRQkycOuEaKCqeIoM86KRstqD8VEtuRUZ9CTVRl/lmqyMCIIAVdkhh8sqrT9PRdj xf3XNfEV+pkx4Ve6v5gInJpsrex0+G+bl13E8VGll5KZJc2KFVKafYpRomuZSW7DSyzt1SZAQmC 3PHZ8jqbGBFOKPGe1SIYGFpBmfRA6nCWm2qtFun1rPLFdflpCPTMIHuwHn3rdqlRtPCQIiuBd7e GnBC1/BxbfRzcbzX/8JMRzqQitb8HPFvsjtz+ao4DiD0dEvhaagVSg2c/uhjq+IWspQbdFOuooT EIZI4FJRt87rvwyOrcZi1wDkt5oVajJY0gjOHCU+3YSLK7ZsyEF1k37JC5VznNG89RUYZ6exrtr 1+edo3GJJGDPipSj7PujdeqihtCgugDdl0DeAynS0j4FL8hb+ZeCl7iMtafJxW19am4LobzouUU 02bGFaAH7um5u5jBUrhJIPWCDamAQUxY8dNmVepNtJzXIevSzv0wuc49HgzodfdkLOn/VBZLe/V v+TcBxcuPhpt0JTRlQzmehIDJ5mXFMe/Fo9nndGwZzDU7KuF2HGGJEc8Humv9ypu8uC57bYFLID vkCKkr+ccypBk1vflHMeIyI2Ldi8Kj6pajbR4OqBuplTASNKuhpTgP61ryQkUDeoVk831eA3nad bT6NxS5+FX3iiJg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
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
index 4d3c03a4524c..667479c2e82f 100644
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
2.51.1.dirty


