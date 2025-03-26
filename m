Return-Path: <linux-integrity+bounces-5425-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB693A70E5F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 02:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFC23BED4C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E4F11185;
	Wed, 26 Mar 2025 01:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="guMPy+lW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65C2904;
	Wed, 26 Mar 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951938; cv=none; b=hJH87OHFI6WbvSzrpoA6VEDAYvCNRyIQscaWJ7iZzE8N6FVno0JX69Wvlh8RrEYth5wu9iaj+t6RCPW37Ls+/w5zTHwX/giBXxafewLl2dlEvVFttIAz6kTPl7Avuatv2QMcK7tizh0DQe3+/xG6g+Y2RjcsZuuLjcGbUI5aaJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951938; c=relaxed/simple;
	bh=CPs7nlHv8bn05wPtO5riFvR5OspucINfQtNa1flrPLE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ja3SpPCXby8qMNBkv7IztsMl96MMyVunHlUs2jokYPNOvk+PLH0ANFjZYZzo7mtWvWemFHiufP0nMHEV3uQIYb81qMGMdUnuWG4HfqdCNcy0nBnBUzTNx1FSZajo/Ax8gBVWVwrXV00RObicIjLjWlekGAVlxGgLS6lvQYNOJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=guMPy+lW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q1GMCb026186;
	Wed, 26 Mar 2025 01:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CfMIx3
	ORGwJ2hz+lxkbrmAjamDDwv/JEfGH1zrvjNVk=; b=guMPy+lWpWKOxGfgj1PPnx
	urf4J/pyAE7X4lzAsFrCFU5ARz7cnzSd7ZfWngvgZkQXK//XvmXrSu3A1dPCTHXy
	3z0YMUsWAYNStDvr52oDNPoKwXCvlvZZYAthzcCRw141jBmrULJ/jnt4NulA5Z80
	SAun83OSbK6HKhzkWzaTkC2xDiltsJKOFhEimRRWaJJfOtd/JteTndAbanhwC4gQ
	Mez5oiBwOayjecR7oqxkhKcwoX4AcEREgh0t+4WQ6pjU6ng+ukYyKF+5Qnzmz9Ec
	OS0K8bpC5UAZMRKQoWEVPi1wDdapaN2M1+OkXdQpu5w0OpQjhq1f/PbZHBiyNLQQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqb38g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:18:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52Q1FBq5014197;
	Wed, 26 Mar 2025 01:18:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwqb38d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:18:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q03C9J030308;
	Wed, 26 Mar 2025 01:18:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7hteapp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:18:40 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52Q1Iduj20382298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:18:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B502B58059;
	Wed, 26 Mar 2025 01:18:39 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ECF658058;
	Wed, 26 Mar 2025 01:18:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.99.18])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 01:18:38 +0000 (GMT)
Message-ID: <4021363dd955236ad55b5d0c26bcf788fa782d79.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 07/13] tpm: enable bank selection for PCR extend
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
Date: Tue, 25 Mar 2025 21:18:38 -0400
In-Reply-To: <20250323140911.226137-8-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-8-nstange@suse.de>
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
X-Proofpoint-GUID: ioXZc-8Cb-DZldkmAvKpDW56HIUifhf_
X-Proofpoint-ORIG-GUID: erQmUz1rOG8b1042QlwTjE8v94fvaqfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=956 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260004

On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:

> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index dfdcbd009720..23ded8ea47dc 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -226,16 +226,34 @@ int tpm2_pcr_read(struct tpm_chip *chip, u32 pcr_id=
x,
>   * @chip:	TPM chip to use.
>   * @pcr_idx:	index of the PCR.
>   * @digests:	list of pcr banks and corresponding digest values to extend=
.
> + * @banks_skip_mask:	pcr banks to skip
>   *
>   * Return: Same as with tpm_transmit_cmd.
>   */
>  int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> -		    struct tpm_digest *digests)
> +		    struct tpm_digest *digests,
> +		    unsigned long banks_skip_mask)
>  {
>  	struct tpm_buf buf;
> +	unsigned long skip_mask;
> +	u32 banks_count;
>  	int rc;
>  	int i;
> =20
> +	banks_count =3D 0;
> +	skip_mask =3D banks_skip_mask;
> +	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> +		const bool skip_bank =3D skip_mask & 1;
> +
> +		skip_mask >>=3D 1;
> +		if (skip_bank)
> +			continue;
> +		banks_count++;
> +	}

Setting ima_unsupported_pcr_banks_mask used BIT(i).  Testing the bit should=
 be
as straight forward here and below.

The first TPM extend after boot is the boot_aggregate.  Afterwards the numb=
er of
banks being extended should always be the same.  Do we really need to re-
calculate the number of banks needing to be extended each time?

> +
> +	if (banks_count =3D=3D 0)
> +		return 0;
> +
>  	if (!disable_pcr_integrity) {
>  		rc =3D tpm2_start_auth_session(chip);
>  		if (rc)
> @@ -257,9 +275,16 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_i=
dx,
>  		tpm_buf_append_auth(chip, &buf, 0, NULL, 0);
>  	}
> =20
> -	tpm_buf_append_u32(&buf, chip->nr_allocated_banks);
> +	tpm_buf_append_u32(&buf, banks_count);
> =20
> +	skip_mask =3D banks_skip_mask;
>  	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> +		const bool skip_bank =3D skip_mask & 1;
> +
> +		skip_mask >>=3D 1;
> +		if (skip_bank)
> +			continue;
> +

>  		tpm_buf_append_u16(&buf, digests[i].alg_id);
>  		tpm_buf_append(&buf, (const unsigned char *)&digests[i].digest,
>  			       chip->allocated_banks[i].digest_size);


