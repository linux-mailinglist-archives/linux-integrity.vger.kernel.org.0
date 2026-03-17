Return-Path: <linux-integrity+bounces-9008-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFvmOR59uWmxHAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9008-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:10 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 595472ADAED
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 17:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88843311FF27
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 16:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5185F2F83CB;
	Tue, 17 Mar 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S9Op6TgM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172D2F6170;
	Tue, 17 Mar 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763619; cv=none; b=Y6dqOm/J4S+Ogimg2fTyN3ZYXC3JxgZrsDDjuokaVBOTTIJ7hYuapfWhlMCfLo1kPltpJtiKdHzSIcNMjmz3K9fQaz2q8WxfJ6pC67SY+9swlIL6z4Cp3XkrnnMpa7Evp6d7dpymA/qfvfujR5JifkJ+YQwS0VBRy6bPG8m8py0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763619; c=relaxed/simple;
	bh=wX7zijGQVzQcNvjZ+YiFhp5KmVoBtRFpHYg0zMP79lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=slOkCGo7d4QAZWyLVtv5qxgm0rIC5wVo/UWxoF7oSyPY4HK7GuDorQB0QVA1Xbt0SrA6Xj2zweSIavaXOB5muC8qoWr7bsPQEJaAYeQ9I7t28U3lvowKi86v6cblhuCU8cO4VrrXSm9lfJFZQnGTOJbQlKH27RLCP/MpjrJTY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S9Op6TgM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HE9Y0t037683;
	Tue, 17 Mar 2026 16:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=43dwuMnFnaFQovGqpg258vYjKjQhQ
	NAZxgt49emEB1s=; b=S9Op6TgMS0VdGZddxUjPmWAYOUkWaPfNkiTUznZj9uDDz
	4O/0l3uMx4VDBED5Sg6lF+NZTPNHve+KKj/nH3hdAEUXqzScU1anfOgx1U3Z26ah
	d3LqMvljLcDN4UKNRNhDg+9dguPM/ph/Cr4dTDyRnn2g8Z7LMgwH+uhzVZdWFrV6
	q202o2LfeCZlb8rUikkvSGSrJ7NVntbdEg4+1SN6OMGj8KebgN1t0fRbB/dfP3Jh
	bLz9U+XsmEqVhhmZ/F6v1iBch6BShfw2lSJ+sgB4fP+Ov/JWpJvgBCIJPU9k+6XO
	aHTJVFrzEHqkBvkTDjgGGe51N9sTjFw9V9uwUGVFg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x4fec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HG1s4n014011;
	Tue, 17 Mar 2026 16:06:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4aafts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 16:06:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62HG11WT020887;
	Tue, 17 Mar 2026 16:06:36 GMT
Received: from localhost (alecbro-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cvx4aafrm-1;
	Tue, 17 Mar 2026 16:06:35 +0000
From: Alec Brown <alec.r.brown@oracle.com>
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jarkko@kernel.org
Cc: peterhuewe@gmx.de, jarkko.sakkinen@iki.fi, jgg@ziepe.ca,
        ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        daniel.kiper@oracle.com, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com, ardb@kernel.org,
        alec.r.brown@oracle.com
Subject: [PATCH 0/4] Reorganize TPM public headers
Date: Tue, 17 Mar 2026 16:03:31 +0000
Message-ID: <20260317160613.2899129-1-alec.r.brown@oracle.com>
X-Mailer: git-send-email 2.47.3
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
 phishscore=0 mlxscore=0 mlxlogscore=597 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603170142
X-Proofpoint-GUID: iNm804fl9NSQ6i-INWYfXgXQ9G96eVfV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0MiBTYWx0ZWRfX8zx8LcTgMxAQ
 lM0L/Yu6vrgcdS78PAoTdbyBzePgMogiGBCLmSxQbipP+TAmadtU1atvcKvgALhya3AWCy02x7R
 MvGK44eE1QE5GGL6r3ZECqrjWV3FYCjcsAsXXKp85QqqpfP0uHIG1wmyaI5MQ7Z63iok461Phxw
 gk5PEqMWF2/nGJQXDgB8kx7QC0ZX4DJ20WtcGgONCsZ3JBrq/P1QYiEqt8koceOUHgTVMSizcSU
 b0vyvzrbULrcp5Q+R2FyCOVfnu42SwP53cAcrI0lLimPJ284HDSQeSOYpxHXGSHfAes7qs0SRp8
 C55GDFUrSiKFDo8vWYbTAKtv3snMEG0ua4P2uJWNvwswkXRapLUPreq4v7k4j/vvj4B9OgiVrDU
 tpoceo0/w4O4GY3d1IrhiKYn8qIeNcTljRMzGOEPF28xniHgkY1YoFJQT0sObNcNSxfv999v4Uz
 uPCEyKgqIBPblRmNrHQ==
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b97c0d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=2sZGKimuh84ZaeTFltkA:9
X-Proofpoint-ORIG-GUID: iNm804fl9NSQ6i-INWYfXgXQ9G96eVfV
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
	TAGGED_FROM(0.00)[bounces-9008-lists,linux-integrity=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 595472ADAED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series reorganizes various TPM definitions into tpm_command.h and
groups them corresponding to the TCG specification for TPM1 and TPM2. The
purpose in reorganizing these definitions is to assist the TPM driver usability
in pre-boot environments. This series is related to Jarkko Sakkinen's work
streamlining TPM2 HMAC sessions but can be applied independently of his
patches.

Ross Philipson (4):
      tpm: Initial step to reorganize TPM public headers
      tpm: Move TPM1 specific definitions to the command header
      tpm: Move TPM2 specific definitions to the command header
      tpm: Move TPM common base definitions to the command header

 drivers/char/tpm/tpm-buf.c                |   1 -
 drivers/char/tpm/tpm.h                    | 179 ----------
 drivers/char/tpm/tpm1-cmd.c               |  19 +-
 drivers/char/tpm/tpm2-cmd.c               |  30 --
 drivers/char/tpm/tpm2-space.c             |  13 -
 include/keys/trusted_tpm.h                |   1 -
 include/linux/tpm.h                       | 195 +----------
 include/linux/tpm_command.h               | 520 +++++++++++++++++++++++++++++-
 security/keys/trusted-keys/trusted_tpm1.c |   1 -
 security/keys/trusted-keys/trusted_tpm2.c |   1 -
 10 files changed, 510 insertions(+), 450 deletions(-)


