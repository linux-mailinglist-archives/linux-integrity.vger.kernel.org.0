Return-Path: <linux-integrity+bounces-5695-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1C7A82F8D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C248848E6
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA40278164;
	Wed,  9 Apr 2025 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ijz3mOeC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5227703E
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224813; cv=none; b=r90HgxLqggHK8luqdS870NmnwYmUWP8q2QBflIMJPs77vqYVTkvGFxODeYUfqKLrdC0t/VS/q9A0G7c5gFef8xeqxNMM81XUwU3lmazA1vHx7crUSAiKJmrIQX1/8EfULzpk5TeO/XbrrQPKCO88UNfETOS3BL7I/TY3t3BLl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224813; c=relaxed/simple;
	bh=pST0Jy42PlsO0MpZv3Tmw04rGz8RTx/Oz6ErubDMxwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8S/v14uZQDaKL9Qsm5KAumDEdc5EG792bC2HlGK2b7R0IhjW7RMvxOQE56EwJM9AuNcKgK4zJWyr9A3KG/iZOSJtc9xPvC9EBliXHHORzc9DM9gt0XOc7kgL8bSLzwtjA8U7fGUm20VXDhoO7kEawd8Sd/nkfvbgjYKhMwL5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ijz3mOeC; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f06e13a4so11156386d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224810; x=1744829610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riL1KUp604CYpD1AiWNliF00+qwNhMr/LsXwK6I/EDI=;
        b=Ijz3mOeCYOdU2GA2D1wzEdTUDjv/ZRKlMR/dP/01ML0nFTLB/rBeuF2E8Wfmqss530
         y/487Hj0e8tP2JIXYS0weUINerXes5OIrF3xHWiK4ItbTwgUit4uDJksfI8Iyftz9RhB
         71FnfF1CpAH3RlFaAenEJ5BwTOp/tko7YbdroKoSaE9C02v869LLM/jK4k/ciMOFqYPz
         i4DId0FdCGbuBiRQSrwwkSnsHfmp/lymZC/lp2UYDElXVzqFPiBRAJOMS5QyFHKjWH3F
         ucnizQL1f8ncPMFrlDZXMWtJF9K84uorrkphcmsz86Mu/2AF5K9jkLsZvfDJszTk2JPq
         aimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224810; x=1744829610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riL1KUp604CYpD1AiWNliF00+qwNhMr/LsXwK6I/EDI=;
        b=C9/4mADT5TMvxk+M7TfUQkhXyb9YECvdFMuO6mZe+oXiD00XAlWzRhw2vZF48oUxmX
         93MHpdX6077oPINHpj6jTNFBLCm2tty0Uh9HXB/06XN674ALrdKbbWiQ29/KNPowxhE6
         cMX/RCvPfb6IP7O3ouLM2WlkrxN93Ej7hJ+AH6vN4s/9q85JP1+e8EBVKpmEakH8JOri
         5F/FhmQeFgmI7FUStYz0tkWRzHWRHsIxg3f9Cuwl4Fifs+WC9GpEJ7V96rUQTc8vgUDp
         T2IfVYp3n28R9g3ha5Cse71HANUVMPjPozUQ2qbslbkJzz0fb7TKi+1UGYGyMxcD1mfv
         2Ssw==
X-Forwarded-Encrypted: i=1; AJvYcCVLBuaeP5fyLDVFaOEDpkhiBBNTwzqjFLy83l2blbIB5irid8e9/H21DBixu/LTIbXcRyUxY2KrtOJP5ow8H5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoo+y0TR1BcoDhrjj5n6VRgBA2cck1g/qs3qKAP1WijOJl232
	LxFxc0mcMBuoFVSjrmh4qCQJ7J69OdNQhK8HI2TO8ik3lhYhIVOT1z7gU54/BQ==
X-Gm-Gg: ASbGnctyix0jzt6mk7q5QwE1NnpK6gkGCEZ/5uPTtDDMhsWUfT9fvsOykYhUcL1ztx8
	jQl3nPjKfxdS6NK6xw+rAm8BbPlQaDmjYcHGqNjjYRHReKsabF1Taz6d+RCWgUZ6z5VMVO5ZumN
	rPpju8LM6+D9nYML26gkq91q3BF9CnXv69UCDjZfGFfnXkWOaj9uEUC6U8NDvrchwvOZrP/oGsf
	z00jJOvLu5tG9PKML6Uz/cj5jmCbjU9VOCN4IfR/JdNJJhp2uRGlk4wq1gC9RmFx6xxvw4xNqoH
	kzoUm4Zh1F1pALh4RGBU9q9Ccwev6oqjV2taumt5WaAzsB9dGFY+XT8fgZ5k/HlAJQg1xJqfkjv
	Na1WjlV/aVpayBtJ5pzI4
X-Google-Smtp-Source: AGHT+IGGqQ+5TDtMPJUftGLobaOx7r+y0xyJI6orbJraNyiHa62EsNyYAeQTLymIJ5NZ2wzofRrAVg==
X-Received: by 2002:a05:6214:29e3:b0:6d9:ac3:e730 with SMTP id 6a1803df08f44-6f0e4c543fcmr8888226d6.5.1744224810451;
        Wed, 09 Apr 2025 11:53:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de9732f1sm10627506d6.44.2025.04.09.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:30 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 01/29] lsm: split the notifier code out into lsm_notifier.c
Date: Wed,  9 Apr 2025 14:49:46 -0400
Message-ID: <20250409185019.238841-32-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3373; i=paul@paul-moore.com; h=from:subject; bh=pST0Jy42PlsO0MpZv3Tmw04rGz8RTx/Oz6ErubDMxwo=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sFrd2BQ5kvOfAZSK6RvKZzIqRR99lLiF2bqN pnGNiXi9MWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBawAKCRDqIPLalzeJ cwOQD/9bfknkxydw8DwctdBJLYfuqvr64I6HAlZQL5my5A8Wg3Vo1HdGPu6KC3Y53g2Uh1IOPnu 2z+3KL6bAtAzY3vTSt1DzOMeFIwtHRlwl7b13SwzUDNZDjSzjYKvJDrhc5FIdOtA1iRJ165ud9j cOp7hnablMr/sDzHwVZlaS0d4QiN7mtKmcwLxfPrjdimBBmmCFTlxEHbmcacRJmWYAkV6nT7yhZ lhzw68uzYTUCO/jBv4jwC4MntaHJpbNmvvr0xnX08D/drYmAauk3m8WAc70iLiq9p4FzVjIoHzc SH4sfMmLbkSn3lankDvhC7nLg8r7WDDZQr0rhpT7L9YYwMj4HIMh8ILJxsgiEmHMBBmA9F9H0AZ /obaG2I+ts3NWr9Js3Yq00UcR0wwBq0Lw9ev9wp4IvGZcEMsvU0baGLLNBYlR8xVgkCMxgfqN04 f/NhjbSj7EKLI3vXglFkFv+LnOx6hRgLVzofm1uhyLvltJXdkZ3gfCYbJ6dyKFVtZW7oQTTVwcz OhsQlyFY06ybQVOQK92ejGzvNZ0G4NrbK4sKbc1a8xuSDEcsKB/WDVfND+Ste/hT28FYa3eRd44 RtCOjhfd4a5mp+F6aDchV3bg/3ebuLO8EUrKUM1v0u3r5y4FRGigsa4f1zF2p20ok3FKAOCT+yJ u0EBYDe39poS1pQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

In an effort to decompose security/security.c somewhat to make it less
twisted and unwieldy, pull out the LSM notifier code into a new file
as it is fairly well self-contained.

No code changes.

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
index fb57e8fddd91..477be0a17e3f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -90,8 +90,6 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
-
 static struct kmem_cache *lsm_file_cache;
 static struct kmem_cache *lsm_inode_cache;
 
@@ -643,27 +641,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
2.49.0


