Return-Path: <linux-integrity+bounces-5304-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD7A665BA
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 02:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF771892BFE
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 01:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF918787F;
	Tue, 18 Mar 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VdSsRA+M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC115B102;
	Tue, 18 Mar 2025 01:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262422; cv=none; b=dtVP+kEMq/EIoRJ/JoVlU2+2v4L5Vgsd0s05HuMxfW1K4pUgZL65D6cUEUsnOWnDTZ1V5vJX5bQsKzeMD9qgUI8KdvjXpz58lNHXhaYelEFbhkpHcaj9eSkt8L2MXnFLWtFZ+1YFWbVrKi7+k+tW/+CcdsljMK4lmhBLG4eGUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262422; c=relaxed/simple;
	bh=R9EEfnYlffIYGJtoXVUNWQn0ZaXZu9SRhv6dgihrTt4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jgv7w0ak6jxpQgJNru3v7NK5gvIx7DlPCJNK5OdyBgg/wHXNBl+FojsEOJkkAy+S8c1wLdE6J4JjA5KNlAb/SIlkWYgTKAdnBG5NBic995Vmeulsg9dQPF7SFOBCIUaOZ91boJqw+amZHfQ02Nbpuqro+O+M5dK7DOXSo4Qs65s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VdSsRA+M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKpoRG011325;
	Tue, 18 Mar 2025 01:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BwGbrp
	/WNkDHxh2JEjTTmTXernwlX1ihlfYB/AQC2/o=; b=VdSsRA+M/WgfvFeLt0qnjY
	iZFCiBQieQEGn43gVCKy22IKv+KEhmDKTKoeT09LH6y2FV79+ELugHIvGw7dd/ZI
	/z+Cn48wxe+VBnSpCl6dl98plTAZTWY6sLiSwAeHua+P0snoFvgJ465dIcS7JU5o
	a8tKEwi7Yti2kDBRlfw9bK90X76oi5/982z72Tx8FaD/Kdf8hCyvaB/sahMxVtR8
	nYL40giWYn0poHfb+VlwMrdYNwfOQfr/SXqFlKyaYhT7llqVp4Vqb1BOOMYsZ2kd
	FNWhTgV0Fz01Um69JJd/Ho7tI63G9GUU6bp1fkF+KuT1Y499Xbui7ebiQrJinWpQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55rwkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:46:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52I1kkeo019642;
	Tue, 18 Mar 2025 01:46:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45eu55rwkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:46:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52I15DYZ005819;
	Tue, 18 Mar 2025 01:46:45 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dpk28yde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 01:46:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52I1kjht3998450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 01:46:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23DEC5803F;
	Tue, 18 Mar 2025 01:46:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51DF85804E;
	Tue, 18 Mar 2025 01:46:44 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.183.137])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Mar 2025 01:46:44 +0000 (GMT)
Message-ID: <34ebd15aae07402d19279ef4286197112c4afc01.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v1 6/7] ima: invalidate unsupported PCR banks once
 at first use
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Mar 2025 21:46:43 -0400
In-Reply-To: <20250313173339.3815589-7-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
	 <20250313173339.3815589-7-nstange@suse.de>
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
X-Proofpoint-ORIG-GUID: gR4TlNVLFw80O4XsAB1uLsbp8lGX4EWO
X-Proofpoint-GUID: NFFnuS3arwztWepHB4gIN072QLAJRCtD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180009

On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
> Normally IMA would extend a template hash of each bank's associated
> algorithm into a PCR. However, if a bank's hash algorithm is unavailable
> to the kernel at IMA init time, it would fallback to extending padded
> SHA1 hashes instead.
>=20
> That is, if e.g. SHA-256 was missing at IMA init, it would extend padded
> SHA1 template hashes into a PCR's SHA-256 bank.
>=20
> The ima_measurement command (marked as experimental) from ima-evm-utils
> would accordingly try both variants when attempting to verify a measureme=
nt
> list against PCRs. keylime OTOH doesn't seem to -- it expects the templat=
e
> hash type to match the PCR bank algorithm. I would argue that for the
> latter case, the fallback scheme could potentially cause hard to debug
> verification failures.
>=20
> There's another problem with the fallback scheme: right now, SHA-1
> availability is a hard requirement for IMA, and it would be good for a
> number of reasons to get rid of that. However, if SHA-1 is not available =
to
> the kernel, it can hardly provide padded SHA-1 template hashes for PCR
> banks with unsupported algos.
>=20
> There are several more or less reasonable alternatives possible, among
> them are:
> a.) Instead of padded SHA-1, use padded/truncated ima_hash template
>     hashes.
> b.) Record every event as a violation, i.e. extend unsupported banks
>     with 0xffs.
> c.) Don't extend unsupported banks at all.
> d.) Invalidate unsupported banks only once (e.g. with 0xffs) at first
>     use.
>=20
> a.) would make verification from tools like ima_measurement nearly
>     impossible, as it would have to guess or somehow determine ima_hash.
> b.) would still put an significant and unnecessary burden on tools like
>     ima_measurement, because it would then have to exercise three
>     possible variants on the measurement list:
>     - the template hash matches the bank algorithm,
>     - the template hash is padded SHA-1,
>     - the template hash is all-ones.
> c.) is a security risk, because the bank would validate an empty
>     measurement list.
>=20
> AFAICS, d.) is the best option to proceed, as it allows for determining
> from the PCR bank value in O(1) whether the bank had been maintained by
> IMA or not and also, it would not validate any measurement list (except
> one with a single violation entry at the head).

Hi Nicolai,

What a pleasure reviewing your patch set.  Nicely organized.  Well written =
patch
descriptions.

Currently with the SHA1 hash algorithm, whether it is being extended into t=
he
TPM or not, the measurement list is complete.  Relying on the ima_hash in t=
he
current kernel and the subsequent kexec'ed kernel should be fine, assuming =
if
they're different hash algorithms both TPM banks are enabled.  Otherwise, t=
he
measurement lists will be incomplete.

This patch set introduces a new definition of integrity violation. Previous=
ly it
was limited to open-writers and ToMToU integrity violations.  Now it could =
also
mean no kernel hash algorithm available.  Unfortunately some attestation
services simply ignore integrity violations.

Mimi

>=20
> So implement d.). As it potentially breaks existing userspace, i.e.
> the current implementation of ima_measurement, put it behind a Kconfig
> option, "IMA_COMPAT_FALLBACK_TPM_EXTEND". If set to "y", the original
> behavior of extending with padded SHA-1 is retained. Otherwise the new
> scheme to invalidate unsupported PCR banks once upon their first extensio=
n
> from IMA is implemented instead. As ima_measurement is marked as
> experimental and I find it unlikely that other existing tools depend on
> the padded SHA-1 fallback scheme, make the IMA_COMPAT_FALLBACK_TPM_EXTEND
> Kconfig option default to "n".
>=20
> For IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn,
> - make ima_calc_field_array_hash() to fill the digests corresponding to
>   banks with unsupported hash algorithms with 0xffs,
> - make ima_pcr_extend() to extend these into the unsupported PCR banks on=
ly
>   upon the PCR's first usage, skip them on subsequent updates and
> - let ima_init_ima_crypto() help it with that by populating the new
>   ima_unsupported_tpm_banks_mask with one bit set for each bank with
>   an unavailable hash algorithm at init.
>=20
> [1] https://github.com/linux-integrity/ima-evm-utils
>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  security/integrity/ima/Kconfig      | 14 ++++++++++++++
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_crypto.c | 27 +++++++++++++++++++++++++--
>  security/integrity/ima/ima_queue.c  | 20 +++++++++++++++++++-
>  4 files changed, 59 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 475c32615006..d6ba392c0b37 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -122,6 +122,20 @@ config IMA_DEFAULT_HASH
>  	default "wp512" if IMA_DEFAULT_HASH_WP512
>  	default "sm3" if IMA_DEFAULT_HASH_SM3
> =20
> +config IMA_COMPAT_FALLBACK_TPM_EXTEND
> +	bool
> +	default n
> +	help
> +	  In case a TPM PCR hash algorithm is not supported by the kernel,
> +	  retain the old behaviour to extend the bank with padded SHA1 template
> +	  digests.
> +
> +	  If Y, IMA will be unavailable when SHA1 is missing from the kernel.
> +	  If N, existing tools may fail to verify IMA measurement lists against
> +	  TPM PCR banks corresponding to hashes not supported by the kernel.
> +
> +	  If unsure, say N.
> +
>  config IMA_WRITE_POLICY
>  	bool "Enable multiple writes to the IMA policy"
>  	default n
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f99b1f81b35c..58e9a81b3f96 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -62,6 +62,7 @@ extern int ima_sha1_idx __ro_after_init;
>  extern int ima_hash_algo_idx __ro_after_init;
>  extern int ima_extra_slots __ro_after_init;
>  extern struct ima_algo_desc *ima_algo_array __ro_after_init;
> +extern unsigned long ima_unsupported_tpm_banks_mask __ro_after_init;
> =20
>  extern unsigned long ima_extended_pcrs_mask;
> =20
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 6f5696d999d0..118ea15d737b 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -67,6 +67,8 @@ int ima_extra_slots __ro_after_init;
> =20
>  struct ima_algo_desc *ima_algo_array __ro_after_init;
> =20
> +unsigned long ima_unsupported_tpm_banks_mask __ro_after_init;
> +
>  static int __init ima_init_ima_crypto(void)
>  {
>  	long rc;
> @@ -150,8 +152,10 @@ int __init ima_init_crypto(void)
>  		ima_algo_array[i].algo =3D algo;
> =20
>  		/* unknown TPM algorithm */
> -		if (algo =3D=3D HASH_ALGO__LAST)
> +		if (algo =3D=3D HASH_ALGO__LAST) {
> +			ima_unsupported_tpm_banks_mask |=3D BIT(i);
>  			continue;
> +		}
> =20
>  		if (algo =3D=3D ima_hash_algo) {
>  			ima_algo_array[i].tfm =3D ima_shash_tfm;
> @@ -167,6 +171,7 @@ int __init ima_init_crypto(void)
>  			}
> =20
>  			ima_algo_array[i].tfm =3D NULL;
> +			ima_unsupported_tpm_banks_mask |=3D BIT(i);
>  		}
>  	}
> =20
> @@ -625,26 +630,44 @@ int ima_calc_field_array_hash(struct ima_field_data=
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
> +		 * extension is enabled.  Otherwise fill with
> +		 * 0xffs. This is the value to invalidate unsupported
> +		 * PCR banks with once at first PCR use. Also, a
> +		 * non-all-zeroes value serves as an indicator to
> +		 * kexec measurement restoration that the entry is not
> +		 * a violation and all its template digests need to
> +		 * get recomputed.
> +		 */
>  		if (!ima_algo_array[i].tfm) {
> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>  			memcpy(entry->digests[i].digest,
>  			       entry->digests[ima_sha1_idx].digest,
>  			       TPM_DIGEST_SIZE);
> +#else
> +			memset(entry->digests[i].digest, 0xff, TPM_DIGEST_SIZE);
> +#endif
>  			continue;
>  		}
> =20
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index f00ba2222c34..4db6c4be58fc 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -150,11 +150,27 @@ unsigned long ima_get_binary_runtime_size(void)
>  static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
>  {
>  	int result =3D 0;
> +	unsigned long tpm_banks_skip_mask;
> =20
>  	if (!ima_tpm_chip)
>  		return result;
> =20
> -	result =3D tpm_pcr_extend(ima_tpm_chip, pcr, digests_arg);
> +#if !IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
> +	tpm_banks_skip_mask =3D ima_unsupported_tpm_banks_mask;
> +	if (!(ima_extended_pcrs_mask & BIT(pcr))) {
> +		/*
> +		 * Invalidate unsupported banks once upon a PCR's
> +		 * first usage. Note that the digests[] entries for
> +		 * unsupported algorithms have been filled with 0xffs.
> +		 */
> +		tpm_banks_skip_mask =3D 0;
> +	}
> +#else
> +	tpm_banks_skip_mask =3D 0;
> +#endif
> +
> +	result =3D tpm_pcr_extend_sel(ima_tpm_chip, pcr, digests_arg,
> +				    tpm_banks_skip_mask);
>  	if (result !=3D 0)
>  		pr_err("Error Communicating to TPM chip, result: %d\n", result);
>  	ima_extended_pcrs_mask |=3D BIT(pcr);
> @@ -280,9 +296,11 @@ int __init ima_init_digests(void)
>  		digest_size =3D ima_tpm_chip->allocated_banks[i].digest_size;
>  		crypto_id =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> =20
> +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
>  		/* for unmapped TPM algorithms digest is still a padded SHA1 */
>  		if (crypto_id =3D=3D HASH_ALGO__LAST)
>  			digest_size =3D SHA1_DIGEST_SIZE;
> +#endif
> =20
>  		memset(digests[i].digest, 0xff, digest_size);
>  	}


