Return-Path: <linux-integrity+bounces-3340-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72B955D99
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7371C20C87
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCF814A609;
	Sun, 18 Aug 2024 17:00:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C41145B21;
	Sun, 18 Aug 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000401; cv=none; b=BGVMWdOig1/tIqtV3T6K1UmDY3iIxVaKwUmFleprxuY2/nnwmND6KIuLMuwI8Gz2L1g8vDD7viP7kVRY9K78sloVv0qaD8rCOosSU1Tyo7Ai3LfFWuIqDjVJ5PDeGjvgi4+mvmKZkQxhItF4/OvsOq72uf/wcmYKZTkVuUCdVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000401; c=relaxed/simple;
	bh=gNmux8ZKDj5mTvVYrtYnkE2L10WgCdg701Gxlyc4Kq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aaPK14mfeDrJQ3uxLtJPz9J00XPsTsJc+eV2GQwiAvvFweFz1L7D2RPDcGdSeNF/ShmkT7RJQ9a4xXqAz0FBJc9S1bOLa/bPGsu9JSyXkHx7CnP7Ni+X8wNkvSCoJ7BAUPh6YWdvYmZk3XtKe5eQsiMWtmMQxnNQOsUD68p+RDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wn1gq3V11z9v7Hk;
	Mon, 19 Aug 2024 00:40:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A1262140380;
	Mon, 19 Aug 2024 00:59:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S5;
	Sun, 18 Aug 2024 17:59:50 +0100 (CET)
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
Subject: [PATCH v2 03/14] PGPLIB: PGP definitions (RFC 4880)
Date: Sun, 18 Aug 2024 18:57:45 +0200
Message-Id: <20240818165756.629203-4-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW5Zw1UurW3XFWUur4fAFb_yoW7KFWDpr
	s5Gr95XFyDt343tr4Sqr429a4fJrsrAr1kGrn3tw15tas8WryIg34ktr1kXan3Ga95J3yY
	kFW5Arn3Cwn0y37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGbBWHEB+gABsi

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
index 000000000000..f8f06b674462
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
+	u8 key_material[];
+} __packed;
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


