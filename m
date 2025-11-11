Return-Path: <linux-integrity+bounces-7618-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E6C4D7AB
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Nov 2025 12:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C55A189CEC6
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Nov 2025 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8618B2F7479;
	Tue, 11 Nov 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JkwyYsJA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D671D63C2;
	Tue, 11 Nov 2025 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861236; cv=none; b=kQu38c9CJ7hBgQgKH5Eh/+kz9CxAFMyjjQuJYx+jLEGfJEWCSgWT4a6ehHpP4pBx2h8H4U8ZRSzZPwik5NuuC1ApXRA7S0dIbvL0qiT/pq/ndx1SsbuEczz28dcKga1f+DNZEL4VPqbp5sPAPivZxzZYMu0xW09+vgyIslGykWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861236; c=relaxed/simple;
	bh=hR91vdwpSfpmbKbLu2l5eJHLKqT5dbj+LrLS8yyS+a8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lEG/jfSO2kHSb7PLN5xa5Yk+hvGDc/LeaSq9K6PcyNveD0LbwOZge5fYY/7eKtgCVh+/pHyeEmqW6aPPUpS9Aq2+/iUmanY81NdK4qTt/Lx0Fey296rbT0IOFJLENV0/TlTyE0wfocNsnlaHO5T9lnI0QCXx85ItK8LOFYD4lc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JkwyYsJA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2xXUJ023600;
	Tue, 11 Nov 2025 11:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8ie7IM
	GwHdNKCBVnPOW7BNm7UFdHOm5GlpkqJRFNifY=; b=JkwyYsJAS+pUgrTx0Md3Nz
	xFewumww2vYdaQoDrmPnHHeY2KZXK/EoMJ9rmUUS0HgfffvZ+mbL9ObpGtYhfpDf
	iPPjGCPCSUuGG1IOHKfIQKR0CqaNhWTtQbJRPUxbLulB/nuN7cnx18wfrCKUsgb9
	UCLlN/gVdVNEH1OG2cgIIqDHsn14za/6yIHQfqfEqNC2raGumlMXQgA822i+M0AF
	VePJXFukS8UXy3Qv0IDCyf4+2OfQ216GpzedIosbioR6JGA+8QAJ60DE25DbyC/b
	QXUnI9uumDD+Z4VezVNRJ+pPxBDVmz1rr+VQwXIbiYRIwvAgdva2wVYACm/rWkYA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjtm3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:40:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ABBe98B001479;
	Tue, 11 Nov 2025 11:40:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjtm3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:40:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB9ehkM008193;
	Tue, 11 Nov 2025 11:40:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aah6mth9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 11:40:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABBe8oU53412136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 11:40:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2901E58054;
	Tue, 11 Nov 2025 11:40:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1397F58045;
	Tue, 11 Nov 2025 11:40:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.139.215])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 11:40:06 +0000 (GMT)
Message-ID: <16c73b4e0761a1622770102d1d48982fe9ae86ac.camel@linux.ibm.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, roberto.sassu@huawei.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, code@tyhicks.com
Cc: Lennart Poettering <mzxreary@0pointer.de>
In-Reply-To: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Nov 2025 06:40:06 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y3HENMEAaKwFjPzQZBz4-AHpwTJjDbBO
X-Proofpoint-ORIG-GUID: BrrJooCEo-ClC07HzSrPnYFuIOCppHAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX9934H9BHLfYy
 tu2xJ5e7hh7EFtIkfFcb7YB2vIHcut/CdsHlnYZYU4PN6MInxdifu2FDx/algA2fmDpepUNn+xY
 gG/HCJDiVXIRUJmpVBaW5NbmUjOiJyh9M08V2mAPhyhinxV6Zsbka54LMINNpUCvZNd7mlw4J21
 QHkMJq3iwcMzywjXUjoE6Ml1C/qVUN92+mthb4n5G0iEfPJ8oJpD2hQ2gjYg8hi03g+AkdYnGIT
 XBmILK0sAGb1Zsq3nLk4k0U8FIoMrCsdM7WTBMKBfoRMjUL1EMoI1UzM8lC2wZVRceKGcE9GMtG
 vwHq98DyDFtzIGVJPWQhPM/fQRZFrcN7XK9ZDWhr7YZPEJjYHweBLUw9sLK/1M2URfNz/T2D3KY
 nveQpq5Yeq7DwyqvjlOeedrzjO2dSg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69132099 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=Te6HIuTWUB4XkS3UWhoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

[Cc'ing Lennart Poettering]

On Thu, 2025-11-06 at 18:14 +0000, Tahera Fahimi wrote:
> Prevent redundant IMA policy rules by checking for duplicates before inse=
rtion. This ensures that
> rules are not re-added when userspace is restarted (using systemd-soft-re=
boot) without a full system
> reboot. ima_rule_exists() detects duplicates in both temporary and active=
 rule lists.
>=20
> Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>

Sorry for the delay in responding ...

Before trying to fix the "problem", let's try to understand it first.  At l=
east
on my test system (-rc5), kexec is working as designed.  On boot, systemd
replaces the existing builtin IMA policy with a custom IMA policy.  The arc=
h
specific policies are not affected, as they are persistent.  On a soft rebo=
ot
(kexec), the IMA custom policy is re-loaded as expected.

To verify the above behavior, extend the IMA policy before the soft reboot.=
=20
Notice after the soft reboot that the original custom IMA policy is loaded =
and
not the extended IMA policy.  Roberto, if there is a problem with this beha=
vior,
we'll discuss it independently of this proposed patch.

The question is why are you seeing duplicate IMA policy rules?  What is spe=
cial
about your environment?

--=20
thanks,

Mimi

