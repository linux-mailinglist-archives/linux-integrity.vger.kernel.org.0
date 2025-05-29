Return-Path: <linux-integrity+bounces-6339-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B69AC817F
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C262B9E141D
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67122DF86;
	Thu, 29 May 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tVqiPx37"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048F1E2858;
	Thu, 29 May 2025 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538635; cv=none; b=CmwVfG7Ax1T+rOfNGMaNS9A/tRcXgEOvbAfGb5W1Iku5M1s4emeyyi6pupeTbcv+uILRPBKjrQas08O+H7go9mrzZiHbei3ZijDwQ7dWMqnNFbtvv7aMMyiJeyAM3LwQhPmhReECODILoniPhbkEm5FUMqkWaiF5Hn+y39b/Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538635; c=relaxed/simple;
	bh=NoIem2IR1XkbOLYWICsa0/7XbSWI7D5skb/waCpL4ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHSRLllM/jcZrIYia9GlgEhNOeM1Ud25VKl4U7Rs6hzxqcNeVNurMq9Kf3xtHYJc53GGFWEvRXLapOP3amXAO+2IkankUGpOKED+ZiP8CaL2dFZytP3pG4TzDh+n3mi+2mfTrCe5DYVM06AsV0asyPaHfKOjqvPdxdvHW7YrjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tVqiPx37; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TD39KL004003;
	Thu, 29 May 2025 17:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cd3hfJ
	PAu92I8pjJNnDLM77ypM5u0SdUnKIjryvXehQ=; b=tVqiPx370F6hz0VANlBWNt
	3I5wxzbqeSDsTmOaaD6AumO6wDweXt3clzsZBsRQr3LVCKud+MVqexazJqD/CFHs
	mxZpgxdgT2lkRQAujafLno7cFhyIx86GQX8OBbh2R1/9yVpPuvF8YjLrjRmGNr/I
	D7GXKcKnUBSob6YaidIPtLv1YC7I8XhY4Xz2HkcH4BeBhBKPwpOVEsME2VyO4kZ7
	GbMNryJf4k3fCA8WU2vHAFfeE1TzF6EjKHu65RY/8EyyY3FXTGJFFEoX5rqk1Jya
	+Twkj04RoZsRPoGxV/ZTzDqdhraHeXSyD2Rwhk9nN1hPwIoecnLs6PPxIFYU8EHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gpvfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 17:10:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54TGvg8C002269;
	Thu, 29 May 2025 17:10:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40gpvf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 17:10:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54TEsmRg014938;
	Thu, 29 May 2025 17:10:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46useq5dh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 17:10:05 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54THA3ig33817236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:10:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54E6058060;
	Thu, 29 May 2025 17:10:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3E1C5805A;
	Thu, 29 May 2025 17:09:59 +0000 (GMT)
Received: from [9.39.17.148] (unknown [9.39.17.148])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 29 May 2025 17:09:59 +0000 (GMT)
Message-ID: <7dcd0f77-852b-4f4c-9842-f1d96e1d8b65@linux.ibm.com>
Date: Thu, 29 May 2025 22:39:58 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] powerpc/secvar: Expose secvars relevant to the key
 management mode
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250521105759.8408-1-ssrish@linux.ibm.com>
 <20250521105759.8408-3-ssrish@linux.ibm.com>
 <aDATahmPIsOmiFAK@kitsune.suse.cz>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aDATahmPIsOmiFAK@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=683894ee cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FjsLbrDDWnlg2_KOIakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NiBTYWx0ZWRfX0V+eXlR27z+3 +VSdYgcKe5IOSdZbflRBZl78OgTo8iYxfPJ/EvVk+s2TeIBhDaAc9ZKH2+BmHqzUkO3wTMJg7Or UmkoHvwxHO78NZAWIxuIHRSpynbi+epxD5Tm5TfXqgWoGQpTDbhjUmoFndTbTS+5UP0jCW7bh4Z
 oj/DBBDDknOUgbD6GcWTHqYzzhJ3EpiKQgGN/RFf+6bkSmQaBw5P92STRMcUQHEdpK4Ai32W1B/ W6yQAEaSQrrT93qTUATYE3jXarwGVyx6xOOrNUH+x7vmXbPsDCt51ADl/FDxOak12U5wlr4zssj ok/aJ4hfWxPl61lWioRkPH/q1Zhrw7K6gCu75vOJS5FtNhVvaZOhrDHs4W4YOgi4/XzEg6AIfqk
 oCqA90Ya6is25MiN6+EEWjumlADPPS18P0YrWnLSBjd91sJ/RLLBvgh8pwrYbfb3LFubPhH5
X-Proofpoint-GUID: ArOXebcoQJSuVq9MHpKD6nWzKayrPNqx
X-Proofpoint-ORIG-GUID: 7DJqLMG3dxtwuJDTEWSwrnL0Sxn6E8zS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290166


On 5/23/25 11:49 AM, Michal Suchánek wrote:
> Hello,
>
> On Wed, May 21, 2025 at 04:27:58PM +0530, Srish Srinivasan wrote:
>> The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
>> secvars irrespective of the key management mode.
>>
>> The PowerVM LPAR supports static and dynamic key management for secure
>> boot. The key management option can be updated in the management
>> console. Only in the dynamic key mode can the user modify the secure
>> boot secvars db, dbx, grubdb, grubdbx, and sbat, which are exposed via
>> the sysfs interface. But the sysfs interface exposes these secvars even
>> in the static key mode. This could lead to errors when reading them or
>> writing to them in the static key mode.
> would it cause an error when reading these variables or only when
> writing them?
>
> Thanks
>
> Michal

Hi Michal,
Thanks for taking a look.


Yes, when PKS is enabled without enabling dynamic key secure boot, the 
secvars
are NOT yet initialized with the default keys built into the binaries, 
and therefore
reading them will result in an error.


Now, while in static key management mode with PKS enabled, if one tries to
populate secvars that are relevant to dynamic key management, the write does
not fail as long as the "Platform KeyStore Signed Update Infrastructure" 
flag on
the HMC is enabled and the signed updates are authorized by valid PK/KEK 
keys.
However, secvars like db and grubdb populated while in static key management
mode are not used by the Partition Firmware or grub as SB_VERSION is not 
present,
i.e dynamic key secure boot has not been enabled yet. In this case, when 
there is a
transition from static key management to dynamic key management, secvars 
with
the signed update policy bit set will not be overwritten by the 
hypervisor with the
default keys. Now, if the keys written into these secvars were not the 
ones that were
used to sign the grub and kernel, it would fail to verify them.


These are the reasons behind the decision to expose only those secvars 
that are
relevant to the key management mode.

>
>
>> Expose only PK, trustedcadb, and moduledb in the static key mode to
>> enable loading of signed third-party kernel modules.
>>
>> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
>> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
>> ---
>>   Documentation/ABI/testing/sysfs-secvar        |  6 ++++
>>   arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
>>   2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
>> index 45281888e520..948df3446a03 100644
>> --- a/Documentation/ABI/testing/sysfs-secvar
>> +++ b/Documentation/ABI/testing/sysfs-secvar
>> @@ -37,6 +37,12 @@ Description:	Each secure variable is represented as a directory named as
>>   		representation. The data and size can be determined by reading
>>   		their respective attribute files.
>>   
>> +		Only secvars relevant to the key management mode are exposed.
>> +		Only in the dynamic key mode can the user modify the secure boot
>> +		secvars db, dbx, grubdb, grubdbx, and sbat. PK, trustedcadb and
>> +		moduledb are the secvars common to both static and dynamic key
>> +		management modes.
>> +
>>   What:		/sys/firmware/secvar/vars/<variable_name>/size
>>   Date:		August 2019
>>   Contact:	Nayna Jain <nayna@linux.ibm.com>
>> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> index 767e5e8c6990..f9e9cc40c9d0 100644
>> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
>> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> @@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
>>   		return PLPKS_SIGNEDUPDATE;
>>   }
>>   
>> -static const char * const plpks_var_names[] = {
>> +static const char * const plpks_var_names_static[] = {
>> +	"PK",
>> +	"moduledb",
>> +	"trustedcadb",
>> +	NULL,
>> +};
>> +
>> +static const char * const plpks_var_names_dynamic[] = {
>>   	"PK",
>>   	"KEK",
>>   	"db",
>> @@ -213,21 +220,34 @@ static int plpks_max_size(u64 *max_size)
>>   	return 0;
>>   }
>>   
>> +static const struct secvar_operations plpks_secvar_ops_static = {
>> +	.get = plpks_get_variable,
>> +	.set = plpks_set_variable,
>> +	.format = plpks_secvar_format,
>> +	.max_size = plpks_max_size,
>> +	.config_attrs = config_attrs,
>> +	.var_names = plpks_var_names_static,
>> +};
>>   
>> -static const struct secvar_operations plpks_secvar_ops = {
>> +static const struct secvar_operations plpks_secvar_ops_dynamic = {
>>   	.get = plpks_get_variable,
>>   	.set = plpks_set_variable,
>>   	.format = plpks_secvar_format,
>>   	.max_size = plpks_max_size,
>>   	.config_attrs = config_attrs,
>> -	.var_names = plpks_var_names,
>> +	.var_names = plpks_var_names_dynamic,
>>   };
>>   
>>   static int plpks_secvar_init(void)
>>   {
>> +	u8 mode;
>> +
>>   	if (!plpks_is_available())
>>   		return -ENODEV;
>>   
>> -	return set_secvar_ops(&plpks_secvar_ops);
>> +	mode = plpks_get_sb_keymgmt_mode();
>> +	if (mode)
>> +		return set_secvar_ops(&plpks_secvar_ops_dynamic);
>> +	return set_secvar_ops(&plpks_secvar_ops_static);
>>   }
>>   machine_device_initcall(pseries, plpks_secvar_init);
>> -- 
>> 2.47.1
>>
>>

