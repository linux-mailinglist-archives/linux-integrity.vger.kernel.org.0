Return-Path: <linux-integrity+bounces-9067-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJl0MbL3wmklngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9067-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:44:34 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F4831C792
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FEE3016C99
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8F354AE3;
	Tue, 24 Mar 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PqT49MWf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B9355F3E
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384793; cv=none; b=QRjtvgKRlLM8ap0qraHeY6x3XqtW8UDhlP4TyZVguOD2oqa2TMtLl3Bx3RnJKrG5YfDyw10R5OMG2NwCTLuERCDccMsEeOxMKPpPVHTrCpAKAlft6LGQYwc54S6TVHmj0zcctbLPmO5P4MMprnBgDuFXzqNgsfHB/gOmesP1w3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384793; c=relaxed/simple;
	bh=mIIZUX/m00r5Ey7BocLet+Aryz3XblQDz8OsskAGdTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVG7I+S8i48LpPPOhhexO+7IgG5ikxksfEVT4crMa/CFC7I1iGIZt8osFfJiXdinXgbhNOJ7f4QeIHLQu1yPSgM8apEZDbJ1IDSY+NyQ4sZLq0EKWkrbHs1AFiKEoslTzTlL6zwcWU6Wa3wL2Y2SB6zHip0ebwyV//kICDoipGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PqT49MWf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OGlPQb158937;
	Tue, 24 Mar 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fZI+R9vI3C9bE8iUXbKYLsgkaBP7ZDwwlP4WZOP58
	Eg=; b=PqT49MWfmvPaRaCReeWSJXuwO9oLC5R0aqHAWfIY3TQe6oJbfPzqjBmbO
	KIc/rZAW7J1yz7K0R2VUpeutPyKJsL5ZPfBIhiMMs/csKmL6e/3UwSRLI8na6SzE
	o7frdxn+gYxGQXCse2nhevB9yLgmB9TwtrX9JmncyeayDQOGxyykB2orifqXd1U4
	f8R+hm1o7ZwXWL50KUGiH9s0aGxXuQD+urwHjnFgtRqpFbjA1GR3Pxsu8IWuLSzi
	Gdfw6r5aU3slI9tGLCuDUSbsg0xycfZJh8RzbPmroSLrY0nzO/UKey11WXxBIW1R
	6TUBuj+pJ3tWaiYt1e5+1z3cZFZQw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqdp68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJcWhr026681;
	Tue, 24 Mar 2026 20:39:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kuq3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OKdcOe17301916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 20:39:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 558AA20043;
	Tue, 24 Mar 2026 20:39:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA84320040;
	Tue, 24 Mar 2026 20:39:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.188.204])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 20:39:36 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 0/3] ima: add regular file data hash support for sigv3
Date: Tue, 24 Mar 2026 16:39:26 -0400
Message-ID: <20260324203929.2475782-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jIodmR86XYux5OTegFAom4CVuuek0jFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NyBTYWx0ZWRfX8Ldt43avYlck
 vjbHSDwF17s3fsD4w1q6pNvCYQaHjBpBZ1lg9bLAsevGRFyBtOSQzDL8ZgPjnEUsh2zxHYQ+UGr
 +1w07GIAn2AD+IEfobXkB0JBgTYHk4gRgWp19uUzvPORnjAcWOS24E8MyEaH1EkrsKqJQvx8ieO
 QiVHgGDHhQ9pejx9rTDaVipFEq8A3nazCaqZ+YU3x4FLZSrGIwPT2SU1uZs+VWzyg2+IG9JxBIh
 1IDna7wTqzf5FKtA37Tmvk4rPdQgZEI8v0tKRhxNNdkJuQOp9DUhJHcpLHHqFGHKE87e2SlA48m
 Z3dlsvgOP03cPVJn3a805TlV4fFIv+dWrzgTnU7JQapRgINE9Pyyks1uANDicgWI78KsnWunrLZ
 0aRw2y+saUPSox5hfCUXu7E0RnmdIrRrYtDWWOHLmkin3MiOriaOLO8acoSrBHCfDbpdqhJPt3U
 mviBuOfbc9Qa4JIVRzw==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2f68f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=E37kwhSqBQ2VOMhXz5gA:9
X-Proofpoint-GUID: jIodmR86XYux5OTegFAom4CVuuek0jFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240157
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9067-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 37F4831C792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IMA signature version 3 (sigv3) support was introduced to avoid file
signature ambiguity. Instead of directly signing a raw fs-verity hash,
IMA signs the hash of ima_file_id structure, containing the type of
signature, the hash algorithm, and the hash.

Pure ML-DSA calculates and signs the hash directly rather than a
pre-hashed digest. To avoid ML-DSA having to re-calculate the file data
hash, Eric Biggers suggested signing the smaller ima_file_id structure.

This patch set adds the sigv3 support for regular file data hashes. A
subsequent patch set will add the ML-DSA support.

Mimi Zohar (3):
  ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
  ima: add regular file data hash signature version 3 support
  ima: add support to require IMA sigv3 signatures

 Documentation/ABI/testing/ima_policy   | 10 ++--
 security/integrity/digsig.c            |  8 +--
 security/integrity/digsig_asymmetric.c | 58 +++++++++++++++++++++
 security/integrity/evm/evm_main.c      |  3 +-
 security/integrity/ima/ima.h           |  1 +
 security/integrity/ima/ima_appraise.c  | 72 ++++++++------------------
 security/integrity/ima/ima_policy.c    | 22 ++++----
 security/integrity/integrity.h         | 14 ++++-
 8 files changed, 115 insertions(+), 73 deletions(-)

--
2.53.0


