Return-Path: <linux-integrity+bounces-7458-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8400BEBA7F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A6DB500221
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F1354AFE;
	Fri, 17 Oct 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q1gf0cgs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D5354AEE
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732951; cv=none; b=s0L/0zEyDtdSSnohVZFbjqPVHkZ8uXeWqNUoTZB26RUjTkYgJcAZq7iIoAwg1fI/zW1BNQjL048SNOTowgVm2GC+UqKTWEKE0AVx+3CeETOxhQOYNn3o93l0yOXXQsncP4SS5A/R1o/h/h6dpn43RF/vUdkbt1lfZW0RmCFjsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732951; c=relaxed/simple;
	bh=u+lXHJINhgCedldTuO/4hbHnp7hpprOksf/zerfYA1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNzlzde5QtilBdxBEH0zBmMXzN5I+3L3MxVn0G/y5A3zy+fgZjh00XIsYq+WWIzPoyjGPL7XAYjRADRbtLgLixht7/UYxZcFzWH2XMJ7LmQrq6xLxHdY19jpvrEtfPPs2pahET8KGCsgvTDZBhuWw9W4zTezGF570Uxz3EJPe/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q1gf0cgs; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7960d69f14bso20020386d6.2
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732946; x=1761337746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3N6LW7dCa1AL+LILbxDSTGCd1z/y+uhctfd8N+j7p4=;
        b=Q1gf0cgsMXKHLpAaGKaYQDuAD6vaG1YabiJne0Z7EkwUzB0iX7NCbt0ayY8yL1XYir
         HoKms51ZI1R5g28dHONpJu/dsQGpCstsYuUFmy3xLV74qqf30ZLZRJ0BrXM3cSN4RxBS
         vsjsv9BGWE0GLz/HMHgDFFkvm60h7Cip0IfnTs2zK+fDHLZozRn1wXw5KnJ/dGRxrKbn
         sKTwUYzfCOWLIRepAkRkXIT6ysSuOMNGaMVBYOGhXGc40YKTQkUq6Ge983liQP64IWV7
         TVzrcncGLGH8YJk/gb1Bnw8qeiimkFn4h8NhAygHtYui5mKIKFsxDC1XP2HQq/ySQocl
         /4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732946; x=1761337746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3N6LW7dCa1AL+LILbxDSTGCd1z/y+uhctfd8N+j7p4=;
        b=dufpNyKR9lgllwuj0hA5qZIXkpiooCZmacqdiUDP31gYLAqzQZMhTGq2SE9hU0lCtj
         n9/+HH2azkvetkqJjbYX+02xWwmgsVL4T8fJ8zwp16XmVFDQdZ6jdYRUvbN/WpHV5OkQ
         MyyCnFyqxtZR5OqXV81s4ZQA55Wgu6sFwpdWjxMaRtzWlOUfHlCFfTaNARTAuo8G1am6
         Uzlz847BZixdBpRpwDEqs+UiGrVbDJhB7mhD4jZvKxndEhEBxassaA7LxWSDMpb6mPPZ
         Hyhh4Sazo4Hs0GQUmQG9EEXd0M7JQL8uorAAWQ3zble6U7D4/kwWD9KbOz9bgrX25pW+
         vS7g==
X-Forwarded-Encrypted: i=1; AJvYcCXk5Rw4MVXz5hZfV3vdlC1ZorV0QzShql9ii2YplYph0Tb05sgMwywXfZMZLwRwFkbcaYINtAlFAeJrDAdtzoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bM25zEKJ6EF1Y8zEsNfLtThtDyGqTgCu5KlRFTuj6HHZXSgY
	iuhShTRlZbAog4g3fyH8xXXnIn/0EM6IfjNgH/3E6D0iUMdZUxhes/CAFY6KoV5DpQ==
X-Gm-Gg: ASbGnct+kQ/e1T3tRC61BNLu8FPFWYuUWpqEdIMU6HV1Tzyzl0ops603w09ld8WRsc2
	9DckUkUH6gppgFhDfINAwxK0QofnCciLcJa3RcPCT8aYEqY6+xARq2d5/FwUsI8/zTkWq2yTA4d
	GSLWW6wVUi2BKpnpBsWXVd6lrE0C+XXGxncmwX00jn+Gu4Wsh435sYK6mQR2qjQZMwbYp9saEJL
	Fj5mRVrTshZ3SgmHebstjIkKC5NgcO/NLQeMJcFbibUoVYsqlLtolUoYVByLuab7pavEYcZSTtp
	/OVmjXjH9M4I8hMxuUAEuDbo/98Il5RJu2CA6fM8ydWcJTb+fUppxTjDh1MEAullk1ORG5rDmWK
	dQ5CGMWVMP9HxA4UKP/gMFTtJ+zZe5bhXN8H1/KZEumsNKaJKeWRf9/1CyWi/8NZPx6nBWycVUc
	O12rDOR2FuZqK2aigzGkBi846jtMsTWQrhHf+S6Myqm1ViCQJc55olf+vO
X-Google-Smtp-Source: AGHT+IGkdGaHCGdW4cIozOX+ZUbSAT5DnsWzJ9XUp/ech7LqMNrfIRMQAbXQqo0nIMJkm+AZWe36jQ==
X-Received: by 2002:a05:6214:2f04:b0:87c:208b:9555 with SMTP id 6a1803df08f44-87c208b9858mr73334376d6.30.1760732946082;
        Fri, 17 Oct 2025 13:29:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521aa2bsm4979846d6.15.2025.10.17.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:05 -0700 (PDT)
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
Subject: [PATCH v5 11/34] lsm: get rid of the lsm_names list and do some cleanup
Date: Fri, 17 Oct 2025 16:24:39 -0400
Message-ID: <20251017202456.484010-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4784; i=paul@paul-moore.com; h=from:subject; bh=u+lXHJINhgCedldTuO/4hbHnp7hpprOksf/zerfYA1Q=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY5Gm+34o2DKTeBoyDchMNSIRW5HH9QqfFUN hDj+ZqED9eJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmOQAKCRDqIPLalzeJ cwzqEACTQw3FP+Mol3blpvqaBBRlqWu9Xteb2aTwRRmo6n8pOC6vgb9dY4NoKvGS1qott38U/Ck h4V32+nA5sqbBZMTXE5m5wWAoP8TihDJdBv8ODwF9MgGv0da70h0QTWViiAY5wBt034xP/2VP8n PTdcW34tiM5Mty8fICYmZlWMQfsRA4+0x+KosqlI691L+tklX1Kpwd4FGchsZxacVat0zdr9blI Z+yaqSClZTtyiDYBEOk1CDyJqV46n7oPT78SJY4u3fF1YWHVSB2iP4cXDWdqIAuv0rNNsDFpuJI Lz1xMpDjNFsHig865o7GJnDPfUmv69ibn9gyeMu6U5SNPozHhhBP0BVcfUFljO/wmFHOFUIDIB+ F7DmK+z5CRvPAtKS8nMgoboF1Uc+7C1+ndV7xXNs+SzrgzOUkqe2kDxF/czdMrFXPYeoeDFvHGr 26DDxi6fY4RdipYNw9WO9Qz9RAYy4kKIP/PgBjb/i7T1Vph4y5khIthvjE2gAi+1Zrze1dlV2wJ gZaGjYp9Z8xek/al9V1g55GxcPefSk0Xw/yBCCz0fol8y8vCurSOLObQdphAAOrCd7+Emk4ar6n RWvyrDiOwD8xkCvHMQS0Kc2Aw/Aad6YJbL+GwmH/9+VoR6OajRT9eecFvfe1vS3fkb6Rj8K0IKt CQHi6AEn7qIEtrw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM currently has a lot of code to maintain a list of the currently
active LSMs in a human readable string, with the only user being the
"/sys/kernel/security/lsm" code.  Let's drop all of that code and
generate the string on first use and then cache it for subsequent use.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/inode.c          | 43 ++++++++++++++++++++++++++++++++--
 security/lsm_init.c       | 49 ---------------------------------------
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7343dd60b1d5..65a8227bece7 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -172,7 +172,6 @@ struct lsm_info {
 
 
 /* DO NOT tamper with these variables outside of the LSM framework */
-extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
diff --git a/security/inode.c b/security/inode.c
index 43382ef8896e..6620c3e42af2 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
+#include "lsm.h"
+
 static struct vfsmount *mount;
 static int mount_count;
 
@@ -315,12 +317,49 @@ void securityfs_remove(struct dentry *dentry)
 EXPORT_SYMBOL_GPL(securityfs_remove);
 
 #ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
 static struct dentry *lsm_dentry;
+
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	int i;
+	static char *str;
+	static size_t len;
+	static DEFINE_SPINLOCK(lock);
+
+	/* NOTE: we never free or modify the string once it is set */
+
+	if (unlikely(!str || !len)) {
+		char *str_tmp;
+		size_t len_tmp = 0;
+
+		for (i = 0; i < lsm_active_cnt; i++)
+			/* the '+ 1' accounts for either a comma or a NUL */
+			len_tmp += strlen(lsm_idlist[i]->name) + 1;
+
+		str_tmp = kmalloc(len_tmp, GFP_KERNEL);
+		if (!str_tmp)
+			return -ENOMEM;
+		str_tmp[0] = '\0';
+
+		for (i = 0; i < lsm_active_cnt; i++) {
+			if (i > 0)
+				strcat(str_tmp, ",");
+			strcat(str_tmp, lsm_idlist[i]->name);
+		}
+
+		spin_lock(&lock);
+		if (!str) {
+			str = str_tmp;
+			len = len_tmp - 1;
+		} else
+			kfree(str_tmp);
+		spin_unlock(&lock);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, str, len);
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index d40f31e79bd5..574fff354d3f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,8 +10,6 @@
 
 #include "lsm.h"
 
-char *lsm_names;
-
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
 	}
 }
 
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
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 		hooks[i].lsmid = lsmid;
 		lsm_static_call_init(&hooks[i]);
 	}
-
-	/*
-	 * Don't try to append during early_security_init(), we'll come back
-	 * and fix this up afterwards.
-	 */
-	if (slab_is_available()) {
-		if (lsm_append(lsmid->name, &lsm_names) < 0)
-			panic("%s - Cannot get early memory.\n", __func__);
-	}
 }
 
 int __init early_security_init(void)
@@ -488,8 +441,6 @@ int __init security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.51.1.dirty


