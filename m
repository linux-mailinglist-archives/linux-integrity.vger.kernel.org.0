Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 463C2116073
	for <lists+linux-integrity@lfdr.de>; Sun,  8 Dec 2019 06:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725268AbfLHFI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 8 Dec 2019 00:08:27 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57936 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfLHFI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Dec 2019 00:08:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 571498EE111;
        Sat,  7 Dec 2019 21:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781707;
        bh=d8XmJLHG2KvR8/wFOzE43Ab6rHOw76OKGKMT856owok=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rwxNCvFXoVWJEZ6PdAUm2ahsmAivgNVTa2Qvsebh9tIMangdbUcNXfQ6AtR+ri61p
         lJLc4dhBJSIa1QI12GgEsvWGtL1kyvLI6OwYrdN0IMNmf02yAXqCQamPqLsv5Tf3V3
         LyEGwZdj7m8+btiFE44l0e+lYti1+ozKS90HKBmw=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YF4fGu__LjVP; Sat,  7 Dec 2019 21:08:27 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id E65E48EE109;
        Sat,  7 Dec 2019 21:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575781707;
        bh=d8XmJLHG2KvR8/wFOzE43Ab6rHOw76OKGKMT856owok=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rwxNCvFXoVWJEZ6PdAUm2ahsmAivgNVTa2Qvsebh9tIMangdbUcNXfQ6AtR+ri61p
         lJLc4dhBJSIa1QI12GgEsvWGtL1kyvLI6OwYrdN0IMNmf02yAXqCQamPqLsv5Tf3V3
         LyEGwZdj7m8+btiFE44l0e+lYti1+ozKS90HKBmw=
Message-ID: <1575781706.14069.10.camel@HansenPartnership.com>
Subject: [PATCH 2/8] lib: add asn.1 encoder
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Sat, 07 Dec 2019 21:08:26 -0800
In-Reply-To: <1575781600.14069.8.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We have a need in the TPM trusted keys to return the ASN.1 form of the
TPM key blob so it can be operated on by tools outside of the kernel.
To do that, we have to be able to read and write the key format.  The
current ASN.1 decoder does fine for reading, but we need pieces of an
ASN.1 encoder to return the key blob.

The current implementation only encodes the ASN.1 bits we actually need.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/asn1_encoder.h |  21 +++++
 lib/Makefile                 |   2 +-
 lib/asn1_encoder.c           | 201 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
new file mode 100644
index 000000000000..0e908d748c8e
--- /dev/null
+++ b/include/linux/asn1_encoder.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_ASN1_ENCODER_H
+#define _LINUX_ASN1_ENCODER_H
+
+#include <linux/types.h>
+#include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
+
+#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
+void asn1_encode_integer(unsigned char **_data, u64 integer);
+void asn1_encode_oid(unsigned char **_data, u32 oid[], int oid_len);
+void asn1_encode_tag(unsigned char **data, u32 tag,
+		     const unsigned char *string, u32 len);
+void asn1_encode_octet_string(unsigned char **data, const unsigned char *string,
+			      u32 len);
+void asn1_encode_sequence(unsigned char **data, const unsigned char *seq,
+			  u32 len);
+void asn1_encode_boolean(unsigned char **data, bool val);
+
+#endif
diff --git a/lib/Makefile b/lib/Makefile
index c2f0e2a4e4e8..515b35f92c3c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -233,7 +233,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 
-obj-$(CONFIG_ASN1) += asn1_decoder.o
+obj-$(CONFIG_ASN1) += asn1_decoder.o asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
new file mode 100644
index 000000000000..2a3b96761344
--- /dev/null
+++ b/lib/asn1_encoder.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Simple encoder primitives for ASN.1 BER/DER/CER
+ *
+ * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
+ */
+
+#include <linux/asn1_encoder.h>
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+/**
+ * asn1_encode_integer - encode positive integer to ASN.1
+ * @_data: pointer to the pointer to the data
+ * @integer: integer to be encoded
+ *
+ * This is a simplified encoder: since we know the integer is
+ * positive we don't have to bother with twos complement and since we
+ * know the largest integer is a u64, we know the max length is 8.
+ */
+void asn1_encode_integer(unsigned char **_data, u64 integer)
+{
+	unsigned char *data = *_data, *d = &data[2];
+	int i;
+	bool found = false;
+
+	data[0] = _tag(UNIV, PRIM, INT);
+	if (integer == 0) {
+		*d++ = 0;
+		goto out;
+	}
+	for (i = sizeof(integer); i > 0 ; i--) {
+		int byte = integer >> (8*(i-1));
+
+		if (!found && byte == 0)
+			continue;
+		found = true;
+		if (byte & 0x80)
+			*d++ = 0;
+		*d++ = byte;
+	}
+ out:
+	data[1] = d - data - 2;
+	*_data = d;
+}
+EXPORT_SYMBOL(asn1_encode_integer);
+
+/* calculate the base 128 digit values setting the top bit of the first octet */
+static void asn1_encode_oid_digit(unsigned char **_data, u32 oid)
+{
+	int start = 7 + 7 + 7 + 7;
+	unsigned char *data = *_data;
+
+	/* quick case */
+	if (oid == 0) {
+		*data++ = 0x80;
+		goto out;
+	}
+
+	while (oid >> start == 0)
+		start -= 7;
+
+	while (start > 0) {
+		u8 byte;
+
+		byte = oid >> start;
+		oid = oid - (byte << start);
+		start -= 7;
+		byte |= 0x80;
+		*data++ = byte;
+	}
+	*data++ = oid;
+
+ out:
+	*_data = data;
+}
+
+/**
+ * asn1_encode_oid - encode an oid to ASN.1
+ * @_data: position to begin encoding at
+ * @oid: array of oids
+ * @oid_len: length of oid array
+ *
+ * this encodes an OID up to ASN.1 when presented as an array of OID values
+ */
+void asn1_encode_oid(unsigned char **_data, u32 oid[], int oid_len)
+{
+	unsigned char *data = *_data;
+	unsigned char *d = data + 2;
+	int i;
+
+	if (WARN(oid_len < 2, "OID must have at least two elements"))
+		return;
+	if (WARN(oid_len > 32, "OID is too large"))
+		return;
+
+	data[0] = _tag(UNIV, PRIM, OID);
+	*d++ = oid[0] * 40 + oid[1];
+	for (i = 2; i < oid_len; i++)
+		asn1_encode_oid_digit(&d, oid[i]);
+	data[1] = d - data - 2;
+	*_data = d;
+}
+EXPORT_SYMBOL(asn1_encode_oid);
+
+static void asn1_encode_definite_length(unsigned char **data, u32 len)
+{
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		return;
+	}
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		return;
+	}
+	if (len <= 0xffff) {
+		*((*data)++) = 0x82;
+		*((*data)++) = (len >> 8) & 0xff;
+		*((*data)++) = len & 0xff;
+		return;
+	}
+
+	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
+		return;
+
+	*((*data)++) = 0x83;
+	*((*data)++) = (len >> 16) & 0xff;
+	*((*data)++) = (len >> 8) & 0xff;
+	*((*data)++) = len & 0xff;
+}
+
+/**
+ * asn1_encode_tag - add a tag for optional or explicit value
+ * @data: pointer to place tag at
+ * @tag: tag to be placed
+ * @string: the data to be tagged
+ * @len: the length of the data to be tagged
+ *
+ * Note this currently only handles short form tags < 31
+ */
+void asn1_encode_tag(unsigned char **data, u32 tag,
+		     const unsigned char *string, u32 len)
+{
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return;
+
+	*((*data)++) = _tagn(CONT, CONS, tag);
+	asn1_encode_definite_length(data, len);
+	memcpy(*data, string, len);
+	*data += len;
+}
+EXPORT_SYMBOL(asn1_encode_tag);
+
+/**
+ * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
+ * @data: pointer to encode at
+ * @string: string to be encoded
+ * @len: length of string
+ *
+ * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
+ */
+void asn1_encode_octet_string(unsigned char **data, const unsigned char *string,
+			      u32 len)
+{
+	*((*data)++) = _tag(UNIV, PRIM, OTS);
+	asn1_encode_definite_length(data, len);
+	memcpy(*data, string, len);
+	*data += len;
+}
+EXPORT_SYMBOL(asn1_encode_octet_string);
+
+/**
+ * asn1_encode_sequence - wrap a byte stream in an ASN.1 SEQUENCE
+ * @data: pointer to encode at
+ * @seq: data to be encoded as a sequence
+ * @len: length of the data to be encoded as a sequence
+ */
+void asn1_encode_sequence(unsigned char **data, const unsigned char *seq,
+			  u32 len)
+{
+	*((*data)++) = _tag(UNIV, CONS, SEQ);
+	asn1_encode_definite_length(data, len);
+	memcpy(*data, seq, len);
+	*data += len;
+}
+EXPORT_SYMBOL(asn1_encode_sequence);
+
+/**
+ * asn1_encode_boolean - encode a boolean value to ASN.1
+ * @data: pointer to encode at
+ * @val: the boolean true/false value
+ */
+void asn1_encode_boolean(unsigned char **data, bool val)
+{
+	*((*data)++) = _tag(UNIV, PRIM, BOOL);
+	asn1_encode_definite_length(data, 1);
+	*((*data)++) = val ? 1 : 0;
+}
+EXPORT_SYMBOL(asn1_encode_boolean);
-- 
2.16.4

