Return-Path: <linux-integrity+bounces-6672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CB2B0CDC7
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C8517BB87
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F9248F62;
	Mon, 21 Jul 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QhDcsUuh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E5248F4D
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140253; cv=none; b=Qo4y8GDBaIHIGYJ71Xsdq0IlRNM3Y6rMbFLH3V6j0c0xfmcgzKcHpIsSAAjltcdxcg+TkkV19K9oFSu47AnTJAvBOhWolR0MXg67aMpK2M2IYSWmx7fzN6CzWdnG2V52CUdrDjc0HJUUtpo0Y5j6pqh27dwnxdKQ2Q7qEvwbroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140253; c=relaxed/simple;
	bh=u+ZKWXFv+q/AmHg3QLxKecr1/KhUOr0Jwtujzf8oUbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACLrRVrqvy6U0/Fl70gaiYu+RV8wkNDkHUefkSr9jIHvNPQzdd/LZylSQCfx91fDfYI9yHE6BjaymLXFf1KcZIQAMgbqQRjWrlFo2pfg0Q6oPO306i3AkC6l6gLDYv7AkaH8B9eT5kOjGu+y957XTUUJLbQRO/a3iQCQDcF53o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QhDcsUuh; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e346ab52e9so638457685a.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140251; x=1753745051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNWPn7nTqNZda+TlIn0lU5y+lxqkvC1F/V9eFQy6zo4=;
        b=QhDcsUuhfk53q2VOert+lsrIvrMcDVCu1Mj6XiXYr15XOi5b9VN5rLZ5/nyBW1lPZ1
         HINmd4p1/7qpXynEzJeJBjPxIse0xM2BKD87HA2ZXaXLacMXMoOTGSAh2qZCkGz8ppJx
         IjuGTt0sZaLSY7FU+tykZhvPwovwVRF0JUWJAnM358uMYrOjB5Vz169DLXVJoCvtu1Bi
         SskhzE2nyCL7/CnBgDaszrsUFYo0OeCMdlZ3l7EyRzOVX/Ws2mlBYZ393KAAbqeQHFbW
         wlSYVl+1EF/ocWRRG4ol2TMLocrNtLGezRj1lHCMx2SoCJcy3zgiKm/wC0fmCW0K2rN2
         O4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140251; x=1753745051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNWPn7nTqNZda+TlIn0lU5y+lxqkvC1F/V9eFQy6zo4=;
        b=piTvsMHd2jAGZIrTNqsuk9KP7p3rpRy5ix5tOktMYexcPQ6VU37orOsl/RGe9/vlA4
         I0ka2gC4/UH3Xk3ajHIWUMPhq2H1kn5kBlqAvi49STewSmi3Wtutd7AoIGGlheKG6CSF
         j5szOijmicQwddXlYDdO6+HT6TEBa3etm9UyNKJKhE8zurowXufNPgIBFq/mzapXKWc4
         thEHAMz2JcF2CkNh1QPDXIQoQnnbB9SVzrcKT1xBo8B6MILmT6aEc2tbXtJxf1RT9AqR
         oSBommTYHJD9kOJ5RG3BDpkrNXi0DM06EJ4NGrrwYKkOTQVMuYfIqjzpJaI59qNpZ9qP
         h0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWni04VqSSnnqWhayaNIq/HMDU9p5w7Z5vRDhQH55f9WYfRFDKRLbY5EE8eEG67YROyy2zKHk463xS3BS6fBJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TpgHt2G5IZ18hFxhUc4vKnQkF6aJBH5TpQlx+fsPiJ5/biUp
	ZqhhIa6dlg0mLf/DVvW9iPuRPq/kVMNHzaoFe8709RqHcOgJYxxBTEfwLV8xOOvkQg==
X-Gm-Gg: ASbGncssGtQyADAAXEynlTo3+/Jp+LfHruc1QITDC+7Qe5rZ2RoFMOf0VlIRzh4iASd
	a3KHTEdPCgVlvhR+3WvpI8MTdIF9XHraKZQiYmE9CqiW59Lop2i8JX3KFku/jpY5wZzewRmw3sf
	W9errezK9AWtZe8YKAwTHLOfUP4VYlPy9uyjkkDkjOmWRsYvxeVXtgb+3feMysBPh1IlpvYRR2g
	DDUIbfiPnrmbUrCvsnTZI+tSpQWkIlP6QX7iMqvdPUFYSU8ph+asUtwA3tL0D1E+x5ad5U34mtu
	AnJOZK3wo8UYEAP/DMDkbFRdZna7zmlc/2RUBmiZ+8e/9JXun5DV8KS3w31OZAtJUHwbh5cJjLi
	kgZU7ha0f8mqIOexGSF/v5q0VsjSSr4LzHAlrcV4MNGYXIHoT3k/Jq8ZWbUHoSD4vrIo=
X-Google-Smtp-Source: AGHT+IE3fkdJDABqQcYAGQ5t6pvzQVW7Xt/XXaqdI25UQ5XfBwzHB74UsFCaueyWC4RUW12P6ow4Xw==
X-Received: by 2002:a05:620a:370f:b0:7e0:2c05:6b9f with SMTP id af79cd13be357-7e343564a1fmr2979745885a.16.1753140251096;
        Mon, 21 Jul 2025 16:24:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8e3ea0sm45076556d6.31.2025.07.21.16.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:10 -0700 (PDT)
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
Subject: [RFC PATCH v2 11/34] lsm: get rid of the lsm_names list and do some cleanup
Date: Mon, 21 Jul 2025 19:21:14 -0400
Message-ID: <20250721232142.77224-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5131; i=paul@paul-moore.com; h=from:subject; bh=u+ZKWXFv+q/AmHg3QLxKecr1/KhUOr0Jwtujzf8oUbk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuwvrO8OcjxNip0h/bdn9y1Ts2S5aZY8g/Ll PNXuT0tAiOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LsAAKCRDqIPLalzeJ c8nQEACuk2jSYOq3sw8JW46xi0RLVjpqlo8ZT0QPT+bVDFz+EGhsL9NEjI5ww2cCcQP8JGf5J67 6wCyCX8DugFl164Brdg8UHwQlh/YTJ7qKSsPmRLGpuTdsgZJ78tYKqJj1pDedbExjai/LAgKQs7 7pwq1dnOfgx3cmKJFEdPDxSHalWTl9V1MEKxDvWOINfDIE1K+KEUZalSlZz/zkaARvvFqWFLpkN IH6rJiQojIj53dA3t45Xkylktpf6iPU8+OI4XUx+M/MSAUvaS+7NkS0fwU0dH4ROw4clqyJiNDV XQw65LOow+cYGJXjBG7ucl0kuoa/XCmGfYntGbI6qR3iC6Xbs2dXDndhhXKBYqGFbpSanHqwwaG SEq+anYOlRDXDW47pHpwWk59x5/O3ID6e7Pbv2lZlhTQvg28dsxV5oPIlwDR4N7uXcidaueQ5JH 5h8nDripe2IqLs76sMHc2oi6vXmyTq7Cw+hAldDAQZ2FGFJ+v0sfwwZkFORIke+BUV8AiFDUdhY YxnI0ZkC03SdVrvCujmeaousij1aVK4tcBng/p2co1KAJS+RqYKfwUFmgxj5XVeSILnCxbH5sVT wPZTNrJ94XX/7h5V3gXpCGrNYlQPpaAbX65OzpUu4W1j+nYtyBwNQAuS2ONXO89ySJJYOlIhpgI X0NHKi3IYSzsCLA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The LSM currently has a lot of code to maintain a list of the currently
active LSMs in a human readable string, with the only user being the
"/sys/kernel/security/lsm" code.  Let's drop all of that code and
generate the string on first use and then cache it for subsequent use.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |  1 -
 security/inode.c          | 59 +++++++++++++++++++++++++++++++++++++--
 security/lsm_init.c       | 49 --------------------------------
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4cd17c9a229f..bc477fb20d02 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -169,7 +169,6 @@ struct lsm_info {
 
 
 /* DO NOT tamper with these variables outside of the LSM framework */
-extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
diff --git a/security/inode.c b/security/inode.c
index 3913501621fa..68ee6c9de833 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -22,6 +22,8 @@
 #include <linux/lsm_hooks.h>
 #include <linux/magic.h>
 
+#include "lsm.h"
+
 static struct vfsmount *mount;
 static int mount_count;
 
@@ -339,12 +341,65 @@ void securityfs_recursive_remove(struct dentry *dentry)
 EXPORT_SYMBOL_GPL(securityfs_recursive_remove);
 
 #ifdef CONFIG_SECURITY
+#include <linux/spinlock.h>
+
 static struct dentry *lsm_dentry;
+
+/* NOTE: we never free the string below once it is set. */
+static DEFINE_SPINLOCK(lsm_read_lock);
+static char *lsm_read_str = NULL;
+static ssize_t lsm_read_len = 0;
+
 static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
 			loff_t *ppos)
 {
-	return simple_read_from_buffer(buf, count, ppos, lsm_names,
-		strlen(lsm_names));
+	int i;
+	char *str;
+	ssize_t len;
+
+restart:
+
+	rcu_read_lock();
+	if (!lsm_read_str) {
+		/* we need to generate the string and try again */
+		rcu_read_unlock();
+		goto generate_string;
+	}
+	len = simple_read_from_buffer(buf, count, ppos,
+				      rcu_dereference(lsm_read_str),
+				      lsm_read_len);
+	rcu_read_unlock();
+	return len;
+
+generate_string:
+
+	for (i = 0; i < lsm_active_cnt; i++)
+		/* the '+ 1' accounts for either a comma or a NUL */
+		len += strlen(lsm_idlist[i]->name) + 1;
+
+	str = kmalloc(len, GFP_KERNEL);
+	if (!str)
+		return -ENOMEM;
+	str[0] = '\0';
+
+	for (i = 0; i < lsm_active_cnt; i++) {
+		if (i > 0)
+			strcat(str, ",");
+		strcat(str, lsm_idlist[i]->name);
+	}
+
+	spin_lock(&lsm_read_lock);
+	if (lsm_read_str) {
+		/* we raced and lost */
+		spin_unlock(&lsm_read_lock);
+		kfree(str);
+		goto restart;
+	}
+	lsm_read_str = str;
+	lsm_read_len = len;
+	spin_unlock(&lsm_read_lock);
+
+	goto restart;
 }
 
 static const struct file_operations lsm_ops = {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 03d3e140e0b1..80b57aef38a0 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -10,8 +10,6 @@
 
 #include "lsm.h"
 
-char *lsm_names;
-
 /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
@@ -365,42 +363,6 @@ static void __init lsm_init_ordered(void)
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
@@ -437,15 +399,6 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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
@@ -482,8 +435,6 @@ int __init security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		init_debug("  early started: %s (%s)\n", lsm->id->name,
 			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->id->name, &lsm_names);
 	}
 
 	/* Load LSMs in specified order. */
-- 
2.50.1


