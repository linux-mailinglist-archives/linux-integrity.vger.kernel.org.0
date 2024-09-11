Return-Path: <linux-integrity+bounces-3524-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716B397524D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3007C284596
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213271A263B;
	Wed, 11 Sep 2024 12:30:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C51A2561;
	Wed, 11 Sep 2024 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057809; cv=none; b=U3v4jJ90EwjiRwGOw6dJJqaG++1KQXwNhnrkCv7kE8GIT/OMIVUIZDMLcsQjFVAr8NPL8/61xjDyTwpgPW0suVheCIqGmx6T4ysl0SUV1ambrZ2dsw6tQk++9ksxguFeYheYAEBib4di40UtdId1aSP9VV5GQvebN7Ypja5BQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057809; c=relaxed/simple;
	bh=CgFny+1sMztqzbvRL4Zo6dkUwofJasolokF6RhUK2BU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d9YvtLQEcEfSeSO0ggjYeDp2C31U3dkKyc3aPdqeCYTQh3u1ztpm0lAgbLL9d+SFNuXEAuZjxCj2qnYixGOM2v3EWC32vcKzbqKQzMN+9oWl0qxvYsZ5NzykzHvOImKWVr5re5XpbxiI4GKwGhCzkfWZl5Nwz/6I4e+HvQV6mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X3fXh4Cmdz9v7Hl;
	Wed, 11 Sep 2024 20:10:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D65C3140123;
	Wed, 11 Sep 2024 20:29:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S6;
	Wed, 11 Sep 2024 13:29:57 +0100 (CET)
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
Subject: [PATCH v3 04/14] PGPLIB: Basic packet parser
Date: Wed, 11 Sep 2024 14:29:01 +0200
Message-Id: <20240911122911.1381864-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW5tFWftw18Zr1DtFyxXwb_yoWfKry3pa
	48CryrKa1UGwn2krWrAr17WwsrCr48ZFyagayFvw1jk39FgwnYgrZFkFy0ga48KF4DJ34f
	urs0gFyY93Z8XrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQAEsG

From: David Howells <dhowells@redhat.com>

Provide a simple parser that extracts the packets from a PGP packet blob
and passes the desirous ones to the given processor function:

	struct pgp_parse_context {
		u64 types_of_interest;
		int (*process_packet)(struct pgp_parse_context *context,
				      enum pgp_packet_tag type,
				      u8 headerlen,
				      const u8 *data,
				      size_t datalen);
	};

	int pgp_parse_packets(const u8 *data, size_t datalen,
			      struct pgp_parse_context *ctx);

This is configured on with CONFIG_PGP_LIBRARY.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig       |   6 +
 crypto/asymmetric_keys/Makefile      |   5 +
 crypto/asymmetric_keys/pgp_library.c | 262 +++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h      |  33 ++++
 4 files changed, 306 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgplib.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e1345b8f39f1..8215e3fcd8db 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -103,4 +103,10 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
 	depends on CRYPTO_SHA256=y || CRYPTO_SHA256=FIPS_SIGNATURE_SELFTEST
 	depends on CRYPTO_ECDSA=y || CRYPTO_ECDSA=FIPS_SIGNATURE_SELFTEST
 
+config PGP_LIBRARY
+	tristate "PGP parsing library"
+	help
+	  This option enables a library that provides a number of simple
+	  utility functions for parsing PGP (RFC 9580) packet-based messages.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index bc65d3b98dcb..055b28207111 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -79,3 +79,8 @@ verify_signed_pefile-y := \
 
 $(obj)/mscode_parser.o: $(obj)/mscode.asn1.h $(obj)/mscode.asn1.h
 $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
+
+#
+# PGP handling
+#
+obj-$(CONFIG_PGP_LIBRARY) += pgp_library.o
diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_keys/pgp_library.c
new file mode 100644
index 000000000000..1b87f8af411b
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PGP packet parser (RFC 9580)
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) "PGPL: "fmt
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "pgplib.h"
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PGP library");
+
+const char *const pgp_hash_algorithms[PGP_HASH__LAST] = {
+	[PGP_HASH_MD5]			= "md5",
+	[PGP_HASH_SHA1]			= "sha1",
+	[PGP_HASH_RIPE_MD_160]		= "rmd160",
+	[PGP_HASH_SHA256]		= "sha256",
+	[PGP_HASH_SHA384]		= "sha384",
+	[PGP_HASH_SHA512]		= "sha512",
+	[PGP_HASH_SHA224]		= "sha224",
+	[PGP_HASH_SHA3_256]		= "sha3-256",
+	[PGP_HASH_SHA3_512]		= "sha3-512",
+};
+EXPORT_SYMBOL_GPL(pgp_hash_algorithms);
+
+/**
+ * pgp_parse_packet_header - Parse a PGP packet header
+ * @_data: Start of the PGP packet (updated to PGP packet data)
+ * @_datalen: Amount of data remaining in buffer (decreased)
+ * @_type: Where the packet type will be returned
+ * @_headerlen: Where the header length will be returned
+ *
+ * Parse a set of PGP packet header [RFC 9580: 4.2].
+ *
+ * Return: Packet data size on success; non-zero on error.  If successful,
+ * *_data and *_datalen will have been updated and *_headerlen will be set to
+ * hold the length of the packet header.
+ */
+static ssize_t pgp_parse_packet_header(const u8 **_data, size_t *_datalen,
+				       enum pgp_packet_tag *_type,
+				       u8 *_headerlen)
+{
+	enum pgp_packet_tag type;
+	const u8 *data = *_data;
+	size_t size, datalen = *_datalen;
+
+	pr_devel("-->%s(,%zu,,)\n", __func__, datalen);
+
+	if (datalen < 2)
+		goto short_packet;
+
+	pr_devel("pkthdr %02x, %02x\n", data[0], data[1]);
+
+	type = *data++;
+	datalen--;
+	if (!(type & 0x80)) {
+		pr_debug("Packet type does not have MSB set\n");
+		return -EBADMSG;
+	}
+	type &= ~0x80;
+
+	if (type & 0x40) {
+		/* New packet length format */
+		type &= ~0x40;
+		pr_devel("new format: t=%u\n", type);
+		switch (data[0]) {
+		case 0x00 ... 0xbf:
+			/* One-byte length */
+			size = data[0];
+			data++;
+			datalen--;
+			*_headerlen = 2;
+			break;
+		case 0xc0 ... 0xdf:
+			/* Two-byte length */
+			if (datalen < 2)
+				goto short_packet;
+			size = (data[0] - 192) * 256;
+			size += data[1] + 192;
+			data += 2;
+			datalen -= 2;
+			*_headerlen = 3;
+			break;
+		case 0xff:
+			/* Five-byte length */
+			if (datalen < 5)
+				goto short_packet;
+			size =  data[1] << 24;
+			size |= data[2] << 16;
+			size |= data[3] << 8;
+			size |= data[4];
+			data += 5;
+			datalen -= 5;
+			*_headerlen = 6;
+			break;
+		default:
+			pr_debug("Partial body length packet not supported\n");
+			return -EBADMSG;
+		}
+	} else {
+		/* Old packet length format */
+		u8 length_type = type & 0x03;
+
+		type >>= 2;
+		pr_devel("old format: t=%u lt=%u\n", type, length_type);
+
+		switch (length_type) {
+		case 0:
+			/* One-byte length */
+			size = data[0];
+			data++;
+			datalen--;
+			*_headerlen = 2;
+			break;
+		case 1:
+			/* Two-byte length */
+			if (datalen < 2)
+				goto short_packet;
+			size  = data[0] << 8;
+			size |= data[1];
+			data += 2;
+			datalen -= 2;
+			*_headerlen = 3;
+			break;
+		case 2:
+			/* Four-byte length */
+			if (datalen < 4)
+				goto short_packet;
+			size  = data[0] << 24;
+			size |= data[1] << 16;
+			size |= data[2] << 8;
+			size |= data[3];
+			data += 4;
+			datalen -= 4;
+			*_headerlen = 5;
+			break;
+		default:
+			pr_debug("Indefinite length packet not supported\n");
+			return -EBADMSG;
+		}
+	}
+
+	pr_devel("datalen=%zu size=%zu\n", datalen, size);
+	if (datalen < size)
+		goto short_packet;
+	if (size > INT_MAX)
+		goto too_big;
+
+	*_data = data;
+	*_datalen = datalen;
+	*_type = type;
+	pr_devel("Found packet type=%u size=%zd\n", type, size);
+	return size;
+
+short_packet:
+	pr_debug("Attempt to parse short packet\n");
+	return -EBADMSG;
+too_big:
+	pr_debug("Signature subpacket size >2G\n");
+	return -EMSGSIZE;
+}
+
+/**
+ * pgp_parse_packets - Parse a set of PGP packets
+ * @data: Data to be parsed (updated)
+ * @datalen: Amount of data (updated)
+ * @ctx: Parsing context
+ *
+ * Parse a set of PGP packets [RFC 9580: 4].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise.
+ */
+int pgp_parse_packets(const u8 *data, size_t datalen,
+		      struct pgp_parse_context *ctx)
+{
+	enum pgp_packet_tag type;
+	ssize_t pktlen;
+	u8 headerlen;
+	int ret;
+
+	while (datalen > 2) {
+		pktlen = pgp_parse_packet_header(&data, &datalen, &type,
+						 &headerlen);
+		if (pktlen < 0)
+			return pktlen;
+
+		if ((ctx->types_of_interest >> type) & 1) {
+			ret = ctx->process_packet(ctx, type, headerlen,
+						  data, pktlen);
+			if (ret < 0)
+				return ret;
+		}
+		data += pktlen;
+		datalen -= pktlen;
+	}
+
+	if (datalen != 0) {
+		pr_debug("Excess octets in packet stream\n");
+		return -EBADMSG;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_packets);
+
+/**
+ * pgp_parse_public_key - Parse the common part of a PGP pubkey packet
+ * @_data: Content of packet (updated)
+ * @_datalen: Length of packet remaining (updated)
+ * @pk: Public key data
+ *
+ * Parse the common data struct for a PGP pubkey packet [RFC 9580: 5.5.2].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise.
+ */
+int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
+			 struct pgp_parse_pubkey *pk)
+{
+	const u8 *data = *_data;
+	size_t datalen = *_datalen;
+	unsigned int tmp;
+
+	if (datalen < 12) {
+		pr_debug("Public key packet too short\n");
+		return -EBADMSG;
+	}
+
+	pk->version = *data++;
+	switch (pk->version) {
+	case PGP_KEY_VERSION_4:
+		break;
+	default:
+		pr_debug("Public key packet with unhandled version %d\n",
+			 pk->version);
+		return -EBADMSG;
+	}
+
+	tmp  = *data++ << 24;
+	tmp |= *data++ << 16;
+	tmp |= *data++ << 8;
+	tmp |= *data++;
+	pk->creation_time = tmp;
+	if (pk->version == PGP_KEY_VERSION_4)
+		pk->expires_at = 0; /* Have to get it from the selfsignature */
+
+	pk->pubkey_algo = *data++;
+	datalen -= 6;
+
+	pr_devel("%x,%x,%lx,%lx\n",
+		 pk->version, pk->pubkey_algo, pk->creation_time,
+		 pk->expires_at);
+
+	*_data = data;
+	*_datalen = datalen;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pgp_parse_public_key);
diff --git a/crypto/asymmetric_keys/pgplib.h b/crypto/asymmetric_keys/pgplib.h
new file mode 100644
index 000000000000..3ec4b408a11e
--- /dev/null
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP library definitions (RFC 9580)
+ *
+ * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include "pgp.h"
+
+/*
+ * PGP library packet parser
+ */
+struct pgp_parse_context {
+	u64 types_of_interest;
+	int (*process_packet)(struct pgp_parse_context *context,
+			      enum pgp_packet_tag type,
+			      u8 headerlen,
+			      const u8 *data,
+			      size_t datalen);
+};
+
+extern int pgp_parse_packets(const u8 *data, size_t datalen,
+			     struct pgp_parse_context *ctx);
+
+struct pgp_parse_pubkey {
+	enum pgp_key_version version : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	__kernel_old_time_t creation_time;
+	__kernel_old_time_t expires_at;
+};
+
+extern int pgp_parse_public_key(const u8 **_data, size_t *_datalen,
+				struct pgp_parse_pubkey *pk);
-- 
2.34.1


