Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48648B513
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiAKSFA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jan 2022 13:05:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4391 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbiAKSDw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jan 2022 13:03:52 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JYJPr45rbz67wXw;
        Wed, 12 Jan 2022 02:00:16 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 11 Jan 2022 19:03:49 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <dhowells@redhat.com>, <dwmw2@infradead.org>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zohar@linux.ibm.com>,
        <ebiggers@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 03/14] PGPLIB: PGP definitions (RFC 4880)
Date:   Tue, 11 Jan 2022 19:03:07 +0100
Message-ID: <20220111180318.591029-4-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111180318.591029-1-roberto.sassu@huawei.com>
References: <20220111180318.591029-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Provide some useful PGP definitions from RFC 4880.  These describe details
of public key crypto as used by crypto keys for things like signature
verification.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp.h | 206 +++++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 crypto/asymmetric_keys/pgp.h

diff --git a/crypto/asymmetric_keys/pgp.h b/crypto/asymmetric_keys/pgp.h
new file mode 100644
index 000000000000..5eb4f4222090
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* PGP definitions (RFC 4880)
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
+ * PGP public-key algorithm identifiers [RFC4880: 9.1]
+ */
+enum pgp_pubkey_algo {
+	PGP_PUBKEY_RSA_ENC_OR_SIG	= 1,
+	PGP_PUBKEY_RSA_ENC_ONLY		= 2,
+	PGP_PUBKEY_RSA_SIG_ONLY		= 3,
+	PGP_PUBKEY_ELGAMAL		= 16,
+	PGP_PUBKEY_DSA			= 17,
+	PGP_PUBKEY__LAST
+};
+
+/*
+ * PGP symmetric-key algorithm identifiers [RFC4880: 9.2]
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
+};
+
+/*
+ * PGP compression algorithm identifiers [RFC4880: 9.3]
+ */
+enum pgp_compr_algo {
+	PGP_COMPR_UNCOMPRESSED		= 0,
+	PGP_COMPR_ZIP			= 1,
+	PGP_COMPR_ZLIB			= 2,
+	PGP_COMPR_BZIP2			= 3,
+};
+
+/*
+ * PGP hash algorithm identifiers [RFC4880: 9.4]
+ */
+enum pgp_hash_algo {
+	PGP_HASH_MD5			= 1,
+	PGP_HASH_SHA1			= 2,
+	PGP_HASH_RIPE_MD_160		= 3,
+	PGP_HASH_SHA256			= 8,
+	PGP_HASH_SHA384			= 9,
+	PGP_HASH_SHA512			= 10,
+	PGP_HASH_SHA224			= 11,
+	PGP_HASH__LAST
+};
+
+extern const char *const pgp_hash_algorithms[PGP_HASH__LAST];
+
+/*
+ * PGP packet type tags [RFC4880: 4.3].
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
+ * Signature (tag 2) packet [RFC4880: 5.2].
+ */
+enum pgp_signature_version {
+	PGP_SIG_VERSION_3			= 3,
+	PGP_SIG_VERSION_4			= 4,
+};
+
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
+ * V4 signature subpacket types [RFC4880: 5.2.3.1].
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
+	PGP_SIG__LAST
+};
+
+#define PGP_SIG_SUBPKT_TYPE_CRITICAL_MASK	0x80
+
+/*
+ * Key (tag 5, 6, 7 and 14) packet
+ */
+enum pgp_key_version {
+	PGP_KEY_VERSION_2			= 2,
+	PGP_KEY_VERSION_3			= 3,
+	PGP_KEY_VERSION_4			= 4,
+};
+
+struct pgp_key_v3_packet {
+	enum pgp_key_version version : 8;
+	struct pgp_time	creation_time;
+	u8 expiry[2];			/* 0 or time in days till expiry */
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	u8 key_material[0];
+} __packed;
+
+struct pgp_key_v4_packet {
+	enum pgp_key_version version : 8;
+	struct pgp_time	creation_time;
+	enum pgp_pubkey_algo pubkey_algo : 8;
+	u8 key_material[0];
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
2.32.0

