Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE712D2D1
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfL3RjN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 12:39:13 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39232 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbfL3RjN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 12:39:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 527C98EE191;
        Mon, 30 Dec 2019 09:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1577727553;
        bh=J8O3LSB+CxMTGlIOpTPG2mQxFPe/FGo21VByuQRGbVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xSW3beqmc8T0JfZAhnohZVKHj0FhGqj3HP3XEyzDLEWKfmhj0e77kyZJmDSTrmgqs
         biQ3CIXvjURv1dDUS8A5XO6zSaMj3lZbqol7MtxSF7KcaIjzavcv9kQiVDGwkGMDKk
         LjAEpF66QvAZY5f9dZQIBnfWUZrE3Q3g5Lx8xcm8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8KhbdBivcy6q; Mon, 30 Dec 2019 09:39:13 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 631798EE185;
        Mon, 30 Dec 2019 09:39:12 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: [PATCH v4 1/9] lib: add asn.1 encoder
Date:   Mon, 30 Dec 2019 09:37:54 -0800
Message-Id: <20191230173802.8731-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
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

v2: updated API to use indefinite length, and made symbol exports gpl
v3: add data length error handling
v4: use end_data instead of data_len pointer
---
 include/linux/asn1_encoder.h |  32 ++++
 lib/Makefile                 |   2 +-
 lib/asn1_encoder.c           | 391 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/asn1_encoder.h
 create mode 100644 lib/asn1_encoder.c

diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
new file mode 100644
index 000000000000..08cd0c2ad34f
--- /dev/null
+++ b/include/linux/asn1_encoder.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _LINUX_ASN1_ENCODER_H
+#define _LINUX_ASN1_ENCODER_H
+
+#include <linux/types.h>
+#include <linux/asn1.h>
+#include <linux/asn1_ber_bytecode.h>
+#include <linux/bug.h>
+
+#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
+unsigned char *
+asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
+		    s64 integer);
+unsigned char *
+asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
+		u32 oid[], int oid_len);
+unsigned char *
+asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
+		u32 tag, const unsigned char *string, int len);
+unsigned char *
+asn1_encode_octet_string(unsigned char *data,
+			 const unsigned char *end_data,
+			 const unsigned char *string, u32 len);
+unsigned char *
+asn1_encode_sequence(unsigned char *data, const unsigned char *end_data,
+		     const unsigned char *seq, int len);
+unsigned char *
+asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
+		    bool val);
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
index 000000000000..e3d9631a50fd
--- /dev/null
+++ b/lib/asn1_encoder.c
@@ -0,0 +1,391 @@
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
+ * @data: pointer to the pointer to the data
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @integer: integer to be encoded
+ *
+ * This is a simplified encoder: it only currently does
+ * positive integers, but it should be simple enough to add the
+ * negative case if a use comes along.
+ */
+unsigned char *
+asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
+		    s64 integer)
+{
+	unsigned char *d = &data[2];
+	int i;
+	bool found = false;
+	int data_len = end_data - data;
+
+	if (WARN(integer < 0,
+		 "BUG: integer encode only supports positive integers"))
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ERR(data))
+		return data;
+
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+
+	data_len -= 2;
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
+		/*
+		 * for a positive number the first byte must have bit
+		 * 7 clear in two's complement (otherwise it's a
+		 * negative number) so prepend a leading zero if
+		 * that's not the case
+		 */
+		if (!found && (byte & 0x80)) {
+			/*
+			 * no check needed here, we already know we
+			 * have len >= 1
+			 */
+			*d++ = 0;
+			data_len--;
+		}
+		found = true;
+		if (data_len == 0)
+			return ERR_PTR(-EINVAL);
+		*d++ = byte;
+		data_len--;
+	}
+ out:
+	data[1] = d - data - 2;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_integer);
+
+/* calculate the base 128 digit values setting the top bit of the first octet */
+static int asn1_encode_oid_digit(unsigned char **_data, int *data_len, u32 oid)
+{
+	int start = 7 + 7 + 7 + 7;
+	unsigned char *data = *_data;
+	int ret = 0;
+
+	if (*data_len < 1)
+		return -EINVAL;
+
+	/* quick case */
+	if (oid == 0) {
+		*data++ = 0x80;
+		(*data_len)--;
+		goto out;
+	}
+
+	while (oid >> start == 0)
+		start -= 7;
+
+	while (start > 0 && *data_len > 0) {
+		u8 byte;
+
+		byte = oid >> start;
+		oid = oid - (byte << start);
+		start -= 7;
+		byte |= 0x80;
+		*data++ = byte;
+		(*data_len)--;
+	}
+	if (*data_len > 0) {
+		*data++ = oid;
+		(*data_len)--;
+	} else {
+		ret = -EINVAL;
+	}
+
+ out:
+	*_data = data;
+	return ret;
+}
+
+/**
+ * asn1_encode_oid - encode an oid to ASN.1
+ * @data: position to begin encoding at
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @oid: array of oids
+ * @oid_len: length of oid array
+ *
+ * this encodes an OID up to ASN.1 when presented as an array of OID values
+ */
+unsigned char *
+asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
+		u32 oid[], int oid_len)
+{
+	unsigned char *d = data + 2;
+	int i, ret;
+	int data_len = end_data - data;
+
+	if (WARN(oid_len < 2, "OID must have at least two elements"))
+		return ERR_PTR(-EINVAL);
+	if (WARN(oid_len > 32, "OID is too large"))
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(data))
+		return data;
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	data[0] = _tag(UNIV, PRIM, OID);
+	*d++ = oid[0] * 40 + oid[1];
+	data_len -= 2;
+	ret = 0;
+	for (i = 2; i < oid_len; i++) {
+		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+	data[1] = d - data - 2;
+	return d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_oid);
+
+static int asn1_encode_length(unsigned char **data, int *data_len, int len)
+{
+	if (*data_len < 1)
+		return -EINVAL;
+	if (len < 0) {
+		*((*data)++) = ASN1_INDEFINITE_LENGTH;
+		(*data_len)--;
+		return 0;
+	}
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		*data_len -= 2;
+		return 0;
+	}
+
+	if (*data_len < 3)
+		return -EINVAL;
+	if (len <= 0xffff) {
+		*((*data)++) = 0x82;
+		*((*data)++) = (len >> 8) & 0xff;
+		*((*data)++) = len & 0xff;
+		*data_len -= 3;
+		return 0;
+	}
+
+	if (WARN(len > 0xffffff, "ASN.1 length can't be > 0xffffff"))
+		return -EINVAL;
+
+	if (*data_len < 4)
+		return -EINVAL;
+	*((*data)++) = 0x83;
+	*((*data)++) = (len >> 16) & 0xff;
+	*((*data)++) = (len >> 8) & 0xff;
+	*((*data)++) = len & 0xff;
+	*data_len -= 4;
+
+	return 0;
+}
+
+/**
+ * asn1_encode_tag - add a tag for optional or explicit value
+ * @data: pointer to place tag at
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @tag: tag to be placed
+ * @string: the data to be tagged
+ * @len: the length of the data to be tagged
+ *
+ * Note this currently only handles short form tags < 31.  To encode
+ * in place pass a NULL @string and -1 for @len; all this will do is
+ * add an indefinite length tag and update the data pointer to the
+ * place where the tag contents should be placed.  After the data is
+ * placed, repeat the prior statement but now with the known length.
+ * In order to avoid having to keep both before and after pointers,
+ * the repeat expects to be called with @data pointing to where the
+ * first encode placed it.
+ */
+unsigned char *
+asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
+		u32 tag, const unsigned char *string, int len)
+{
+	int ret;
+	int data_len = end_data - data;
+
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return ERR_PTR(-EINVAL);
+
+	if (!string && WARN(len > 127,
+			    "BUG: recode tag is too big (>127)"))
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(data))
+		return data;
+
+	if (!string && len > 0) {
+		/*
+		 * we're recoding, so move back to the start of the
+		 * tag and install a dummy length because the real
+		 * data_len should be NULL
+		 */
+		data -= 2;
+		data_len = 2;
+	}
+
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tagn(CONT, CONS, tag);
+	data_len--;
+	ret = asn1_encode_length(&data, &data_len, len);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (!string)
+		return data;
+	if (data_len < len)
+		return ERR_PTR(-EINVAL);
+	memcpy(data, string, len);
+	data += len;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_tag);
+
+/**
+ * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
+ * @data: pointer to encode at
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @string: string to be encoded
+ * @len: length of string
+ *
+ * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
+ */
+unsigned char *
+asn1_encode_octet_string(unsigned char *data,
+			 const unsigned char *end_data,
+			 const unsigned char *string, u32 len)
+{
+	int ret;
+	int data_len = end_data - data;
+
+	if (IS_ERR(data))
+		return data;
+
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tag(UNIV, PRIM, OTS);
+	data_len--;
+	ret = asn1_encode_length(&data, &data_len, len);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (data_len < len)
+		return ERR_PTR(-EINVAL);
+
+	memcpy(data, string, len);
+	data += len;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_octet_string);
+
+/**
+ * asn1_encode_sequence - wrap a byte stream in an ASN.1 SEQUENCE
+ * @data: pointer to encode at
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @seq: data to be encoded as a sequence
+ * @len: length of the data to be encoded as a sequence
+ *
+ * Fill in a sequence.  To encode in place, pass NULL for @seq and -1
+ * for @len; then call again once the length is known (still with NULL
+ * for @seq). In order to avoid having to keep both before and after
+ * pointers, the repeat expects to be called with @data pointing to
+ * where the first encode placed it.
+ */
+unsigned char *
+asn1_encode_sequence(unsigned char *data, const unsigned char *end_data,
+		     const unsigned char *seq, int len)
+{
+	int ret;
+	int data_len = end_data - data;
+
+	if (!seq && WARN(len > 127,
+			 "BUG: recode sequence is too big (>127)"))
+		return ERR_PTR(-EINVAL);
+	if (IS_ERR(data))
+		return data;
+	if (!seq && len >= 0) {
+		/*
+		 * we're recoding, so move back to the start of the
+		 * sequence and install a dummy length because the
+		 * real length should be NULL
+		 */
+		data -= 2;
+		data_len = 2;
+	}
+
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tag(UNIV, CONS, SEQ);
+	data_len--;
+	ret = asn1_encode_length(&data, &data_len, len);
+	if (ret)
+		return ERR_PTR(ret);
+	if (!seq)
+		return data;
+
+	if (data_len < len)
+		return ERR_PTR(-EINVAL);
+
+	memcpy(data, seq, len);
+	data += len;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_sequence);
+
+/**
+ * asn1_encode_boolean - encode a boolean value to ASN.1
+ * @data: pointer to encode at
+ * @end_data: end of data pointer, points one beyond last usable byte in @data
+ * @val: the boolean true/false value
+ */
+unsigned char *
+asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
+		    bool val)
+{
+	int data_len = end_data - data;
+
+	if (IS_ERR(data))
+		return data;
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+	*(data++) = _tag(UNIV, PRIM, BOOL);
+	data_len--;
+	asn1_encode_length(&data, &data_len, 1);
+	*(data++) = val ? 1 : 0;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_boolean);
-- 
2.16.4

