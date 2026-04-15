Return-Path: <linux-integrity+bounces-9186-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCSICM3y3mmIMwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9186-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:07:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B24823FFAD5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 04:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3DAB302573F
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 02:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D635D1DED40;
	Wed, 15 Apr 2026 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPCmw5AM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A34189B84;
	Wed, 15 Apr 2026 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218824; cv=none; b=j2Qoe7SaAWJJmrGO6ko8XmhRvmx8UnFl2tROqVSp4Gaik0qc6bpq+Z8XWL3a5AH6AnDo5mCFlmrVZgx66hQSO1fqc0xFpy71pmCW61hZSM/o8YQM1hf5oYF5uep/BjNkHkIsb2co1Td7xqJ/6hyk2mJyZXql88Lf/Y4MhWSeGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218824; c=relaxed/simple;
	bh=IecmHzOipkkkPmbPXCxpDi3g0fcHBkGoeFUSE+/Kqpo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tYVXP4M02bet5TiHTwGM5sSS+Uhd2HKhTVwS3xTCQylsohDTlRG+ICArCfrCsx/h1VSWaGVadDuLLhVhLasZEp61z9yOHScML2pkTThMzVQJgrszgirLRcIf9Qzc1bvH8HB8CVRkO0NVH7xl/LxUg640o47ZUwPV4tAuOEUsfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPCmw5AM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EE0VfE1842715;
	Wed, 15 Apr 2026 02:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a3UTx5
	FY7FvQXXPlDHpRItK2UqXqy676UsCPLyvlpDM=; b=aPCmw5AMCctpyiHj227Lw7
	3VQRkv17sWrN65mK4l00v1dfDzUmX5X1Nl29SO4cPVg0OktaT5h8bxmhHGdjshhp
	/BMkcpnlfEQvWtEbNA3hTD3V7pbZETGsP/OGGYQ6iVtXTudQT2BCgVqgh2vqC9In
	z1votaCxrlK+Kb/A0tnC2dg3+J3HuIvpEBQG+ra6P+zJLI8KVf257kLSY+fEx0Gf
	7OG8lOQRocxvIIJuLNrdmM/YRopZYdF5wi3AonFdUnmTEudaWpG1Nco9nhc83Gm/
	4ZzqJFuFPKRF5Tlp2zX0N4mutXWGPdPPnfQwKewygjsauZg0wUwN39Cjk93xdMVQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mnv92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:01:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63F1nVDI015164;
	Wed, 15 Apr 2026 02:01:51 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msmeum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 02:01:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F21oGG30933730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 02:01:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADC5958056;
	Wed, 15 Apr 2026 02:01:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24AA58054;
	Wed, 15 Apr 2026 02:01:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.163.24])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 02:01:49 +0000 (GMT)
Message-ID: <be3fdb81a322ab96e356e165b737c46f00c12cc3.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] integrity: Add support for sigv3 verification
 using ML-DSA keys
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, roberto.sassu@huawei.com,
        ebiggers@kernel.org
In-Reply-To: <20260408174154.139606-3-stefanb@linux.ibm.com>
References: <20260408174154.139606-1-stefanb@linux.ibm.com>
	 <20260408174154.139606-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:01:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAxNSBTYWx0ZWRfX0hrE4Mq5h1Hm
 RCymNg+CwhKh9AmapC7QSmy1ZC0GA5Gt1I1WMU8D3nnnG1l0k5iiDgHsX9ynKtfu0+hynSavZVz
 OueKKKVtNLft2woaKWhz/AGjCHAeA4AivGq+9QEVRTOK0zwW//lLPDS2xE6llJUVB1L3Us9abC0
 Z5+NZglbwmfDSJYzlOn8956I6BQ/P65G4gQ3/ZuR4yun3bn8ybkq+Fl0J+XV+uSxBiXGKiIIxJu
 76wH3eVz5fO74ZICn0jM5JHjUCXhpGpkjhwx1Bj3x2uBpJlpc9vHYi64JKj3DbMU1k6yvXMDnSY
 R6Yykg0sjdHL+eANGUG432tMPwkEIwaieCRn6MwAyDRdmu1AMTA2fiokN1WUEc0dLTRgO/eoybk
 1u4r1o3qsiWTCEknBr/B+09VCDof522hbq1YPgxIc+YfMR0McWqpNTQQxYpJspuCz3XY9AMaD8j
 xYARYe1pQ3bAjL3QpLQ==
X-Authority-Analysis: v=2.4 cv=eJ4jSnp1 c=1 sm=1 tr=0 ts=69def190 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=W27cmtjrIxJUHtwpsqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jZsvfvCXp9OFVTFFybtgJ88RG-FNO1Iw
X-Proofpoint-ORIG-GUID: jZsvfvCXp9OFVTFFybtgJ88RG-FNO1Iw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604150015
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9186-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B24823FFAD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-08 at 13:41 -0400, Stefan Berger wrote:
> Add support for sigv3 signature verification using ML-DSA in pure mode.
> When a sigv3 signature is verified, first check whether the key to use
> for verification is an ML-DSA key and therefore uses a hashless signature
> verification scheme. The hashless signature verification method uses the
> ima_file_id structure directly for signature verification rather than
> its digest.
>=20
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>=20

Thanks, Stefan.
> ---
> v2: Set hash_algo in public_key_signature to "none"
> ---
>  security/integrity/digsig_asymmetric.c | 84 ++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/=
digsig_asymmetric.c
> index e29ed73f15cd..c80cb2b117a6 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -190,17 +190,91 @@ static int calc_file_id_hash(enum evm_ima_xattr_typ=
e type,
>  	return rc;
>  }
> =20
> +/*

kernel-doc starts with "/**".

> + * asymmetric_verify_v3_hashless - Use hashless signature verification o=
n sigv3
> + * @key: The key to use for signature verification
> + * @pk: The associated public key
> + * @encoding: The encoding the key type uses
> + * @sig: The signature
> + * @siglen: The length of the xattr signature
> + * @algo: The hash algorithm
> + * @digest: The file digest
> + *
> + * Create an ima_file_id structure and use it for signature verification
> + * directly. This can be used for ML-DSA in pure mode for example.

Like the comments on 1/2, please add a comment here indicating that all cal=
lers
must verify the signature length (siglen) and the public key (pk) is not NU=
LL,
before calling asymmetric_verify_v3_hashless().  Also indicate that the cal=
ler
must free the key.

> + */
> +static int asymmetric_verify_v3_hashless(struct key *key,
> +					 const struct public_key *pk,
> +					 const char *encoding,
> +					 const char *sig, int siglen,
> +					 u8 algo,
> +					 const u8 *digest)
> +{
> +	struct signature_v2_hdr *hdr =3D (struct signature_v2_hdr *)sig;
> +	struct ima_file_id file_id =3D {
> +		.hash_type =3D hdr->type,
> +		.hash_algorithm =3D algo,
> +	};
> +	size_t digest_size =3D hash_digest_size[algo];

Defer initializing the digest_size and .m_size, below, until after checking=
 the
hash algorithm is valid.=20

> +	struct public_key_signature pks =3D {
> +		.m =3D (u8 *)&file_id,
> +		.m_size =3D sizeof(file_id) - (HASH_MAX_DIGESTSIZE - digest_size),
> +		.s =3D hdr->sig,
> +		.s_size =3D siglen - sizeof(*hdr),
> +		.pkey_algo =3D pk->pkey_algo,
> +		.hash_algo =3D "none",
> +		.encoding =3D encoding,
> +	};
> +	int ret;
> +
> +	if (hdr->type !=3D IMA_VERITY_DIGSIG &&
> +	    hdr->type !=3D EVM_IMA_XATTR_DIGSIG &&
> +	    hdr->type !=3D EVM_XATTR_PORTABLE_DIGSIG)
> +		return -EINVAL;
> +
> +	if (pks.s_size !=3D be16_to_cpu(hdr->sig_size))
> +		return -EBADMSG;
> +
> +	memcpy(file_id.hash, digest, digest_size);

First check the hash algorithm is valid, before using digest_size.

> +
> +	ret =3D verify_signature(key, &pks);
> +	pr_debug("%s() =3D %d\n", __func__, ret);
> +	return ret;
> +}
> +
>  int asymmetric_verify_v3(struct key *keyring, const char *sig, int sigle=
n,
>  			 const char *data, int datalen, u8 algo)
>  {
>  	struct signature_v2_hdr *hdr =3D (struct signature_v2_hdr *)sig;
>  	struct ima_max_digest_data hash;
> +	const struct public_key *pk;
> +	struct key *key;
>  	int rc;
> =20
> -	rc =3D calc_file_id_hash(hdr->type, algo, data, &hash);
> -	if (rc)
> -		return -EINVAL;
> +	if (siglen <=3D sizeof(*hdr))
> +		return -EBADMSG;
> +
> +	key =3D request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
> +	if (IS_ERR(key))
> +		return PTR_ERR(key);
> =20
> -	return asymmetric_verify(keyring, sig, siglen, hash.digest,
> -				 hash.hdr.length);
> +	pk =3D asymmetric_key_public_key(key);

Please add a test to check that 'pk' isn't null.

> +	if (!strncmp(pk->pkey_algo, "mldsa", 5)) {
> +		rc =3D asymmetric_verify_v3_hashless(key, pk, "raw",
> +						   sig, siglen, algo, data);
> +	} else {
> +		rc =3D calc_file_id_hash(hdr->type, algo, data, &hash);
> +		if (rc) {
> +			rc =3D -EINVAL;
> +			goto err_exit;
> +		}
> +
> +		rc =3D asymmetric_verify_common(key, pk, sig, siglen, hash.digest,
> +					      hash.hdr.length);
> +	}
> +
> +err_exit:

Normally a label named 'err*' would be preceded by a return.  Here, the lab=
el
"err_exit" is always called, not only when there is an error.  Please renam=
e the
label to something more appropriate - out, cleanup, etc.

> +	key_put(key);
> +
> +	return rc;
>  }

thanks,

Mimi

