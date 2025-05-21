Return-Path: <linux-integrity+bounces-6272-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644D2ABF6EB
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D8BC7A5DDF
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E78216DEB3;
	Wed, 21 May 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="JIVFVAUb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2250276;
	Wed, 21 May 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836116; cv=none; b=lauwsjy7Crb3bwawKgghEfeYL5k6A/rZtM0sydGFC0FJkP4rL1biydL3KsjDZaXYDqB2V4f/rYUDrNKNDyozQWnXVc1dHmv80p29tX8w4StSHnR6nfXVjAhPoeBpVPug3OwIgVcbSr1X5ZyGDN87fSSV1OAzKK+DUpsL1YvJwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836116; c=relaxed/simple;
	bh=whFbhyYR4IgKv9Tb2wGiNsVrC3YE8OQrrr7rxlJwrSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX+u70ZWL9P+prX7C157cv4c9u/WhEBfhkKi96XxUWskrJB4wJNg9EB7icSORTkcHtEE5XIDZUtJE7ldd8BY8CjsoztX98mXKW4Ti9KXK3zdKOTcMd0o4FooAJuTnLog1q532KNnBVq6/ItWZmsJb9kOfIgKHf2LGo+cpv1Y94o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=JIVFVAUb; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 710971087A4A;
	Wed, 21 May 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836108;
	bh=whFbhyYR4IgKv9Tb2wGiNsVrC3YE8OQrrr7rxlJwrSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIVFVAUb5bO36tZNfhpUFy4OEfK3g+PFQYc7g1owDQsIb93a6KMYmwJNqb+grRq5p
	 8lKOKTQCLrbc/Mp/bLErQwXJWYTY44z8T0gj++PH7NjRvckjMAt41EladOutaMfT4L
	 VEQYMOtzr8x5ziaWzkhEgxno2LQaN+Le8kA8XXhN9KlBngYQ2ObrY+HfQD5/vSuFfw
	 guVjS/23MsQvt2AI6ETO4IpZSoAE3j3V/onO3yZC2xwccy2NVCghmgIGwkvLe1yvUA
	 KVyfr5JRlkOLQytf6xabqqNsgnN+3URBQtDaL7PqvCik4JbsU5ajRY0dIELDTUXUh6
	 iCN13+cgxXgUg==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 6/9] Loadpol LSM: emit an audit log
Date: Wed, 21 May 2025 16:01:10 +0200
Message-ID: <20250521140121.591482-7-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a decision is reached, emit an audit log so that the userland may
know why the module load (eventually) failed.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 include/uapi/linux/audit.h        |  1 +
 security/loadpol/loadpol_policy.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 9a4ecc9f6dc5..592070fd3c1a 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -148,6 +148,7 @@
 #define AUDIT_IPE_POLICY_LOAD	1422	/* IPE policy load */
 #define AUDIT_LANDLOCK_ACCESS	1423	/* Landlock denial */
 #define AUDIT_LANDLOCK_DOMAIN	1424	/* Landlock domain status */
+#define AUDIT_LOADPOL_ACTION	1430	/* Module load request filtered */
 
 #define AUDIT_FIRST_KERN_ANOM_MSG   1700
 #define AUDIT_LAST_KERN_ANOM_MSG    1799
diff --git a/security/loadpol/loadpol_policy.c b/security/loadpol/loadpol_policy.c
index 366046f00959..de2b116bc09d 100644
--- a/security/loadpol/loadpol_policy.c
+++ b/security/loadpol/loadpol_policy.c
@@ -6,6 +6,7 @@
 #include <linux/sched.h>
 #include <linux/sysctl.h>
 #include <linux/parser.h>
+#include <linux/audit.h>
 
 #include "loadpol.h"
 
@@ -257,6 +258,7 @@ int loadpol_kernel_module_load(const char *kmod)
 	struct task_struct *parent_task;
 	struct loadpol_policy_entry *entry;
 	struct list_head *policy_list_tmp;
+	struct audit_buffer *ab;
 	enum policy_entry_origin orig = ORIGIN_USERSPACE;
 	bool allowed = false;
 
@@ -293,6 +295,14 @@ int loadpol_kernel_module_load(const char *kmod)
 unlock_and_exit:
 	rcu_read_unlock();
 
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_LOADPOL_ACTION);
+	if (!ab)
+		goto out;
+	audit_log_format(ab, "allowed=%d requested_module=%s", allowed, kmod);
+	audit_log_task_info(ab);
+	audit_log_end(ab);
+
+out:
 	pr_debug("Loadpol: load of module '%s' %s",
 		 kmod,
 		 allowed ? "allowed" : "blocked");
-- 
2.49.0


