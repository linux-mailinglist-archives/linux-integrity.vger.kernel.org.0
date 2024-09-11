Return-Path: <linux-integrity+bounces-3523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9597523E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C1D1F21C1E
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C324E19E988;
	Wed, 11 Sep 2024 12:30:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4918C03E;
	Wed, 11 Sep 2024 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057801; cv=none; b=QE2c/5ViQTaSUWN9VEJ/rU6suG/4ELOf0AbjrGT+gq3jNC1g+/IHmjUdeiAQKxJMQmITgz3fqD8hBkgg7q4//qmeeTmGuCHKjFkw/oMvB3TSkWagXMclEeF/7M2HaSQQ51MSF+ouKbxDc14k24/IyDtmbMrStOugpcN7L6vGuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057801; c=relaxed/simple;
	bh=B6emJ8PXU8IoHFjTi36zNHukoCT6UB6UryFbbH4zT9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAB0XZ1qoxizQr2tBe/Yn0jpKTmIxbc4QlxYHvi9HslVhSeZSIwUNBQL351erb4QnvcGREqMT7WdtUMkpGkmQZ9IZ6o8/A69NstpBIdbKsqkGekaYfRJ89zI/QDQ6IPyKJGu81P031E99Nj6U+ESFwlVtpyyV8Vja7KiG7eodJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X3fQ44ldHz9v7Jb;
	Wed, 11 Sep 2024 20:04:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 0597A140413;
	Wed, 11 Sep 2024 20:29:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3pscjjeFmDBG3AA--.60453S5;
	Wed, 11 Sep 2024 13:29:51 +0100 (CET)
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
Subject: [PATCH v3 03/14] PGPLIB: PGP definitions (RFC 9580)
Date: Wed, 11 Sep 2024 14:29:00 +0200
Message-Id: <20240911122911.1381864-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwD3pscjjeFmDBG3AA--.60453S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWUKFyUGrW5tF1kAFWfGrg_yoWxXr4xpr
	s5Gr95XFZ8t343tr1aqr4j9a43JrsrArn5Grn3Kw15t3W5WryxW34ktr1kXanrCa98J3yY
	kFW5Jrn3Cwn0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UACztU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQHzQADsB

From: David Howells <dhowells@redhat.com>

Provide some useful PGP definitions from RFC 9580.  These describe details
of public key crypto as used by crypto keys for things like signature
verification.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp.h | 216 +++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp.h

diff --git a/crypto/asymmetric_keys/pgp.h b/crypto/asymmetric_keys/pgp.h
new file mode 100644
index 000000000000..eaf0ab8e0373
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP definitions (RFC 9580)
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/types.h>
+
+struct pgp_key_ID {
+	u8 id[8];
+} __packed;
+
+struct pgp_time {
+	u8 time[4];
+} __packed;
+
+/*
+ * PGP public-key algorithm identifiers [RFC 9580: 9.1]
+ */
+enum pgp_pubkey_algo {
+	PGP_PUBKEY_RSA_ENC_OR_SIG	= 1,
+	PGP_PUBKEY_RSA_ENC_ONLY		= 2,
+	PGP_PUBKEY_RSA_SIG_ONLY		= 3,
+	PGP_PUBKEY_ELGAMAL		= 16,
+	PGP_PUBKEY_DSA			= 17,
+	PGP_PUBKEY_ECDH			= 18,
+	PGP_PUBKEY_ECDSA		= 19,
+	PGP_PUBKEY_EDDSA_LEGACY		= 22,
+	PGP_PUBKEY_X25519		= 25,
+	PGP_PUBKEY_X448			= 26,
+	PGP_PUBKEY_ED25519		= 27,
+	PGP_PUBKEY_ED448		= 28,
+	PGP_PUBKEY__LAST
+};
+
+/*
+ * PGP symmetric-key algorithm identifiers [RFC 9580: 9.3]
+ */
+enum pgp_symkey_algo {
+	PGP_SYMKEY_PLAINTEXT		= 0,
+	PGP_SYMKEY_IDEA			= 1,
+	PGP_SYMKEY_3DES			= 2,
+	PGP_SYMKEY_CAST5		= 3,
+	PGP_SYMKEY_BLOWFISH		= 4,
+	PGP_SYMKEY_AES_128KEY		= 7,
+	PGP_SYMKEY_AES_192KEY		= 8,
+	PGP_SYMKEY_AES_256KEY		= 9,
+	PGP_SYMKEY_TWOFISH_256KEY	= 10,
+	PGP_SYMKEY_CAMELIA_128KEY	= 11,
+	PGP_SYMKEY_CAMELIA_192KEY	= 12,
+	PGP_SYMKEY_CAMELIA_256KEY	= 13,
+	PGP_SYMKEY__LAST
+};
+
+/*
+ * PGP compression algorithm identifiers [RFC 9580: 9.4]
+ */
+enum pgp_compr_algo {
+	PGP_COMPR_UNCOMPRESSED		= 0,
+	PGP_COMPR_ZIP			= 1,
+	PGP_COMPR_ZLIB			= 2,
+	PGP_COMPR_BZIP2			= 3,
+	PGP_COMPR__LAST
+};
+
+/*
+ * PGP hash algorithm identifiers [RFC 9580: 9.4]
+ */
+enum pgp_hash_algo {
+	PGP_HASH_MD5			= 1,
+	PGP_HASH_SHA1			= 2,
+	PGP_HASH_RIPE_MD_160		= 3,
+	PGP_HASH_SHA256			= 8,
+	PGP_HASH_SHA384			= 9,
+	PGP_HASH_SHA512			= 10,
+	PGP_HASH_SHA224			= 11,
+	PGP_HASH_SHA3_256		= 12,
+	PGP_HASH_SHA3_512		= 14,
+	PGP_HASH__LAST
+};
+
+extern const char *const pgp_hash_algorithms[PGP_HASH__LAST];
+
+/*
+ * PGP packet type tags [RFC 9580: 5].
+ */
+enum pgp_packet_tag {
+	PGP_PKT_RESERVED		= 0,
+	PGP_PKT_PUBKEY_ENC_SESSION_KEY	= 1,
+	PGP_PKT_SIGNATURE		= 2,
+	PGP_PKT_SYMKEY_ENC_SESSION_KEY	= 3,
+	PGP_PKT_ONEPASS_SIGNATURE	= 4,
+	PGP_PKT_SECRET_KEY		= 5,
+	PGP_PKT_PUBLIC_KEY		= 6,
+	PGP_PKT_SECRET_SUBKEY		= 7,
+	PGP_PKT_COMPRESSED_DATA		= 8,
+	PGP_PKT_SYM_ENC_DATA		= 9,
+	PGP_PKT_MARKER			= 10,
+	PGP_PKT_LITERAL_DATA		= 11,
+	PGP_PKT_TRUST			= 12,
+	PGP_PKT_USER_ID			= 13,
+	PGP_PKT_PUBLIC_SUBKEY		= 14,
+	PGP_PKT_USER_ATTRIBUTE		= 17,
+	PGP_PKT_SYM_ENC_AND_INTEG_DATA	= 18,
+	PGP_PKT_MODIFY_DETECT_CODE	= 19,
+	PGP_PKT_PRIVATE_0		= 60,
+	PGP_PKT_PRIVATE_3		= 63,
+	PGP_PKT__HIGHEST		= 63
+};
+
+/*
+ * Signature (tag 2) packet [RFC 9580: 5.2].
+ */
+enum pgp_signature_version {
+	PGP_SIG_VERSION_3			= 3,
+	PGP_SIG_VERSION_4			= 4,
+};
+
+/*
+ * Signature types [RFC 9580: 5.2.1].
+ */
+enum pgp_signature_type {
+	PGP_SIG_BINARY_DOCUMENT_SIG		= 0x00,
+	PGP_SIG_CANONICAL_TEXT_DOCUMENT_SIG	= 0x01,
+	PGP_SIG_STANDALONE_SIG			= 0x02,
+	PGP_SIG_GENERAL_CERT_OF_UID_PUBKEY	= 0x10,
+	PGP_SIG_PERSONAL_CERT_OF_UID_PUBKEY	= 0x11,
+	PGP_SIG_CASUAL_CERT_OF_UID_PUBKEY	= 0x12,
+	PGP_SIG_POSTITIVE_CERT_OF_UID_PUBKEY	= 0x13,
+	PGP_SIG_SUBKEY_BINDING_SIG		= 0x18,
+	PGP_SIG_PRIMARY_KEY_BINDING_SIG		= 0x19,
+	PGP_SIG_DIRECTLY_ON_KEY			= 0x1F,
+	PGP_SIG_KEY_REVOCATION_SIG		= 0x20,
+	PGP_SIG_SUBKEY_REVOCATION_SIG		= 0x28,
+	PGP_SIG_CERT_REVOCATION_SIG		= 0x30,
+	PGP_SIG_TIMESTAMP_SIG			= 0x40,
+	PGP_SIG_THIRD_PARTY_CONFIRM_SIG		= 0x50,
+};
+
+struct pgp_signature_v3_packet {
+	enum pgp_signature_version version : 8; /* == PGP_SIG_VERSION_3 */
+	u8	length_of_hashed;	/* == 5 */
+	struct {
+		enum pgp_signature_type signature_type : 8;
+		struct pgp_time	creation_time;
+	} __packed hashed;
+	struct pgp_key_ID issuer;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+} __packed;
+
+struct pgp_signature_v4_packet {
+	enum pgp_signature_version version : 8;	/* == PGP_SIG_VERSION_4 */
+	enum pgp_signature_type signature_type : 8;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	enum pgp_hash_algo hash_algo : 8;
+} __packed;
+
+/*
+ * V4 signature subpacket types [RFC 9580: 5.2.3.7].
+ */
+enum pgp_sig_subpkt_type {
+	PGP_SIG_CREATION_TIME			= 2,
+	PGP_SIG_EXPIRATION_TIME			= 3,
+	PGP_SIG_EXPORTABLE_CERT			= 4,
+	PGP_SIG_TRUST_SIG			= 5,
+	PGP_SIG_REGEXP				= 6,
+	PGP_SIG_REVOCABLE			= 7,
+	PGP_SIG_KEY_EXPIRATION_TIME		= 9,
+	PGP_SIG_PREF_SYM_ALGO			= 11,
+	PGP_SIG_REVOCATION_KEY			= 12,
+	PGP_SIG_ISSUER				= 16,
+	PGP_SIG_NOTATION_DATA			= 20,
+	PGP_SIG_PREF_HASH_ALGO			= 21,
+	PGP_SIG_PREF_COMPR_ALGO			= 22,
+	PGP_SIG_KEY_SERVER_PREFS		= 23,
+	PGP_SIG_PREF_KEY_SERVER			= 24,
+	PGP_SIG_PRIMARY_USER_ID			= 25,
+	PGP_SIG_POLICY_URI			= 26,
+	PGP_SIG_KEY_FLAGS			= 27,
+	PGP_SIG_SIGNERS_USER_ID			= 28,
+	PGP_SIG_REASON_FOR_REVOCATION		= 29,
+	PGP_SIG_FEATURES			= 30,
+	PGP_SIG_TARGET				= 31,
+	PGP_SIG_EMBEDDED_SIG			= 32,
+	PGP_SIG_ISSUER_FINGERPRINT		= 33,
+	PGP_SIG_INTENDED_RECIPIENT_FINGERPRINT	= 35,
+	PGP_SIG_PREFERRED_AEAD_CIPHERS		= 39,
+	PGP_SIG__LAST
+};
+
+#define PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK	0x80
+
+/*
+ * Key (tag 5, 6, 7 and 14) packet
+ */
+enum pgp_key_version {
+	PGP_KEY_VERSION_4			= 4,
+};
+
+struct pgp_key_v4_packet {
+	enum pgp_key_version version : 8;
+	struct pgp_time	creation_time;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	u8 key_material[];
+} __packed;
+
+/*
+ * Literal Data (tag 11) packet
+ */
+enum pgp_literal_data_format {
+	PGP_LIT_FORMAT_BINARY			= 0x62,
+	PGP_LIT_FORMAT_TEXT			= 0x74,
+	PGP_LIT_FORMAT_TEXT_UTF8		= 0x75,
+};
-- 
2.34.1


