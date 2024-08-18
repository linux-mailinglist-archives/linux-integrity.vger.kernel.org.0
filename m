Return-Path: <linux-integrity+bounces-3349-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3F955DBE
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FDF1F22897
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE241509B3;
	Sun, 18 Aug 2024 17:01:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CD2208CA;
	Sun, 18 Aug 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000509; cv=none; b=Nc5hpVnZSWAaeLk/aeT/u5pzpKrI9V26RvDUX9458Koe+yohEyZ2wPmY8mqFG8UL9BMhRqaK41Yr8jxw1Mebyc10fExEzanxjPwVPddKfffsfrSO9IbIXS3C1jjnkfmgguuw+NbmP5tgXNsnxL0uxPOoht+aL/5qWzTgP56UB3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000509; c=relaxed/simple;
	bh=qMOiEqz0rHS56gmTXYlVqcNZFoXbHBOfIXIdCs0+OUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=riZi4nrsar61aiqssq26czhS5KHAa2h77F2to3DoldnzApImmuI29gNA2/p7u9EHcHs9EjCWRXabFR/4EVOSnx9ydRGGzvJoF/bRjpFsHhnXR9D+wW9XTdGdiiYtINtPrH4/3133mmyrpSb1jk0uO2ZSU1CTKPrPX8QKW+/dD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wn1jw0y3vz9v7Hs;
	Mon, 19 Aug 2024 00:42:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5051314022E;
	Mon, 19 Aug 2024 01:01:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXmKMJmFj1xAQ--.19682S4;
	Sun, 18 Aug 2024 18:01:43 +0100 (CET)
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
Subject: [PATCH v2 12/14] PGP: Provide a key type for testing PGP signatures
Date: Sun, 18 Aug 2024 18:57:54 +0200
Message-Id: <20240818165756.629203-13-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwCHCoXmKMJmFj1xAQ--.19682S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF18tw4xAr4xXw4DZr1UKFg_yoW3Kw4xpF
	yFkrWrtFy8Jrn7C3y5AayfWwnYkr40yry3G39aqw1Yy39rWw1kGrZ2yF1kKFy3tw4kZ3yr
	A3yYva4Uuw1DtrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jbID7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB8QADsh

From: David Howells <dhowells@redhat.com>

Provide a key type for testing the PGP signature parser.  It is given a
non-detached PGP message as payload:

	keyctl padd pgp_test a @s <content.txt.gpg

A suitable message can be generated like this:

	echo "This is a test attached-signed content" >content.txt
	gpg --compress-algo=none -s content.txt

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig        |  13 +++
 crypto/asymmetric_keys/Makefile       |   2 +
 crypto/asymmetric_keys/pgp_library.c  |  64 +++++++++++++
 crypto/asymmetric_keys/pgp_test_key.c | 129 ++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h       |  16 ++++
 5 files changed, 224 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_test_key.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 4c5c52cf54e4..d9c709e042f6 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -120,4 +120,17 @@ config PGP_KEY_PARSER
 	  for key data and provides the ability to instantiate a crypto key
 	  from a public key packet found inside the blob.
 
+config PGP_TEST_KEY
+	tristate "PGP testing key type"
+	depends on SYSTEM_DATA_VERIFICATION
+	depends on PGP_KEY_PARSER=y
+	help
+	  This option provides a type of key that can be loaded up from a
+	  PGP message - provided the message is signed by a trusted key.  If
+	  it is, the PGP wrapper is discarded and reading the key returns
+	  just the payload.  If it isn't, adding the key will fail with an
+	  error.
+
+	  This is intended for testing the PGP parser.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index e7ff01997eb2..507a78f9a0a1 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -89,3 +89,5 @@ obj-$(CONFIG_PGP_KEY_PARSER) += pgp_key_parser.o
 pgp_key_parser-y := \
 	pgp_public_key.o \
 	pgp_signature.o
+
+obj-$(CONFIG_PGP_TEST_KEY) += pgp_test_key.o
diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
index 2fd3e7d55f6f..2bcd5f46ad48 100644
--- a/crypto/asymmetric_keys/pgp_library.c
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -554,3 +554,67 @@ int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pgp_parse_sig_params);
+
+#if IS_ENABLED(CONFIG_PGP_TEST_KEY)
+
+/**
+ * pgp_parse_literal_data - Parse basic params from a PGP literal data packet
+ * @data: Content of packet
+ * @datalen: Length of packet remaining
+ * @p: The basic parameters
+ *
+ * Parse the basic parameters from a PGP literal data packet [RFC 4880: 5.9]
+ * that are needed to work out what form the data is in and where it is.
+ *
+ * Returns 0 if successful or a negative error code.
+ */
+int pgp_parse_literal_data(const u8 *data, size_t datalen,
+			   struct pgp_literal_data_parameters *p)
+{
+	unsigned int tmp;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 6)
+		goto too_short;
+	datalen -= 6;
+
+	p->format = *data++;
+	switch (p->format) {
+	case PGP_LIT_FORMAT_BINARY:
+	case PGP_LIT_FORMAT_TEXT:
+	case PGP_LIT_FORMAT_TEXT_UTF8:
+		break;
+	default:
+		pr_debug("Literal data packet with unhandled format %02x\n",
+			 p->format);
+		return -EBADMSG;
+	}
+
+	p->filename_len = *data++;
+	p->filename_offset = 2;
+	if (datalen < p->filename_len)
+		goto too_short;
+	data += p->filename_len;
+	datalen -= p->filename_len;
+
+	tmp  = *data++ << 24;
+	tmp |= *data++ << 16;
+	tmp |= *data++ << 8;
+	tmp |= *data++;
+	p->time = tmp;
+
+	p->content_offset = 6 + p->filename_len;
+	p->content_len = datalen;
+
+	pr_devel("%x,%u,%x,%u\n",
+		 p->format, p->filename_len, p->time, p->content_len);
+	return 0;
+
+too_short:
+	pr_debug("Literal data packet too short\n");
+	return -EBADMSG;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_literal_data);
+
+#endif /* CONFIG_PGP_TEST_KEY */
diff --git a/crypto/asymmetric_keys/pgp_test_key.c b/crypto/asymmetric_keys/pgp_test_key.c
new file mode 100644
index 000000000000..e067dedf6ca0
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_test_key.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Testing module to load key from trusted PGP message
+ *
+ * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "PGPtest: "fmt
+#include <linux/key.h>
+#include <linux/key-type.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/verification.h>
+#include <keys/user-type.h>
+#include <keys/system_keyring.h>
+#include <crypto/pgp.h>
+
+#include "pgp_parser.h"
+
+MODULE_LICENSE("GPL");
+
+struct pgp_test_parse_context {
+	struct pgp_parse_context pgp;
+	struct pgp_literal_data_parameters params;
+	const void *content;
+};
+
+static int pgp_test_parse_data(struct pgp_parse_context *context,
+			       enum pgp_packet_tag type,
+			       u8 headerlen,
+			       const u8 *data,
+			       size_t datalen)
+{
+	struct pgp_test_parse_context *ctx =
+		container_of(context, struct pgp_test_parse_context, pgp);
+	int ret;
+
+	kenter("");
+
+	ret = pgp_parse_literal_data(data, datalen, &ctx->params);
+	if (ret == 0)
+		ctx->content = data + ctx->params.content_offset;
+	return ret;
+}
+
+/*
+ * Instantiate a PGP wrapped and validated key.
+ */
+static int pgp_test_instantiate(struct key *key,
+				struct key_preparsed_payload *prep)
+{
+	struct pgp_test_parse_context p;
+	const void *saved_prep_data;
+	size_t saved_prep_datalen;
+	const struct cred *cred = current_cred();
+	int ret;
+
+	kenter("");
+
+	memset(&p, 0, sizeof(p));
+	p.pgp.types_of_interest = (1 << PGP_PKT_LITERAL_DATA);
+	p.pgp.process_packet = pgp_test_parse_data;
+	ret = pgp_parse_packets(prep->data, prep->datalen, &p.pgp);
+	if (ret < 0) {
+		kleave(" = %d [parse]", ret);
+		return ret;
+	}
+
+	if (!p.params.content_len) {
+		kleave(" = -ENODATA [no literal data");
+		return -ENODATA;
+	}
+
+	ret = verify_pgp_signature(p.content, p.params.content_len,
+				   prep->data, prep->datalen, NULL,
+				   VERIFYING_UNSPECIFIED_SIGNATURE, NULL, NULL);
+	if (ret < 0 && cred->session_keyring) {
+		ret = verify_pgp_signature(p.content, p.params.content_len,
+					   prep->data, prep->datalen,
+					   cred->session_keyring,
+					   VERIFYING_UNSPECIFIED_SIGNATURE,
+					   NULL, NULL);
+		if (ret < 0)
+			goto error;
+
+		pr_warn("PGP message doesn't chain back to a trusted key\n");
+	}
+
+	saved_prep_data = prep->data;
+	saved_prep_datalen = prep->datalen;
+	prep->data = p.content;
+	prep->datalen = p.params.content_len;
+	ret = generic_key_instantiate(key, prep);
+	prep->data = saved_prep_data;
+	prep->datalen = saved_prep_datalen;
+error:
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * user defined keys take an arbitrary string as the description and an
+ * arbitrary blob of data as the payload
+ */
+static struct key_type key_type_pgp_test = {
+	.name			= "pgp_test",
+	.instantiate		= pgp_test_instantiate,
+	.revoke			= user_revoke,
+	.destroy		= user_destroy,
+	.describe		= user_describe,
+	.read			= user_read,
+};
+
+/*
+ * Module stuff
+ */
+static int __init pgp_key_init(void)
+{
+	return register_key_type(&key_type_pgp_test);
+}
+
+static void __exit pgp_key_cleanup(void)
+{
+	unregister_key_type(&key_type_pgp_test);
+}
+
+module_init(pgp_key_init);
+module_exit(pgp_key_cleanup);
diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgplib.h
index 967e2853186d..0dc3cd142469 100644
--- a/crypto/asymmetric_keys/pgplib.h
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -56,3 +56,19 @@ struct pgp_sig_parameters {
 
 extern int pgp_parse_sig_params(const u8 **_data, size_t *_datalen,
 				struct pgp_sig_parameters *p);
+
+#if IS_ENABLED(CONFIG_PGP_TEST_KEY)
+
+struct pgp_literal_data_parameters {
+	enum pgp_literal_data_format format : 8;
+	u8 filename_len;
+	u8 filename_offset;
+	u8 content_offset;
+	u32 content_len;
+	u32 time;
+};
+
+extern int pgp_parse_literal_data(const u8 *data, size_t datalen,
+				  struct pgp_literal_data_parameters *p);
+
+#endif /* CONFIG_PGP_TEST_KEY */
-- 
2.34.1


