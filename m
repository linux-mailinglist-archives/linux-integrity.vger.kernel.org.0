Return-Path: <linux-integrity+bounces-3534-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF20975283
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC35E28A7F4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204F519F404;
	Wed, 11 Sep 2024 12:32:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81718C03E;
	Wed, 11 Sep 2024 12:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057933; cv=none; b=WElKJtNebpz447xM1hRw97onHPw0rk1EU/F3MUqBf8hkVw8V8bXgBxAh+Abu2hYNxD7MqBNXUl+DnYjWSxLkmO5GdrKsEF/+D8gQRcDCImM5Uo7Y0ES31kmEUFBoSC53SDOrdFfx/w0j4+B14nATpHWdlNdd6nsw/vkAR7CxhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057933; c=relaxed/simple;
	bh=tSytCnfi4nnQFFL8WhpSzw4/Y/VqtTFp8/HjS3cG67E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JW9yxS4RlKCeCV0p+OhletJ+PbSbQOD4O95FVB7j0ppHKqhs2JDYLflZaA14AOFsuKsD4ew//Rl6QMgyyiaGht0/Do0Ah5aJjvzMJssKFnWOXwkGL+vVg7l/AVpZrLKVZ6u2mnYsU9LR6au21Kzj9UMlT3oWUiPMRAzJ+J460zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X3fSc5XVbz9v7Jb;
	Wed, 11 Sep 2024 20:06:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id DD54614086A;
	Wed, 11 Sep 2024 20:32:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3hy+ijeFmnHu1AA--.60036S6;
	Wed, 11 Sep 2024 13:32:00 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 14/14] KEYS: Introduce load_pgp_public_keyring()
Date: Wed, 11 Sep 2024 14:29:11 +0200
Message-Id: <20240911122911.1381864-15-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwD3hy+ijeFmnHu1AA--.60036S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DZryrGFWkCF1rAF18Krg_yoWrZF45p3
	yvyr1fKr4xtr1fArWfGF1UWrW5Cw1vkry2gw13Cw43AFWDKFy5ArsrKFs09ay5Wr98Zr1F
	v3yvqr1a9w1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
	kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
	pf9x07Udl1kUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQH5gAAsp

From: Roberto Sassu <roberto.sassu@huawei.com>

Preload PGP keys from 'pubring.gpg', placed in certs/ of the kernel source
directory.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/Kconfig               | 11 +++++++++++
 certs/Makefile              |  7 +++++++
 certs/system_certificates.S | 18 ++++++++++++++++++
 certs/system_keyring.c      | 23 +++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/certs/Kconfig b/certs/Kconfig
index 78307dc25559..9b7ece1e45fa 100644
--- a/certs/Kconfig
+++ b/certs/Kconfig
@@ -154,4 +154,15 @@ config SYSTEM_BLACKLIST_AUTH_UPDATE
 	  keyring.  The PKCS#7 signature of the description is set in the key
 	  payload.  Blacklist keys cannot be removed.
 
+config PGP_PRELOAD_PUBLIC_KEYS
+	bool "Preload PGP public keys"
+	depends on SYSTEM_TRUSTED_KEYRING
+	select PGP_PRELOAD
+	default n
+	help
+	  Load at boot time the PGP public keys from a reserved area (populated
+	  with the content of 'certs/pubring.gpg' provided at kernel build
+	  time), and add them to the built-in keyring. Invalid keys are ignored
+	  and the loading continues.
+
 endmenu
diff --git a/certs/Makefile b/certs/Makefile
index 1094e3860c2a..7a3d68441e09 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -31,6 +31,13 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs)
 
+ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+ifeq ($(shell ls $(srctree)/certs/pubring.gpg 2> /dev/null), $(srctree)/certs/pubring.gpg)
+AFLAGS_system_certificates.o := -DHAVE_PUBRING_GPG
+$(obj)/system_certificates.o: $(srctree)/certs/pubring.gpg
+endif
+endif
+
 targets += x509_certificate_list
 
 # If module signing is requested, say by allyesconfig, but a key has not been
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 003e25d4a17e..b3cbf0811e3f 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -44,3 +44,21 @@ module_cert_size:
 #else
 	.long __module_cert_end - __module_cert_start
 #endif
+
+	.align 8
+	.globl pgp_public_keys
+pgp_public_keys:
+__pgp_key_list_start:
+#ifdef HAVE_PUBRING_GPG
+	.incbin "certs/pubring.gpg"
+#endif
+__pgp_key_list_end:
+
+	.align 8
+	.globl pgp_public_keys_size
+pgp_public_keys_size:
+#ifdef CONFIG_64BIT
+	.quad __pgp_key_list_end - __pgp_key_list_start
+#else
+	.long __pgp_key_list_end - __pgp_key_list_start
+#endif
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index f132773c6096..357d52d1d250 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -32,6 +32,10 @@ static struct key *platform_trusted_keys;
 extern __initconst const u8 system_certificate_list[];
 extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
+#ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+extern __initconst const u8 pgp_public_keys[];
+extern __initconst const unsigned long pgp_public_keys_size;
+#endif
 
 /**
  * restrict_link_by_builtin_trusted - Restrict keyring addition by built-in CA
@@ -268,6 +272,15 @@ __init int load_module_cert(struct key *keyring)
 	if (!IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG))
 		return 0;
 
+#ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+	pr_notice("Load PGP public keys to keyring %s\n", keyring->description);
+
+	if (preload_pgp_keys(pgp_public_keys,
+			     pgp_public_keys_size,
+			     keyring) < 0)
+		pr_err("Can't load PGP public keys\n");
+#endif
+
 	pr_notice("Loading compiled-in module X.509 certificates\n");
 
 	return x509_load_certificate_list(system_certificate_list,
@@ -292,6 +305,16 @@ static __init int load_system_certificate_list(void)
 	size = system_certificate_list_size - module_cert_size;
 #endif
 
+#ifdef CONFIG_PGP_PRELOAD_PUBLIC_KEYS
+	pr_notice("Load PGP public keys to keyring %s\n",
+		  builtin_trusted_keys->description);
+
+	if (preload_pgp_keys(pgp_public_keys,
+			     pgp_public_keys_size,
+			     builtin_trusted_keys) < 0)
+		pr_err("Can't load PGP public keys\n");
+#endif
+
 	return x509_load_certificate_list(p, size, builtin_trusted_keys);
 }
 late_initcall(load_system_certificate_list);
-- 
2.34.1


