Return-Path: <linux-integrity+bounces-7477-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D19BEBBF9
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D42674F25C8
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EF8277C98;
	Fri, 17 Oct 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bnJSKTOP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9D263C8A
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734149; cv=none; b=d9ahPnWoW8UowaEQeIYo2P/S1WKFcStXmD2PbUXciOqsRXcrTm7Tvy/5a/gYyQn0uNVBp4zmMn7996zkjbHzMtbn/3HVA2Cpd6SBuSX5WGIsL4e5IGDg3KHOGbBIwT202ZirstJ/PV7ZxLJLULduA++/qMzh71aGzqRbbgEfmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734149; c=relaxed/simple;
	bh=ErnEjTlP2oL3lgKe6cM77ZFrK56hTD14qS7xELtvXqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ii8Lx6mrw1zQdNXf6nmVKIwG9N69a2GHhO97N8AASU00CyilfVrl6+NQKOe99Glrty9i3MyI5YQ1jKlikhc5lTKHfBgK9vRwjKUA4tExC054En71v0uwlSFK57tdRBR1RsFyoS3UclVtDAu8m8lAURSOCACUcCTkx202HnASxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bnJSKTOP; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-88e68c0a7bfso464333685a.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734146; x=1761338946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoEmhYC6PZh0/oZ7DQlj7GDuJDMxQv+wwBLqgTr2Qyg=;
        b=bnJSKTOPjm+/8O8ZR43/JD7gtM5BgGsKS1p4apTDr4NNmzVvADp+KRZAgTTSjKeGGx
         EFZhUXirnQ+5mv3RurmHWJNqFt/EBrLLKyxSj3EyPZXlBXBrxaRiuXnIZF7vss9MTptT
         iiSpRupjsBAo7Q2+tL5Xg/+mdCC159qycpt666jlzY8VVC5fZIiFqGDnKD1j9FHHFWxB
         q6VWFbTDnplRuUImv6AzIAkdzrwvQBfo2GrZQ52m2BL6OuU0KOursvySbXjfmkZppZ07
         XydsBzoRKpMZrBjr7Ug0gmL1kRJ/iYfCNbVNjyVA8RvJM4RT/v/LSgj9tK5M5oRhJLtG
         kcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734146; x=1761338946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MoEmhYC6PZh0/oZ7DQlj7GDuJDMxQv+wwBLqgTr2Qyg=;
        b=Msx9ImBx4R8AsPBJ72/rjJTak6H5x9Acn1nhNq98y6xd/qD7J2W/FPHURQ61YRox0p
         BlSWmxlP3sxJvzGt53wFVXe5JCBjJIlGukvAFc1ko9yDJdvKZfdhTzrHCnzkKeoka7iB
         +nPo65Ubm8MPj3Pyml9UlcB3PfseF15/pTsxG0qekjpco2BDWjPWo1O9FuQISbCLM2yc
         9VS8YR1W6QnNxyq6fAi2q/yW0bfu22sfJ/H5eI04B/1+Dg1tVywbaYX9YhQhwsVwkg0h
         JK1rZpeLxl2P4Ck11YNO/wiHcenrQ3O8tKcAnvaL10UH/A8jcU8Ag13RuOx0yIhLwUIi
         Cq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzG+b9r3kfsnKpC9XCB97xj+MqLPK4viSBlG7iFeClq1gUaN8TwkBXVFJo+KIyNlhrq+c0Aw6F1nRM4GbM/Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW20ES4f+RjttZeimsjrEbCNf0R0+B4V4FbdHKrWFyPxGog+R/
	/Q8BuZhI4wPplDFrDDxigVLbWZ1kyjOKjqgpk1i0268WbIDMyQ8sobyIogtPH0mr1g==
X-Gm-Gg: ASbGncuNSEwBa4n6Vw16MAy1m4mflhhIZ9blGsrpljD9h+z7e6oyndLTD2X4wzH8zm2
	YtA3Azt/CYrtPHVchkHgWZryuTR/PHTTnpx1xCses9EgVTVWKdV//dfI98y3zzRSwQ9NvnkWiS/
	MbaMcLd5jQSltFNzf+JtVOWhBt1IZH6llcGQ56t//JYAiSBpkAXLrBuCble9IvhuCdiLdBDpzzV
	3uNTEfWK6YlYW9zUf7PS4jRktvb3s7AHp5csO3EF1Oh8swjmKZ44cBRQua4q4WlSAJQJcorte2l
	IHT7Ekq/nWO++QxzQFolpOMHWsZhJsfzl/TQ93YiLI9Jrj1yoWZnKuG1SSFEInxitsU6jLArdaU
	lgVqRCryczHRjIxfi7i11aAqW5jrceCqr5yMHDcNmlGJ5Q3yEZ7PcriqMhoYedoiJqZxu1MY+RR
	3HTDGYpMzeIn5PIUxzCmwSYK/hh0U/vQrmMJgHmyFm7mPex2Z9u9m+4Wnt
X-Google-Smtp-Source: AGHT+IGU9MrpopUz/Xf/ETZZmknqUgbSRpgllUgKHyesHpJWr1fGTVcgkNtvoeIK4GEUaZ6y4SIxXA==
X-Received: by 2002:a05:620a:19a0:b0:86f:40d1:642a with SMTP id af79cd13be357-8906fd18352mr665016985a.46.1760734146211;
        Fri, 17 Oct 2025 13:49:06 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d6112sm43952285a.5.2025.10.17.13.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:05 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 08/11] ima,evm: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:22 -0400
Message-ID: <20251017204815.505363-19-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5079; i=paul@paul-moore.com; h=from:subject; bh=gwoUolnGu0iyXZybPYEg8kunGtOfuXadxit1lO57m6A=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qumJ6O8yDoyDBKm1OgBDdANu72h6bRjwW2XF m8D3x9XqW+JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrpgAKCRDqIPLalzeJ cx/DEACvMDuWKdEgxtP+0o5owt/8DJRlPic6M0fizDPEX0ozXCLs+Xr0l3vPdyu5PUq2s5R11cK m0HAk7a4v8XEcbP7UOZcj5blHg4Qqy7pb2XNdT9w59+R6N95L0E6VAplYHXibWbSACfxVDfZOE4 Bc5u7zbIyMCMJwp+cWUm3Z+yKyuYzw6jyJpUKuk06ZtvDebbFX9AVDFAQQpzbZW+nO1YSgJ/fxG gkc9tc0FFq+KASrhMgJjOJSaxCU3Hoxj8vNIgZjcZGe8Oic2gRXpQc8YUlfqMoB3m87M0ainv4d VHCjDJK3suI/ihbKIDLLmoK5zH2qGXpBQVmcoqP5sSTCd5/qu45YvtjUh5VzphQ86ZE8ZA23pY3 Kf58/3aTvzXmbxff/kYHivWSQN3lgG3ab9dY32DY6z3IvldkEpZIDADHciHuD1XtirwLuXckI1I RKcu7B6LweUZbePusx9ODtT/yOEKYSw8Rz7GKnRsShFXbVGMIwJBS2jiA770i6rEuAD0F3bIcbg Z3BRKvHVANlmMs9D9mTQ9slvJhT11SxayflYtmVBYcv44jELr46coaIBfWE1ZaBPfjYcocBd0qb S1zZ9lyQsrUzvAv3ya+9M4QxNsc2/XtqJ7QEHoIqADJvl33URUNj0v18XzbUQn7E0dYvV9CQ/fD rz3VYQNeNyWJK6g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

From: Roberto Sassu <roberto.sassu@huawei.com>

This patch converts IMA and EVM to use the LSM frameworks's initcall
mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
evm_init_secfs(), to work around the fact that there is no "integrity" LSM,
and introduced integrity_fs_fini() to remove the integrity directory, if
empty. Both integrity_fs_init() and integrity_fs_fini() support the
scenario of being called by both the IMA and EVM LSMs.

This patch does not touch any of the platform certificate code that
lives under the security/integrity/platform_certs directory as the
IMA/EVM developers would prefer to address that in a future patchset.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
[PM: adjust description as discussed over email]
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/integrity/evm/evm_main.c  |  3 +--
 security/integrity/evm/evm_secfs.c | 11 +++++++++--
 security/integrity/iint.c          | 14 ++++++++++++--
 security/integrity/ima/ima_fs.c    | 11 +++++++++--
 security/integrity/ima/ima_main.c  |  4 ++--
 security/integrity/integrity.h     |  2 ++
 6 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index db8e324ed4e6..73d500a375cb 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1179,6 +1179,5 @@ DEFINE_LSM(evm) = {
 	.init = init_evm_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &evm_blob_sizes,
+	.initcall_late = init_evm,
 };
-
-late_initcall(init_evm);
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index b0d2aad27850..c26724690cec 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -302,10 +302,16 @@ int __init evm_init_secfs(void)
 	int error = 0;
 	struct dentry *dentry;
 
-	evm_dir = securityfs_create_dir("evm", integrity_dir);
-	if (IS_ERR(evm_dir))
+	error = integrity_fs_init();
+	if (error < 0)
 		return -EFAULT;
 
+	evm_dir = securityfs_create_dir("evm", integrity_dir);
+	if (IS_ERR(evm_dir)) {
+		error = -EFAULT;
+		goto out;
+	}
+
 	dentry = securityfs_create_file("evm", 0660,
 				      evm_dir, NULL, &evm_key_ops);
 	if (IS_ERR(dentry)) {
@@ -329,5 +335,6 @@ int __init evm_init_secfs(void)
 out:
 	securityfs_remove(evm_symlink);
 	securityfs_remove(evm_dir);
+	integrity_fs_fini();
 	return error;
 }
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 068ac6c2ae1e..8ec1a3436a71 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -42,8 +42,11 @@ void __init integrity_load_keys(void)
 		evm_load_x509();
 }
 
-static int __init integrity_fs_init(void)
+int __init integrity_fs_init(void)
 {
+	if (integrity_dir)
+		return 0;
+
 	integrity_dir = securityfs_create_dir("integrity", NULL);
 	if (IS_ERR(integrity_dir)) {
 		int ret = PTR_ERR(integrity_dir);
@@ -58,4 +61,11 @@ static int __init integrity_fs_init(void)
 	return 0;
 }
 
-late_initcall(integrity_fs_init)
+void __init integrity_fs_fini(void)
+{
+	if (!integrity_dir || !simple_empty(integrity_dir))
+		return;
+
+	securityfs_remove(integrity_dir);
+	integrity_dir = NULL;
+}
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..012a58959ff0 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -499,9 +499,15 @@ int __init ima_fs_init(void)
 	struct dentry *dentry;
 	int ret;
 
+	ret = integrity_fs_init();
+	if (ret < 0)
+		return ret;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
-		return PTR_ERR(ima_dir);
+	if (IS_ERR(ima_dir)) {
+		ret = PTR_ERR(ima_dir);
+		goto out;
+	}
 
 	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
 						NULL);
@@ -555,6 +561,7 @@ int __init ima_fs_init(void)
 out:
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
+	integrity_fs_fini();
 
 	return ret;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index eade8e1e3cb1..b703bfc2f470 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1283,6 +1283,6 @@ DEFINE_LSM(ima) = {
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
 	.blobs = &ima_blob_sizes,
+	/* Start IMA after the TPM is available */
+	.initcall_late = init_ima,
 };
-
-late_initcall(init_ima);	/* Start IMA after the TPM is available */
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index c2c2da691123..7b388b66cf80 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -114,6 +114,8 @@ struct ima_file_id {
 
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count);
+int __init integrity_fs_init(void);
+void __init integrity_fs_fini(void);
 
 #define INTEGRITY_KEYRING_EVM		0
 #define INTEGRITY_KEYRING_IMA		1
-- 
2.51.1.dirty


