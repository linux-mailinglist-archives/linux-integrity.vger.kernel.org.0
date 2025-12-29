Return-Path: <linux-integrity+bounces-8143-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F4CE8319
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Dec 2025 22:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4B213001039
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Dec 2025 21:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A02E6CC5;
	Mon, 29 Dec 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gyeEvgLv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274182853F8;
	Mon, 29 Dec 2025 21:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767042829; cv=none; b=pMrY2OtD6IIzKaCVauqQ4/fcXwiu+GfVBvEDuoyBBBDkNnkGdwmYmqAgZ2qNyl220LHf7fIHHXGwzK3G9bZSylIcI7pK+ucKyD0MXIBZZxfTUtBjnr2LncGTdt2FBqxJCl5K7MNwSGhLU8FKFzZejO6mpWhaQXx0gato92iruUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767042829; c=relaxed/simple;
	bh=4EwlcBqchvFuTXBSCsYR00Clhai03BcfL9+QbF1W9HU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VsgBZ0ww32ImRInwyTsQp+/EDfnXUMq7PFkSfzDppRW4LmCvQ6idQBiiMB8zvJdxmX0EfeOPASvtTpuAEMaP2JqoahE2K8Gta1nhnpewjy/WxfiOXjFijNRwREcpyUGuA7GJkS3X/stw5Ft9R7kcOcW9S5MJgSNf1WzbmUjrS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gyeEvgLv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTEkt9H027434;
	Mon, 29 Dec 2025 21:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0jz2AH
	db7TipnulZpylulsco/VpR2GodIw1SA7RLfEg=; b=gyeEvgLvKEynflobczvh0p
	9AGWmSOchfR/DlNIqIzH1gx55QOS4tkzPEEkucx7oHAHw0wn26tKjqSflxGWE51g
	X838ZXLFRDQddjNRNTsD9getEQRGRdz361BWTl6MTTTRDdzMymke66ksndFssOBb
	tbdfdJ5SdPdXKnQhe1JQyFTT3yrSXpju/uLBVoQ5BcTW5z5GJ/mZirFh76sMo4wr
	oo50d5Ea/G1ra2vqoZSZS58N/rBeoh+6mJ9TmqdLaULQMYzuUR4sD3N3r7+BhDPX
	N+Ub0RdpktQW8Ccmtbt/jdR/ClHjVW3k+hvVGKdOEdX790SpmG2/6jvlV5MKpgqw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xcydm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 21:13:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BTLB20b007111;
	Mon, 29 Dec 2025 21:13:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bb46xcydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 21:13:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTJfrXw023891;
	Mon, 29 Dec 2025 21:13:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bat5y793p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Dec 2025 21:13:11 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BTLDA3H32047804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Dec 2025 21:13:11 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04AD58043;
	Mon, 29 Dec 2025 21:13:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19F258055;
	Mon, 29 Dec 2025 21:13:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.14.247])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Dec 2025 21:13:09 +0000 (GMT)
Message-ID: <29331004c900e82a898668459ff0f8157e6f8645.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Fix stack-out-of-bounds in
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
In-Reply-To: <20251228031914.47618-1-carges@cloudflare.com>
References: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
	 <20251228031914.47618-1-carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Dec 2025 16:13:09 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE5MCBTYWx0ZWRfXzW1oPxMNN7lO
 53VhBNfFykpwIYkSHcoqVaYJVa6zwqlkRTno5fCCIah2hroa5QgxH9k36XGIebXNQNZiOzy4vin
 cSvMjOOrpCzI8DJRasuAhZuOUiTQByZJOrwrvwycbY4MlyC+6rf8WbTzTVjvVn2wBk+nFyf91mf
 ayz2/fVwtQzNC9c3GtyEAenLkYpMFVSAddm+tyG+4P8okcDmu1XTMmdjd4Zo1tan99LWTs+P6T3
 SLm3p/hRuUhcb9OZcfTzfOpt4SEzh4nyrMOQkv2bjOUJK8i8kVLlP8BWc7VPYSUw3fped9UPRpz
 1SwDXDmCdFmcW1kA7PzUtdnLm8Xyc5VSfb48tsSEd4rqk4OUyvd5Oq3yjwTxz0s/DqtNvL82Et7
 Zk8mUsZhOWSNZ/hWjrz+oE5MHg0YxvBCISK5inlSHrO58Q12HN9mu12eMSOpbJxGjLeLNc/5kaV
 Oq0H5QAuGpMvq1OjGbw==
X-Proofpoint-ORIG-GUID: f8Qph36I37IDZzUt4mCZNcMd7Mvcselq
X-Authority-Analysis: v=2.4 cv=L7AQguT8 c=1 sm=1 tr=0 ts=6952eee9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EG7W4yiQAAAA:8 a=B2nDkTjVBPwomQTfEAIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DewqOWr7bIQBkLHKGE9FT-B6-bQGb-wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512290190

On Sat, 2025-12-27 at 21:18 -0600, Chris J Arges wrote:
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

Thanks, Chris.  The patch is now queued in the linux-integrity/next-integri=
ty
branch.

Mimi

