Return-Path: <linux-integrity+bounces-8133-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE557CDAB92
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Dec 2025 22:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7FB3021060
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Dec 2025 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18C9319605;
	Tue, 23 Dec 2025 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kF+g5dI9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B7313E09;
	Tue, 23 Dec 2025 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766527142; cv=none; b=q4YWynHXKC5G/1BGgy+Gg3+hll+5nspHGxGXRww6t5p2fIkBA+3yJQEjjvR8BixWIadHohGRRSv1F6C9CqEZwsNgIhSZPO3OSATjLAEpBEid6QdmouaVm63ddg4GlqmSEOua3LpObRUjclXH0wmwLFAFVYez1k+rWGG/yF7ABCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766527142; c=relaxed/simple;
	bh=cRZI+zGur1cwyfEe1IV+pPuHgPuurAl3t3V8fT116SI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JBAFC2KauMJUmoCxLEW56WfsHD/yWV3S09YfkBBQRI3SvFU12JwUecQwNvYAkxoVJoeCZSxbMcqsCoWZJar+22K50Qt0cNwSWIqTHrttI8S4DGht+KIXwIdr6/1ll3K3hbi3mbhkJORGRjzwC+MwtAR3QkRMAdMmJx07HWm1pOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kF+g5dI9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNHHC9C028016;
	Tue, 23 Dec 2025 21:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bYL7Vg
	CRXF5UjhwibR2FH6zeItLwB+UTsw9IhvDX8Zg=; b=kF+g5dI9Sw9jjQZnL/CYLI
	AepBkANm9/x2/spmhRlHbemX7u9k5Lsdwc/lWzimeEf6BnsJ7e4zl+F4Z3zFnIEg
	/fYMHMJYfbcftiKvdDFMd3HhlCoECU+Rd8JpTPWmoeuEsqJS8zxsfeov4A2kuFsl
	w9pdpRJnlcmA5v4/Xl0wl8lRulDoGeAYqK44rvoSMnNOAb5VSSjGQKIJF6iY60u/
	HjL55poGkrd3k7Dk7WvmQBerdtOjGMg2yJZrwrllnyT9sJDf8bb2hIzT8KpfJssu
	UUo8gtZ9er3jemg5snabSGFbiBK5UjfOej5tsd0M/Pxq9ZXnY1qPWkoyooDTDHdA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7e6h4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 21:58:30 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BNLswPr005799;
	Tue, 23 Dec 2025 21:58:29 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7e6h48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 21:58:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNIOIOx032263;
	Tue, 23 Dec 2025 21:58:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b68u150jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Dec 2025 21:58:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BNLwR9U24969776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 21:58:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A67E258056;
	Tue, 23 Dec 2025 21:58:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C2A58052;
	Tue, 23 Dec 2025 21:58:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.160.131])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Dec 2025 21:58:26 +0000 (GMT)
Message-ID: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: Fix stack-out-of-bounds in
 is_bprm_creds_for_exec()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Chris J Arges <carges@cloudflare.com>, roberto.sassu@huawei.com
Cc: kernel-team@cloudflare.com, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge
 E. Hallyn"	 <serge@hallyn.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,
        Kees Cook <kees@kernel.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251221180128.1026760-1-carges@cloudflare.com>
References: <20251219195456.912190-1-carges@cloudflare.com>
	 <20251221180128.1026760-1-carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Dec 2025 16:58:26 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G8YR0tk5 c=1 sm=1 tr=0 ts=694b1086 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EG7W4yiQAAAA:8 a=4JA6PFR-wSO6Wt4oxs4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9UoQX5v987gBdsLM-BGf7gpjBb2AUulX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE4MyBTYWx0ZWRfX4xIYWDUbWbCU
 ViDJT+k+RGjdCV1HVqFI53/N9aeZAgjac2tTDmYyoXY7073xDhvQ+vTixc88XtN+tVhqwXJ6JLN
 ZRdm3XiOXm6Y3VEn0EFeVGZjNmZpODGRu7yCgM2DJlN9FvHF5byRwLHhPuoLlWWdS3l2mBjrCOr
 cnG2L0wEIuhqgvZ6jC0/+0LQaWwS6hT/icRFcqCQ4BzcXZJJoJDP+KiDuVVoIGF2q/nXxAxEza5
 /fW5rTreelNTAV7EU6+N8KA3Zt8XtsFKfdx+MvWs+EEU15SS5HzlEsyP2Jh2zmRsJafruVp3Auj
 lBks8FDp5Qdp1cl2Hi1liN4irCQBL9P8gnEUZ9Y/yzKKKLi3EzQzYwv6nNjUdlp+vugnZAd3tid
 zFpBHwwlJM5c3dxehxP+g4J8GG+hSfB+huMImOPg84Za0L44qiMyAQQ0ajAA0d5wS6hkdzJzo37
 m3GmjDzvLvQi9kSiw8g==
X-Proofpoint-GUID: WA15osKuKkLXa8Ax4EEm5wpfvP3nGfad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512230183

Hi Chris,

On Sun, 2025-12-21 at 12:01 -0600, Chris J Arges wrote:
> KASAN reported a stack-out-of-bounds access in ima_appraise_measurement
> from is_bprm_creds_for_exec:
>=20
> BUG: KASAN: stack-out-of-bounds in ima_appraise_measurement+0x12dc/0x16a0
>  Read of size 1 at addr ffffc9000160f940 by task sudo/550
> The buggy address belongs to stack of task sudo/550
> and is located at offset 24 in frame:
>   ima_appraise_measurement+0x0/0x16a0
> This frame has 2 objects:
>   [48, 56) 'file'
>   [80, 148) 'hash'
>=20
> This is caused by using container_of on the *file pointer. This offset
> calculation is what triggers the stack-out-of-bounds error.
>=20
> In order to fix this, pass in a bprm_is_check boolean which can be set
> depending on how process_measurement is called. If the caller has a
> linux_binprm pointer and the function is BPRM_CHECK we can determine
> is_check and set it then. Otherwise set it to false.
>=20
> Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")
>=20
> Signed-off-by: Chris J Arges <carges@cloudflare.com>

Thank you!  I'd appreciate your limiting the line lengths to 80 chars (e.g.
scripts/checkpatch.pl --max-line-length=3D80).

--=20
thanks,

Mimi

