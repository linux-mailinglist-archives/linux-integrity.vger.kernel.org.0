Return-Path: <linux-integrity+bounces-7130-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A812B7D41E
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FA62A040E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C0F32951B;
	Tue, 16 Sep 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OMKstbqz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A74329506
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060866; cv=none; b=q6vcUVeq8CH6U2ENb37ly56AQuATMrI7zNS+ljCD49FffrA+6pDvicLGJgIXNctS68Jeidi4e4VS4PNyIdl+1iH7BBJuWt7iTNjVVAoBletQ8t2rkfDYmNBAewMgosQzqGCTA761cToJIc3Jf2V3sy9dethmP5dbTaJdhKVs/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060866; c=relaxed/simple;
	bh=MdOdl403AAmx6EaK5G/kf3D0ZcnIWf8hQtg8Cp8fPQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8GPenSTDFrmOlS7FR4PdtAY4fPAaRCiZyUYty+evzPV2BaT2LGlW0OH1AueaAcG1ZILxuZAk8Bzecr4a0j0OYD+y006iD4WI4woNsQ1T8d8EJoufhTlK5kbycDUXKmmIJc85aAKnf8hY+kN4zjVqURKJUPl6h+jCAjCAUxhwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OMKstbqz; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-80e33b9e2d3so530093885a.2
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060864; x=1758665664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00LphZFGZPzPYCxzWmyeqt92KKRcJk2FySWOF+nsmM=;
        b=OMKstbqzFzc8RH3Q0+vuaCpJ5p0LkGHf12yuHF6dMr5+iqo5h+kHP7xljN2YqRmwv6
         kYErnwDc2aeQ8ZNsme0ySYpb6GvHFOOPBGKTpKygbVbkmhcp18j1MEEz2vXuUYXH1ZKz
         Gdg5CU8gsuA5POq9roJxBbQP9HY5Dt+FKXCr5cZUpS2zd9mZPerWVfj8Fg7bd6AArWYk
         j9e0x8CiNk2ZPLGiuVoWpvCZzELbWVpOJw5QnQajm560js+CfXO+Q7j1trmHUWlbFSGC
         okJX7tDfCvR3ZTiI880PiryUjfgtxs0BlXqIv8n4zUTrL85zDZueVRTZBXvO0kO2HQMw
         iNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060864; x=1758665664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x00LphZFGZPzPYCxzWmyeqt92KKRcJk2FySWOF+nsmM=;
        b=hgIKvLwiIgeQ0vEGKyo/ibUlxBoNTR7iYsQIOAxX72s1IaNvZkMqcYh6iwThvkMSj4
         6sESxNzSCk/rOaP5Xlo4aRk7P41D3yNLnWPLVXXiOBJyyDWCFGKnoWa2pTQoAXDDp0hU
         aiZutpUhmKLq4yWw0QSE/IgPlChYTfV9rw8uoW0mvdvSEp7odVpPbK/HDc33/f+LLHxg
         MyZcLgaRuX9ylwcTP/kkbkrSFNGnzhIhIUt613tYpmAjnkrPM44MDRB13reWEdgtzYh0
         gnQsaarFMGj2SwENixRzrlHMzgROE43A3YbcPl8dT+FCZQbGTYHRu8LgKHq98cKUEA6y
         HbWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAJRZ4coxspP8t2UvhpuQbik5pNlhiz0fiLrnSieZU7e9I4fdJL79xcVhsZFEahAEStCI9CzIjPCun9q0884=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzz+tkA+sC9iN7pWKzTqnQ0E60/8sqEJ6EwFLWTRydOMwckEHG
	r1/yuINg0Gy8tFRQrqdDmx2BvWbwe9KC38SbfegsXCJ9g5Qy2v+d1BVY568G+BNEgQ==
X-Gm-Gg: ASbGnctMCXTYPG5OrdTLdnZknVwyyzvRMzZY88ItJdTMXO913uCnMSS0rK5kcCSofQz
	uqSSefDDrSTLRs+n/VsOI2gkN123gRMA951eKkQEqXP4RYVeppwZLh4BxVWR507mrcM/lpr8cf/
	Wa8MDkhYrvzXM7hFCB7ZHbzPWraBc8isWZE9wgWXnnDU0T0IW10cuwboBRNb2twhIAkaIirS2gx
	C0XU54VO/b6q6759Z2Hm4hTDEEh1AONyE7oAF2aJ2Ma24I5z/Sl5Z7QFiUJRZJ1XSK0HVGkTnQW
	Ue9yyV4K6lNtKf5b4X3EZdj+0m8pw+MXSGIDChHbV0I5JnieDYmFoxzXEPFgbPLy1EL2pBEjx5J
	z56lxMWTbzvboYGBXdL68EjamQd8npFuEZpFyG8UEKbpKwyNALDPCurGuPmtmOPc9ov9k
X-Google-Smtp-Source: AGHT+IFJ8lVgzisrCe2bzObZyVN9BQbbCZHhb/QDlgdNZzPxBKSHumGJUW/uUobyG+JtQQIALoHLxw==
X-Received: by 2002:a05:6214:2b0b:b0:783:f54f:4187 with SMTP id 6a1803df08f44-783f54f4237mr114207056d6.28.1758060864279;
        Tue, 16 Sep 2025 15:14:24 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78040544175sm47988186d6.62.2025.09.16.15.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:22 -0700 (PDT)
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
Subject: [PATCH v4 25/34] ipe: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:52 -0400
Message-ID: <20250916220355.252592-61-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=paul@paul-moore.com; h=from:subject; bh=MdOdl403AAmx6EaK5G/kf3D0ZcnIWf8hQtg8Cp8fPQI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8b2iWUDC6m4rypPel7juaV1r1LKgrmw4zK+ Fo/ghII3K2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfGwAKCRDqIPLalzeJ c7WLD/0TINdindUyMl3edV3z4QGER/marIc7uWKXM3ULz+eF5oHI+rbx2NbIpPjfnk99nRpttxP 2J5WDjV9g+OggM0umSQlqbgmUwKkZ1lrHINxE+IrlNbGK7wQefNeL4OjQT7Rq6o9sA3E6zdAjr5 fCip3LpC6Q7Xc356y8fVtEdkFEkKVjRwX5n8KV35+A0juueXC2lBcqU3Yrt0Yl0CkDjFDQEKWbG UQqxYqSaD0ZHS4U+rPfh2XkqLKEET8ApRb3NSCVaZJFJhUQNtnVsEwgBTFlFhIT5XbE/j+WKsvF EbRFFzkT6fn2AXJFBbbT7Qgfe2BsFZfynw6YdJvLBO58G+ip/LJUeWPWvopguddWFXc3LKGdBTa nPTHx/FRcPDm2GyjXYJ1ARdgDEHZ4VUj48Plc3Q5H9o/QEc+jc+QuR5q09yI4edlPdFHqA+L8Y+ ok31mSkq85XjxB9BFOngxu1Df/iTBpVJd7xP2Uz55ViEM1Wna8B8b3p6sAyr+GZz2CtxFpJLT1w 5r8uBqwFsqljT/D1YMMF96mwtxzMBFt3O/k0xTe7+I6/tn5nqvk9tGe49J+yH7tuIvfwS2ilIDI aM1O0fFku9DhKDZzay9j44YTXka/L0UTuURHN142AWaSqntrMhsAenBhEUIa5H2+T2JVE2U0AZd GaANnn/t9QwuMsg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 0bb9468b8026..076c111c85c8 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
 	securityfs_remove(root);
 	return rc;
 }
-
-fs_initcall(ipe_init_securityfs);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 2426441181dc..71644748ed56 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
 	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
+	.initcall_fs = ipe_init_securityfs,
 };
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index fb37513812dd..25cfdb8f0c20 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+int ipe_init_securityfs(void);
+
 #endif /* _IPE_H */
-- 
2.51.0


