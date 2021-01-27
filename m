Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2003063C4
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 20:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbhA0TIz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 14:08:55 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:58772 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344219AbhA0TIw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 14:08:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 60CD6128091F;
        Wed, 27 Jan 2021 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1611774492;
        bh=YHt4RAsYu1QQnSDnLJUdyiRZsRAbCnUy9STr4RulVHQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
        b=vrzJMioulwHAWnVCSNYmJqVq6Vu62B4xgqpKainEYLSPtN1fuLfN3IHbUgUqKlz3S
         YcMoJT1skWK4L4b1jHqeBCuPuvB7BrAHFWBbwpQY8vQMonzyqeXuCmgFsViYBuhCVK
         HKeBRt1YjnE7upanc3jckoTWMqBcKmpcx1Htm5T8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y1lO1iGujHmF; Wed, 27 Jan 2021 11:08:12 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id E547F128091E;
        Wed, 27 Jan 2021 11:08:11 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH v15 1/5] lib: add ASN.1 encoder
Date:   Wed, 27 Jan 2021 11:06:13 -0800
Message-Id: <20210127190617.17564-2-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We have a need in the TPM2 trusted keys to return the ASN.1 form of
the TPM key blob so it can be operated on by tools outside of the
kernel.  The specific tools are the openssl_tpm2_engine, openconnect
and the Intel tpm2-tss-engine.  To do that, we have to be able to read
and write the same binary key format the tools use.  The current ASN.1
decoder does fine for reading, but we need pieces of an ASN.1 encoder
to write the key blob in binary compatible form.

For backwards compatibility, the trusted key reader code will still
accept the two TPM2B quantities that it uses today, but the writer
will only output the ASN.1 form.

The current implementation only encodes the ASN.1 bits we actually need.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: David Howells <dhowells@redhat.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

---

v2: updated API to use indefinite length, and made symbol exports gpl
v3: add data length error handling
v4: use end_data instead of data_len pointer
v5: mention tools and space out code
v7: reverse christmas tree variable definitions and better spacing
v9: update comments, remove indefinite length, make encoder config dependent
v15: add review and tested
---
 include/linux/asn1_encoder.h |  32 +++
 lib/Kconfig                  |   3 +
 lib/Makefile                 |   1 +
 lib/asn1_encoder.c           | 454 +++++++++++++++++++++++++++++++++++
 4 files changed, 490 insertions(+)
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
diff --git a/lib/Kconfig b/lib/Kconfig
index 46806332a8cc..a5bd3a86226f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -692,3 +692,6 @@ config GENERIC_LIB_DEVMEM_IS_ALLOWED
 config PLDMFW
 	bool
 	default n
+
+config ASN1_ENCODER
+       tristate
diff --git a/lib/Makefile b/lib/Makefile
index afeff05fa8c5..b9a975daed16 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -282,6 +282,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
 obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 
 obj-$(CONFIG_ASN1) += asn1_decoder.o
+obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
new file mode 100644
index 000000000000..41e71aae3ef6
--- /dev/null
+++ b/lib/asn1_encoder.c
@@ -0,0 +1,454 @@
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
+ * asn1_encode_integer() - encode positive integer to ASN.1
+ * @data:	pointer to the pointer to the data
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @integer:	integer to be encoded
+ *
+ * This is a simplified encoder: it only currently does
+ * positive integers, but it should be simple enough to add the
+ * negative case if a use comes along.
+ */
+unsigned char *
+asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
+		    s64 integer)
+{
+	int data_len = end_data - data;
+	unsigned char *d = &data[2];
+	bool found = false;
+	int i;
+
+	if (WARN(integer < 0,
+		 "BUG: integer encode only supports positive integers"))
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ERR(data))
+		return data;
+
+	/* need at least 3 bytes for tag, length and integer encoding */
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+
+	/* remaining length where at d (the start of the integer encoding) */
+	data_len -= 2;
+
+	data[0] = _tag(UNIV, PRIM, INT);
+	if (integer == 0) {
+		*d++ = 0;
+		goto out;
+	}
+
+	for (i = sizeof(integer); i > 0 ; i--) {
+		int byte = integer >> (8 * (i - 1));
+
+		if (!found && byte == 0)
+			continue;
+
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
+
+		found = true;
+		if (data_len == 0)
+			return ERR_PTR(-EINVAL);
+
+		*d++ = byte;
+		data_len--;
+	}
+
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
+	unsigned char *data = *_data;
+	int start = 7 + 7 + 7 + 7;
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
+
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
+ * asn1_encode_oid() - encode an oid to ASN.1
+ * @data:	position to begin encoding at
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @oid:	array of oids
+ * @oid_len:	length of oid array
+ *
+ * this encodes an OID up to ASN.1 when presented as an array of OID values
+ */
+unsigned char *
+asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
+		u32 oid[], int oid_len)
+{
+	int data_len = end_data - data;
+	unsigned char *d = data + 2;
+	int i, ret;
+
+	if (WARN(oid_len < 2, "OID must have at least two elements"))
+		return ERR_PTR(-EINVAL);
+
+	if (WARN(oid_len > 32, "OID is too large"))
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ERR(data))
+		return data;
+
+
+	/* need at least 3 bytes for tag, length and OID encoding */
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+
+	data[0] = _tag(UNIV, PRIM, OID);
+	*d++ = oid[0] * 40 + oid[1];
+
+	data_len -= 3;
+
+	ret = 0;
+
+	for (i = 2; i < oid_len; i++) {
+		ret = asn1_encode_oid_digit(&d, &data_len, oid[i]);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	data[1] = d - data - 2;
+
+	return d;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_oid);
+
+/**
+ * asn1_encode_length() - encode a length to follow an ASN.1 tag
+ * @data: pointer to encode at
+ * @data_len: pointer to remaning length (adjusted by routine)
+ * @len: length to encode
+ *
+ * This routine can encode lengths up to 65535 using the ASN.1 rules.
+ * It will accept a negative length and place a zero length tag
+ * instead (to keep the ASN.1 valid).  This convention allows other
+ * encoder primitives to accept negative lengths as singalling the
+ * sequence will be re-encoded when the length is known.
+ */
+static int asn1_encode_length(unsigned char **data, int *data_len, int len)
+{
+	if (*data_len < 1)
+		return -EINVAL;
+
+	if (len < 0) {
+		*((*data)++) = 0;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (len <= 0x7f) {
+		*((*data)++) = len;
+		(*data_len)--;
+		return 0;
+	}
+
+	if (*data_len < 2)
+		return -EINVAL;
+
+	if (len <= 0xff) {
+		*((*data)++) = 0x81;
+		*((*data)++) = len & 0xff;
+		*data_len -= 2;
+		return 0;
+	}
+
+	if (*data_len < 3)
+		return -EINVAL;
+
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
+ * asn1_encode_tag() - add a tag for optional or explicit value
+ * @data:	pointer to place tag at
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @tag:	tag to be placed
+ * @string:	the data to be tagged
+ * @len:	the length of the data to be tagged
+ *
+ * Note this currently only handles short form tags < 31.
+ *
+ * Standard usage is to pass in a @tag, @string and @length and the
+ * @string will be ASN.1 encoded with @tag and placed into @data.  If
+ * the encoding would put data past @end_data then an error is
+ * returned, otherwise a pointer to a position one beyond the encoding
+ * is returned.
+ *
+ * To encode in place pass a NULL @string and -1 for @len and the
+ * maximum allowable beginning and end of the data; all this will do
+ * is add the current maximum length and update the data pointer to
+ * the place where the tag contents should be placed is returned.  The
+ * data should be copied in by the calling routine which should then
+ * repeat the prior statement but now with the known length.  In order
+ * to avoid having to keep both before and after pointers, the repeat
+ * expects to be called with @data pointing to where the first encode
+ * returned it and still NULL for @string but the real length in @len.
+ */
+unsigned char *
+asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
+		u32 tag, const unsigned char *string, int len)
+{
+	int data_len = end_data - data;
+	int ret;
+
+	if (WARN(tag > 30, "ASN.1 tag can't be > 30"))
+		return ERR_PTR(-EINVAL);
+
+	if (!string && WARN(len > 127,
+			    "BUG: recode tag is too big (>127)"))
+		return ERR_PTR(-EINVAL);
+
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
+
+	if (!string)
+		return data;
+
+	if (data_len < len)
+		return ERR_PTR(-EINVAL);
+
+	memcpy(data, string, len);
+	data += len;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_tag);
+
+/**
+ * asn1_encode_octet_string() - encode an ASN.1 OCTET STRING
+ * @data:	pointer to encode at
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @string:	string to be encoded
+ * @len:	length of string
+ *
+ * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
+ */
+unsigned char *
+asn1_encode_octet_string(unsigned char *data,
+			 const unsigned char *end_data,
+			 const unsigned char *string, u32 len)
+{
+	int data_len = end_data - data;
+	int ret;
+
+	if (IS_ERR(data))
+		return data;
+
+	/* need minimum of 2 bytes for tag and length of zero length string */
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tag(UNIV, PRIM, OTS);
+	data_len--;
+
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
+ * asn1_encode_sequence() - wrap a byte stream in an ASN.1 SEQUENCE
+ * @data:	pointer to encode at
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @seq:	data to be encoded as a sequence
+ * @len:	length of the data to be encoded as a sequence
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
+	int data_len = end_data - data;
+	int ret;
+
+	if (!seq && WARN(len > 127,
+			 "BUG: recode sequence is too big (>127)"))
+		return ERR_PTR(-EINVAL);
+
+	if (IS_ERR(data))
+		return data;
+
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
+
+	ret = asn1_encode_length(&data, &data_len, len);
+	if (ret)
+		return ERR_PTR(ret);
+
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
+ * asn1_encode_boolean() - encode a boolean value to ASN.1
+ * @data:	pointer to encode at
+ * @end_data:	end of data pointer, points one beyond last usable byte in @data
+ * @val:	the boolean true/false value
+ */
+unsigned char *
+asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
+		    bool val)
+{
+	int data_len = end_data - data;
+
+	if (IS_ERR(data))
+		return data;
+
+	/* booleans are 3 bytes: tag, length == 1 and value == 0 or 1 */
+	if (data_len < 3)
+		return ERR_PTR(-EINVAL);
+
+	*(data++) = _tag(UNIV, PRIM, BOOL);
+	data_len--;
+
+	asn1_encode_length(&data, &data_len, 1);
+
+	if (val)
+		*(data++) = 1;
+	else
+		*(data++) = 0;
+
+	return data;
+}
+EXPORT_SYMBOL_GPL(asn1_encode_boolean);
+
+MODULE_LICENSE("GPL");
-- 
2.26.2

