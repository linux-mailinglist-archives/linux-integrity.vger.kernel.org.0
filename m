Return-Path: <linux-integrity+bounces-3341-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E8955D9E
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BC4281972
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F415575D;
	Sun, 18 Aug 2024 17:00:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD561422D2;
	Sun, 18 Aug 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000406; cv=none; b=D+/HGFwb3LnxU7LqVoojIFmqTAMxvIqsY1DGWCh+rFOYYXoFVBtj5ChZRKJ/WDd+GaK3PmV7WnLJt1aBx1CanMQ66+63FQUyctmARTxJgynAxqNT87fnYaFXNMFfytCCHec6onxHj8phRUeHd5MAq1QsYwbv87B75zguY7CJ0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000406; c=relaxed/simple;
	bh=7YAVB89evGdQ+BUALdIKIojrufVeidrxP0YVKk6wLGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s314hYkGfNULHUA4wu2hkcH6VEb2ibtvpLrr3rOdAXEJXg9x5xcnjWd00erS9vezlukPIl7YM57iH3LbroKeWTvmlhQS3SUvgUayibsdG0Uuz5coU9N/QcjUXi58/aRMlPyndFzV1m2OFMufWhmKs1jRhAEfpgI8JaTrlblSeIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wn1gz1BsNz9v7NK;
	Mon, 19 Aug 2024 00:41:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0EF97140380;
	Mon, 19 Aug 2024 00:59:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S6;
	Sun, 18 Aug 2024 17:59:55 +0100 (CET)
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
Subject: [PATCH v2 04/14] PGPLIB: Basic packet parser
Date: Sun, 18 Aug 2024 18:57:46 +0200
Message-Id: <20240818165756.629203-5-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW7GF1rArW3ZFW5Wr17ZFb_yoWDJrWUpa
	48CryrKa1UGwn2krWrAr17WwnrCr48ZFWagayFvw1jk39FgwnYgrZFkFyxKa48Ka1DJ34S
	krs0gFyYv3Z0qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ
	TmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB6gAAs5

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
 crypto/asymmetric_keys/pgp_library.c | 272 +++++++++++++++++++++++++++
 crypto/asymmetric_keys/pgplib.h      |  33 ++++
 4 files changed, 316 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp_library.c
 create mode 100644 crypto/asymmetric_keys/pgplib.h

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e1345b8f39f1..ce17c0881d94 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -103,4 +103,10 @@ config FIPS_SIGNATURE_SELFTEST_ECDSA
 	depends on CRYPTO_SHA256=y || CRYPTO_SHA256=FIPS_SIGNATURE_SELFTEST
 	depends on CRYPTO_ECDSA=y || CRYPTO_ECDSA=FIPS_SIGNATURE_SELFTEST
 
+config PGP_LIBRARY
+	tristate "PGP parsing library"
+	help
+	  This option enables a library that provides a number of simple
+	  utility functions for parsing PGP (RFC 4880) packet-based messages.
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
index 000000000000..33ed01f67654
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_library.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PGP packet parser (RFC 4880)
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
+
+const char *const pgp_hash_algorithms[PGP_HASH__LAST] = {
+	[PGP_HASH_MD5]			= "md5",
+	[PGP_HASH_SHA1]			= "sha1",
+	[PGP_HASH_RIPE_MD_160]		= "rmd160",
+	[PGP_HASH_SHA256]		= "sha256",
+	[PGP_HASH_SHA384]		= "sha384",
+	[PGP_HASH_SHA512]		= "sha512",
+	[PGP_HASH_SHA224]		= "sha224",
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
+ * Parse a set of PGP packet header [RFC 4880: 4.2].
+ *
+ * Return: packet data size on success; non-zero on error.  If successful,
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
+ * Parse a set of PGP packets [RFC 4880: 4].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise
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
+ * Parse the common data struct for a PGP pubkey packet [RFC 4880: 5.5.2].
+ *
+ * Return: 0 on successful parsing, a negative value otherwise
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
+	case PGP_KEY_VERSION_2:
+	case PGP_KEY_VERSION_3:
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
+	if (pk->version == PGP_KEY_VERSION_4) {
+		pk->expires_at = 0; /* Have to get it from the selfsignature */
+	} else {
+		unsigned short ndays;
+
+		ndays  = *data++ << 8;
+		ndays |= *data++;
+		if (ndays)
+			pk->expires_at = pk->creation_time + ndays * 86400UL;
+		else
+			pk->expires_at = 0;
+		datalen -= 2;
+	}
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
index 000000000000..d82b84179433
--- /dev/null
+++ b/crypto/asymmetric_keys/pgplib.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP library definitions (RFC 4880)
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


