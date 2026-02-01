Return-Path: <linux-integrity+bounces-8384-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cG9/GbO9fmkddgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8384-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 03:42:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2DC4B38
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 03:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50B823013D59
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BE26D4EF;
	Sun,  1 Feb 2026 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZcWgui4h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3A23C4F2
	for <linux-integrity@vger.kernel.org>; Sun,  1 Feb 2026 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769913772; cv=none; b=gXT+6ABIz8+zmGjG3BeFOPOVTpji2X6r3pkzPxkY6zXPOiG6rXM3mr6EhblZYSicd0VZvS77jNC8dlnUpz5HdNheQq65aPak7/cwihy7LiEShiyipLhDOPKCU3ccjlmdudoVWHGe1HIW8pmmgaYzCacH8qmbcdSx9EDZ8LBAdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769913772; c=relaxed/simple;
	bh=JNajJnO9nq5PoIsWYsYzLUJ8h+KRcJYHjBw5q0Uf3mk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+t6R8PICxJotYoMGBBn34idNLcUYcJ3uqaLcJrS4zEeXh7RCinmxpNSgvZtx1qKG4r1563HEtO0l2upG090Yg3ku3OiMoc3lfdmxPyRBRfsaIX0P+gem9pMmXjyyQk3vIooE3MclzQX04hgb11BkQixSdYTgQZdk7q8jFDvh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZcWgui4h; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61107BKs1351763
	for <linux-integrity@vger.kernel.org>; Sat, 31 Jan 2026 18:42:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=KxLQFcBKQj+dgeEIod
	F9EG42qAQTlb+bW/yrZOzovN4=; b=ZcWgui4hNbvRUJlyxu7eDdLXpkZ5SLp8uJ
	JlCpB7Kvm29rnJUhuJixcIsjfqsbBk5evJNXZGc3PbZV8z2yS11OMCEDJx6RLOJu
	0QE0QkwX1A9OdG9cLSJHaR8r/dlfwN0ikMGXhs4N3yX13jKOt1qXWavAsvKvag2Z
	UPKVaBvdeSfWi0TCGPNcrDOG9GBDA6kkBaw2keftEkIoFm+iHXpdNQHSNsqxsEFG
	7/AuKIo0eZUbVHwk87D7o0GaZIekBD5J4fesW+2tlbuN1vV8x+XQ3IrlgEZzUdha
	57zCAWWIafQ0Qd3F0vL2MCxPP7Om8VUgN77dHu5RrlY8C56xFjYQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1ga1d9vp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sat, 31 Jan 2026 18:42:50 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 1 Feb 2026 02:42:48 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 1383A7789A4; Sat, 31 Jan 2026 18:40:15 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu
	<roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
CC: Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn"
	<serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH] ima: check return value of crypto_shash_final() in boot aggregate
Date: Sat, 31 Jan 2026 18:40:15 -0800
Message-ID: <20260201024015.2862236-1-hodgesd@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDAyMSBTYWx0ZWRfXxu5T3Rka7dHx
 2/LPoIxYbvll75wprnEImp/uqzuVbRUVSVKXJ2CIri1NWOftB0Q0mv0nfrIIOLy82KM1pGrtH/z
 zNOtd8BocYw6nUOzD7800RvdhOMDIZ+IN8TDFQjnQWHbUUXZKQ9a9dzF/G2VAzZkhBRxeiboIyy
 1WTsxCpITBmAEU2R7HPP63SDPlbBtL8N3LZNhpTic/XewdQXK9CQ5yhmNZqV9KghqPJSZbToex2
 xEg+745QvcO1nfAujDKMj38nRdV5PYqRVi66JtHCxq0uFRDN8Qy9fM79busGjfE0pa33vcnmpW2
 NOj6uKwwzifOfZoN3N1KJxRwqKs1kZKTyTS5hsS1rgmcRKq3c0ps37FFs5b2KY755cTzEyxmW3V
 xqo/xKz8za6sNvpUHOzVv1dT9kZq6UEHV31M21ms+Psmun73XsQmMBn9/b+xVKldS3f1hWbbLTL
 S7HwQagz4RQoO6lUDng==
X-Proofpoint-ORIG-GUID: iNpYKHMcfg346bEChDpQJe33TrCdFA6x
X-Authority-Analysis: v=2.4 cv=TembdBQh c=1 sm=1 tr=0 ts=697ebdaa cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=G4tEbEgpH93ySczLUAUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: iNpYKHMcfg346bEChDpQJe33TrCdFA6x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_01,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-8384-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEC2DC4B38
X-Rspamd-Action: no action

The return value of crypto_shash_final() is not checked in
ima_calc_boot_aggregate_tfm(). If the hash finalization fails, the
function returns success and a corrupted boot aggregate digest could
be used for IMA measurements.

Capture the return value and propagate any error to the caller.

Fixes: 76bb28f6126f ("ima: use new crypto_shash API instead of old crypto=
_hash")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 security/integrity/ima/ima_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
index 6f5696d999d0..8ae7821a65c2 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -825,21 +825,21 @@ static int ima_calc_boot_aggregate_tfm(char *digest=
, u16 alg_id,
 	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
 	 */
 	if (alg_id !=3D TPM_ALG_SHA1) {
 		for (i =3D TPM_PCR8; i < TPM_PCR10; i++) {
 			ima_pcrread(i, &d);
 			rc =3D crypto_shash_update(shash, d.digest,
 						crypto_shash_digestsize(tfm));
 		}
 	}
 	if (!rc)
-		crypto_shash_final(shash, digest);
+		rc =3D crypto_shash_final(shash, digest);
 	return rc;
 }
=20
 int ima_calc_boot_aggregate(struct ima_digest_data *hash)
 {
 	struct crypto_shash *tfm;
 	u16 crypto_id, alg_id;
 	int rc, i, bank_idx =3D -1;
=20
 	for (i =3D 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
--=20
2.47.3


