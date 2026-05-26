Return-Path: <linux-integrity+bounces-9680-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC1ODNKpFWqJXAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9680-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:10:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10225D7268
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8455D3079171
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B603FDBF3;
	Tue, 26 May 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ApeOM2Jg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977253FD941;
	Tue, 26 May 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804186; cv=none; b=kbSd0FuRK9xu7w9yX7mfPDX09aWl2EwkbAzF1vH0UAVcuGiPzjDIfN+73Ing7jnGTv0xXrondkdM4rPHE0qGeMrgTWnytEcoggZ/JKrv2QrG/p3xoIJ0umeCgCO4rclXuw3TlpWOSZTj03vbSokTozzviDwu2wurd7Q7r6RGogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804186; c=relaxed/simple;
	bh=t5xw9LJjkBj+ypCFdHXKNrc+fuw2ZnYcp/JPKXg8Qnk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=i2g+0uSapBY58AnaYSQ2zAgWH5BXuwSgQb4J462e2jj1jLkUgAOgsGWHpG0ZsnEX2PPFhBqO39n8IsNLiepWj0dKuso3BAKrFrbTeYDmnSVS9kyRSljnQivZ+OA8dKtrh8tNu4XUkKJA3sF1eKep56G0C8d7dUKPL+Zz7AsqgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ApeOM2Jg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q1EAEb3938045;
	Tue, 26 May 2026 14:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OVSHyb
	RARqv6qeKU358Dv996FmOqA6kpbGSnXc/6dh4=; b=ApeOM2JgBhG97YqqmVq1vA
	uW3+ODYnwlOwSXYPk3ABbaJ+8JGDtXMMjQ6lATL8k6JNP0vsILcDvGNMDzuJ0pX/
	HzTlPFKL9s0UYmf4IsrtS5KmZi0toV8X/p2XQrzZRikULR2Sjvb4UJrTVCZwg6B3
	yUMU9ClFYaCF0na6kX+ievHwD6TbPVHJrXF3SO78E6CvspW79UYeYSGVouGLl4vR
	gax2kEQS52V16Ce9YjcWbdcJsyx7kPgJiFqpY+mkeGQPq6fQQQ1Y+BVxJxZJ9jmc
	EqLL0OWaT3PCAiccaeA4AKHLn1xRj1Ae/dLSy8NCYrbfiWb1KQITDVu0W3ZCUXcw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2cdxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:02:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QDsFrP010217;
	Tue, 26 May 2026 14:02:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebpxw1qxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 14:02:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QE2ckF37749292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 14:02:38 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C7DC58064;
	Tue, 26 May 2026 14:02:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 290A058052;
	Tue, 26 May 2026 14:02:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.63.240])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 14:02:37 +0000 (GMT)
Message-ID: <ea886419ef3047ede1885504fad8f865cdcc5ce3.camel@linux.ibm.com>
Subject: Re: [PATCH v5 12/13] ima: Return error on deleting measurements
 already copied during kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-13-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:02:36 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Bt2M4F3zVq5rPeWk7bo51CXNf2qBiY3I
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a15a800 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=uIBYqjL5AI_LJtRyct0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExOCBTYWx0ZWRfX91i9/+0QiPY7
 Hy9XdjmcMU6QDtO2IpgatIpKynyhzZKFIZ6n7O0jdCxFhrPBy5A/OBXKtl+OUHkIJbA0gW5eciM
 duRO7/+kssygkfeOMsuQq7v/jc9RFsMU451njoI8chD76jW1HkIMpBmtpf6TIUSpGScFqztS7x/
 Mb3V9Vbypf3kYMxqqZBi5mm0N+XsZ0S6M4npuy3nJb9a0huaoONxyDQxtzmfuFWdLNBvIW5sOjY
 DcLrdKXdfb6On9hxSk1abvCKdUy3D6Z0RxTtBg+O8c0doHZ5N0b7rSNvSq3lgbMXvKrNnqJXUfp
 3DIUTyX5TSmZY7PoPpYnexhIbQf8RSW/1iBqLRbYMqRx3wYzO/Lhd+VBs+4WP3ZVoXLbsQ4sHzF
 x2/N1OWx3uS42PlhfBLcCSa88bOxrUmA0uQ313y3qm1mscW8yY7NQWmH38uC2rg1RHkqZSZOuZK
 Ee1mVu3cLnzRo+k/5fA==
X-Proofpoint-ORIG-GUID: mDlI4sDPjAyCtgp0Cq6g3LsSl4l3Uu0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9680-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,huawei.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D10225D7268
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Refuse to delete staged or active list measurements, if a kexec racing wi=
th
> the deletion already copied those measurements in the kexec buffer. In th=
is
> way, user space becomes aware that those measurements are going to appear
> in the secondary kernel, and thus they don't have to be saved twice.

There are two reboot notifiers: one to prevent additional measurements exte=
nding
the TPM, while the other copies the measurements for kexec.  This patch pre=
vents
deleting the staged measurements after the latter notifier.

Instead of introducing a specific method for detecting whether the measurem=
ent
list has been copied, rely on one of the two existing reboot notifiers. The
simplest method would test "ima_measurements_suspended", which would preven=
t
deleting the staged measurements a bit earlier.

Mimi


