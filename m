Return-Path: <linux-integrity+bounces-9010-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOjEGT99uWmxHAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9010-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CB42ADB27
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B711E3132FC8
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB092F2619;
	Tue, 17 Mar 2026 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CKlOwAFm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA602F7AD2;
	Tue, 17 Mar 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763620; cv=none; b=dIxvcs+Zz1y2Sqx8ldqoq8M8gE72I3Tb/auiGkc+t6yMMro5ljKi8mZDM+nOcpo6XduTg38zqM5ZFCDTOzMzSflmZH/lNsyVwCTwzdD3Fb7H8bztIgMGesHDXBaM+ZhCOuSk8kkoU8AUpbz8akFAqD2arvsrmOU3W/nXctqexxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763620; c=relaxed/simple;
	bh=syxAEL/501RO1ZUmlbawWqdmrT2uSQijrIKoGaXtHnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZioJaLzwRWrdm8P8EQ8dVfKGrLkJALaCq6iAJmmnohopCAOG9841Jk8aoOi7MYSn5vdGvF03vBQRzEBkejVUNaOaL6kGWC5TvIc+qqpM8dPnjAYalSbdNbhoWUci+mEMYF5lqUcJzeqzQVxXxzYHKPCufr+Vd0npRKwX4mMf5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CKlOwAFm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HEldwi690711;
	Tue, 17 Mar 2026 16:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Vtjvu
	LVtH4bFy/IPuQthuOAYT+18A15k5X/T8A0XztU=; b=CKlOwAFmv2HS2VoUq/iyK
	opJRGqCQrr051uREmNHIU2QydCqfUz8iAMNXCSci+toI5DtirirN5o91zkBLVL3H
	2MvgFc9GKptLgci2c6xGhigj67qHWCMUuJrcfagH+KntiUWofS/XFR5RhKYFHKWT
	OsHSpIilCaZf+nqvBiXcMGeG6S6BI4j0wXaMPBNmkOkgiP5uNpz6jxfaRCJb2YnF
	WoA8kicLNnNmuEhZDpD3DdCjgwPO2M8uNkW11fmI80+DihRzD7/N4Obon1eI1Qkl
	M5aOv/VRxUHT6DRNxagIaFP6zILpG6j2KzWK3IgIWYHcs9M9wMvh8VpOJD7sowo1
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj64d4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HF66cA002826;
	Tue, 17 Mar 2026 16:06:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4mjp2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62HG6cS1027484;
	Tue, 17 Mar 2026 16:06:38 GMT
Received: from localhost (alecbro-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4mjp0b-1;
	Tue, 17 Mar 2026 16:06:37 +0000
From: Alec Brown <alec.r.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jarkko@kernel.org
Cc: peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
        ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, ardb@kernel.org,
        alec.r.brown@oracle.com
Subject: [PATCH 2/4] tpm: Move TPM1 specific definitions to the command header
Date: Tue, 17 Mar 2026 16:03:33 +0000
Message-ID: <20260317160613.2899129-3-alec.r.brown@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317160613.2899129-1-alec.r.brown@oracle.com>
References: <20260317160613.2899129-1-alec.r.brown@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170142
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69b97c10 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=xt6ew7UTAAAA:8 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8
 a=afNhsboDH8tTV8YAr2QA:9 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22
 cc=ntf awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MiBTYWx0ZWRfX82XdGY3bqpj4
 LW+YFBG1zYYzCfMEB6fAy9SXaW6iG9mqoCOX+dV9T3O78jYn087KmlkA1iio/ZvqoWfpKzGLY0O
 +besE6TUGbBrKJ2FNK2ssHTILcqD4L8WXg2lzYRwOtrFUf8ffdMVFZQxTge7Lmzzk5T6hPE4jFK
 5fBAaibC9jhtUN8wTqyggLBMqu64iMVWMq27GnIOu5AT2bEw2DmjoSPbiEpAiUe7eNiv6DJ1/am
 0j1R9u7sqnpAdrckYJe0QmsUNK1Lhk/xgl09+sj18iZUiUzlix8m79PiJKcQ4Zg0HjO1p9bGDuM
 G/4Q+Bydx2GtpL15I7h2MYCxJl63lGGlqSRy6HVweuHj8ApFknRX6IihEK0MhtE752rewd15u7P
 I/7ZX4D8Zs3uakf3oadOz61X8N58uzksQhegPM4nJxQF59/xhk4ScV9yLcmUURyh6TrDP5bePQl
 CRwJhbmLhCPiib8y4XQfOQ0NR89sTEYD2RW2eWeE=
X-Proofpoint-GUID: YPo-Ec6XQ_HzTPO0aCktydYj-PVJ8oVB
X-Proofpoint-ORIG-GUID: YPo-Ec6XQ_HzTPO0aCktydYj-PVJ8oVB
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9010-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alec.r.brown@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trustedcomputinggroup.org:url,oracle.com:dkim,oracle.com:email,oracle.com:mid,apertussolutions.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 04CB42ADB27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ross Philipson <ross.philipson@oracle.com>

From: Ross Philipson <ross.philipson@oracle.com>

Gather all the TPM1 definitions and structures in the internal header
file drivers/char/tpm/tpm.h into the command header. In addition, bring
in the single RNG structure from tpm-interface.c.

The definitions moved to these files correspond to the TCG specification
for TPM 1 family:

TPM 1.2 Main Specification
 -  https://trustedcomputinggroup.org/resource/tpm-main-specification/

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
---
 drivers/char/tpm/tpm.h      | 102 --------------------------------
 drivers/char/tpm/tpm1-cmd.c |   5 --
 include/linux/tpm_command.h | 115 ++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 02c07fef41ba..1a9a46a921fe 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -51,105 +51,9 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-#define TPM_WARN_RETRY          0x800
-#define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
-#define TPM_ERR_FAILEDSELFTEST  0x1C
-#define TPM_ERR_INVALID_POSTINIT 38
-
-#define TPM_TAG_RQU_COMMAND 193
-
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
-struct	stclear_flags_t {
-	__be16	tag;
-	u8	deactivated;
-	u8	disableForceClear;
-	u8	physicalPresence;
-	u8	physicalPresenceLock;
-	u8	bGlobalLock;
-} __packed;
-
-struct tpm1_version {
-	u8 major;
-	u8 minor;
-	u8 rev_major;
-	u8 rev_minor;
-} __packed;
-
-struct tpm1_version2 {
-	__be16 tag;
-	struct tpm1_version version;
-} __packed;
-
-struct	timeout_t {
-	__be32	a;
-	__be32	b;
-	__be32	c;
-	__be32	d;
-} __packed;
-
-struct duration_t {
-	__be32	tpm_short;
-	__be32	tpm_medium;
-	__be32	tpm_long;
-} __packed;
-
-struct permanent_flags_t {
-	__be16	tag;
-	u8	disable;
-	u8	ownership;
-	u8	deactivated;
-	u8	readPubek;
-	u8	disableOwnerClear;
-	u8	allowMaintenance;
-	u8	physicalPresenceLifetimeLock;
-	u8	physicalPresenceHWEnable;
-	u8	physicalPresenceCMDEnable;
-	u8	CEKPUsed;
-	u8	TPMpost;
-	u8	TPMpostLock;
-	u8	FIPS;
-	u8	operator;
-	u8	enableRevokeEK;
-	u8	nvLocked;
-	u8	readSRKPub;
-	u8	tpmEstablished;
-	u8	maintenanceDone;
-	u8	disableFullDALogicInfo;
-} __packed;
-
-typedef union {
-	struct	permanent_flags_t perm_flags;
-	struct	stclear_flags_t	stclear_flags;
-	__u8	owned;
-	__be32	num_pcrs;
-	struct tpm1_version version1;
-	struct tpm1_version2 version2;
-	__be32	manufacturer_id;
-	struct timeout_t  timeout;
-	struct duration_t duration;
-} cap_t;
-
-enum tpm_capabilities {
-	TPM_CAP_FLAG = 4,
-	TPM_CAP_PROP = 5,
-	TPM_CAP_VERSION_1_1 = 0x06,
-	TPM_CAP_VERSION_1_2 = 0x1A,
-};
-
-enum tpm_sub_capabilities {
-	TPM_CAP_PROP_PCR = 0x101,
-	TPM_CAP_PROP_MANUFACTURER = 0x103,
-	TPM_CAP_FLAG_PERM = 0x108,
-	TPM_CAP_FLAG_VOL = 0x109,
-	TPM_CAP_PROP_OWNER = 0x111,
-	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
-	TPM_CAP_PROP_TIS_DURATION = 0x120,
-};
-
 enum tpm2_pt_props {
 	TPM2_PT_NONE = 0x00000000,
 	TPM2_PT_GROUP = 0x00000100,
@@ -224,12 +128,6 @@ enum tpm2_pt_props {
 	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
 };
 
-/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
- * bytes, but 128 is still a relatively large number of random bytes and
- * anything much bigger causes users of struct tpm_cmd_t to start getting
- * compiler warnings about stack frame size. */
-#define TPM_MAX_RNG_DATA	128
-
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 664ca1fff2e8..96f189b5fd6f 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -504,11 +504,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-struct tpm1_get_random_out {
-	__be32 rng_data_len;
-	u8 rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm1_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 9a8991b8801d..20b634591fb1 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -38,6 +38,121 @@ enum tpm_command_ordinals {
 	TPM_ORD_UNSEAL			= 24,
 };
 
+enum tpm_capabilities {
+	TPM_CAP_FLAG		= 4,
+	TPM_CAP_PROP		= 5,
+	TPM_CAP_VERSION_1_1	= 0x06,
+	TPM_CAP_VERSION_1_2	= 0x1A,
+};
+
+enum tpm_sub_capabilities {
+	TPM_CAP_PROP_PCR		= 0x101,
+	TPM_CAP_PROP_MANUFACTURER	= 0x103,
+	TPM_CAP_FLAG_PERM		= 0x108,
+	TPM_CAP_FLAG_VOL		= 0x109,
+	TPM_CAP_PROP_OWNER		= 0x111,
+	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
+	TPM_CAP_PROP_TIS_DURATION	= 0x120,
+};
+
+/* Return Codes */
+enum tpm_return_codes {
+	TPM_BASE_MASK			= 0,
+	TPM_NON_FATAL_MASK		= 0x00000800,
+	TPM_SUCCESS			= TPM_BASE_MASK + 0,
+	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
+	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
+	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
+	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
+	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
+	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
+	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
+	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
+};
+
+struct	stclear_flags_t {
+	__be16 tag;
+	u8 deactivated;
+	u8 disableForceClear;
+	u8 physicalPresence;
+	u8 physicalPresenceLock;
+	u8 bGlobalLock;
+} __packed;
+
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
+} __packed;
+
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
+} __packed;
+
+struct	timeout_t {
+	__be32 a;
+	__be32 b;
+	__be32 c;
+	__be32 d;
+} __packed;
+
+struct duration_t {
+	__be32 tpm_short;
+	__be32 tpm_medium;
+	__be32 tpm_long;
+} __packed;
+
+struct permanent_flags_t {
+	__be16 tag;
+	u8 disable;
+	u8 ownership;
+	u8 deactivated;
+	u8 readPubek;
+	u8 disableOwnerClear;
+	u8 allowMaintenance;
+	u8 physicalPresenceLifetimeLock;
+	u8 physicalPresenceHWEnable;
+	u8 physicalPresenceCMDEnable;
+	u8 CEKPUsed;
+	u8 TPMpost;
+	u8 TPMpostLock;
+	u8 FIPS;
+	u8 operator;
+	u8 enableRevokeEK;
+	u8 nvLocked;
+	u8 readSRKPub;
+	u8 tpmEstablished;
+	u8 maintenanceDone;
+	u8 disableFullDALogicInfo;
+} __packed;
+
+typedef union {
+	struct permanent_flags_t perm_flags;
+	struct stclear_flags_t stclear_flags;
+	__u8 owned;
+	__be32 num_pcrs;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
+	__be32 manufacturer_id;
+	struct timeout_t timeout;
+	struct duration_t duration;
+} cap_t;
+
+/*
+ * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
+ * bytes, but 128 is still a relatively large number of random bytes and
+ * anything much bigger causes users of struct tpm_cmd_t to start getting
+ * compiler warnings about stack frame size.
+ */
+#define TPM_MAX_RNG_DATA		128
+
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
+
 /* Other constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
-- 
2.47.3


