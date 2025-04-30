Return-Path: <linux-integrity+bounces-6089-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89DAA5007
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 17:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A43B189CC46
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4324728A;
	Wed, 30 Apr 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gx4huT9x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43172DC797;
	Wed, 30 Apr 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026461; cv=none; b=EjDpcVgyP5bwEFhmEaauswLaO510LZFsKID748bjIKwGLZvUmXfo+lDd2pm6oLSdIH/So8SDaAGD/DEHjvt4NpeVeeOqmRh1M7M20M5iYdSiKLw4hLedexVJ0dSD8ONKLCcaLIpL4Lsf6SSkTgJFXv4NWHreTaECGoc5fGRKcJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026461; c=relaxed/simple;
	bh=FuLvj1spcgHTY8elhfiA9TPD/i0AFNC+63bWI9gh7Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UE41DtE/JDjqH0jBw9aNAuGak25SgueUdnV5K6RYMVJsKidFnMHxiJo7O7IqvwD9HB3zaztEVHPjwol33Z6LkRknKJkHb9fAAbPukdChZhYvCohhhNcOUksZU72toFOKXXmOAYtnZ5nWwfaJiBxPs1VsUuICO9BLFADZbZqcT0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gx4huT9x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UCDng1024910;
	Wed, 30 Apr 2025 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MSej7j
	bobwbqeMlTjU5/lo6oaSDe6uN5LnOYgyj/SdQ=; b=gx4huT9xHGEbuQGd0xF0Ne
	sfADIs9RzE6k210z/KSdDqQi1Cx5X4FiPmEuG0cMXhDe02gdX3BHvjdPd4d+9Rr9
	PnbDKt5pxnn/g9RvJJ3lqtK6sBWj9Bdvfrt9f2iyzXymay8gPRw+9qTEzV+B9KdC
	q7BU8jgExrNojj4C1jJUs9bbqgn/yAM8Q1E+yukgATFHwXYj9iPgOadkekkbwBKw
	8j4Iz+gEGL651RRnQ5peJKwygDiCcKCXf0yyLaLeBvB89W0EPQsCCq93Tv9umXcF
	ElvRM2a7bnyc2DmBrSU8hkS7uVGCe2zeA+4y61drm621oCg60eQfHLDDuxoH0JVA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwbtbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:20:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53UFKamv028721;
	Wed, 30 Apr 2025 15:20:36 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwbtbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:20:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UD6o67001336;
	Wed, 30 Apr 2025 15:20:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpgehb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 15:20:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53UFKYiv23397040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 15:20:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 779A858056;
	Wed, 30 Apr 2025 15:20:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 838205805E;
	Wed, 30 Apr 2025 15:20:33 +0000 (GMT)
Received: from [9.61.140.105] (unknown [9.61.140.105])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Apr 2025 15:20:33 +0000 (GMT)
Message-ID: <d7c04725-418c-4db3-ab85-009140b7698e@linux.ibm.com>
Date: Wed, 30 Apr 2025 11:20:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format representation
 for static key management
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
 <20250430090350.30023-2-ssrish@linux.ibm.com>
Content-Language: en-US
From: Nayna Jain <nayna@linux.ibm.com>
In-Reply-To: <20250430090350.30023-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sDwlPpGTTG1GR-oBmFiMYWWWTjVwpb_d
X-Proofpoint-GUID: xLV0T2ohgs7To3hQR3WekN-SvhuxH38r
X-Authority-Analysis: v=2.4 cv=GOIIEvNK c=1 sm=1 tr=0 ts=68123fc4 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=a-ZR6o523KS40DtQx9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwNyBTYWx0ZWRfX3zqiUZPo9iZO 2lL18Y26RKKVcJyXaHuMUyERkPxST22gM5RMxTwf8zNZ3ir/SL2adW3x+dhrSDZnLJbB2fbFq8u 2yHOYbALiitdCfPkr/WmKLZ6c6YeDD8XT4uK8yn0aXUmJQm9ENLVO3ucPBQs5Y3kBr1ClhI4rhs
 iPWlJYWQL5szHilpcVSR4WsmnkzkvfpQSODeOgP6RfiRpRwbMGloP97eBnRRtaq6idjaqa+zQXM dc0CPuOUpemzJQblmyVoNp7diwi/oO3E7TLhWlukosuuzXc4lX+mqWitm5phkPOrCOkBGYvFXxL I0zwDzqJJAcmXsliFjAbccR4no/r9ELNsj9enD4MdzaQxpCBthWCjDEanZJeRGmK6GD3EDIO4g7
 idF0weCWINGJdwhnLWw2dmPt61qXqIogNELHxCwHtOcctT72KnuQqQRaw3Dvd+YW/S0npKzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300107


On 4/30/25 5:03 AM, Srish Srinivasan wrote:
> On a PLPKS enabled PowerVM LPAR, the secvar format property for static
> key management is misrepresented as "ibm,plpks-sb-unknown", creating
> reason for confusion.
>
> Static key management mode uses fixed, built-in keys. Dynamic key
> management mode allows keys to be updated in production to handle
> security updates without firmware rebuilds.
>
> Define a function named plpks_get_sb_keymgmt_mode() to retrieve the
> key management mode based on the existence of the SB_VERSION property
> in the firmware.
>
> Set the secvar format property to either "ibm,plpks-sb-v1" or
> "ibm,plpks-sb-v0" based on the key management mode, and return the
> length of the secvar format property.

Reviewed-by: Nayna Jain <nayna@linux.ibm.com>

Thanks & Regards,
    - Nayna

>
> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/plpks-secvar.c | 70 +++++++++++--------
>   1 file changed, 40 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
> index 257fd1f8bc19..d57067a733ab 100644
> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
> @@ -152,39 +152,49 @@ static int plpks_set_variable(const char *key, u64 key_len, u8 *data,
>   	return rc;
>   }
>   
> -// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
> -// Instead, report the format using the SB_VERSION variable in the keystore.
> -// The string is made up by us, and takes the form "ibm,plpks-sb-v<n>" (or "ibm,plpks-sb-unknown"
> -// if the SB_VERSION variable doesn't exist). Hypervisor defines the SB_VERSION variable as a
> -// "1 byte unsigned integer value".
> -static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
> +/*
> + * Return the key management mode.
> + *
> + * SB_VERSION is defined as a "1 byte unsigned integer value". It is owned by
> + * the Partition Firmware and its presence indicates that the key management
> + * mode is dynamic. Only signed variables have null bytes in their names.
> + * SB_VERSION does not.
> + *
> + * Return 1 to indicate that the key management mode is dynamic. Otherwise
> + * return 0, indicating that the key management mode is static.
> + */
> +static u8 plpks_get_sb_keymgmt_mode(void)
>   {
> -	struct plpks_var var = {0};
> -	ssize_t ret;
> -	u8 version;
> -
> -	var.component = NULL;
> -	// Only the signed variables have null bytes in their names, this one doesn't
> -	var.name = "SB_VERSION";
> -	var.namelen = strlen(var.name);
> -	var.datalen = 1;
> -	var.data = &version;
> -
> -	// Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
> -	ret = plpks_read_fw_var(&var);
> -	if (ret) {
> -		if (ret == -ENOENT) {
> -			ret = snprintf(buf, bufsize, "ibm,plpks-sb-unknown");
> -		} else {
> -			pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
> -			ret = -EIO;
> -		}
> -		goto err;
> +	u8 mode;
> +	ssize_t rc;
> +	struct plpks_var var = {
> +		.component = NULL,
> +		.name = "SB_VERSION",
> +		.namelen = 10,
> +		.datalen = 1,
> +		.data = &mode,
> +	};
> +
> +	rc = plpks_read_fw_var(&var);
> +	if (rc) {
> +		pr_info("Error %ld reading SB_VERSION from firmware\n", rc);
> +		mode = 0;
>   	}
> +	return mode;
> +}
>   
> -	ret = snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
> -err:
> -	return ret;
> +// PLPKS dynamic secure boot doesn't give us a format string in the same way
> +// OPAL does. Instead, report the format using the SB_VERSION variable in the
> +// keystore. The string, made up by us, takes the form "ibm,plpks-sb-v<n>".Set
> +// the secvar format property to either "ibm,plpks-sb-v1" or "ibm,plpks-sb-v0",
> +// based on the key management mode, and return the length of the secvar format
> +// property.
> +static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
> +{
> +	u8 mode;
> +
> +	mode = plpks_get_sb_keymgmt_mode();
> +	return snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", mode);
>   }
>   
>   static int plpks_max_size(u64 *max_size)

