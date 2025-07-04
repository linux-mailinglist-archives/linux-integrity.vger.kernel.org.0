Return-Path: <linux-integrity+bounces-6622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C4AF8C8F
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 10:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7859B1C2116E
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22492EF665;
	Fri,  4 Jul 2025 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A8LMSWFk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6642EE60E;
	Fri,  4 Jul 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618602; cv=none; b=U5a1w/TFdPlsS43SfeFucOUB1odEFhXUD6F+NDhDm5RK8RVH0Vsw7Lt+E/xnaGH+XRPaTRoyR+Tj7NIYHSpyIb2rhGaolGlnXP7IvrDgN15oEvSyYcJqItBN4F/ZoIFPkY75AJEM5lK0esC8fiaddJCOGoTAVDgXAvQvOg6/9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618602; c=relaxed/simple;
	bh=WC663r1Nrv3IDM4pbbroaXIZVFiya4oXX5gjFpAjE0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tpRYftpzrmu3GGHgz4rg5v2P8uTl7br+PzL6wCsSVdamW75qYJ2vbstVg+kOVADKrytkPqegVSCVd6hfbn3Yov08/FgywBTHhE650dosSG9Fg4POIyFhZE9JJlaw38RMX2SC6CtEUZ+BkYJ+Hfq2qryoKB5yj57Iok5gyvI66WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A8LMSWFk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5646qXdq008983;
	Fri, 4 Jul 2025 08:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OhOmXY
	Aj/2Vy0m+ws5zyVcX4kOdXzVFqtuhyr/O1J18=; b=A8LMSWFkXTZXb45HoNVSXh
	iuLvbVCzskreMNkozbUe0mgx20SeQxmiLcF6ljeqqi1Th0n/G82dmjeeZ0H03aJ7
	wEQNH5De+crB3G6kVeargOCyVJbSdUeyTa78+f4mEqnojNZ0kKG2HA9QKlo8UtOM
	2MfVHyHwkPLZ6ddTk/iNp8ox8wdIYvQQoN/JD879pPrz1M51B0u/kaKAS3X7kVez
	yKXq6sNUtxQxtWEG/m7HhEqAqCk+3HtbfS86KMPoFgH6z0YLsSBLukfo5XFE9XZG
	0UWexjNLZCdy5euwBRORgQkDhsJxVrfN7Te1us6ePKwJAxN50ZhpqbY/7NHCUFCg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g84bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 08:43:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5648acbL022614;
	Fri, 4 Jul 2025 08:43:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j82g84b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 08:43:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5648GALh021371;
	Fri, 4 Jul 2025 08:43:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jwe3rrv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Jul 2025 08:43:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5648gwEd51184018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Jul 2025 08:42:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50E5520043;
	Fri,  4 Jul 2025 08:42:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C60A22004B;
	Fri,  4 Jul 2025 08:42:52 +0000 (GMT)
Received: from [9.61.253.3] (unknown [9.61.253.3])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Jul 2025 08:42:52 +0000 (GMT)
Message-ID: <b6e8f65a-234f-4543-961b-076a088ae819@linux.ibm.com>
Date: Fri, 4 Jul 2025 14:12:49 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] powerpc/secvar: Expose secvars relevant to the key
 management mode
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, msuchanek@suse.de,
        linux-kernel@vger.kernel.org
References: <20250610211907.101384-1-ssrish@linux.ibm.com>
 <20250610211907.101384-3-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20250610211907.101384-3-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _ZCsWS_I4BWE0w9I80nvT2k7t-FmBJnC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA2NCBTYWx0ZWRfX98GxvNa98QK1 B56FU+8wjb1Ho3ofFdGEKVuvJdKr/K7QbDcCNmKAtbAk/IQXOZtkIbir5tyd/ZRcm4MJauKGuwV 8HAJHvfUA+TUxAV8xhRAL9hFlNq16O/PiG446xNGlDsK3wMgf3zOy1W3EG/NvbNR/zqinkLleeY
 Mi9EnlsA9xFLxlQ3EN3TYESO4HzHBd7J5Ny6glPEirBNcFSCZUsBSHuaFuSGfrZzzxrgQb4hLOf bcDYgMdMRwjRRYjW9/w52Q+BBpuctxeUh2DBhexUyWF8yjVgFPORuE7z7DXRa0eNrke9oLes0y7 NTLBSUXt+MBlKcOWmASxOHjGsGZN4KMpEkvb7y6d5SNooRqGedIUT55TgiMIVI6f5KZ4Mgeppu+
 zv7JJPtEnj+6F5Ak+fidrdhQ27R5m46Z5kSUER5gevPi86rZ8Jg+NcIeZ15XXcCluWdxSios
X-Authority-Analysis: v=2.4 cv=LpeSymdc c=1 sm=1 tr=0 ts=68679417 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=1BM8l147YzEeg-DoTtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hEM-4Tx3Tu_gdYPd0gXpOtHVYGv4GjD6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507040064


On 11/06/25 2:49 AM, Srish Srinivasan wrote:
> The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
> secvars irrespective of the key management mode.
>
> The PowerVM LPAR supports static and dynamic key management for secure
> boot. The key management option can be updated in the management
> console. The secvars PK, trustedcadb, and moduledb can be consumed both
> in the static and dynamic key management modes for the loading of signed
> third-party kernel modules. However, other secvars i.e. KEK, grubdb,
> grubdbx, sbat, db and dbx, which are used to verify the grub and kernel
> images, are consumed only in the dynamic key management mode.
>
> Expose only PK, trustedcadb, and moduledb in the static key management
> mode.
>
> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
With the following scenarios:
1. With and with out secure boot by enabling keystore_signed_updates and 
keystore_kbytes
2. With Dynamic Key Guest Secure Boot
3. With Static Key Guest Secure Boot
> ---
>   Documentation/ABI/testing/sysfs-secvar        |  7 +++++
>   arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
>   2 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
> index f001a4f4bd2e..1016967a730f 100644
> --- a/Documentation/ABI/testing/sysfs-secvar
> +++ b/Documentation/ABI/testing/sysfs-secvar
> @@ -38,6 +38,13 @@ Description:	Each secure variable is represented as a directory named as
>   		representation. The data and size can be determined by reading
>   		their respective attribute files.
>   
> +		Only secvars relevant to the key management mode are exposed.
> +		Only in the dynamic key management mode should the user have
> +		access (read and write) to the secure boot secvars db, dbx,
> +		grubdb, grubdbx, and sbat. These secvars are not consumed in the
> +		static key management mode. PK, trustedcadb and moduledb are the
> +		secvars common to both static and dynamic key management modes.
> +
>   What:		/sys/firmware/secvar/vars/<variable_name>/size
>   Date:		August 2019
>   Contact:	Nayna Jain <nayna@linux.ibm.com>
> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
> index 767e5e8c6990..f9e9cc40c9d0 100644
> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
> @@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
>   		return PLPKS_SIGNEDUPDATE;
>   }
>   
> -static const char * const plpks_var_names[] = {
> +static const char * const plpks_var_names_static[] = {
> +	"PK",
> +	"moduledb",
> +	"trustedcadb",
> +	NULL,
> +};
> +
> +static const char * const plpks_var_names_dynamic[] = {
>   	"PK",
>   	"KEK",
>   	"db",
> @@ -213,21 +220,34 @@ static int plpks_max_size(u64 *max_size)
>   	return 0;
>   }
>   
> +static const struct secvar_operations plpks_secvar_ops_static = {
> +	.get = plpks_get_variable,
> +	.set = plpks_set_variable,
> +	.format = plpks_secvar_format,
> +	.max_size = plpks_max_size,
> +	.config_attrs = config_attrs,
> +	.var_names = plpks_var_names_static,
> +};
>   
> -static const struct secvar_operations plpks_secvar_ops = {
> +static const struct secvar_operations plpks_secvar_ops_dynamic = {
>   	.get = plpks_get_variable,
>   	.set = plpks_set_variable,
>   	.format = plpks_secvar_format,
>   	.max_size = plpks_max_size,
>   	.config_attrs = config_attrs,
> -	.var_names = plpks_var_names,
> +	.var_names = plpks_var_names_dynamic,
>   };
>   
>   static int plpks_secvar_init(void)
>   {
> +	u8 mode;
> +
>   	if (!plpks_is_available())
>   		return -ENODEV;
>   
> -	return set_secvar_ops(&plpks_secvar_ops);
> +	mode = plpks_get_sb_keymgmt_mode();
> +	if (mode)
> +		return set_secvar_ops(&plpks_secvar_ops_dynamic);
> +	return set_secvar_ops(&plpks_secvar_ops_static);
>   }
>   machine_device_initcall(pseries, plpks_secvar_init);

-- 
Thanks and Regards
R.Nageswara Sastry


