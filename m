Return-Path: <linux-integrity+bounces-5416-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D935A703C7
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A423A53E8
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3566F25A2A3;
	Tue, 25 Mar 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lATcgykU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6052561C3;
	Tue, 25 Mar 2025 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912840; cv=none; b=Rsdpvlz91z5zEsnSB6XsUhjC+XDGPgM78+NBjYcJEVg6lqlvUTI78UnM6BvzrOzaS4PM+nh3wLeLJq4Rxel+MRZ+7i5SKL5prq/K51G6w7CJ3fSyTWVpT3CPSg7q9wA1CDLOKVToUaEiO5MPWnjdY0sYFiycrLfwUXGsESfc9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912840; c=relaxed/simple;
	bh=px61XK7szBKX857OMYLA4R0ENNMTrBRzoxFZcLIPIZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jl0/YNt5g8J8oEN/EMtXo7QEGMyDP7f/YpH4VqUB/RNHofvNCpIouClraOc02cYl1iARZTobp2HKdrrkSEkPH+4rHLsL2W4ul22QRqsDKmtXToSJZus9aSmKu064cpH3/ci2net2HiCnQsYet6g9dtlCd5tYSiFNJCeQw2HmsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lATcgykU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9xFWZ011554;
	Tue, 25 Mar 2025 14:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=udBKi4
	S4n9gVHDosWR7cem1epd9mqTZMz3+N2lD2nUI=; b=lATcgykUYfvtzV9aQuv1i4
	1SSNQqVzM0OqqJXvONI5CBeq0FFLe7KZZb/NoKLQQIeg2rexWgxsSEZVHzIURzG0
	1GaiYUVuD/g6eLLkUBfFjEpQS0bfxeVl7rDpPHwG/M9wtV+Fh7ZDvkNNsmN7yy0I
	Nn+2pejshcYhKrw+n6QwLl82dA5c2r2YKloxDjs9m0IJ7PWARNFgD+dBtWiHZOMB
	ECO75fURglii/8vGtW5sSd0VQjW5h2HRNlSsFGu4zUFu/RCcoNhfidjotqjxDW58
	GXL3jWi2oJORMTTKsuZyEnkJ9NXrI2nP1ro9b1cS7j1nGefWRQvsiOhJqnokAYBw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpv6xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 14:27:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PEMkI4030531;
	Tue, 25 Mar 2025 14:26:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpv6xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 14:26:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PCxtZI020101;
	Tue, 25 Mar 2025 14:26:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnusnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 14:26:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PEQq9h23527924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 14:26:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8984258052;
	Tue, 25 Mar 2025 14:26:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90A7A58045;
	Tue, 25 Mar 2025 14:26:51 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.150.123])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 14:26:51 +0000 (GMT)
Message-ID: <0e7ca7094baf8f9968e72b43441745c420d61215.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 01/13] ima: don't expose runtime_measurements for
 unsupported hashes
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
Date: Tue, 25 Mar 2025 10:26:51 -0400
In-Reply-To: <20250323140911.226137-2-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-2-nstange@suse.de>
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
X-Proofpoint-ORIG-GUID: rcy9s3ku3MB0gbXpZhNZV5VCfoO6Uk_1
X-Proofpoint-GUID: YVBzbaEO41g3yHFLIxbe0WR6Ea7SHzWj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250102

On Sun, 2025-03-23 at 15:08 +0100, Nicolai Stange wrote:
> IMA creates one runtime_measurements_<hash-algo> sysfs file for every TPM
> bank + for SHA1 if not covered by any such. These differ only in that the
> template hash value for each record is of the file's associated algorithm
> each.
>=20
> The kernel does not necessarily support each hash algorithm associated
> with some TPM bank though -- the most common case probably being that the
> algorithm is not built-in, but provided as a module, if at all, and thus
> not available at IMA init time yet.

At least from an IMA perspective, the IMA Kconfig selects "CRYPTO_SHA1", ma=
king
it the only crypto hash algorithm required to be built into the kernel.
>=20
> If that happens to be the case, the behavior is a bit counter-intuitive:
> probably for historic reasons and to still extend the TPM bank with
> something, a record's template hash is filled with the padded SHA1 value.
> That is, it is perfectly possible that runtime_measurements_sha256 contai=
ns
> padded SHA1 template hashes if SHA-256 was unavailable at IMA init.

As you explained in "[RFC PATCH v2 09/13] ima: invalidate unsupported PCR b=
anks
only once", not extending the TPM bank:
  b.) is a security risk, because the bank would validate an empty measurem=
ent
list.

The solution was to extend a padded SHA1 digest, which could still be verif=
ied.
The question boils down to whether extending the TPM bank with a valid, may=
be
deprecated hash algo, is better than not extending it at all.  Was that the
right solution?  I believe it was at the time.  SHA1 was being deprecated f=
or
specific use cases, not all usecases.

So the question is what to do going forward.

>=20
> I would argue that it's likely that no existing userspace tool is relying
> on this fallback logic -- they either wouldn't consume the hash value fro=
m
> the measurement list directly but recreate it by themselves, as is requir=
ed
> for verification against PCRs, or, if they did, they would somehow assume=
 a
> hash algorithm and expect the hashes in the measurement list to be of tha=
t
> type. If of the latter kind, this could even lead to hard to debug
> verification failures. For example, from looking at keylime's current
> code, the verifier logic seems to assume that the template hashes found
> in the provided measurement list are of the configured 'ima_log_hash_alg'
> type. In particular, it does not check against padded SHA1 upon
> mismatch.

The downside, if none of the TPM bank hash algorithms are configured as bui=
ltin
in the kernel, is the lack of a measurement list.

True, not implementing the fallback is simpler, but it is their choice.

>=20
> That being said, there's also another dimension: currently IMA has a
> hard requirement on SHA-1 and subsequent patches in this series will
> attempt to get rid of that. If SHA-1 is not available at IMA init though,
> it would also mean that padded SHA-1 values cannot get filled in as a
> fallback for other unsupported algorithms. Substituting something like
> hard coded all-zeroes or all-ones would be dangerous, because some
> application or user scripts could perhaps (ab)use the template hashes fro=
m
> the exported measurement lists for some kind of fingerprinting scheme or
> so.

Agreed, using the open-writer/ToMToU integrity violation to indicate an
unsupported TPM bank would not be a good idea.

>=20
> In conclusion, I think it's best to not create the
> runtime_measurements_<hash-algo> sysfs files for hash algorithms not
> supported by the kernel. That way, applications expecting a certain
> hash algorithm for the measurement list and which are not able to handle
> the padded-SHA1 fallback scheme would fail with a clear indication on wha=
t
> the proem is. Furthermore, as digests for unsupported banks are not
> getting exposed to userspace anymore, we'll have all flexibility to
> set it to any value internally, including all-ones as will be needed in
> a subsequent patch when addressing PCR extend for unsupported banks.
>=20
> So, do not create runtime_measurements_<hash-algo> sysfs files for
> unsupported hash algorithms. Likewise for their ascii counterparts.
>=20
> Note that at this point, SHA-1 is still mandatory, and thus,
> runtime_measurements_sha1 as well as the "runtime_measurements" will
> remain there, even though the code has provisions already to skip their
> creation as well in case SHA-1 was unavailable.
>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>
>=20

If the purpose of this patch set is to actually remove IMA's dependency on =
a
working SHA-1, at some point the Kconfig "select CRYPTO_SHA1" needs to be
removed.  Otherwise the kernel will be built with SHA1 builtin
(CONFIG_CRYPTO_SHA1=3Dy).

If the purpose of this patch set is preparatory for eventually removing the=
 SHA1
dependency, then the cover letter and the patch descriptions should indicat=
e
that.

Assuming the latter, other than updating the patch description, the patch i=
s
fine.

Before posting the non-RFC version of this patch, please trim the patch
description.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_fs.c | 35 +++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index e4a79a9b2d58..a8df2fe5f4cb 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -454,6 +454,9 @@ static int __init create_securityfs_measurement_lists=
(void)
>  		return -ENOMEM;
> =20
>  	for (i =3D 0; i < securityfs_measurement_list_count; i++) {
> +		if (!ima_algo_array[i].tfm)
> +			continue;
> +
>  		algo =3D ima_algo_array[i].algo;
> =20
>  		sprintf(file_name, "ascii_runtime_measurements_%s",
> @@ -573,20 +576,26 @@ int __init ima_fs_init(void)
>  	if (ret !=3D 0)
>  		goto out;
> =20
> -	binary_runtime_measurements =3D
> -	    securityfs_create_symlink("binary_runtime_measurements", ima_dir,
> -				      "binary_runtime_measurements_sha1", NULL);
> -	if (IS_ERR(binary_runtime_measurements)) {
> -		ret =3D PTR_ERR(binary_runtime_measurements);
> -		goto out;
> -	}
> +	if (ima_algo_array[ima_sha1_idx].tfm) {
> +		binary_runtime_measurements =3D
> +		    securityfs_create_symlink("binary_runtime_measurements",
> +					      ima_dir,
> +					      "binary_runtime_measurements_sha1",
> +					      NULL);
> +		if (IS_ERR(binary_runtime_measurements)) {
> +			ret =3D PTR_ERR(binary_runtime_measurements);
> +			goto out;
> +		}
> =20
> -	ascii_runtime_measurements =3D
> -	    securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
> -				      "ascii_runtime_measurements_sha1", NULL);
> -	if (IS_ERR(ascii_runtime_measurements)) {
> -		ret =3D PTR_ERR(ascii_runtime_measurements);
> -		goto out;
> +		ascii_runtime_measurements =3D
> +		    securityfs_create_symlink("ascii_runtime_measurements",
> +					      ima_dir,
> +					      "ascii_runtime_measurements_sha1",
> +					      NULL);
> +		if (IS_ERR(ascii_runtime_measurements)) {
> +			ret =3D PTR_ERR(ascii_runtime_measurements);
> +			goto out;
> +		}
>  	}
> =20
>  	runtime_measurements_count =3D


