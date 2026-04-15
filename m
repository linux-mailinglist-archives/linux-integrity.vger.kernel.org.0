Return-Path: <linux-integrity+bounces-9185-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBSDKEjx3mkzMwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9185-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:00:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0161B3FFA4A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 669B9303CC32
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7829D288;
	Wed, 15 Apr 2026 02:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jZtE1ge8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DF279358;
	Wed, 15 Apr 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218437; cv=none; b=RwgqmcxpJsbuwv7+ZMuVsxgbSRC1qPUxsuZoVUN9auXe2ng6xmKC2AJxKGvuljrym9atU4ncW9F0FF0mrwqXCtlwQISJ3WQ+GDUFeBG2Yu+rAE2Wm5yJpmuKwsGBJ4bb8iae9o0fWZffENxM+sKVSAO8mX3mQ6/ffJrRq8y3qrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218437; c=relaxed/simple;
	bh=oHq8bR5jGxaAXpTJxVSPBb4WEcz7HXZGZrbe7P9vXX8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=loJKoM47M1sEi5QGjHl+YTGW0QL7fkH1SpCk56i4SWZvbco/ynZNSfE44U/JiFXdjc0EGMvYlXAPI9NsGFSiiYbhwUe8yIeRMCDaxJoozUUyZf9SXWFpSPc0xFb92N0xi3X7I9Rd1ttBtoZzyfS+1MzFOT4td8YD44jn8xKDd28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jZtE1ge8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EEFPaF1833337;
	Wed, 15 Apr 2026 02:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5MOw7R
	NjoSA9fGBMespGb+Mu6dqzUTGE/TtZB5T57dM=; b=jZtE1ge8Z3Syvl8nE18YMk
	2JaAsQDo4YADNu84nJO3Od25hZk2M/9pxuRyYPSNDkhNq4Eid4+nipcml2M04v6G
	6JdLB9DyLkO8a4u/yj2952QFOJ6SkzUQhSjzC7x9Cxh7MMS5jK5sdGaYlMTXiTyE
	e7+rgpQ6kEwcWjS7L5TU/NRaExSkU0lX/Pkuv7B7WTk0jtboKuXEFNCSCdKbz4et
	kfTjH4z5lKeMJAkXEGHQ82HX10uNjwT3O162kUxfcO9XFElme3FVfjhRDDaK7ahv
	ptt1VvHHrIvEDF5I2U1qF677FdnQQBTDDmEWpfXOpMCM48M01ZfeC91CHaplTDJg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rdvva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:00:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63EM2TIc004180;
	Wed, 15 Apr 2026 02:00:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24kc7a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:00:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F20FPo24642188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 02:00:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D5C5803F;
	Wed, 15 Apr 2026 02:00:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C4235805A;
	Wed, 15 Apr 2026 02:00:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.163.24])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 02:00:14 +0000 (GMT)
Message-ID: <0375ccecdfb77286dff7f40af5ddbd20f7d6e0fa.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] integrity: Refactor asymmetric_verify for
 reusability
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        ebiggers@kernel.org
In-Reply-To: <20260408174154.139606-2-stefanb@linux.ibm.com>
References: <20260408174154.139606-1-stefanb@linux.ibm.com>
	 <20260408174154.139606-2-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:00:14 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAxNSBTYWx0ZWRfX4+5IVEwufySr
 pi2dxlKhUX8r66FPvNAby9hHjwEF9AmYQbHNtPXQI+DoVSam6xN78gpsGdS27mmHOfu3IBXDqzQ
 zRjdh+r2ed60xi5OaHQ8v1Ad4v8NCZ461QUMCvRd3mQkiR2l2riuvYASZerqqYy+/QZvsp09KBe
 3cAe+M5gyixBgsZrT+w45HECgVca15sGvnkDKuTUo1eVi8WxXSCQ/pZ56z/X8jKyz9qRJgYIdmr
 5q5XQ+eX25SgJwasfzLHf3g8uIxyy7M61kIePpGOr2p9tlnOQih7NGVgzzsB+YUyjVlGTzZYL+C
 PYKEHHEna+Hf6gtGDZu9wlyQS2/HBaVoosVFq6p1GZMS86Yr1VbtqB68pG0HDBDV5zTCllgvnQF
 g2UgOlXpbRuPBnQudfye3LGaBfR37XivP39z82l1njmr9Pci2OJ9f0gHH9pyWvkbygbPBKTdZCj
 mLzJsht8vFPfi0rhkJA==
X-Proofpoint-ORIG-GUID: chkpS2LAsVyOdnl0sFBJobDkd1WzObAc
X-Proofpoint-GUID: chkpS2LAsVyOdnl0sFBJobDkd1WzObAc
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69def131 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=u2mOHqZjYNy73RYEmlAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150015
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9185-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0161B3FFA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-08 at 13:41 -0400, Stefan Berger wrote:
> Refactor asymmetric_verify for reusability. Have it call
> asymmetric_verify_common with the signature verification key and the
> public_key structure as parameters. sigv3 support for ML-DSA will need to
> check the public key type first to decide how to do the signature
> verification and therefore will have these parameters available for
> calling asymmetric_verify_common.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks, Stefan.

> ---
>  security/integrity/digsig_asymmetric.c | 42 +++++++++++++++++---------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/=
digsig_asymmetric.c
> index 6e68ec3becbd..e29ed73f15cd 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -79,18 +79,15 @@ static struct key *request_asymmetric_key(struct key =
*keyring, uint32_t keyid)
>  	return key;
>  }
> =20
> -int asymmetric_verify(struct key *keyring, const char *sig,
> -		      int siglen, const char *data, int datalen)
> +static int asymmetric_verify_common(const struct key *key,
> +				    const struct public_key *pk,
> +				    const char *sig, int siglen,
> +				    const char *data, int datalen)
>  {
> -	struct public_key_signature pks;
>  	struct signature_v2_hdr *hdr =3D (struct signature_v2_hdr *)sig;
> -	const struct public_key *pk;
> -	struct key *key;
> +	struct public_key_signature pks;
>  	int ret;
> =20
> -	if (siglen <=3D sizeof(*hdr))
> -		return -EBADMSG;
> -
>  	siglen -=3D sizeof(*hdr);

Normally kernel-doc is unnecessary for static functions.  Here, however, si=
nce=20
only the caller verifies the signature length, there should be a kernel-doc
function definition.  It should indicate that all callers must verify the
signature length (siglen) and that the public key (pk) is not NULL, before
calling asymmetric_verify_common().

> =20
>  	if (siglen !=3D be16_to_cpu(hdr->sig_size))
> @@ -99,15 +96,10 @@ int asymmetric_verify(struct key *keyring, const char=
 *sig,
>  	if (hdr->hash_algo >=3D HASH_ALGO__LAST)
>  		return -ENOPKG;
> =20
> -	key =3D request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
> -	if (IS_ERR(key))
> -		return PTR_ERR(key);
> -
>  	memset(&pks, 0, sizeof(pks));
> =20
>  	pks.hash_algo =3D hash_algo_name[hdr->hash_algo];
> =20
> -	pk =3D asymmetric_key_public_key(key);
>  	pks.pkey_algo =3D pk->pkey_algo;
>  	if (!strcmp(pk->pkey_algo, "rsa")) {
>  		pks.encoding =3D "pkcs1";
> @@ -127,11 +119,33 @@ int asymmetric_verify(struct key *keyring, const ch=
ar *sig,
>  	pks.s_size =3D siglen;
>  	ret =3D verify_signature(key, &pks);
>  out:
> -	key_put(key);

The kernel-doc function definition should also indicate that the caller mus=
t
free the key.

>  	pr_debug("%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> =20
> +int asymmetric_verify(struct key *keyring, const char *sig,
> +		      int siglen, const char *data, int datalen)
> +{
> +	struct signature_v2_hdr *hdr =3D (struct signature_v2_hdr *)sig;
> +	const struct public_key *pk;
> +	struct key *key;
> +	int ret;
> +
> +	if (siglen <=3D sizeof(*hdr))
> +		return -EBADMSG;
> +
> +	key =3D request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);
> +	pk =3D asymmetric_key_public_key(key);

Please add a test here making sure pk is not null.

thanks,

Mimi

> +
> +	ret =3D asymmetric_verify_common(key, pk, sig, siglen, data, datalen);
> +
> +	key_put(key);
> +
> +	return ret;
> +}
> +
>  /*
>   * calc_file_id_hash - calculate the hash of the ima_file_id struct data
>   * @type: xattr type [enum evm_ima_xattr_type]

