Return-Path: <linux-integrity+bounces-5441-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F833A71856
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1B3ACF08
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286F1EE01B;
	Wed, 26 Mar 2025 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s7dybfJi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216AD54652;
	Wed, 26 Mar 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998743; cv=none; b=OiYP4o53OQBAoV0KVkmjwyQJ/Geuv5JSESCjivpge15ovFQkCp8Yf78vN64HS7WY/WG/hNHTdqXVUj7JlEqtnD3udAP/NXvRAyHV+INVPwfZcpgCZW8rcw4AHDtuJpp0hGLaQSnT6QUy5Vk0/tYlqoexeCzL6hNKU8pJvHYGbzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998743; c=relaxed/simple;
	bh=ma1YQtfpq5iTg9o3RgA0apKG26XLDszEhzGUXxMWjhU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lYm7SPa7AOy4PPcms9DxCcwz3QHqU+KtP8qH2YJbOd9T/RdAqQzWGtcFBjfpFC3KObCvhZTFoD3FdInFqnJdNtSmo0MAxxR8nIhhyECnJohaBtDJG5mM3vajJnna4Buyus9eX4MYc0lvYdtkiMpiazKD2GQnJzv8uQUFtlqekQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s7dybfJi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q95m2m032164;
	Wed, 26 Mar 2025 14:18:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Orpqfl
	YvLR6yQCOVp0PAhUv6AcpZGe51LgipDVS9Yg8=; b=s7dybfJi6v55ye1eZXq0Fh
	fZBvGmumh8DG+xIN2ocriTqFOVrtF2rT8aSxfTs57BLPEGTv1xuHKKFNuQGhnepX
	EcPmDVlkSYucqg9dfi1CL7bQR0+0ow9y+fMxjF5Ch3EwJwjf4XglwkYT3IurVvWl
	2KDlm8hqINmv0PtdLgnUXTorQfIbqpvtskX6l1BMSpGhHkN5BdbaWU4Fb4oBrmCB
	J+RbliiiW6ARSdEXvVz21VArUmMewP6HqJ1OevCzH1p4M5ynz1/RYT7BOAymps/W
	vTswiKuGXmVuf03rzmGeO2f5GRWGQxfil7NVtWZr2zdIt+EiPCg5eJQOf5afqHzw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0m6jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:18:44 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52QE9tOc001099;
	Wed, 26 Mar 2025 14:18:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45m3q0m6jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:18:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QE0YxU030308;
	Wed, 26 Mar 2025 14:18:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htgv9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 14:18:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QEIgUg28639788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 14:18:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF4858053;
	Wed, 26 Mar 2025 14:18:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E88B358043;
	Wed, 26 Mar 2025 14:18:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.116.195])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 14:18:41 +0000 (GMT)
Message-ID: <a4bf93f0c64f4b329e022663afecf6edf0e22884.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Mar 2025 10:18:41 -0400
In-Reply-To: <877c4cqi76.fsf@>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-4-nstange@suse.de>
	 <e492df76d30b0b95f83b577499a25cdca2256407.camel@linux.ibm.com>
	 <877c4cqi76.fsf@>
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
X-Proofpoint-ORIG-GUID: zmLRHcCmztHMSy7QR3Fv_a6UW3CUEQLq
X-Proofpoint-GUID: tteIZopCLiEUccVcuGbhUcvUT64YJpwm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260085

On Wed, 2025-03-26 at 10:01 +0100, Nicolai Stange wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>=20
> > > diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity=
/ima/ima_crypto.c
> > > index 6f5696d999d0..a43080fb8edc 100644
> > > --- a/security/integrity/ima/ima_crypto.c
> > > +++ b/security/integrity/ima/ima_crypto.c
> > > @@ -625,26 +625,43 @@ int ima_calc_field_array_hash(struct ima_field_=
data *field_data,
> > >  	u16 alg_id;
> > >  	int rc, i;
> > > =20
> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
> > >  	rc =3D ima_calc_field_array_hash_tfm(field_data, entry, ima_sha1_id=
x);
> > >  	if (rc)
> > >  		return rc;
> > > =20
> > >  	entry->digests[ima_sha1_idx].alg_id =3D TPM_ALG_SHA1;
> > > +#endif
> > > =20
> > >  	for (i =3D 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
> > >  		if (i =3D=3D ima_sha1_idx)
> > >  			continue;
> > > +#endif
> > > =20
> > >  		if (i < NR_BANKS(ima_tpm_chip)) {
> > >  			alg_id =3D ima_tpm_chip->allocated_banks[i].alg_id;
> > >  			entry->digests[i].alg_id =3D alg_id;
> > >  		}
> > > =20
> > > -		/* for unmapped TPM algorithms digest is still a padded SHA1 */
> > > +		/*
> > > +		 * For unmapped TPM algorithms, the digest is still a
> > > +		 * padded SHA1 if backwards-compatibility fallback PCR
> > > +		 * extension is enabled. Otherwise fill with
> > > +		 * 0xfes. This is the value to invalidate unsupported
> > > +		 * PCR banks with. Also, a non-all-zeroes value serves
> > > +		 * as an indicator to kexec measurement restoration
> > > +		 * that the entry is not a violation and all its
> > > +		 * template digests need to get recomputed.
> > > +		 */
> > >  		if (!ima_algo_array[i].tfm) {
> > > +#if IS_ENABLED(CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND)
> > >  			memcpy(entry->digests[i].digest,
> > >  			       entry->digests[ima_sha1_idx].digest,
> > >  			       TPM_DIGEST_SIZE);
>=20
>                                ^
> That's been here before, just for the record for the below.

And it is correct.

>=20
> > > +#else
> > > +			memset(entry->digests[i].digest, 0xfe, TPM_DIGEST_SIZE);
> > > +#endif
> >=20
> > Using TPM_DIGEST_SIZE will result in a padded 0xfe value.
>=20
> Yes, but as the sysfs files for unsupported algos are gone, this will be
> used only for extending the PCR banks. tpm[12]_pcr_extend()
> (necessarily) truncate the digests to the correct size before sending
> them to the TPM.
>=20
> But if you prefer I can absolutely replace TPM_DIGEST_SIZE by
> hash_digest_size[ima_algo_array[i].algo].

Unlike violations, which are the full digest size, a padded sha1 is extende=
d
into the unsupported algos TPM banks.  I assume you'd want it to be the ful=
l
digest size like violations.

Mimi


