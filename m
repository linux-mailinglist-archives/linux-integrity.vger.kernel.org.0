Return-Path: <linux-integrity+bounces-6126-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F31CAA8E59
	for <lists+linux-integrity@lfdr.de>; Mon,  5 May 2025 10:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CBB18924BC
	for <lists+linux-integrity@lfdr.de>; Mon,  5 May 2025 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7301F30A4;
	Mon,  5 May 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lEuI0uhE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C417A314;
	Mon,  5 May 2025 08:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746434273; cv=none; b=JeTxVydLzMTdpv7j7hyLZ6/WF3zmD+nUgii18JCEjqfU8N7ZQaqHTu4sRgj0mtLOCudgM9NO+8dhbgV4qhvTp4o6AOqzro5O9MZQWVncSzdXsrAjM7AgbS7LIIG8ZYNku4/PVOBtnIK70cHzcWgIv5QIeQegLPyuNmF2JPEp6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746434273; c=relaxed/simple;
	bh=/jmpLHgfdFoEFUS2+41jObZbP/NobZmuVHLiVyvLh4I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YuBGe5Ik5EkvfpyS2X5cQ83iXoUS084KALyH637XtMVM48NigLo09/Idx/O7JIQnTGaGpq7CZi0lgZlu9cNn5UQPElQ6XTtGomnRMUJ8h9xGFDVtXGdv3h1q9F4mAfRQMYnemtSL8eZYpd5A1uuuDL42Qts4cT3ST7RSSRowqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lEuI0uhE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544Lerbo015954;
	Mon, 5 May 2025 08:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sJnEdJ
	mXfgBwSldLZE2cC4O1tLhklRfbkGj7jMDp4Hs=; b=lEuI0uhEbPI7TboxcaMyLH
	YwGUb4cnN5Z1HhLI+2+sJu/ZmcCWtRt4v8n82LswOUSqlou+vazb8rzaX6Mkwy8A
	JRLw/qYoPy2y1BNlc7zcYCnqTAbSGaFrzsdVpyn3BjAEfilvSoX51BIMzf146gFn
	7IQjazzR7a6srsBQrHXhb1LyiqEa+yigOxAX82gJfFD0yOjeaDvJR/YoTtPAjbmZ
	pFvYSs6ZRRHos1d2DrCYviUck/uAzqaxcLKzho1wegiyhp9WzLT/PqGhrSzBIJAG
	ReuXvlZBqUMwSPtRSBn1DPQnRcL+pZA8qZjg2x9sucCnOZQCv6pDu4tYiT7GAZ7Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46egb7swxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 08:37:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5458bVwS023491;
	Mon, 5 May 2025 08:37:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46egb7swxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 08:37:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5457T4kS025813;
	Mon, 5 May 2025 08:37:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyngpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 08:37:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5458bSJc41025856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 08:37:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9C920043;
	Mon,  5 May 2025 08:37:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DC5D20040;
	Mon,  5 May 2025 08:37:27 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 May 2025 08:37:27 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.150.10.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BE3C3601F3;
	Mon,  5 May 2025 18:37:20 +1000 (AEST)
Message-ID: <43baab5747031ec84100939fe154fa2b071f3789.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/secvar: Expose secvars relevant to the key
 management mode
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20250430090350.30023-3-ssrish@linux.ibm.com>
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
		 <20250430090350.30023-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 May 2025 17:23:10 +1000
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 35tEsaiZ0udvRbn6fwx-PJWiD8x-ogSE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA4MSBTYWx0ZWRfX/DxKSVTpEP4u CpWl+vcdeNJeWg32B7Jw8NrJM/hjZNEiEvDRT6M+slVVr3efcJNkt5XIlNMMUpHfuhPhSApytrl 8yq05jGIKv9D+vNiE+1/eW4chsNIPo2szUW/lVwH6fg/yTQerd8nQ19QQ2WyglHE5P7lkTbGq8K
 cYK17wsGBUuTI6wD1HHZUHD+jkXBKCT1F5jqvgu3GkHA49biqIrGuIF7v02Gen8MEicbljcNctK mUpn9VvNPO7ePBVd5F6vciQrCo7o0BmD/28mbnZ9UIA0Sv6nSIASoibZiGuOrAF700RdxhaqMgN n+JHmc0H9incqxthapP9N5or/MHK+dpK5pqUCvk+xZVGc8qMoma4I1wPTkT1RvlavDhIbqLU80+
 gYHShMNgLSHoRk6zqzK4C2Rpkj7ZpNmoOBK2oLFaEaGil1A1WGoHWGG+2/Zj2ZqkPfxXmRnx
X-Authority-Analysis: v=2.4 cv=YcK95xRf c=1 sm=1 tr=0 ts=681878cc cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=q79MgDi7yVbGD4n-FgcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OjVXDvUkOp_ULUg-xePAuknCUwHRtP36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050081

On Wed, 2025-04-30 at 14:33 +0530, Srish Srinivasan wrote:
> The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
> secvars irrespective of the key management mode.
>=20
> The PowerVM LPAR supports static and dynamic key management for
> secure
> boot. The key management option can be updated in the management
> console. Only in the dynamic key mode can the user modify the secure
> boot secvars db, dbx, grubdb, grubdbx, and sbat, which are exposed
> via
> the sysfs interface. But the sysfs interface exposes these secvars
> even
> in the static key mode. This could lead to errors when reading them
> or
> writing to them in the static key mode.
>=20
> Expose only PK, trustedcadb, and moduledb in the static key mode to
> enable loading of signed third-party kernel modules.
>=20
> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

I'm assuming it's been determined that there's no value in letting
userspace see db/dbx/etc in a read-only way in static mode?

With one comment below:

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0Documentation/ABI/testing/sysfs-secvar=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 9 ++++--
> =C2=A0arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++=
-
> --
> =C2=A02 files changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-secvar
> b/Documentation/ABI/testing/sysfs-secvar
> index 857cf12b0904..2bdc7d9c0c10 100644
> --- a/Documentation/ABI/testing/sysfs-secvar
> +++ b/Documentation/ABI/testing/sysfs-secvar
> @@ -22,9 +22,12 @@ Description:	A string indicating which backend is
> in use by the firmware.
> =C2=A0		and is expected to be "ibm,edk2-compat-v1".
> =C2=A0
> =C2=A0		On pseries/PLPKS, this is generated by the kernel
> based on the
> -		version number in the SB_VERSION variable in the
> keystore, and
> -		has the form "ibm,plpks-sb-v<version>", or
> -		"ibm,plpks-sb-unknown" if there is no SB_VERSION
> variable.
> +		existence of the SB_VERSION property in firmware.
> This string
> +		takes the form "ibm,plpks-sb-v1" in the presence of
> SB_VERSION,
> +		indicating the key management mode is dynamic.
> Otherwise it
> +		takes the form "ibm,plpks-sb-v0" in the static key
> management
> +		mode. Only secvars relevant to the key management
> mode are
> +		exposed.

Everything except the last sentence here is relevant to the previous
patch in the series (noting my comments on the previous patch about the
string).

The last sentence is more related to the <variable name> entry than the
format entry, and perhaps worth including a list of what variables are
applicable to each mode.

> =C2=A0
> =C2=A0What:		/sys/firmware/secvar/vars/<variable name>
> =C2=A0Date:		August 2019
> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c
> b/arch/powerpc/platforms/pseries/plpks-secvar.c
> index d57067a733ab..cbcb2c356f2a 100644
> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
> @@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
> =C2=A0		return PLPKS_SIGNEDUPDATE;
> =C2=A0}
> =C2=A0
> -static const char * const plpks_var_names[] =3D {
> +static const char * const plpks_var_names_static[] =3D {
> +	"PK",
> +	"moduledb",
> +	"trustedcadb",
> +	NULL,
> +};
> +
> +static const char * const plpks_var_names_dynamic[] =3D {
> =C2=A0	"PK",
> =C2=A0	"KEK",
> =C2=A0	"db",
> @@ -207,21 +214,34 @@ static int plpks_max_size(u64 *max_size)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static const struct secvar_operations plpks_secvar_ops_static =3D {
> +	.get =3D plpks_get_variable,
> +	.set =3D plpks_set_variable,
> +	.format =3D plpks_secvar_format,
> +	.max_size =3D plpks_max_size,
> +	.config_attrs =3D config_attrs,
> +	.var_names =3D plpks_var_names_static,
> +};
> =C2=A0
> -static const struct secvar_operations plpks_secvar_ops =3D {
> +static const struct secvar_operations plpks_secvar_ops_dynamic =3D {
> =C2=A0	.get =3D plpks_get_variable,
> =C2=A0	.set =3D plpks_set_variable,
> =C2=A0	.format =3D plpks_secvar_format,
> =C2=A0	.max_size =3D plpks_max_size,
> =C2=A0	.config_attrs =3D config_attrs,
> -	.var_names =3D plpks_var_names,
> +	.var_names =3D plpks_var_names_dynamic,
> =C2=A0};
> =C2=A0
> =C2=A0static int plpks_secvar_init(void)
> =C2=A0{
> +	u8 mode;
> +
> =C2=A0	if (!plpks_is_available())
> =C2=A0		return -ENODEV;
> =C2=A0
> -	return set_secvar_ops(&plpks_secvar_ops);
> +	mode =3D plpks_get_sb_keymgmt_mode();
> +	if (mode)
> +		return set_secvar_ops(&plpks_secvar_ops_dynamic);
> +	return set_secvar_ops(&plpks_secvar_ops_static);
> =C2=A0}
> =C2=A0machine_device_initcall(pseries, plpks_secvar_init);

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

