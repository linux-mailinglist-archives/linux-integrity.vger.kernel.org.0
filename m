Return-Path: <linux-integrity+bounces-5410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DC5A6DD29
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B801679BE
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2FE25F7B2;
	Mon, 24 Mar 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BxOcWAyP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69A469D;
	Mon, 24 Mar 2025 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827028; cv=none; b=QqdssxeWTxgKxAVmBeCkiAR5AxI0YYh2DwA8FAh943+zkb/LOb+GtgEHCa+4uUeAteal3HjkBblFRrvM16EgnWAVGKSdw0KKJtlAYdqNLGbyqvg3m1VzQKcwvi/Rlay2tIe79E0q8e/Uk2vK6IAPDK88DlQjL+4XToUWD6RnZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827028; c=relaxed/simple;
	bh=w4usWJ0THkg46w1N4lNwuAFhLjNZVRI59MyTMA6sUgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASHLT/IyznBLnlYP7Y3QkkQZUJkRj1d8pwp2B5NU8sSnff5YLRbCJhkeZk/jL1l6OLFQ/l7RIDcG6yGqru5uufW3iKwcGYOPRS8+cn6ZW0El3kazER/6GhwXQ15xeB6xDFxMYPbBHw3y0jD0EVVjdFXcbS2NuaCZxS2uXv2oP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BxOcWAyP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O88erE013699;
	Mon, 24 Mar 2025 14:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wsnfio
	ygdKj/JbaeD/Jr1iGKaGn9+/X1K++K57nGSSk=; b=BxOcWAyPk/zO/lSyqmEQ1e
	7hLBNqIEamSXIuG8ZOcpTqajqCClwkO0WEdEvRvb7bsydQggUlBeZJUNdxkRKCoD
	OiOEWyS0gYJj+5S0hWMkf64MmsBNjsxBkflxlnbiVGZG3BN+l9MuSdXvVEyEir6Y
	5KHPU8Ni66AqNyEBykOt9CElT9/PVeM8UW5FfxpTmHupC3pq6Sb+8fIDfMigYDu/
	FJnSTCIOqJco6V5jQIzy8CRYVZ5360/DJLOahNYRRYBPvfU51Q9E5bKT8w3KBG7V
	WMlvktwen5h7YXgp53+r4oJ2cxMA4BpDLlqDbwnBZj9dCLVTgi04dQ3AgWwJReew
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwvjua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:31:50 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52ODo87Q030801;
	Mon, 24 Mar 2025 14:31:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwvju7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:31:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52OBWISZ025485;
	Mon, 24 Mar 2025 14:31:49 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7wyxrnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:31:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OEVmsp24249000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 14:31:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98BBF58054;
	Mon, 24 Mar 2025 14:31:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99D425804E;
	Mon, 24 Mar 2025 14:31:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.112.208])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 14:31:47 +0000 (GMT)
Message-ID: <35d199c2a09e9215aad715c97a6702dd04be4a98.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 02/13] ima: always create runtime_measurements
 sysfs file for ima_hash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2025 10:31:47 -0400
In-Reply-To: <20250323140911.226137-3-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-3-nstange@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WFHKhhaMsSffxRQcD5Fs2CYz8utV4MQh
X-Proofpoint-GUID: JAVphQZoba47LGGKGFYvuN0vJoAmYbkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240105

On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
> runtime_measurements_<hash-algo> sysfs files are getting created for
> each PCR bank + for SHA-1.
>=20
> Now that runtime_measurements_<hash-algo> sysfs file creation is being
> skipped for unsupported hash algorithms, it will become possible that no
> such file would be provided at all once SHA-1 is made optional in a
> later patch.
>=20
> Always create the file for the 'ima_hash' algorithm, even if it's not
> associated with any of the PCR banks. As IMA initialization will
> continue to fail if the ima_hash algorithm is not available to the
> kernel, this guarantees that at least one such file will always be
> there.
>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  security/integrity/ima/ima_fs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index a8df2fe5f4cb..f030ff7f56da 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -436,10 +436,8 @@ static int __init create_securityfs_measurement_list=
s(void)
>  	u16 algo;
>  	int i;
> =20
> -	securityfs_measurement_list_count =3D NR_BANKS(ima_tpm_chip);
> -
> -	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
> -		securityfs_measurement_list_count++;
> +	securityfs_measurement_list_count =3D
> +		NR_BANKS(ima_tpm_chip) + ima_extra_slots;
> =20
>  	ascii_securityfs_measurement_lists =3D
>  	    kcalloc(securityfs_measurement_list_count, sizeof(struct dentry *),

"ima_hash" is the default file hash algorithm.  Re-using it as the default
complete measurement list assumes that the subsequent kexec'ed kernels conf=
igure
and define it as the default file hash algorithm as well, which might not b=
e the
case.  Drop this patch.

Defer allocating the "extra" non-sha1 bank.  A subsequent patch will select
SHA256.  Based on the chosen algorithm, define the "extra" non-sha1 bank.

thanks,

Mimi

