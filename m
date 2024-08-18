Return-Path: <linux-integrity+bounces-3351-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6728955DC6
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6687A282F92
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B6155A59;
	Sun, 18 Aug 2024 17:02:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA531553A7;
	Sun, 18 Aug 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000524; cv=none; b=jSge0xHDZY34DMKAqyOnl/AaNYWZSzcf7i14tjq/8KIvLQV53dSqicd9ERoyNUPoDX/F7+nHYN5gjngImsqy0AgJQPAY3Dk7KBPbQZTDc/viMk67hYwiF1XV7o5mb8HTSK15YN+Qp8kPwPxLVsGv0+JGV3CNwMR3b983GWFL3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000524; c=relaxed/simple;
	bh=9xjxxmBQ7tQlGwg/eoRKItneGP4VK5pPCK0biFg/LhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZBd1J0Jg0GNYs7xAQqW0oMldkX6MzA2hnYHY3R0UQ/+43jR8Z3ckh9OMv6mWQz9/3GDbMQxgR05auaxFh55srt19FeTBt91g+WlMVjkb4HimrfwwJTRLv+R84c/XCWNYlE0ghFaN1erWaBXxxtcQgJXE/QiUeholxGt/4nxR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wn1kG2vGlz9v7NJ;
	Mon, 19 Aug 2024 00:43:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 48DBF14040D;
	Mon, 19 Aug 2024 01:01:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXmKMJmFj1xAQ--.19682S6;
	Sun, 18 Aug 2024 18:01:54 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 14/14] KEYS: Introduce load_pgp_public_keyring()
Date: Sun, 18 Aug 2024 18:57:56 +0200
Message-Id: <20240818165756.629203-15-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHCoXmKMJmFj1xAQ--.19682S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1DZryrGFWkCF1rAF18Krg_yoWrZF45p3
	yvyr1fKr4xtr1fArWfGF1UWrW5Cw1vkry2gw13Cw43AFWDKFy5ArsrKFs09ay5Wr98Zr1F
	q3yvqF1a9w1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB9AAAsn

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
index db0fde36a71b..7b4c1dfa7fb3 100644
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


