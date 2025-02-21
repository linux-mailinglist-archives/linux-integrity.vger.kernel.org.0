Return-Path: <linux-integrity+bounces-4963-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A1A3F93E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F236164C0C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 15:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B291D5CCC;
	Fri, 21 Feb 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZGoS3Cd0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3D71DD9AB;
	Fri, 21 Feb 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152571; cv=none; b=T/vXs4TDlBFIlD/GqrnulEwnxdczPEpKq7JU0stfnW13HjnXFX6jIujqaa7szWt8q9TXhlR3aTkp/0sJJvLX2Sb0fxlNYLPAjobFCoyxBuZOpGBgb2/Fx4tgnlvG6wwIkciL/WPxXPGb+qfSitvCeDyPQkhPOdCy51nzMXS9/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152571; c=relaxed/simple;
	bh=3oGfUaAJqfdFFYmlKDmTZtZ50G7yUU86f5/6w5g2HrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XR7OZfbKlXZmfw3PU0BimFoqBWnFDUcETryHw9YSrB990UiN3dxqZtLCzS7dgn7yMt9//sMNtaI6Mjw8o9mOMcJEbueLt6dnwwoIE2jUBvBMLUNr2s29ggFI3u0ibInch19xZQmBJKmJXZWj7P+iTgidY6Jj5q9EqTiRd0QOyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZGoS3Cd0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LAu7O9029669;
	Fri, 21 Feb 2025 15:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KSlXcQ
	u4bYwd9QVRA4LMcePl4d8VQOxalou03xKgF+4=; b=ZGoS3Cd0dXzWb/TjJkZBvG
	RZvPkT10j6+s/4pk6XdYBzFUfLXE58cEjEgxUHHLx9LRf/1rPuNfVj9yj2FbPS9E
	itruWfagpLsn4Jt5sQwvNRd1zK7O1MFg4E56lsWetS7TjF6NDgXRBP9JcH2YPkLD
	FXcHSKFIPljDXwUeQtoRW4V6KqRgSKGfnjc6SKCmCKSGJK+7e6FygA0DyYfv7uX4
	6IjI2S7eJeITRR9q9Od6194SXMuPbP3IAe3CDhW3KRLIylOo1GUTdtrhJZNjUVQO
	7z736y/dcIZ+ZBb4+FZuVOBDeCpERdjwVX2bsmX2hVa1o6Kl0Zwmy0kzmo4/4PNw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xfj9uv07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:42:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFWmDq009721;
	Fri, 21 Feb 2025 15:42:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03ygs12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 15:42:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LFgGFU16843430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 15:42:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60E9A58052;
	Fri, 21 Feb 2025 15:42:16 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B0E95805E;
	Fri, 21 Feb 2025 15:42:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.157.102])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 15:42:15 +0000 (GMT)
Message-ID: <1883119129dbeeabad1f5239f042a7b920feef0f.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Fri, 21 Feb 2025 10:41:59 -0500
In-Reply-To: <20250218225502.747963-4-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-4-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: QCsQPTOODc6JC0-pUekND63em9iiktCZ
X-Proofpoint-GUID: QCsQPTOODc6JC0-pUekND63em9iiktCZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210111

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> kexec_calculate_store_digests() calculates and stores the digest of the
> segment at kexec_file_load syscall where the IMA segment is also
> allocated.=C2=A0 With this series, the IMA segment will be updated with t=
he
> measurement log at kexec execute stage when soft reboot is initiated.=20
> Therefore, it may fail digest verification in verify_sha256_digest()=20
> after kexec soft reboot into the new kernel. Therefore, the digest=20
> calculation/verification of the IMA segment needs to be skipped.
>=20
> Skip the calculating and storing digest of the IMA segment in
> kexec_calculate_store_digests() so that it is not added to the
> 'purgatory_sha_regions'.
>=20
> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
> no change is needed in verify_sha256_digest() in this context.
>=20
> With this change, the IMA segment is not included in the digest
> calculation, storage, and verification.

Basically you're saying because the hash verification will fail, don't incl=
ude
the IMA buffer.  What's missing is the reason for not caring whether the IM=
A
hash is included or not.

I understand this is the best we can do without making some major kexec cha=
nges.

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

After updating the patch description,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0include/linux/kexec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0kernel/kexec_file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++++++++++++++++++++++
> =C2=A0security/integrity/ima/ima_kexec.c |=C2=A0 3 +++
> =C2=A03 files changed, 28 insertions(+)
>=20
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4dbf806bccef..bd554ced9fb2 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -362,6 +362,9 @@ struct kimage {
> =C2=A0
> =C2=A0	phys_addr_t ima_buffer_addr;
> =C2=A0	size_t ima_buffer_size;
> +
> +	unsigned long ima_segment_index;
> +	bool is_ima_segment_index_set;
> =C2=A0#endif
> =C2=A0
> =C2=A0	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..606132253c79 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> +#ifdef CONFIG_IMA_KEXEC
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	if (image->is_ima_segment_index_set && i =3D=3D image->ima_segment_inde=
x)
> +		return true;
> +	else
> +		return false;
> +}
> +#else
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	return false;
> +}
> +#endif
> +
> =C2=A0static int kexec_calculate_store_digests(struct kimage *image);
> =C2=A0
> =C2=A0/* Maximum size in bytes for kernel/initrd files. */
> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kima=
ge
> *image)
> =C2=A0		if (ksegment->kbuf =3D=3D pi->purgatory_buf)
> =C2=A0			continue;
> =C2=A0
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (check_ima_segment_index(image, i))
> +			continue;
> +
> =C2=A0		ret =3D crypto_shash_update(desc, ksegment->kbuf,
> =C2=A0					=C2=A0 ksegment->bufsz);
> =C2=A0		if (ret)
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index 89088f1fa989..704676fa6615 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -160,6 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0	kbuf.buffer =3D kexec_buffer;
> =C2=A0	kbuf.bufsz =3D kexec_buffer_size;
> =C2=A0	kbuf.memsz =3D kexec_segment_size;
> +	image->is_ima_segment_index_set =3D false;
> =C2=A0	ret =3D kexec_add_buffer(&kbuf);
> =C2=A0	if (ret) {
> =C2=A0		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -170,6 +171,8 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0	image->ima_buffer_addr =3D kbuf.mem;
> =C2=A0	image->ima_buffer_size =3D kexec_segment_size;
> =C2=A0	image->ima_buffer =3D kexec_buffer;
> +	image->ima_segment_index =3D image->nr_segments - 1;
> +	image->is_ima_segment_index_set =3D true;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * kexec owns kexec_buffer after kexec_add_buffer() is called


