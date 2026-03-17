Return-Path: <linux-integrity+bounces-9011-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJJVNzR8uWmxHAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9011-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:07:16 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E48FE2AD9D8
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32FD23004059
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A462F6160;
	Tue, 17 Mar 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RdYG3u5i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7182989B5;
	Tue, 17 Mar 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763627; cv=none; b=ai2SOcK5MsU+pFtoKYNyrjZRtl4XGHsIbXf1aFWJ6NPHQOnQKbded/0CQSRa8JijTjHfXakoTOposcycjsU9xymGmLRIgzzIP6IgDw4EHoVo3KKxAV+z3CE6zGz28N5x3xWBBBCpydNg6Ti+RjJBex+zI+/88nPHgkEUbmqV+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763627; c=relaxed/simple;
	bh=t2NL9iSH90ZbyBRuDaEc4VmSUCcU9oMYksWVQH3umKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtEE7NyyErKByv5RpzqgF5fe1FHISWRcqCaeVmAfjlMbezso8YovWPHD4N12Kh29Cp6YB0k7P7JG4MUXVqg9Qaj0v4kN9gZDZXTfhBaX87VtUGvHMN3H+C47r6TdMd2sOaismCzkVl/i+Kfe8DnPeyMDaLPR+MGL5GJvOyz0EZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RdYG3u5i; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HFUj6i2678560;
	Tue, 17 Mar 2026 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=h17Dq
	1sZbOW8NqFaQWYBK3Ma3S2XGzTpK85APlbelc4=; b=RdYG3u5iX81+CefSgNL66
	yWtrn+KtjGE02ZlYtD0RSHHO0kAeftAbSe0IOGXCceOwPLcHh9R4o5eY9HRhyED/
	o9ZA119TorCeDqF/++oyPm/nAIXzt7ltymLAdRCBpJwlS9WErSASf+KDi3YjFF6n
	6O11k7Dhad463FcDdSlXoqImIxmLHI+FaN+yCz+SuX7JTtESuuqx++XJ/7+7ENgi
	cUai6cq7wGnG1d7HzmR8Tdm8NgIH2ql7X7WDpOJ2974I+J394sJV0TqQkAM1GaQR
	aMQIB0GJcl/veDHWmJlFZ12swpezMRSv9thC3KENZr49hskZpdePR5JboqHbczuf
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x4fen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HG5qwl014273;
	Tue, 17 Mar 2026 16:06:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4aag0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:39 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62HG6Pvi031124;
	Tue, 17 Mar 2026 16:06:39 GMT
Received: from localhost (alecbro-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4aafxe-1;
	Tue, 17 Mar 2026 16:06:38 +0000
From: Alec Brown <alec.r.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jarkko@kernel.org
Cc: peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
        ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, ardb@kernel.org,
        alec.r.brown@oracle.com
Subject: [PATCH 3/4] tpm: Move TPM2 specific definitions to the command header
Date: Tue, 17 Mar 2026 16:03:34 +0000
Message-ID: <20260317160613.2899129-4-alec.r.brown@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170142
X-Proofpoint-GUID: V3h44JkB6XCdpRrs8J9e9-tENqGARyK2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MiBTYWx0ZWRfXylH3SPbWGgDo
 740SoDCMFgZbV3sfra+Qvr2WXt9X1ykyeqVCA8opsITZPbzamK3JHDfMPEVQ6LOBzprBZK0kvYN
 3GJEvLYlFMSTXd6WpK62cj0Aj9uhXTlzzS0+7jh+THW5bBZBKORKVG2IoZTgpZazk+BIpK9Wge4
 4bXt1nkWmiGRfkYeGARvCi0wijcTWigTF51R0vN8RsXMMAttyfMIz65pAXaNDqJNEfZDPhIFC7T
 qVYyYkVo3AHc2+HUiL9ajpMjhDVXXoV9MrIjCFf3p4T+BC4jvzw6/QeRgD8AaMJ3Jn+P6r2TBY+
 EWerJ0HJvoOsZg7z6kinnW03lPM6wI7LheiQVtKH2/1darQsXRN9l9tMTkB2oCe4rBFWo0tfRqP
 HGzZkPfLzU+UD26vfEii/xE4gR9Lw8p27b0rTkDMU214KyG+mu2nSZbTH77HOdOA7aou540oNct
 M7mYtQgtlOblFBngsuA==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b97c10 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=xt6ew7UTAAAA:8 a=yPCof4ZbAAAA:8 a=UN5060LkAAAA:8
 a=gcEkvpJgjdfwdMcMbXkA:9 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22
X-Proofpoint-ORIG-GUID: V3h44JkB6XCdpRrs8J9e9-tENqGARyK2
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9011-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,iki.fi,ziepe.ca,oracle.com,apertussolutions.com,googlegroups.com,kernel.org];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alec.r.brown@oracle.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:email,oracle.com:mid,apertussolutions.com:email];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E48FE2AD9D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ross Philipson <ross.philipson@oracle.com>

From: Ross Philipson <ross.philipson@oracle.com>

Gather all the TPM2 definitions and structures in the internal header
file drivers/char/tpm/tpm.h into the command header, including:
 - Command codes, return codes and definitions from the public and
internal tpm.h files.
 - Structures defined in numerous TPM driver C modules.

The definitions moved to these files correspond to the TCG specification
for TPM 2 family:

TPM 2.0 Library
 - https://trustedcomputinggroup.org/resource/tpm-library-specification/

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Alec Brown <alec.r.brown@oracle.com>
---
 drivers/char/tpm/tpm.h        |  77 ----------
 drivers/char/tpm/tpm2-cmd.c   |  30 ----
 drivers/char/tpm/tpm2-space.c |  13 --
 include/linux/tpm.h           | 145 ------------------
 include/linux/tpm_command.h   | 273 ++++++++++++++++++++++++++++++++++
 5 files changed, 273 insertions(+), 265 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 1a9a46a921fe..147e57c0e7bb 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -51,83 +51,6 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-/* TPM2 specific constants. */
-#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
-
-enum tpm2_pt_props {
-	TPM2_PT_NONE = 0x00000000,
-	TPM2_PT_GROUP = 0x00000100,
-	TPM2_PT_FIXED = TPM2_PT_GROUP * 1,
-	TPM2_PT_FAMILY_INDICATOR = TPM2_PT_FIXED + 0,
-	TPM2_PT_LEVEL = TPM2_PT_FIXED + 1,
-	TPM2_PT_REVISION = TPM2_PT_FIXED + 2,
-	TPM2_PT_DAY_OF_YEAR = TPM2_PT_FIXED + 3,
-	TPM2_PT_YEAR = TPM2_PT_FIXED + 4,
-	TPM2_PT_MANUFACTURER = TPM2_PT_FIXED + 5,
-	TPM2_PT_VENDOR_STRING_1 = TPM2_PT_FIXED + 6,
-	TPM2_PT_VENDOR_STRING_2 = TPM2_PT_FIXED + 7,
-	TPM2_PT_VENDOR_STRING_3 = TPM2_PT_FIXED + 8,
-	TPM2_PT_VENDOR_STRING_4 = TPM2_PT_FIXED + 9,
-	TPM2_PT_VENDOR_TPM_TYPE = TPM2_PT_FIXED + 10,
-	TPM2_PT_FIRMWARE_VERSION_1 = TPM2_PT_FIXED + 11,
-	TPM2_PT_FIRMWARE_VERSION_2 = TPM2_PT_FIXED + 12,
-	TPM2_PT_INPUT_BUFFER = TPM2_PT_FIXED + 13,
-	TPM2_PT_HR_TRANSIENT_MIN = TPM2_PT_FIXED + 14,
-	TPM2_PT_HR_PERSISTENT_MIN = TPM2_PT_FIXED + 15,
-	TPM2_PT_HR_LOADED_MIN = TPM2_PT_FIXED + 16,
-	TPM2_PT_ACTIVE_SESSIONS_MAX = TPM2_PT_FIXED + 17,
-	TPM2_PT_PCR_COUNT = TPM2_PT_FIXED + 18,
-	TPM2_PT_PCR_SELECT_MIN = TPM2_PT_FIXED + 19,
-	TPM2_PT_CONTEXT_GAP_MAX = TPM2_PT_FIXED + 20,
-	TPM2_PT_NV_COUNTERS_MAX = TPM2_PT_FIXED + 22,
-	TPM2_PT_NV_INDEX_MAX = TPM2_PT_FIXED + 23,
-	TPM2_PT_MEMORY = TPM2_PT_FIXED + 24,
-	TPM2_PT_CLOCK_UPDATE = TPM2_PT_FIXED + 25,
-	TPM2_PT_CONTEXT_HASH = TPM2_PT_FIXED + 26,
-	TPM2_PT_CONTEXT_SYM = TPM2_PT_FIXED + 27,
-	TPM2_PT_CONTEXT_SYM_SIZE = TPM2_PT_FIXED + 28,
-	TPM2_PT_ORDERLY_COUNT = TPM2_PT_FIXED + 29,
-	TPM2_PT_MAX_COMMAND_SIZE = TPM2_PT_FIXED + 30,
-	TPM2_PT_MAX_RESPONSE_SIZE = TPM2_PT_FIXED + 31,
-	TPM2_PT_MAX_DIGEST = TPM2_PT_FIXED + 32,
-	TPM2_PT_MAX_OBJECT_CONTEXT = TPM2_PT_FIXED + 33,
-	TPM2_PT_MAX_SESSION_CONTEXT = TPM2_PT_FIXED + 34,
-	TPM2_PT_PS_FAMILY_INDICATOR = TPM2_PT_FIXED + 35,
-	TPM2_PT_PS_LEVEL = TPM2_PT_FIXED + 36,
-	TPM2_PT_PS_REVISION = TPM2_PT_FIXED + 37,
-	TPM2_PT_PS_DAY_OF_YEAR = TPM2_PT_FIXED + 38,
-	TPM2_PT_PS_YEAR = TPM2_PT_FIXED + 39,
-	TPM2_PT_SPLIT_MAX = TPM2_PT_FIXED + 40,
-	TPM2_PT_TOTAL_COMMANDS = TPM2_PT_FIXED + 41,
-	TPM2_PT_LIBRARY_COMMANDS = TPM2_PT_FIXED + 42,
-	TPM2_PT_VENDOR_COMMANDS = TPM2_PT_FIXED + 43,
-	TPM2_PT_NV_BUFFER_MAX = TPM2_PT_FIXED + 44,
-	TPM2_PT_MODES = TPM2_PT_FIXED + 45,
-	TPM2_PT_MAX_CAP_BUFFER = TPM2_PT_FIXED + 46,
-	TPM2_PT_VAR = TPM2_PT_GROUP * 2,
-	TPM2_PT_PERMANENT = TPM2_PT_VAR + 0,
-	TPM2_PT_STARTUP_CLEAR = TPM2_PT_VAR + 1,
-	TPM2_PT_HR_NV_INDEX = TPM2_PT_VAR + 2,
-	TPM2_PT_HR_LOADED = TPM2_PT_VAR + 3,
-	TPM2_PT_HR_LOADED_AVAIL = TPM2_PT_VAR + 4,
-	TPM2_PT_HR_ACTIVE = TPM2_PT_VAR + 5,
-	TPM2_PT_HR_ACTIVE_AVAIL = TPM2_PT_VAR + 6,
-	TPM2_PT_HR_TRANSIENT_AVAIL = TPM2_PT_VAR + 7,
-	TPM2_PT_HR_PERSISTENT = TPM2_PT_VAR + 8,
-	TPM2_PT_HR_PERSISTENT_AVAIL = TPM2_PT_VAR + 9,
-	TPM2_PT_NV_COUNTERS = TPM2_PT_VAR + 10,
-	TPM2_PT_NV_COUNTERS_AVAIL = TPM2_PT_VAR + 11,
-	TPM2_PT_ALGORITHM_SET = TPM2_PT_VAR + 12,
-	TPM2_PT_LOADED_CURVES = TPM2_PT_VAR + 13,
-	TPM2_PT_LOCKOUT_COUNTER = TPM2_PT_VAR + 14,
-	TPM2_PT_MAX_AUTH_FAIL = TPM2_PT_VAR + 15,
-	TPM2_PT_LOCKOUT_INTERVAL = TPM2_PT_VAR + 16,
-	TPM2_PT_LOCKOUT_RECOVERY = TPM2_PT_VAR + 17,
-	TPM2_PT_NV_WRITE_RECOVERY = TPM2_PT_VAR + 18,
-	TPM2_PT_AUDIT_COUNTER_0 = TPM2_PT_VAR + 19,
-	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
-};
-
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4a..1fa3e8a43c79 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -94,17 +94,6 @@ unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
 	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
 }
 
-struct tpm2_pcr_read_out {
-	__be32	update_cnt;
-	__be32	pcr_selects_cnt;
-	__be16	hash_alg;
-	u8	pcr_select_size;
-	u8	pcr_select[TPM2_PCR_SELECT_MIN];
-	__be32	digests_cnt;
-	__be16	digest_size;
-	u8	digest[];
-} __packed;
-
 /**
  * tpm2_pcr_read() - read a PCR value
  * @chip:	TPM chip to use.
@@ -238,11 +227,6 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	return rc;
 }
 
-struct tpm2_get_random_out {
-	__be16 size;
-	u8 buffer[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm2_get_random() - get random bytes from the TPM RNG
  *
@@ -366,14 +350,6 @@ void tpm2_flush_context(struct tpm_chip *chip, u32 handle)
 }
 EXPORT_SYMBOL_GPL(tpm2_flush_context);
 
-struct tpm2_get_cap_out {
-	u8 more_data;
-	__be32 subcap_id;
-	__be32 property_cnt;
-	__be32 property_id;
-	__be32 value;
-} __packed;
-
 /**
  * tpm2_get_tpm_pt() - get value of a TPM_CAP_TPM_PROPERTIES type property
  * @chip:		a &tpm_chip instance
@@ -541,12 +517,6 @@ static int tpm2_init_bank_info(struct tpm_chip *chip, u32 bank_index)
 	return tpm2_pcr_read(chip, 0, &digest, &bank->digest_size);
 }
 
-struct tpm2_pcr_selection {
-	__be16  hash_alg;
-	u8  size_of_select;
-	u8  pcr_select[3];
-} __packed;
-
 ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 {
 	struct tpm2_pcr_selection pcr_selection;
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 60354cd53b5c..7c1c0a174a2b 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -15,19 +15,6 @@
 #include <linux/unaligned.h>
 #include "tpm.h"
 
-enum tpm2_handle_types {
-	TPM2_HT_HMAC_SESSION	= 0x02000000,
-	TPM2_HT_POLICY_SESSION	= 0x03000000,
-	TPM2_HT_TRANSIENT	= 0x80000000,
-};
-
-struct tpm2_context {
-	__be64 sequence;
-	__be32 saved_handle;
-	__be32 hierarchy;
-	__be16 blob_size;
-} __packed;
-
 static void tpm2_flush_sessions(struct tpm_chip *chip, struct tpm_space *space)
 {
 	int i;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 18dcf0ef46f6..92957452f7a7 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -38,12 +38,6 @@ struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-enum tpm2_session_types {
-	TPM2_SE_HMAC	= 0x00,
-	TPM2_SE_POLICY	= 0x01,
-	TPM2_SE_TRIAL	= 0x02,
-};
-
 /* if you add a new hash to this, increment TPM_MAX_HASHES below */
 enum tpm_algorithms {
 	TPM_ALG_ERROR		= 0x0000,
@@ -65,11 +59,6 @@ enum tpm_algorithms {
  */
 #define TPM_MAX_HASHES	5
 
-enum tpm2_curves {
-	TPM2_ECC_NONE		= 0x0000,
-	TPM2_ECC_NIST_P256	= 0x0003,
-};
-
 struct tpm_digest {
 	u16 alg_id;
 	u8 digest[TPM2_MAX_DIGEST_SIZE];
@@ -222,122 +211,11 @@ struct tpm_chip {
 
 #define TPM_HEADER_SIZE		10
 
-enum tpm2_const {
-	TPM2_PLATFORM_PCR       =     24,
-	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
-};
-
-enum tpm2_timeouts {
-	TPM2_TIMEOUT_A          =    750,
-	TPM2_TIMEOUT_B          =   4000,
-	TPM2_TIMEOUT_C          =    200,
-	TPM2_TIMEOUT_D          =     30,
-};
-
-enum tpm2_durations {
-	TPM2_DURATION_SHORT     =     20,
-	TPM2_DURATION_LONG      =   2000,
-	TPM2_DURATION_DEFAULT   = 120000,
-};
-
-enum tpm2_structures {
-	TPM2_ST_NO_SESSIONS	= 0x8001,
-	TPM2_ST_SESSIONS	= 0x8002,
-	TPM2_ST_CREATION	= 0x8021,
-};
-
-/* Indicates from what layer of the software stack the error comes from */
-#define TSS2_RC_LAYER_SHIFT	 16
-#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
-
-enum tpm2_return_codes {
-	TPM2_RC_SUCCESS		= 0x0000,
-	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
-	TPM2_RC_HANDLE		= 0x008B,
-	TPM2_RC_INTEGRITY	= 0x009F,
-	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
-	TPM2_RC_FAILURE		= 0x0101,
-	TPM2_RC_DISABLED	= 0x0120,
-	TPM2_RC_UPGRADE		= 0x012D,
-	TPM2_RC_COMMAND_CODE    = 0x0143,
-	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
-	TPM2_RC_REFERENCE_H0	= 0x0910,
-	TPM2_RC_RETRY		= 0x0922,
-	TPM2_RC_SESSION_MEMORY	= 0x0903,
-};
-
-enum tpm2_command_codes {
-	TPM2_CC_FIRST		        = 0x011F,
-	TPM2_CC_HIERARCHY_CONTROL       = 0x0121,
-	TPM2_CC_HIERARCHY_CHANGE_AUTH   = 0x0129,
-	TPM2_CC_CREATE_PRIMARY          = 0x0131,
-	TPM2_CC_SEQUENCE_COMPLETE       = 0x013E,
-	TPM2_CC_SELF_TEST	        = 0x0143,
-	TPM2_CC_STARTUP		        = 0x0144,
-	TPM2_CC_SHUTDOWN	        = 0x0145,
-	TPM2_CC_NV_READ                 = 0x014E,
-	TPM2_CC_CREATE		        = 0x0153,
-	TPM2_CC_LOAD		        = 0x0157,
-	TPM2_CC_SEQUENCE_UPDATE         = 0x015C,
-	TPM2_CC_UNSEAL		        = 0x015E,
-	TPM2_CC_CONTEXT_LOAD	        = 0x0161,
-	TPM2_CC_CONTEXT_SAVE	        = 0x0162,
-	TPM2_CC_FLUSH_CONTEXT	        = 0x0165,
-	TPM2_CC_READ_PUBLIC		= 0x0173,
-	TPM2_CC_START_AUTH_SESS		= 0x0176,
-	TPM2_CC_VERIFY_SIGNATURE        = 0x0177,
-	TPM2_CC_GET_CAPABILITY	        = 0x017A,
-	TPM2_CC_GET_RANDOM	        = 0x017B,
-	TPM2_CC_PCR_READ	        = 0x017E,
-	TPM2_CC_PCR_EXTEND	        = 0x0182,
-	TPM2_CC_EVENT_SEQUENCE_COMPLETE = 0x0185,
-	TPM2_CC_HASH_SEQUENCE_START     = 0x0186,
-	TPM2_CC_CREATE_LOADED           = 0x0191,
-	TPM2_CC_LAST		        = 0x0193, /* Spec 1.36 */
-};
-
-enum tpm2_permanent_handles {
-	TPM2_RH_NULL		= 0x40000007,
-	TPM2_RS_PW		= 0x40000009,
-};
-
-/* Most Significant Octet for key types  */
-enum tpm2_mso_type {
-	TPM2_MSO_NVRAM		= 0x01,
-	TPM2_MSO_SESSION	= 0x02,
-	TPM2_MSO_POLICY		= 0x03,
-	TPM2_MSO_PERMANENT	= 0x40,
-	TPM2_MSO_VOLATILE	= 0x80,
-	TPM2_MSO_PERSISTENT	= 0x81,
-};
-
 static inline enum tpm2_mso_type tpm2_handle_mso(u32 handle)
 {
 	return handle >> 24;
 }
 
-enum tpm2_capabilities {
-	TPM2_CAP_HANDLES	= 1,
-	TPM2_CAP_COMMANDS	= 2,
-	TPM2_CAP_PCRS		= 5,
-	TPM2_CAP_TPM_PROPERTIES = 6,
-};
-
-enum tpm2_properties {
-	TPM_PT_TOTAL_COMMANDS	= 0x0129,
-};
-
-enum tpm2_startup_types {
-	TPM2_SU_CLEAR	= 0x0000,
-	TPM2_SU_STATE	= 0x0001,
-};
-
-enum tpm2_cc_attrs {
-	TPM2_CC_ATTR_CHANDLES	= 25,
-	TPM2_CC_ATTR_RHANDLE	= 28,
-	TPM2_CC_ATTR_VENDOR	= 29,
-};
-
 #define TPM_VID_INTEL    0x8086
 #define TPM_VID_WINBOND  0x1050
 #define TPM_VID_STM      0x104A
@@ -389,29 +267,6 @@ struct tpm_buf {
 	u8 handles;
 };
 
-enum tpm2_object_attributes {
-	TPM2_OA_FIXED_TPM		= BIT(1),
-	TPM2_OA_ST_CLEAR		= BIT(2),
-	TPM2_OA_FIXED_PARENT		= BIT(4),
-	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
-	TPM2_OA_NO_DA			= BIT(10),
-	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
-	TPM2_OA_RESTRICTED		= BIT(16),
-	TPM2_OA_DECRYPT			= BIT(17),
-	TPM2_OA_SIGN			= BIT(18),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
-	TPM2_SA_AUDIT_RESET		= BIT(3),
-	TPM2_SA_DECRYPT			= BIT(5),
-	TPM2_SA_ENCRYPT			= BIT(6),
-	TPM2_SA_AUDIT			= BIT(7),
-};
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
index 20b634591fb1..ee76fcd5ecef 100644
--- a/include/linux/tpm_command.h
+++ b/include/linux/tpm_command.h
@@ -158,4 +158,277 @@ struct tpm1_get_random_out {
 #define TPM_NONCE_SIZE                  20
 #define TPM_ST_CLEAR			1
 
+/************************************************/
+/* TPM 2 Family Chips                           */
+/************************************************/
+
+/*
+ * TPM 2.0 Library
+ * https://trustedcomputinggroup.org/resource/tpm-library-specification/
+ */
+
+/* TPM2 specific constants. */
+#define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
+
+enum tpm2_session_types {
+	TPM2_SE_HMAC	= 0x00,
+	TPM2_SE_POLICY	= 0x01,
+	TPM2_SE_TRIAL	= 0x02,
+};
+
+enum tpm2_timeouts {
+	TPM2_TIMEOUT_A		= 750,
+	TPM2_TIMEOUT_B		= 4000,
+	TPM2_TIMEOUT_C		= 200,
+	TPM2_TIMEOUT_D		= 30,
+	TPM2_DURATION_SHORT	= 20,
+	TPM2_DURATION_MEDIUM	= 750,
+	TPM2_DURATION_LONG	= 2000,
+	TPM2_DURATION_LONG_LONG	= 300000,
+	TPM2_DURATION_DEFAULT	= 120000,
+};
+
+enum tpm2_structures {
+	TPM2_ST_NO_SESSIONS	= 0x8001,
+	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
+};
+
+/* Indicates from what layer of the software stack the error comes from */
+#define TSS2_RC_LAYER_SHIFT	 16
+#define TSS2_RESMGR_TPM_RC_LAYER (11 << TSS2_RC_LAYER_SHIFT)
+
+enum tpm2_return_codes {
+	TPM2_RC_SUCCESS		= 0x0000,
+	TPM2_RC_HASH		= 0x0083, /* RC_FMT1 */
+	TPM2_RC_HANDLE		= 0x008B,
+	TPM2_RC_INTEGRITY	= 0x009F,
+	TPM2_RC_INITIALIZE	= 0x0100, /* RC_VER1 */
+	TPM2_RC_FAILURE		= 0x0101,
+	TPM2_RC_DISABLED	= 0x0120,
+	TPM2_RC_UPGRADE		= 0x012D,
+	TPM2_RC_COMMAND_CODE	= 0x0143,
+	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
+	TPM2_RC_REFERENCE_H0	= 0x0910,
+	TPM2_RC_RETRY		= 0x0922,
+	TPM2_RC_SESSION_MEMORY	= 0x0903,
+};
+
+enum tpm2_command_codes {
+	TPM2_CC_FIRST			= 0x011F,
+	TPM2_CC_HIERARCHY_CONTROL	= 0x0121,
+	TPM2_CC_HIERARCHY_CHANGE_AUTH	= 0x0129,
+	TPM2_CC_CREATE_PRIMARY		= 0x0131,
+	TPM2_CC_SEQUENCE_COMPLETE	= 0x013E,
+	TPM2_CC_SELF_TEST		= 0x0143,
+	TPM2_CC_STARTUP			= 0x0144,
+	TPM2_CC_SHUTDOWN		= 0x0145,
+	TPM2_CC_NV_READ			= 0x014E,
+	TPM2_CC_CREATE			= 0x0153,
+	TPM2_CC_LOAD			= 0x0157,
+	TPM2_CC_SEQUENCE_UPDATE		= 0x015C,
+	TPM2_CC_UNSEAL			= 0x015E,
+	TPM2_CC_CONTEXT_LOAD		= 0x0161,
+	TPM2_CC_CONTEXT_SAVE		= 0x0162,
+	TPM2_CC_FLUSH_CONTEXT		= 0x0165,
+	TPM2_CC_READ_PUBLIC		= 0x0173,
+	TPM2_CC_START_AUTH_SESS		= 0x0176,
+	TPM2_CC_VERIFY_SIGNATURE	= 0x0177,
+	TPM2_CC_GET_CAPABILITY		= 0x017A,
+	TPM2_CC_GET_RANDOM		= 0x017B,
+	TPM2_CC_PCR_READ		= 0x017E,
+	TPM2_CC_PCR_EXTEND		= 0x0182,
+	TPM2_CC_EVENT_SEQUENCE_COMPLETE	= 0x0185,
+	TPM2_CC_HASH_SEQUENCE_START	= 0x0186,
+	TPM2_CC_CREATE_LOADED		= 0x0191,
+	TPM2_CC_LAST			= 0x0193, /* Spec 1.36 */
+};
+
+enum tpm2_capabilities {
+	TPM2_CAP_HANDLES	= 1,
+	TPM2_CAP_COMMANDS	= 2,
+	TPM2_CAP_PCRS		= 5,
+	TPM2_CAP_TPM_PROPERTIES = 6,
+};
+
+enum tpm2_properties {
+	TPM_PT_TOTAL_COMMANDS	= 0x0129,
+};
+
+enum tpm2_startup_types {
+	TPM2_SU_CLEAR		= 0x0000,
+	TPM2_SU_STATE		= 0x0001,
+};
+
+enum tpm2_cc_attrs {
+	TPM2_CC_ATTR_CHANDLES	= 25,
+	TPM2_CC_ATTR_RHANDLE	= 28,
+	TPM2_CC_ATTR_VENDOR	= 29,
+};
+
+enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
+	TPM2_RS_PW		= 0x40000009,
+};
+
+/* Most Significant Octet for key types  */
+enum tpm2_mso_type {
+	TPM2_MSO_NVRAM		= 0x01,
+	TPM2_MSO_SESSION	= 0x02,
+	TPM2_MSO_POLICY		= 0x03,
+	TPM2_MSO_PERMANENT	= 0x40,
+	TPM2_MSO_VOLATILE	= 0x80,
+	TPM2_MSO_PERSISTENT	= 0x81,
+};
+
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
+};
+
+enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_ST_CLEAR		= BIT(2),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
+	TPM2_OA_SIGN			= BIT(18),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
+	TPM2_SA_AUDIT_RESET		= BIT(3),
+	TPM2_SA_DECRYPT			= BIT(5),
+	TPM2_SA_ENCRYPT			= BIT(6),
+	TPM2_SA_AUDIT			= BIT(7),
+};
+
+enum tpm2_pcr_select {
+	TPM2_PLATFORM_PCR	= 24,
+	TPM2_PCR_SELECT_MIN	= ((TPM2_PLATFORM_PCR + 7) / 8),
+};
+
+enum tpm2_handle_types {
+	TPM2_HT_HMAC_SESSION	= 0x02000000,
+	TPM2_HT_POLICY_SESSION	= 0x03000000,
+	TPM2_HT_TRANSIENT	= 0x80000000,
+};
+
+enum tpm2_pt_props {
+	TPM2_PT_NONE			= 0x00000000,
+	TPM2_PT_GROUP			= 0x00000100,
+	TPM2_PT_FIXED			= TPM2_PT_GROUP * 1,
+	TPM2_PT_FAMILY_INDICATOR	= TPM2_PT_FIXED + 0,
+	TPM2_PT_LEVEL		= TPM2_PT_FIXED + 1,
+	TPM2_PT_REVISION	= TPM2_PT_FIXED + 2,
+	TPM2_PT_DAY_OF_YEAR	= TPM2_PT_FIXED + 3,
+	TPM2_PT_YEAR		= TPM2_PT_FIXED + 4,
+	TPM2_PT_MANUFACTURER	= TPM2_PT_FIXED + 5,
+	TPM2_PT_VENDOR_STRING_1	= TPM2_PT_FIXED + 6,
+	TPM2_PT_VENDOR_STRING_2	= TPM2_PT_FIXED + 7,
+	TPM2_PT_VENDOR_STRING_3	= TPM2_PT_FIXED + 8,
+	TPM2_PT_VENDOR_STRING_4	= TPM2_PT_FIXED + 9,
+	TPM2_PT_VENDOR_TPM_TYPE	= TPM2_PT_FIXED + 10,
+	TPM2_PT_FIRMWARE_VERSION_1	= TPM2_PT_FIXED + 11,
+	TPM2_PT_FIRMWARE_VERSION_2	= TPM2_PT_FIXED + 12,
+	TPM2_PT_INPUT_BUFFER		= TPM2_PT_FIXED + 13,
+	TPM2_PT_HR_TRANSIENT_MIN	= TPM2_PT_FIXED + 14,
+	TPM2_PT_HR_PERSISTENT_MIN	= TPM2_PT_FIXED + 15,
+	TPM2_PT_HR_LOADED_MIN		= TPM2_PT_FIXED + 16,
+	TPM2_PT_ACTIVE_SESSIONS_MAX	= TPM2_PT_FIXED + 17,
+	TPM2_PT_PCR_COUNT	= TPM2_PT_FIXED + 18,
+	TPM2_PT_PCR_SELECT_MIN	= TPM2_PT_FIXED + 19,
+	TPM2_PT_CONTEXT_GAP_MAX	= TPM2_PT_FIXED + 20,
+	TPM2_PT_NV_COUNTERS_MAX	= TPM2_PT_FIXED + 22,
+	TPM2_PT_NV_INDEX_MAX	= TPM2_PT_FIXED + 23,
+	TPM2_PT_MEMORY		= TPM2_PT_FIXED + 24,
+	TPM2_PT_CLOCK_UPDATE	= TPM2_PT_FIXED + 25,
+	TPM2_PT_CONTEXT_HASH	= TPM2_PT_FIXED + 26,
+	TPM2_PT_CONTEXT_SYM	= TPM2_PT_FIXED + 27,
+	TPM2_PT_CONTEXT_SYM_SIZE	= TPM2_PT_FIXED + 28,
+	TPM2_PT_ORDERLY_COUNT		= TPM2_PT_FIXED + 29,
+	TPM2_PT_MAX_COMMAND_SIZE	= TPM2_PT_FIXED + 30,
+	TPM2_PT_MAX_RESPONSE_SIZE	= TPM2_PT_FIXED + 31,
+	TPM2_PT_MAX_DIGEST		= TPM2_PT_FIXED + 32,
+	TPM2_PT_MAX_OBJECT_CONTEXT	= TPM2_PT_FIXED + 33,
+	TPM2_PT_MAX_SESSION_CONTEXT	= TPM2_PT_FIXED + 34,
+	TPM2_PT_PS_FAMILY_INDICATOR	= TPM2_PT_FIXED + 35,
+	TPM2_PT_PS_LEVEL	= TPM2_PT_FIXED + 36,
+	TPM2_PT_PS_REVISION	= TPM2_PT_FIXED + 37,
+	TPM2_PT_PS_DAY_OF_YEAR	= TPM2_PT_FIXED + 38,
+	TPM2_PT_PS_YEAR		= TPM2_PT_FIXED + 39,
+	TPM2_PT_SPLIT_MAX	= TPM2_PT_FIXED + 40,
+	TPM2_PT_TOTAL_COMMANDS	= TPM2_PT_FIXED + 41,
+	TPM2_PT_LIBRARY_COMMANDS	= TPM2_PT_FIXED + 42,
+	TPM2_PT_VENDOR_COMMANDS		= TPM2_PT_FIXED + 43,
+	TPM2_PT_NV_BUFFER_MAX		= TPM2_PT_FIXED + 44,
+	TPM2_PT_MODES			= TPM2_PT_FIXED + 45,
+	TPM2_PT_MAX_CAP_BUFFER		= TPM2_PT_FIXED + 46,
+	TPM2_PT_VAR		= TPM2_PT_GROUP * 2,
+	TPM2_PT_PERMANENT	= TPM2_PT_VAR + 0,
+	TPM2_PT_STARTUP_CLEAR	= TPM2_PT_VAR + 1,
+	TPM2_PT_HR_NV_INDEX	= TPM2_PT_VAR + 2,
+	TPM2_PT_HR_LOADED	= TPM2_PT_VAR + 3,
+	TPM2_PT_HR_LOADED_AVAIL	= TPM2_PT_VAR + 4,
+	TPM2_PT_HR_ACTIVE	= TPM2_PT_VAR + 5,
+	TPM2_PT_HR_ACTIVE_AVAIL	= TPM2_PT_VAR + 6,
+	TPM2_PT_HR_TRANSIENT_AVAIL	= TPM2_PT_VAR + 7,
+	TPM2_PT_HR_PERSISTENT		= TPM2_PT_VAR + 8,
+	TPM2_PT_HR_PERSISTENT_AVAIL	= TPM2_PT_VAR + 9,
+	TPM2_PT_NV_COUNTERS		= TPM2_PT_VAR + 10,
+	TPM2_PT_NV_COUNTERS_AVAIL	= TPM2_PT_VAR + 11,
+	TPM2_PT_ALGORITHM_SET		= TPM2_PT_VAR + 12,
+	TPM2_PT_LOADED_CURVES		= TPM2_PT_VAR + 13,
+	TPM2_PT_LOCKOUT_COUNTER		= TPM2_PT_VAR + 14,
+	TPM2_PT_MAX_AUTH_FAIL		= TPM2_PT_VAR + 15,
+	TPM2_PT_LOCKOUT_INTERVAL	= TPM2_PT_VAR + 16,
+	TPM2_PT_LOCKOUT_RECOVERY	= TPM2_PT_VAR + 17,
+	TPM2_PT_NV_WRITE_RECOVERY	= TPM2_PT_VAR + 18,
+	TPM2_PT_AUDIT_COUNTER_0	= TPM2_PT_VAR + 19,
+	TPM2_PT_AUDIT_COUNTER_1	= TPM2_PT_VAR + 20,
+};
+
+struct tpm2_pcr_read_out {
+	__be32 update_cnt;
+	__be32 pcr_selects_cnt;
+	__be16 hash_alg;
+	u8 pcr_select_size;
+	u8 pcr_select[TPM2_PCR_SELECT_MIN];
+	__be32 digests_cnt;
+	__be16 digest_size;
+	u8 digest[];
+} __packed;
+
+struct tpm2_get_random_out {
+	__be16 size;
+	u8 buffer[TPM_MAX_RNG_DATA];
+} __packed;
+
+struct tpm2_get_cap_out {
+	u8 more_data;
+	__be32 subcap_id;
+	__be32 property_cnt;
+	__be32 property_id;
+	__be32 value;
+} __packed;
+
+struct tpm2_pcr_selection {
+	__be16 hash_alg;
+	u8 size_of_select;
+	u8 pcr_select[3];
+} __packed;
+
+struct tpm2_context {
+	__be64 sequence;
+	__be32 saved_handle;
+	__be32 hierarchy;
+	__be16 blob_size;
+} __packed;
+
 #endif
-- 
2.47.3


