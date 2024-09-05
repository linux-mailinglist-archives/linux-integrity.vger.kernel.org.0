Return-Path: <linux-integrity+bounces-3460-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A75696DE09
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4532E1F24E45
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331019D89F;
	Thu,  5 Sep 2024 15:26:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E787F7FC;
	Thu,  5 Sep 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549967; cv=none; b=VgZvsst73PCsMHHIiylWpU5/rztsWOefy3eGgZpJitrIQvqM5ENtCrgfldb3XXW32C37/xcPn0B1X5kalI1/vbcPaq8QLMjk0gHbomaucMlr6wNIkBEa0d30NIvPQp914ltEB480D6wM3YaWbEemOsv94016xT5fIcW44dhwpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549967; c=relaxed/simple;
	bh=sX3taRTqCQXOYWd+iZICjAkXnyRQiHQh7gSAGKcrY+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IzZ9XyEEJtA7tM8xc/cy/I6qPyVz5IzvlmmKk2+mpRiGgzztb7HkEnZ1v30NL2Mqq2KJM+rApyddUmcy4ANXmNaUk6taZLq14xCpwvYvaUV7XmW/RZWWmnbepaUrZuDu2pzXADrAhnJghncbU9xXHecntZr1zJFkYkKK1xuPHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02kn3pbyz9v7NM;
	Thu,  5 Sep 2024 23:06:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 287CA14068E;
	Thu,  5 Sep 2024 23:25:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S3;
	Thu, 05 Sep 2024 16:25:57 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 01/10] ima: Introduce hook DIGEST_LIST_CHECK
Date: Thu,  5 Sep 2024 17:25:03 +0200
Message-Id: <20240905152512.3781098-2-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47Ar1rXF47XFy8Cw1rWFg_yoW5Zr1Upa
	1DKa4jkryYqFy2kFs3C3W29FWkK3ySgF4UG390v3WvkFnxZF18Xr1ayr9F9FyfGryFyFn7
	trn0gr47Aa1jyw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
	U0t5r7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLPwADs8

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce a new hook to check the integrity of digest lists.

The new hook is invoked during a kernel read with file type
READING_DIGEST LIST, which is done by the Integrity Digest Cache when it is
populating a digest cache with a digest list.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/ABI/testing/ima_policy | 1 +
 security/integrity/ima/ima.h         | 1 +
 security/integrity/ima/ima_main.c    | 3 ++-
 security/integrity/ima/ima_policy.c  | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index c2385183826c..22237fec5532 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -36,6 +36,7 @@ Description:
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
 				[SETXATTR_CHECK][MMAP_CHECK_REQPROT]
+				[DIGEST_LIST_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ad5c95cf22ac..9d41d6b1cce2 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -317,6 +317,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
 	hook(SETXATTR_CHECK, setxattr_check)		\
+	hook(DIGEST_LIST_CHECK, digest_list_check)	\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 646d900828e0..cff8b5a12512 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -798,7 +798,8 @@ const int read_idmap[READING_MAX_ID] = {
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
-	[READING_POLICY] = POLICY_CHECK
+	[READING_POLICY] = POLICY_CHECK,
+	[READING_DIGEST_LIST] = DIGEST_LIST_CHECK,
 };
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 09da8e639239..047d50c2eb57 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1290,6 +1290,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case MODULE_CHECK:
 	case KEXEC_KERNEL_CHECK:
 	case KEXEC_INITRAMFS_CHECK:
+	case DIGEST_LIST_CHECK:
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
@@ -1533,6 +1534,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = CRITICAL_DATA;
 			else if (strcmp(args[0].from, "SETXATTR_CHECK") == 0)
 				entry->func = SETXATTR_CHECK;
+			else if (strcmp(args[0].from, "DIGEST_LIST_CHECK") == 0)
+				entry->func = DIGEST_LIST_CHECK;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.34.1


