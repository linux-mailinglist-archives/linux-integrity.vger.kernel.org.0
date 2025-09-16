Return-Path: <linux-integrity+bounces-7133-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BBB7D484
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE1B2A0898
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A68A32B484;
	Tue, 16 Sep 2025 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TYz5JR5G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52D307AE9
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060872; cv=none; b=r54XtFiTVbaPKWn4p6UdcjU9y+yMa287fWYCa5v79DPk4NwtJNz5TTt6KOnHs00XJlV+Kpu4hxD88mBG8RqQdGbqpZWowXNyoY1ZsEMuYm2Wv9Yzx+L628V4UXryXvn0xlMpMaYBHgeOGWZJhfQSrhBDPXFdRlwZY057RC9ZESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060872; c=relaxed/simple;
	bh=a/V49kLSKtGG6Su9YcwPVXSqjWuSXtkOHwF3bku/bnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pV59Pii1TcxPwUIZjOTAvRdXaMjVuyc1+oxTFwPGvEF+i1BFprLvhCGdPQPtyqMnb6OJS/U93PkDGiMiZhKfeb9wVOtwUzLF1tEEls+x8w+kIdSkzqvfgjLJEZRzgf9kdekmyY9Uy+wVf/GsqDzb3cvjMhLYFejNIEczDmC/Ql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TYz5JR5G; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80e2c527010so382188985a.1
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060869; x=1758665669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqEdXP+h5cgn5aUTyFbpUadd1OBxruvOR6+xm+U/M5g=;
        b=TYz5JR5GanUEzxqlgvM/TOHgK1mFgSEzDqE8tdFJVJik7aESyKgGrhLzY5gJqX2amD
         JcV5kEo3aWE1O6jPr0mxX+6fAZjdOke1E67pyoQokgNA4lUESp8+Uo2w0uTngW6U4OBt
         pkszyLjJgwGaFK+1NBJOO58lvU7Wa2p1GWJfd+7TQ/ZWzMCfoA3PCLjzmUSgngquMe6R
         Ol1/yqmX5UebOXGJ3O+lhV0HaT7so9xAVqTTfJyAK7NESuY1OJc7BZi2anNa2EwPxbjR
         dHYHHsaEpFKy3KA0nvcHXEeas/fxpLsHjbosn6gAw0lkk5mwgxUPgEEh3lICcV1yMYiV
         /5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060869; x=1758665669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqEdXP+h5cgn5aUTyFbpUadd1OBxruvOR6+xm+U/M5g=;
        b=og5yj2Yo/HqbisWDcjfAsbJgIRMUURASmH8MYTlfBV2SZcXwFI6XsSzYJy4+Rf0VlW
         AsD4Ux1pdSLjsGJW1fv9ONugirclD90zz4LV8bQiINP6zIzrWGwTA5+qJIOvsjC53dBz
         NEIXrfCAIVlXQ1SQ5mON0mdfOcgbUyIAtREe7/oEaVJz0JM6WtiDYLA2whEDbJG/I9qx
         r1sfvMc5ZBdOmCugkVCT0gEJYNPOrPS1Z7Jb6L5gc/K9V8CfRhPxVNYzQl2UVUIZSzuz
         UKVnJRxxqoeGeklxwneFV4aTRqkVat0zVe4LMZsepnW6HZe9MgdHB6E1Dj5Ps5SX5bBK
         KIaA==
X-Forwarded-Encrypted: i=1; AJvYcCUpseSpafAmnTtwissSwzjc34jq5U279eorYIxNv3oiKpiwg+QmtEClKsW9Q+JIIkX9XPecWsg+97/sCQNQ1qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5kJNx8rF55HRHyX+g2lInJ2PYwBr8QzECdh4sDj/0pcij/1rz
	jUVjLPFiVBEcspRABe/pV5Sf39XLh+arYdJLEZoA++IKpM4JEiH+I9BnXuJeswL9cg==
X-Gm-Gg: ASbGncvgGJJFzfJfSHKmhBE6fIw5KWpmo9h7R27D1YXtnUo8o4MF79BsxWQZjQwoAU5
	bHzAWbpp25CNuAdorKHVvBP/8X10rhe4xXfMHhpYks9L2pu3qzIT0xz/N91/zidAOrL7gVb/ewg
	JZ2BuHcpzTNOSusByf3hru8n5fVnG+WmzTsKKqa8OkihQnZhN/lWLfxhNj/SGLZnnX1Jr1mCoVR
	UHqMfq6dbikiaAsNecQIpYKDVhxlLSY94d/1NPpl7JIr8Bcj8c3/IFDzstYrEfn0APF11NUs3it
	Uhf/GcUZFBj3yEzalbgEG5C4UceNncwXlIeavsTi4+i7CcmY1Kr3y8XpLeQ9cE8T3Acw4anrk5w
	V7nXRorVE9PVv1B64S/LPFUuX5mEwtMQExRbGsLApcfQAbbBYh/Lw8mLPo3E2AyFy6icI
X-Google-Smtp-Source: AGHT+IGwnaIXEtPCsUr4ecfBhenFTu9eSJIfPQ+Z8jGoBCKJsOoPDK/OIr/b0J1j6sIaaclyymaJrA==
X-Received: by 2002:a05:622a:3cf:b0:4b3:4fdb:f2a4 with SMTP id d75a77b69052e-4ba6b93ee64mr896491cf.73.1758060869586;
        Tue, 16 Sep 2025 15:14:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b7a9e98f12sm32966181cf.9.2025.09.16.15.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:28 -0700 (PDT)
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
Subject: [PATCH v4 28/34] safesetid: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:55 -0400
Message-ID: <20250916220355.252592-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1882; i=paul@paul-moore.com; h=from:subject; bh=a/V49kLSKtGG6Su9YcwPVXSqjWuSXtkOHwF3bku/bnc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8kzWm3iBISsjtxkGxWRBbxUTgWmeQShsQw9 jGMHW8P5DyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfJAAKCRDqIPLalzeJ cxHTD/91e8kfGyFQqfXAFm42CnRYKTkZWeIEAy6BBDXum8ilT+cssdzqR5Ap0+hTCdsp8nuY+KN k4VqyLs0QP3M0InBMyuSQnCEjFbZYkUhTqY14FH3AHdy7xqa1lBauD+wtryD2QLWkQmndCb+tXb 7hmu9/ihhzvIobQslLK9jJIPX+6V2FuiFNjGSX9ynpHkSTnN8A5DzT0bmPtx+8xsp+cMVSahYao 954/5DWCZMFmoUBl0R6hDw9kYsOTOT6ZhG9PCuWz/ozB74O91Rt3VedwkJcjCJfTVOOp//1RsOr SIABMSof70mpziLin+NM9VcB0KvzFjov8c6Yd3YZL3fCL1dR5J/NWE1aGAdopLnGpAp6IGInjnT Hh804Gl/JRkzw8BWfm/sdKtBK9ZfdKEZ8hDmIQLKKgNN2Yt7JOL+sfF/dBm1qAGsmk6em7omZE7 YC5SVSG3pCu6aJBafilt9K0506WVsawurUb4EXrs9L/ZprxstI+up41dByI2XN8i8WCpoSgsRUG 4ywLvSQOJ+VbcVDQqn7Qc8DER04r9hVIeOBwztGDESDPlFec9wa2UUTTcTI3YEGm0G82y+jGvqo 0bM+kWHYovpEOlT8d4qvJH56kGnA0h32s+XEZM7R35749TUmBa17rsmQizkfelutgJW/ZmMorF6 33Cf+n30MrB5rUA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.51.0


