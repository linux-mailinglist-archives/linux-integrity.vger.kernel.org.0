Return-Path: <linux-integrity+bounces-5411-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A560A6DDBE
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013A11886DE5
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3CC25EF87;
	Mon, 24 Mar 2025 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e3LHmKZB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740E25C71F;
	Mon, 24 Mar 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828779; cv=none; b=nc1Kt5BFJ/JdQyCzT+jDXABEWrhp5QFwSz4fvud5BUMfoECMl5e/CwyVpbc68k0/Yh4A8PxES5XY2K5ymGX+4yIXH7B0SFIYrajsGqkEqGzDZTPxLTfuASf7Qc8dBGTM+7/gyLqGFRrYPaDnrCiD+PKAE4E/w47jjZ84N4RZea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828779; c=relaxed/simple;
	bh=V98jmacgU4Qx2t66GEhPxqu64+nrMQkE97BJHxv8TCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YD4x8gflTxWDFs/r9UBhQ8RVRDYTa/o7fNe0mBDtpKtvEInvL33PTvIGwkSOxJF7Pq05YYxArCxrey9bol8xpyy1PzfNOBRYtbABhSRAOm0NKFV3NfDlcsJJYWjvJtSVHl3mY3avyoOAl9TeKC3rtWe0XiaLlKaDhg1fVw8tp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e3LHmKZB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OAF4Kn016686;
	Mon, 24 Mar 2025 15:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p+CxRx
	XsCtc1i1Pdxoiq3pOu/G/+Ubjb/YFFS5D4UCM=; b=e3LHmKZBVJLR58OF7dxwWd
	B8Ur14kdSsuRGn/e6MGnguUycKOMyesjGUPaQhvxPcqcV6xOQxjqJhGA66oVWeFM
	SXJuaKIZ6hFzueFEBpKpiyinXBCxECAkSU9gULDscSi20aqePM6/dAC+UPdtlNhf
	cbTysEfO4j0n6e7irE/xWxDjtEacnglEgoZcgz7xqQBssr+d0X6EF6Dsgr6dljU2
	n6WqbvF5hRHH2L+38t/8TynJuxumvMRW8KDW4i7A7Ti1H/9cuInACqqwLACWx/3K
	KGmAQkihyKp0ACrar0TrU7qhRrSn+n2ghqrHFIq/PjeQ2pchIUoMyJz2nhZ5eNCQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwvqy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:05:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52OEvYmO007876;
	Mon, 24 Mar 2025 15:05:57 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwvqxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:05:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ODSeeA005838;
	Mon, 24 Mar 2025 15:05:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja826d57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:05:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OF5tqO22413896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 15:05:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB7558056;
	Mon, 24 Mar 2025 15:05:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988D35805E;
	Mon, 24 Mar 2025 15:05:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.8.252])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 15:05:54 +0000 (GMT)
Message-ID: <e492df76d30b0b95f83b577499a25cdca2256407.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
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
Date: Mon, 24 Mar 2025 11:05:54 -0400
In-Reply-To: <20250323140911.226137-4-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-4-nstange@suse.de>
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
X-Proofpoint-ORIG-GUID: MIlsvbPN2kVUKJa8lOzZivNueMoAtRkV
X-Proofpoint-GUID: GyAgjLgQGvQOOylWqY1vaTlzbdvleXLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=978 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240108


> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 6f5696d999d0..a43080fb8edc 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -625,26 +625,43 @@ int ima_calc_field_array_hash(struct ima_field_data=
 *field_data,
>  	u16 alg_id;
>  	int rc, i;
> =20
> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>  	rc =3D ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_idx);
>  	if (rc)
>  		return rc;
> =20
>  	entry->digests[ima_sha1_idx].alg_id =3D TPM_ALG_SHA1;
> +#endif
> =20
>  	for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>  		if (i =3D=3D ima_sha1_idx)
>  			continue;
> +#endif
> =20
>  		if (i < NR_BANKS(ima_tpm_chip)) {
>  			alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
>  			entry->digests[i].alg_id =3D alg_id;
>  		}
> =20
> -		/* for unmapped TPM algorithms digest is still a padded SHA1 */
> +		/*
> +		 * For unmapped TPM algorithms, the digest is still a
> +		 * padded SHA1 if backwards-compatibility fallback PCR
> +		 * extension is enabled. Otherwise fill with
> +		 * 0xfes. This is the value to invalidate unsupported
> +		 * PCR banks with. Also, a non-all-zeroes value serves
> +		 * as an indicator to kexec measurement restoration
> +		 * that the entry is not a violation and all its
> +		 * template digests need to get recomputed.
> +		 */
>  		if (!ima_algo_array[i].tfm) {
> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>  			memcpy(entry->digests[i].digest,
>  			       entry->digests[ima_sha1_idx].digest,
>  			       TPM_DIGEST_SIZE);
> +#else
> +			memset(entry->digests[i].digest, 0xfe, TPM_DIGEST_SIZE);
> +#endif

Using TPM_DIGEST_SIZE will result in a padded 0xfe value.

>  			continue;
>  		}
> =20


