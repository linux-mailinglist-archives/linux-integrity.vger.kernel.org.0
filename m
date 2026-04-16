Return-Path: <linux-integrity+bounces-9210-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIgyGBgD4WmJoQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9210-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:41:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62750411158
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77E3930116A3
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113938AC76;
	Thu, 16 Apr 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THr4vOaN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B4F3E3D93;
	Thu, 16 Apr 2026 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354062; cv=none; b=kRGT2tQ4DvG4vBeWSv9dEzNDkF/MsrUfLmDd2ggRwLnYSVZQBdn9mVNo9Sg1BQ1+HQCOcYFhDNCXlGsq7DoAoeh2MOmMv5IpaGVrMKNKwwNAzIkDtYWsbYVN9oM9vVprK62Wrna74XLJv9CrT5PRxt9gq+HIOhbTTt9yiqbf/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354062; c=relaxed/simple;
	bh=aTJrDqyfd3BxqK6ssxHLbipQlUcE8/Ox2nWq9xC2j6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWBVU9s5ccoZrc5TZjRN84KfZDO5WK750NBnev3fvo0hJ6Tb4d+Ixn28DUIbRbukKTOPxNgcDtFDydRp4aLrvkC56ImoH2SMfK4YZ5Q2CY1v6rIY2/1CR70I2JjCFvVNjV2iyaT49OYF7IIHn0QjyAlZwVYYddJgc8d4XLVMmak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THr4vOaN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G9icdW1804718;
	Thu, 16 Apr 2026 15:40:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w5ausvGPfLI0fQUKs
	Gr3sFRK5EcfMKkvMq69wUBmlas=; b=THr4vOaNVAKI5b5FsPxqwp5TjV2coNTIG
	I9dR3Ry8TdvLUpOC0+VEq80onwhrl55blPprn1qGcWspkMHAbbTQ2FZSnK+z/dOW
	j2OlW2eI9kZYF1A7cznwscW+tXYjigkJQzgHLKdoHf2XMHKdCXEjYUSc1LniYZM8
	1gC2klFxL2KZPMSL2O+npIQSPqVfz+uqa8jaEzKEqs0QkjjiIM9cSRnmxdMmYMPQ
	uRcpf1ujVQYZ6xTchiT2tia3JA1IOqFV8DdmIGt1k9ytdH3qOwoURciGUqR7L0ZN
	UVi1dwmf823ij1jAeWsVAZXK7IXg1sla1DapqEhxzjDvOJGizDJtg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kdb7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCxrbH003385;
	Thu, 16 Apr 2026 15:40:48 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh953d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFekfe12386900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:40:46 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 702AD5804E;
	Thu, 16 Apr 2026 15:40:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B40A55803F;
	Thu, 16 Apr 2026 15:40:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:40:45 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/4] integrity: Check that algo parameter is within valid range
Date: Thu, 16 Apr 2026 11:40:37 -0400
Message-ID: <20260416154039.1648083-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416154039.1648083-1-stefanb@linux.ibm.com>
References: <20260416154039.1648083-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h4jjSS45nKgh_OA_YT8QTWRcMcTluYfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfX9Rsr9UbeRnFV
 5gIYkJpUovg+fEwWPtP3uFrPLAnfY0scOdSaXFCKFAzvCzK9R/IHCthTVr7BI6uqpOeaYMnznDZ
 ZCHp47UcKweaPYxFRVQYr8+u9YQHsK/36rW1x76SS0MrSE4FcislJ1PsVwIAxY3Rqw+4p0R+HB7
 ktcfkgOnC99qdp1TojsMgfNjn/tN7V99yvSECq3WvGSix4RxTGa/H/OEm8hagBNMisE1ZqKbs35
 B4nQpptBlr2qJfDMZSzboB5Vcy1F6OU3tNcGqoJcDKQUVIkP5RahsgHvhBE5NwjbGaZSw3YAG2U
 p+rI92cpXRKzfVwqd54tq3KTrFDwvEqeKNPxHUaalVbW3ONZfDPDBiA6Yq9/eZ9W2t6h5OZd2Oy
 FAD0MXJWp9ozsWDseoqOCJrh1HCD35BGJx5DEYfdwpNO6P6rONL29nRgCvLVbaCu/ewgzlIhdwt
 +/UR65B6huIf/wOYDNg==
X-Proofpoint-ORIG-GUID: h4jjSS45nKgh_OA_YT8QTWRcMcTluYfr
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e10301 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=obyXdEPKXPE7isLz8FsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9210-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 62750411158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Check that the algo parameter passed to calc_file_id_hash is within valid
range. Do this in asymmetric_verify_v3 since this value will also be passed
to a hashless signature verification function from here.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index a791ad43b3fb..ed171a627d18 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -139,7 +139,7 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 /*
  * calc_file_id_hash - calculate the hash of the ima_file_id struct data
  * @type: xattr type [enum evm_ima_xattr_type]
- * @algo: hash algorithm [enum hash_algo]
+ * @algo: hash algorithm [enum hash_algo]; caller must ensure valid value
  * @digest: pointer to the digest to be hashed
  * @hash: (out) pointer to the hash
  *
@@ -187,6 +187,9 @@ int asymmetric_verify_v3(struct key *keyring, const char *sig, int siglen,
 	struct ima_max_digest_data hash;
 	int rc;
 
+	if (algo >= HASH_ALGO__LAST)
+		return -ENOPKG;
+
 	rc = calc_file_id_hash(hdr->type, algo, data, &hash);
 	if (rc)
 		return -EINVAL;
-- 
2.53.0


