Return-Path: <linux-integrity+bounces-6690-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ABEB0CE16
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A55188BC42
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8D2561AB;
	Mon, 21 Jul 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RMO6Rapk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBB1255E34
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140274; cv=none; b=iIVWtsGCnKAdAX2wOGZcy0Yp4t3oV983/DALuN8B8xLfYeYTDYPAphTH52d7Ldg3Fw/yNR9gIPbGcMDW5S/QWCKjONxWPpjv66KCTMIeuEZ3sFkJaOn3JrN/0/hLpvvZzgN/N/ZA0jaA2FfrFxW/wuM/KumJv9keF6wuYNhsECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140274; c=relaxed/simple;
	bh=+gdQ1Czu7rv7jdTTczvi1RYieE4Tkxnqe62OiAJK00s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnPC4V+fAQgymh7VyACKAHGa/1fbgxvF2VSo4sx3vJ/BZsFDpV0mdad3XiIVY3MEoXft2YgOZM9MzsG41Vbj344e0PshbLp9yVjOY/cp4hKoZAS87aYTgUFq+LqnY9Ez0e2MBTU2rWDDEhito0OSkLbGeoEYSz/Q064b1SzPEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RMO6Rapk; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fad79433bbso43810496d6.0
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140271; x=1753745071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiA+OJUaAzDTv5PHcF3sh1p3tu3Ya4mB63tPg4bKqH4=;
        b=RMO6RapkzDCyp+WnyVhxL7lNRuTSKPP+nXFeL+OTf/lfhokG5yndvPPuerJBYJmxtI
         PYYWLF/3T4BKDasNOp0J21UIEAnizRFmI3AkKb8FoMpeCnFJuFpej1UOygr3jB79C8QN
         yyKAtLQiHgPJ2+0PY/LuXAlEsbp5LiZsnAss57R8MCT5rbik2ZzPyB9JXe3EXclwnvza
         k8e2J2/uSqGxESC2vSug0tY25hLqi07frR9V1RW6ictSr16h3YVM2hd9ts+9uEV1Hoy4
         UyCaiAovie3Lns+wUdt4ji/kT/s8kKmvWR58UBiRgsuO0MzDAXH7PxyxwW5+Cgoe5USW
         gFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140271; x=1753745071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiA+OJUaAzDTv5PHcF3sh1p3tu3Ya4mB63tPg4bKqH4=;
        b=oFH+z1QVR63vMV4OyYd3KMrtWJic2sGaBKxLXziZBEhPuEGsDfDx8wlVB8bShqjJJH
         6CJYBfAvIKCvilH02sG3XWmgYKQhX7rEiUyLuF1dvMfUYBk391uh8M6aTonJGSbnipo6
         Tdoy93llI8J60VSR/uUCJECQyVGqHPNu3/oEOx8WqCIw9p8XdjKQv9vSjFzc4nEDQdqq
         EmYH5m6t+wJpzgWoD8gbetTf17xEcSFAzAI9iN9on7yUAcORgmOx3vgVXgkBZPfl+axU
         9fBxrb/N4gpt8eSFvJHDZdFyqT6vYjua6FfOj5oVT0VQeiqZn5uA7jWGPPcWr61nhee0
         8s7g==
X-Forwarded-Encrypted: i=1; AJvYcCUOOO3+rn5SKju6OttNtw6D/QR6ENIvSzT1VI5eylZ4P2CF0lFswQiJzVGpeBV34YTFkQlPv9xYju4bbvR6qhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLPZ5j9i7SpO431CPYcOboIbsXBvDiawLofrPu0mjrF4uYT0rK
	frXVXUWImU9MVVIUgBDhBJh9SFOAwO5+qGNmVGJoMDcbf3Rn/lbGXjjT9mD8yxaPmg==
X-Gm-Gg: ASbGncuPLzoCgF9xQ4zHujHnMQE5yoRfQ8b3x48WMdebzZ7SRz8FbdCiQNfmg1aitE5
	kiFUfBAw9macGhFAj+TVrYNUyYRLS1hsz8fQv+oMZCrdalYI9z5Z7giYYAr2c58q/CJDLjpltCL
	eKR0GdW07QRhEKVlL8Oi17SrlcbztgxP28tuja0RBUuqNaz+AxokYd/mCeyMWINsBjrNbZhOcFD
	y56kw5b+Wh6Iekd3T9Ows4vRUmdx/Gm9DQp0ibSamGw6CQp7JSv6LZOHEIWvvVDjRBWeOjDzbg5
	/SPG2JUIi3rBbKgTlbIfUKqO3AnfEZIXhKFAi6jynYVqaZQkQwUQHgDYxpsiJw0Hno0m2ueNZDU
	ud/MhNBMK4BK7oazRyHmwCbMFk1gmA5XAKmtTJnpSD9/6y+3i28OcNr+oO88MftFGjz8=
X-Google-Smtp-Source: AGHT+IEJYlolQFTaUn6HdlFtxzYbq+OWBtBbLKQwUX9IaoI3NSxY1nHpuB/NK8zVy0VsghQAZOws0g==
X-Received: by 2002:a05:6214:c2f:b0:704:9bc2:be36 with SMTP id 6a1803df08f44-704f69fdcefmr429300856d6.7.1753140271240;
        Mon, 21 Jul 2025 16:24:31 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba8df3fsm45917276d6.79.2025.07.21.16.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:30 -0700 (PDT)
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
Subject: [RFC PATCH v2 29/34] apparmor: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:32 -0400
Message-ID: <20250721232142.77224-65-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564; i=paul@paul-moore.com; h=from:subject; bh=+gdQ1Czu7rv7jdTTczvi1RYieE4Tkxnqe62OiAJK00s=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvv6v4jeR0i1ABMksbYtivuhAW46UQ0diKcZ EBKoa+lOO6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L7wAKCRDqIPLalzeJ c3m6EADW6MDxdj8pJsfgiw/fl7aMHs4m700QgWzXJYmHHH7HRXEV/xeooRmyRUFw7+5oKTVwoD/ YPrhY/PiSRlNJqDdjLXBiuoWUwFmpP21JfDNd9noEE9k4qE5AbrUKlPro+y1Py22uoytXogWXty 8LBplAGhdPIInIEzZcjhsps88bpB6Vk/vTVyiL2xVIzec5BOfq8XD7+XEYETDqvIId1TRjvNWew ERknhdwCk09irU9Vo9wYIeTak867TvWff5v1KFgC2UkQN0QmHXFsxvU/a7RBE5ghJiENvRhS9oI cn7PS3D1dX8q5Wh1lFD3tUWdD81tA/uBLLX1ZyU99vDg55mg72M3k9NIQo93PoPiNPhb2niq5Cv RgAanmcx76UBs4VVN/IMBeXd0K0DbMEspFb1HU1rtjzVbOljNFDoyIZY3iB7iirt/8ZYfx/UuLg 63qpJ0SBeg3Hn0hvbkpYnG2ZSzdSQZYMG6R/LGwojPkyWkBIdcXY7ouSvZgnuAJkbc41uecM1P/ p7rZc7J5eQeE9XRABYr4sndvtwV2P5U4T0rqt5LRS+U+JIQ8JZumj8RVDDfot/vz1YWY30+xhwN v3zUYgUXoLO4lUf9A9xedmC5JEQNikht9/1lQb6UrLNtdzKQMaOVRoQ0v5+L+dQ7ffqRqdxjGdz SrZguKNQPcNs61w==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/apparmor/apparmorfs.c         | 4 +---
 security/apparmor/crypto.c             | 4 +---
 security/apparmor/include/apparmorfs.h | 2 ++
 security/apparmor/include/crypto.h     | 1 +
 security/apparmor/lsm.c                | 9 ++++++++-
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 0aef34b9609b..02fbc7aa072c 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2632,7 +2632,7 @@ static const struct inode_operations policy_link_iops = {
  *
  * Returns: error on failure
  */
-static int __init aa_create_aafs(void)
+int __init aa_create_aafs(void)
 {
 	struct dentry *dent;
 	int error;
@@ -2711,5 +2711,3 @@ static int __init aa_create_aafs(void)
 	AA_ERROR("Error creating AppArmor securityfs\n");
 	return error;
 }
-
-fs_initcall(aa_create_aafs);
diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
index aad486b2fca6..e4395c1bfac5 100644
--- a/security/apparmor/crypto.c
+++ b/security/apparmor/crypto.c
@@ -99,7 +99,7 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
 	return error;
 }
 
-static int __init init_profile_hash(void)
+int __init init_profile_hash(void)
 {
 	struct crypto_shash *tfm;
 
@@ -119,5 +119,3 @@ static int __init init_profile_hash(void)
 
 	return 0;
 }
-
-late_initcall(init_profile_hash);
diff --git a/security/apparmor/include/apparmorfs.h b/security/apparmor/include/apparmorfs.h
index 1e94904f68d9..dd580594dfb7 100644
--- a/security/apparmor/include/apparmorfs.h
+++ b/security/apparmor/include/apparmorfs.h
@@ -104,6 +104,8 @@ enum aafs_prof_type {
 #define prof_dir(X) ((X)->dents[AAFS_PROF_DIR])
 #define prof_child_dir(X) ((X)->dents[AAFS_PROF_PROFS])
 
+int aa_create_aafs(void);
+
 void __aa_bump_ns_revision(struct aa_ns *ns);
 void __aafs_profile_rmdir(struct aa_profile *profile);
 void __aafs_profile_migrate_dents(struct aa_profile *old,
diff --git a/security/apparmor/include/crypto.h b/security/apparmor/include/crypto.h
index 636a04e20d91..f3ffd388cc58 100644
--- a/security/apparmor/include/crypto.h
+++ b/security/apparmor/include/crypto.h
@@ -13,6 +13,7 @@
 #include "policy.h"
 
 #ifdef CONFIG_SECURITY_APPARMOR_HASH
+int init_profile_hash(void);
 unsigned int aa_hash_size(void);
 char *aa_calc_hash(void *data, size_t len);
 int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a7f6a3274682..2fefaab6349f 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -31,6 +31,7 @@
 #include "include/audit.h"
 #include "include/capability.h"
 #include "include/cred.h"
+#include "include/crypto.h"
 #include "include/file.h"
 #include "include/ipc.h"
 #include "include/net.h"
@@ -2146,7 +2147,6 @@ static int __init apparmor_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(apparmor_nf_ip_init);
 #endif
 
 static char nulldfa_src[] = {
@@ -2277,4 +2277,11 @@ DEFINE_LSM(apparmor) = {
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
+	.initcall_fs = aa_create_aafs,
+#if defined(CONFIG_NETFILTER) && defined(CONFIG_NETWORK_SECMARK)
+	.initcall_device = apparmor_nf_ip_init,
+#endif
+#ifdef CONFIG_SECURITY_APPARMOR_HASH
+	.initcall_late = init_profile_hash,
+#endif
 };
-- 
2.50.1


