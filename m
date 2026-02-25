Return-Path: <linux-integrity+bounces-8560-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FtDI1pdn2lRagQAu9opvQ
	(envelope-from <linux-integrity+bounces-8560-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 21:36:42 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F8D19D507
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 21:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FF56302B3BB
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B430F94B;
	Wed, 25 Feb 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KDGNuREf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03D530CDAE;
	Wed, 25 Feb 2026 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772051787; cv=none; b=eH4lg9b7ct7rRAV/wNdV/m/fISaP03gCc6vcD27wwZ2KcZ3vQmVxwpA9DCSZ5CplpnTtzH4o5+xoY7LqAzeFKByUJlLO/Qls/8Mq7qXoM5LKO+aUKGyebkPZW/iyE8z+VEYC4HHBYECGiUMUCFHrdELjCacV912K/Yq5ExQRur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772051787; c=relaxed/simple;
	bh=g5qIzCT0nTBgc6/TC3fQQrdqfgIhrq8T+JFySa0v8bY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=aFs/94Tlv4dRN0yVKbk7/8lZPBcm6WTRUuMZSHVuKT5ce2GNFKxCRE53+KBak9au+M1k24PstRVlNeupVHpXXOVWDRomTKoQfoKAH6Q+YcG6EuFbxFsjA3ySliHwJhtUAVxMpCF/jUDkQrRslO/VEjgJKn9hH3HR0MjYs4CK83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KDGNuREf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PGoNVa3239518;
	Wed, 25 Feb 2026 20:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Rkeog
	Psv6m/db4y7KsAK+AE4fu8iZX5Wp37u0no3/s=; b=KDGNuREfFUVlWSex93E838
	kL1I3K3cgJKdkxE7f52TRiMqjYPNH/MNizJNbngJX0IJ5DKa9SMgMzoTWNovMlEA
	QI6Wmz9x/huVsieWlUC4AarmJs8Yvn5EfBUlDavvrnwuDdryMzBHSEvAHeH9fgmY
	E+aMJqmYLP0ZEwfd7nhLeZdXqu7Keoxy5fOmm4ss6gF8sCD7u6uxahNppFiI2Pbq
	UeWlcIpERwZiqc0DYZv8Jsf6UtiwvO8KEZxykkMAxV0jsuN7YrnLoh89BOMA2F/4
	P1egGbYPtLP8zzSkW2DTCIE+C26/KSDr4CsbT67pbzNfN0HCQ3uQ+reF3IW+lW2w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24ghvjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:36:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PJiRq5001678;
	Wed, 25 Feb 2026 20:36:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n7ay3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:36:06 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PKa5in31523490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 20:36:05 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91C8E58063;
	Wed, 25 Feb 2026 20:36:05 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2F758055;
	Wed, 25 Feb 2026 20:36:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.41.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 20:36:03 +0000 (GMT)
Message-ID: <6808b1a8fcb014e6c7c18241d39155f5c12edc31.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Mimi Zohar <zohar@linux.ibm.com>
To: dima@arista.com, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Silvia Sisinni
 <silvia.sisinni@polito.it>,
        Enrico Bravi	 <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Feb 2026 15:36:03 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699f5d37 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=n2GhSfulAAAA:8
 a=mQ_sVfgH6UvzEiHddsUA:9 a=QEXdDO2ut3YA:10 a=9NqWk_7B-uqI6kdQTXIl:22
X-Proofpoint-GUID: uLhEVVQezr7ZCgiJujoy43ZwOcPqTjQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE5MyBTYWx0ZWRfX/m9ElrMkkStT
 VCe5dhSag/tZriaTltrNFRVeRt/qtj4xwF+wTy4p0SY7NgUpJCnyID8n1QEV9XqvShxYpwWyjmW
 i9Xn56ufo7v3XMrwNGFssQB/x1OUL3IJYu22V/qNxayuBGcskyZp1g/rGvoUrCzdQzXQnU3KJkF
 RoFHMf7wdpexr/qBRfvejGNvswGpDgxSnahtMaK9Nto5Sm/2qrlY9iGNoSSJOLG/CGM2b0TJ1pO
 tr73rFaWBKQRkB7KeewlSAKytQRrp4h9AD4zBrKQDbA97wJVwUQMHCYhLgeh0PBqJu8vVj+QdaU
 mm1jzE8awSoaM27IK1QAr03JLr3/f36TeVMtROObfzgCgFeWvd8GBTqChJxfDurjzxEjI/wdHBS
 706uIDhKf/Sq7xG45PQuMpcvCeWNTGz5x+0rnH8pwWETt9qKFMg+qXudWreumtbtmD3hCA6Ypp8
 vahTij9fQsyhZEHV6LQ==
X-Proofpoint-ORIG-GUID: 8yDyPnYboAuMDzKrEdV0Kry9ZVWk7Opj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250193
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8560-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[arista.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 39F8D19D507
X-Rspamd-Action: no action

On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
>=20
> ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> are places relying on the algorithm to be valid because it is accessed
> by hash_algo_name[].

If the TPM algorithm is not supported by whom? the kernel?  HASH_ALGO__LAST=
 is
defined in linux/hash_info.h.  If the crypto algorithm is not supported by =
the
kernel, then the kernel won't be able to calculate the hash to extend the T=
PM.

> @@ -404,16 +398,24 @@ static int __init create_securityfs_measurement_lis=
ts(void)
>  		char file_name[NAME_MAX + 1];
>  		struct dentry *dentry;
> =20
> -		sprintf(file_name, "ascii_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);
> +		else
> +			sprintf(file_name, "ascii_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_ascii_measurements_ops);
>  		if (IS_ERR(dentry))
>  			return PTR_ERR(dentry);
> =20
> -		sprintf(file_name, "binary_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);

There's no point in creating either of the securityfs files if the kernel
doesn't support the hash algorithm.

Mimi


> +		else
> +			sprintf(file_name, "binary_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_measurements_ops);


