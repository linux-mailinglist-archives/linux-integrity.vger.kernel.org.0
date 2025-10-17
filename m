Return-Path: <linux-integrity+bounces-7450-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49252BEBADF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215757453D0
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8B354AC9;
	Fri, 17 Oct 2025 20:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZzspZ64V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CB354AD2
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732933; cv=none; b=aWUzvHBzpeJcCVJbab8Cywc7Hm+5V++OzmW23IAxz9yMTbyOhwmfw9X6PPWiZCjeW4OuSsvSqpTlKm88d4aFzbMSo1sPNkLtbs3pDf7qY6EUycOIxRen39B5vmWTcuyMtJbiOAJ4z+8HDsZPx6NZElitLWHvL7mvd1gKOIZPYB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732933; c=relaxed/simple;
	bh=qgjmKQ74+m1JYS6e6grWAxn3nVvKztxiX2hOB5/8y/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN/eGejRhkZxXkdG9Xql7mb/eQjT4sRRqQXJF27/Jo4a4Q726C20LoyHDHsw3CoM/iSyij6d5Tj44+skIZ5zoyvvNf9F4JYwEcQln4vA01jwspPV/bgCpNfUQesHVo5ZvaGOth5goRvNO8H+zwf5/sL12phoLLxpEHhMtQHLEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZzspZ64V; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-87c1877b428so40360356d6.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732928; x=1761337728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pZ2vUtftYSsfD0tQLvyqTRKB796NbaO9jApkOjMm1Y=;
        b=ZzspZ64V5gQlYaqSlBPMjkZDkSE6p9yCP/XGCP3Uj3czLY0e5oe4YwijYZ4tNjtd3y
         lTQlQ6PjsJbNe+JtKVoJPvY9hvu6K2+hUVBSewhaBxMfq6nPmyIk48sfrzlNOLldpTLI
         ginQX/EWHYYKglC8Tg6Jvkt3tQTqKmNpK8M7z5AczjTd6fryIVJNYO8hQbxAIg8y3S1e
         g2YkezCwn+UG7y1CUUDnSFvhiH8vIuOhlaRESgSE0tDwzIWGPKVmePeUufsp/l+rt8YP
         KIWwiT/HvUxtR88VbglT3vZeLiEkVldl0JPjNK1Qbizvbez6i0OgcXPNdcMRBSYcwLT0
         q0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732928; x=1761337728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pZ2vUtftYSsfD0tQLvyqTRKB796NbaO9jApkOjMm1Y=;
        b=EbhX77L5rXcOobxL/dA0IqZOjSD/tk3lHfCe9YSD6Xgds8v0qMwk8vJS/G9wqMDdds
         dL0Zmo+1NrehCnfcujn1lp0c9zAAU/1Q5YIB9XSXGCFTdIcBRxt6rALKF4+fHjr4ER15
         C2VLmJXihJjTIYpGMyyRZTqWnDjgj/3MjzL7JnhHsa8MLfcKFqpDbt0dxNYVjSOjoZ6X
         FQXPZk+X3yuZLUB/fraGbnFz6umZ06YAbfaRMj+lQ7Wt6HuCFByFgupKP7VXaGbPZPev
         51QHWx13upvjsfmiVTWuDx4/j/LNaa354yshwibYsm1Q1GhkmCDkNcRxRwTw3suRS7sR
         3/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl2dKqwYljnbbcYIBVnuiI/NAmmCpuJVcNVv+RKHjyujlO7dXiaAB2j17vFuDUHMeLyphqDSXT5jIxC/hRUfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkoF84IK32us3Nib9KChYtw98hGlb+lytsSRK1RnBbGrgWRUg
	L3Fvll3XR8Da4wqeV9QHLeOPvGXctRDNO70J//uCKG2AFYWYa5US+hACWBocVhy8zRRZO5timGZ
	b3ZseMw==
X-Gm-Gg: ASbGncuNo4AS5luRYFFG6Qtc57dXVKu5eMUhzkIzIJ1pFNA8zuC0ktOMPhp4i38ypIt
	7UBCABb0r5SHxSEpJfzv3Aeqmjzs+UqktVR6qiZkmLwaQfT93HNHyBXm5SG5VpUzjC33XCjjjsH
	A6YjDy5cqmw4vYuYAsxwFsPw5g6CrOYhenZpYaZEmlRU2JPVKGOBRFKhQuUYmt6obTZM/BcqoBv
	TLKgIf+eBOZeY1h8DAd1QyOBh8tiN4KkTZhgxCZfXcvEbv9Sdem9PBBNPfW0Re0MBEUNDVXp5LD
	0sA9oqBcdRPQjmmFQpT2GABSKTsj0xadQBnnTTH50eKDcmHZoKW+rN2FRUtSB63qQk/klPUhr+g
	FbfVUdj3mhyrxU63CowItAtqeg+HfM7nNldf+8ORsaXuw6o+b6vziY0uAcBffoWiDAbcqDPCFpJ
	7KAC9cvMmrmtFy64dtn+ZT19sRgrzSsmN+3JqFV9l6qRbclA==
X-Google-Smtp-Source: AGHT+IH9JvuySK3yXJy45u8D6CoAGWAg3+QOVbqpzfzdH1IAZ45VuVv1Bd+r+tdChdPvY6j7EkHTEg==
X-Received: by 2002:ac8:590c:0:b0:4e8:9358:cd22 with SMTP id d75a77b69052e-4e89d4225c8mr78914061cf.84.1760732927964;
        Fri, 17 Oct 2025 13:28:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02884878sm4728646d6.31.2025.10.17.13.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:46 -0700 (PDT)
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
Subject: [PATCH v5 02/34] lsm: split the init code out into lsm_init.c
Date: Fri, 17 Oct 2025 16:24:30 -0400
Message-ID: <20251017202456.484010-38-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38542; i=paul@paul-moore.com; h=from:subject; bh=qgjmKQ74+m1JYS6e6grWAxn3nVvKztxiX2hOB5/8y/g=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYb62Mj6lMnvTdrRlHFaB+2khrYBfQ9w7wBy et3Jb4g1Q6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmGwAKCRDqIPLalzeJ c3iSEACpBj9+LL+wUzIeh1pl4hMXFfFOfKu3K+4nVxu13uTrw6H5m4Y3tfsi/pjLQM4Rngx9M1O qtjAGh+YlR7rCMxgTsRk1TC1qSMevt+exwivRxhKkbiKOjyHAY0z5w/7d+ScyYJXRe+QFBRlx3x VlCqwUDTCmC3uJqLpqx1k22g1BZymcSbfRzct4NW3VxOeIR7I89u2+hoxOhQEdJpdKxgRfA4M7v FOeFMytJE7V3Q3Qx6eDyU+yUyxnuv8i65DnWfOz1FxKXWNlunanXJ5DUamCBOkqOLpC9q1D750e zi7K1kaG9lmdjewbusV+Z9UP4fGNzxYCMnqCOY4pGq7rCWEx7fNuGDKtTzyzweYP4sE996nK8ky /VGPk2QTr/9io5csDfCswfwrMCd2FVxV2pm0tiJh1gX+skRH3mmZcPVvOqcuOjnjo0U9XinXM9m LkvX6lXiFlfGMCTE6f8srnmBZ7EmGw8E9AqmzWd24IYHQy+yCSiMwLliP6jsgAJ1ZEcJBlZeScm H2n3OCWFtLMpA5bBH782O6vRnWWd9nbUa0X2bE3F3QYXHIcOUDVe7FDaSJ4pc2V9gUpcB+GqcnW CAIaQaXwcBkv0PaKzpQ78r66lBVmDEHPjRY29a1TYxwqE3TvtvOiR1hMpHdejKtHRG73fJmxgqk xY8V9Dgfw1QhDPA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Continue to pull code out of security/security.c to help improve
readability by pulling all of the LSM framework initialization
code out into a new file.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |   3 +-
 security/Makefile         |   2 +-
 security/lsm.h            |  22 ++
 security/lsm_init.c       | 543 ++++++++++++++++++++++++++++++++++
 security/security.c       | 597 +++-----------------------------------
 5 files changed, 601 insertions(+), 566 deletions(-)
 create mode 100644 security/lsm.h
 create mode 100644 security/lsm_init.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 79ec5a2bdcca..0112926ed923 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -170,11 +170,10 @@ struct lsm_info {
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
+
 /* DO NOT tamper with these variables outside of the LSM framework */
 extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
-extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
-extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
 /**
  * lsm_get_xattr_slot - Return the next available slot and increment the index
diff --git a/security/Makefile b/security/Makefile
index 14d87847bce8..4601230ba442 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o lsm_init.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm.h b/security/lsm.h
new file mode 100644
index 000000000000..0e1731bad4a7
--- /dev/null
+++ b/security/lsm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM functions
+ */
+
+#ifndef _LSM_H_
+#define _LSM_H_
+
+#include <linux/lsm_hooks.h>
+
+/* LSM blob configuration */
+extern struct lsm_blob_sizes blob_sizes;
+
+/* LSM blob caches */
+extern struct kmem_cache *lsm_file_cache;
+extern struct kmem_cache *lsm_inode_cache;
+
+/* LSM blob allocators */
+int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
+int lsm_task_alloc(struct task_struct *task);
+
+#endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
new file mode 100644
index 000000000000..124213b906af
--- /dev/null
+++ b/security/lsm_init.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM initialization functions
+ */
+
+#define pr_fmt(fmt) "LSM: " fmt
+
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+
+#include "lsm.h"
+
+char *lsm_names;
+
+/* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
+extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
+
+/* Boot-time LSM user choice */
+static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
+static __initdata const char *chosen_lsm_order;
+static __initdata const char *chosen_major_lsm;
+
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
+static __initdata struct lsm_info *exclusive;
+
+static __initdata bool debug;
+#define init_debug(...)							\
+	do {								\
+		if (debug)						\
+			pr_info(__VA_ARGS__);				\
+	} while (0)
+
+static int lsm_append(const char *new, char **result);
+
+/* Save user chosen LSM */
+static int __init choose_major_lsm(char *str)
+{
+	chosen_major_lsm = str;
+	return 1;
+}
+__setup("security=", choose_major_lsm);
+
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
+/* Enable LSM order debugging. */
+static int __init enable_debug(char *str)
+{
+	debug = true;
+	return 1;
+}
+__setup("lsm.debug", enable_debug);
+
+/* Mark an LSM's enabled flag. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	/*
+	 * When an LSM hasn't configured an enable variable, we can use
+	 * a hard-coded location for storing the default enabled state.
+	 */
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
+		*lsm->enabled = enabled;
+	}
+}
+
+static inline bool is_enabled(struct lsm_info *lsm)
+{
+	if (!lsm->enabled)
+		return false;
+
+	return *lsm->enabled;
+}
+
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
+		return;
+
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
+	ordered_lsms[last_lsm++] = lsm;
+
+	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
+		   is_enabled(lsm) ? "enabled" : "disabled");
+}
+
+/* Is an LSM allowed to be initialized? */
+static bool __init lsm_allowed(struct lsm_info *lsm)
+{
+	/* Skip if the LSM is disabled. */
+	if (!is_enabled(lsm))
+		return false;
+
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
+	return true;
+}
+
+static void __init lsm_set_blob_size(int *need, int *lbs)
+{
+	int offset;
+
+	if (*need <= 0)
+		return;
+
+	offset = ALIGN(*lbs, sizeof(void *));
+	*lbs = offset + *need;
+	*need = offset;
+}
+
+static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+{
+	if (!needed)
+		return;
+
+	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
+	/*
+	 * The inode blob gets an rcu_head in addition to
+	 * what the modules might need.
+	 */
+	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&needed->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
+	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
+	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
+	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
+}
+
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_allowed(lsm);
+
+	/* Record enablement (to handle any following exclusive LSMs). */
+	set_enabled(lsm, enabled);
+
+	/* If enabled, do pre-initialization work. */
+	if (enabled) {
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive chosen:   %s\n", lsm->name);
+		}
+
+		lsm_set_blob_sizes(lsm->blobs);
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
+/* Populate ordered LSMs list from comma-separated LSM name list. */
+static void __init ordered_lsm_parse(const char *order, const char *origin)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "  first");
+	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		struct lsm_info *major;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (major = __start_lsm_info; major < __end_lsm_info;
+		     major++) {
+			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(major->name, chosen_major_lsm) != 0) {
+				set_enabled(major, false);
+				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
+					   chosen_major_lsm, major->name);
+			}
+		}
+	}
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (strcmp(lsm->name, name) == 0) {
+				if (lsm->order == LSM_ORDER_MUTABLE)
+					append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
+
+		if (!found)
+			init_debug("%s ignored: %s (not built into kernel)\n",
+				   origin, name);
+	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (exists_ordered_lsm(lsm))
+				continue;
+			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+				append_ordered_lsm(lsm, "security=");
+		}
+	}
+
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "   last");
+	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s skipped: %s (not in requested order)\n",
+			   origin, lsm->name);
+	}
+
+	kfree(sep);
+}
+
+static void __init report_lsm_order(void)
+{
+	struct lsm_info **lsm, *early;
+	int first = 0;
+
+	pr_info("initializing lsm=");
+
+	/* Report each enabled LSM name, comma separated. */
+	for (early = __start_early_lsm_info;
+	     early < __end_early_lsm_info; early++)
+		if (is_enabled(early))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		if (is_enabled(*lsm))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+
+	pr_cont("\n");
+}
+
+/**
+ * lsm_early_cred - during initialization allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ *
+ * Allocate the cred blob for all the modules
+ */
+static void __init lsm_early_cred(struct cred *cred)
+{
+	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
+
+	if (rc)
+		panic("%s: Early cred alloc failed.\n", __func__);
+}
+
+/**
+ * lsm_early_task - during initialization allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ */
+static void __init lsm_early_task(struct task_struct *task)
+{
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		panic("%s: Early task alloc failed.\n", __func__);
+}
+
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info **lsm;
+
+	if (chosen_lsm_order) {
+		if (chosen_major_lsm) {
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				chosen_major_lsm, chosen_lsm_order);
+			chosen_major_lsm = NULL;
+		}
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	} else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		prepare_lsm(*lsm);
+
+	report_lsm_order();
+
+	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
+	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
+	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
+	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
+	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
+	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
+	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
+	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
+
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_inode)
+		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
+						    blob_sizes.lbs_inode, 0,
+						    SLAB_PANIC, NULL);
+
+	lsm_early_cred((struct cred *) current->cred);
+	lsm_early_task(current);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
+}
+
+static bool match_last_lsm(const char *list, const char *lsm)
+{
+	const char *last;
+
+	if (WARN_ON(!list || !lsm))
+		return false;
+	last = strrchr(list, ',');
+	if (last)
+		/* Pass the comma, strcmp() will check for '\0' */
+		last++;
+	else
+		last = list;
+	return !strcmp(last, lsm);
+}
+
+static int lsm_append(const char *new, char **result)
+{
+	char *cp;
+
+	if (*result == NULL) {
+		*result = kstrdup(new, GFP_KERNEL);
+		if (*result == NULL)
+			return -ENOMEM;
+	} else {
+		/* Check if it is the last registered name */
+		if (match_last_lsm(*result, new))
+			return 0;
+		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
+		if (cp == NULL)
+			return -ENOMEM;
+		kfree(*result);
+		*result = cp;
+	}
+	return 0;
+}
+
+static void __init lsm_static_call_init(struct security_hook_list *hl)
+{
+	struct lsm_static_call *scall = hl->scalls;
+	int i;
+
+	for (i = 0; i < MAX_LSM_COUNT; i++) {
+		/* Update the first static call that is not used yet */
+		if (!scall->hl) {
+			__static_call_update(scall->key, scall->trampoline,
+					     hl->hook.lsm_func_addr);
+			scall->hl = hl;
+			static_branch_enable(scall->active);
+			return;
+		}
+		scall++;
+	}
+	panic("%s - Ran out of static slots.\n", __func__);
+}
+
+/**
+ * security_add_hooks - Add a modules hooks to the hook lists.
+ * @hooks: the hooks to add
+ * @count: the number of hooks to add
+ * @lsmid: the identification information for the security module
+ *
+ * Each LSM has to register its hooks with the infrastructure.
+ */
+void __init security_add_hooks(struct security_hook_list *hooks, int count,
+			       const struct lsm_id *lsmid)
+{
+	int i;
+
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
+		if (lsm_active_cnt >= MAX_LSM_COUNT)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+	}
+
+	for (i = 0; i < count; i++) {
+		hooks[i].lsmid = lsmid;
+		lsm_static_call_init(&hooks[i]);
+	}
+
+	/*
+	 * Don't try to append during early_security_init(), we'll come back
+	 * and fix this up afterwards.
+	 */
+	if (slab_is_available()) {
+		if (lsm_append(lsmid->name, &lsm_names) < 0)
+			panic("%s - Cannot get early memory.\n", __func__);
+	}
+}
+
+int __init early_security_init(void)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+		prepare_lsm(lsm);
+		initialize_lsm(lsm);
+	}
+
+	return 0;
+}
+
+/**
+ * security_init - initializes the security framework
+ *
+ * This should be called early in the kernel initialization sequence.
+ */
+int __init security_init(void)
+{
+	struct lsm_info *lsm;
+
+	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
+	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
+
+	/*
+	 * Append the names of the early LSM modules now that kmalloc() is
+	 * available
+	 */
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		init_debug("  early started: %s (%s)\n", lsm->name,
+			   is_enabled(lsm) ? "enabled" : "disabled");
+		if (lsm->enabled)
+			lsm_append(lsm->name, &lsm_names);
+	}
+
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
+	return 0;
+}
diff --git a/security/security.c b/security/security.c
index 667479c2e82f..dc9734f0d45c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,24 +32,7 @@
 #include <net/flow.h>
 #include <net/sock.h>
 
-#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
-
-/*
- * Identifier for the LSM static calls.
- * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
- * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
- */
-#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
-
-/*
- * Call the macro M for each LSM hook MAX_LSM_COUNT times.
- */
-#define LSM_LOOP_UNROLL(M, ...) 		\
-do {						\
-	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
-} while (0)
-
-#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
+#include "lsm.h"
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -90,21 +73,29 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static struct kmem_cache *lsm_file_cache;
-static struct kmem_cache *lsm_inode_cache;
+struct lsm_blob_sizes blob_sizes;
 
-char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __ro_after_init;
+struct kmem_cache *lsm_file_cache;
+struct kmem_cache *lsm_inode_cache;
 
-/* Boot-time LSM user choice */
-static __initdata const char *chosen_lsm_order;
-static __initdata const char *chosen_major_lsm;
+#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
 
-static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
+/*
+ * Identifier for the LSM static calls.
+ * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
+ * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
+ */
+#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
 
-/* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
-static __initdata struct lsm_info *exclusive;
+/*
+ * Call the macro M for each LSM hook MAX_LSM_COUNT times.
+ */
+#define LSM_LOOP_UNROLL(M, ...) 		\
+do {						\
+	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
+} while (0)
+
+#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 #define LSM_HOOK_TRAMP(NAME, NUM) \
@@ -155,496 +146,25 @@ struct lsm_static_calls_table
 #undef INIT_LSM_STATIC_CALL
 	};
 
-static __initdata bool debug;
-#define init_debug(...)						\
-	do {							\
-		if (debug)					\
-			pr_info(__VA_ARGS__);			\
-	} while (0)
-
-static bool __init is_enabled(struct lsm_info *lsm)
-{
-	if (!lsm->enabled)
-		return false;
-
-	return *lsm->enabled;
-}
-
-/* Mark an LSM's enabled flag. */
-static int lsm_enabled_true __initdata = 1;
-static int lsm_enabled_false __initdata = 0;
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
-{
-	/*
-	 * When an LSM hasn't configured an enable variable, we can use
-	 * a hard-coded location for storing the default enabled state.
-	 */
-	if (!lsm->enabled) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-		else
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_true) {
-		if (!enabled)
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_false) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-	} else {
-		*lsm->enabled = enabled;
-	}
-}
-
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
-{
-	struct lsm_info **check;
-
-	for (check = ordered_lsms; *check; check++)
-		if (*check == lsm)
-			return true;
-
-	return false;
-}
-
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
-{
-	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
-		return;
-
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
-
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm++] = lsm;
-
-	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
-}
-
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
-static void __init lsm_set_blob_size(int *need, int *lbs)
-{
-	int offset;
-
-	if (*need <= 0)
-		return;
-
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
-}
-
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
-{
-	if (!needed)
-		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
-	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
-	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
-	}
-}
-
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
-{
-	if (is_enabled(lsm)) {
-		int ret;
-
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
-	}
-}
-
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
-		struct lsm_info *major;
-
-		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
-		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->name, chosen_major_lsm) != 0) {
-				set_enabled(major, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->name);
-			}
-		}
-	}
-
-	sep = kstrdup(order, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
-				found = true;
-			}
-		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
-	}
-
-	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (exists_ordered_lsm(lsm))
-				continue;
-			if (strcmp(lsm->name, chosen_major_lsm) == 0)
-				append_ordered_lsm(lsm, "security=");
-		}
-	}
-
-	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
-	}
-
-	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (exists_ordered_lsm(lsm))
-			continue;
-		set_enabled(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->name);
-	}
-
-	kfree(sep);
-}
-
-static void __init lsm_static_call_init(struct security_hook_list *hl)
-{
-	struct lsm_static_call *scall = hl->scalls;
-	int i;
-
-	for (i = 0; i < MAX_LSM_COUNT; i++) {
-		/* Update the first static call that is not used yet */
-		if (!scall->hl) {
-			__static_call_update(scall->key, scall->trampoline,
-					     hl->hook.lsm_func_addr);
-			scall->hl = hl;
-			static_branch_enable(scall->active);
-			return;
-		}
-		scall++;
-	}
-	panic("%s - Ran out of static slots.\n", __func__);
-}
-
-static void __init lsm_early_cred(struct cred *cred);
-static void __init lsm_early_task(struct task_struct *task);
-
-static int lsm_append(const char *new, char **result);
-
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-
-	pr_cont("\n");
-}
-
-static void __init ordered_lsm_init(void)
-{
-	struct lsm_info **lsm;
-
-	if (chosen_lsm_order) {
-		if (chosen_major_lsm) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				chosen_major_lsm, chosen_lsm_order);
-			chosen_major_lsm = NULL;
-		}
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	} else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
-
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
-
-	report_lsm_order();
-
-	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
-	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
-	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
-	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
-#ifdef CONFIG_KEYS
-	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
-#endif /* CONFIG_KEYS */
-	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
-	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
-	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
-	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
-	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
-	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
-	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
-	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
-	init_debug("bpf map blob size    = %d\n", blob_sizes.lbs_bpf_map);
-	init_debug("bpf prog blob size   = %d\n", blob_sizes.lbs_bpf_prog);
-	init_debug("bpf token blob size  = %d\n", blob_sizes.lbs_bpf_token);
-
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
-	if (blob_sizes.lbs_file)
-		lsm_file_cache = kmem_cache_create("lsm_file_cache",
-						   blob_sizes.lbs_file, 0,
-						   SLAB_PANIC, NULL);
-	if (blob_sizes.lbs_inode)
-		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
-						    blob_sizes.lbs_inode, 0,
-						    SLAB_PANIC, NULL);
-
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		initialize_lsm(*lsm);
-}
-
-int __init early_security_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
-		initialize_lsm(lsm);
-	}
-
-	return 0;
-}
-
 /**
- * security_init - initializes the security framework
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
  *
- * This should be called early in the kernel initialization sequence.
- */
-int __init security_init(void)
-{
-	struct lsm_info *lsm;
-
-	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
-
-	/*
-	 * Append the names of the early LSM modules now that kmalloc() is
-	 * available
-	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
-		init_debug("  early started: %s (%s)\n", lsm->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->name, &lsm_names);
-	}
-
-	/* Load LSMs in specified order. */
-	ordered_lsm_init();
-
-	return 0;
-}
-
-/* Save user chosen LSM */
-static int __init choose_major_lsm(char *str)
-{
-	chosen_major_lsm = str;
-	return 1;
-}
-__setup("security=", choose_major_lsm);
-
-/* Explicitly choose LSM initialization order. */
-static int __init choose_lsm_order(char *str)
-{
-	chosen_lsm_order = str;
-	return 1;
-}
-__setup("lsm=", choose_lsm_order);
-
-/* Enable LSM order debugging. */
-static int __init enable_debug(char *str)
-{
-	debug = true;
-	return 1;
-}
-__setup("lsm.debug", enable_debug);
-
-static bool match_last_lsm(const char *list, const char *lsm)
-{
-	const char *last;
-
-	if (WARN_ON(!list || !lsm))
-		return false;
-	last = strrchr(list, ',');
-	if (last)
-		/* Pass the comma, strcmp() will check for '\0' */
-		last++;
-	else
-		last = list;
-	return !strcmp(last, lsm);
-}
-
-static int lsm_append(const char *new, char **result)
-{
-	char *cp;
-
-	if (*result == NULL) {
-		*result = kstrdup(new, GFP_KERNEL);
-		if (*result == NULL)
-			return -ENOMEM;
-	} else {
-		/* Check if it is the last registered name */
-		if (match_last_lsm(*result, new))
-			return 0;
-		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
-		if (cp == NULL)
-			return -ENOMEM;
-		kfree(*result);
-		*result = cp;
-	}
-	return 0;
-}
-
-/**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * Allocate the file blob for all the modules
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-			       const struct lsm_id *lsmid)
+static int lsm_file_alloc(struct file *file)
 {
-	int i;
-
-	/*
-	 * A security module may call security_add_hooks() more
-	 * than once during initialization, and LSM initialization
-	 * is serialized. Landlock is one such case.
-	 * Look at the previous entry, if there is one, for duplication.
-	 */
-	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
-		if (lsm_active_cnt >= MAX_LSM_COUNT)
-			panic("%s Too many LSMs registered.\n", __func__);
-		lsm_idlist[lsm_active_cnt++] = lsmid;
+	if (!lsm_file_cache) {
+		file->f_security = NULL;
+		return 0;
 	}
 
-	for (i = 0; i < count; i++) {
-		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
-	}
-
-	/*
-	 * Don't try to append during early_security_init(), we'll come back
-	 * and fix this up afterwards.
-	 */
-	if (slab_is_available()) {
-		if (lsm_append(lsmid->name, &lsm_names) < 0)
-			panic("%s - Cannot get early memory.\n", __func__);
-	}
+	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
+	if (file->f_security == NULL)
+		return -ENOMEM;
+	return 0;
 }
 
 /**
@@ -679,46 +199,11 @@ static int lsm_blob_alloc(void **dest, size_t size, gfp_t gfp)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
 {
 	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_file_alloc - allocate a composite file blob
- * @file: the file that needs a blob
- *
- * Allocate the file blob for all the modules
- *
- * Returns 0, or -ENOMEM if memory can't be allocated.
- */
-static int lsm_file_alloc(struct file *file)
-{
-	if (!lsm_file_cache) {
-		file->f_security = NULL;
-		return 0;
-	}
-
-	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
-	if (file->f_security == NULL)
-		return -ENOMEM;
-	return 0;
-}
-
 /**
  * lsm_inode_alloc - allocate a composite inode blob
  * @inode: the inode that needs a blob
@@ -749,7 +234,7 @@ static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_task_alloc(struct task_struct *task)
+int lsm_task_alloc(struct task_struct *task)
 {
 	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL);
 }
@@ -851,20 +336,6 @@ static int lsm_bpf_token_alloc(struct bpf_token *token)
 }
 #endif /* CONFIG_BPF_SYSCALL */
 
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 /**
  * lsm_superblock_alloc - allocate a composite superblock blob
  * @sb: the superblock that needs a blob
-- 
2.51.1.dirty


