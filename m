Return-Path: <linux-integrity+bounces-6149-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAEFAACDA0
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37FDF7ADDC3
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CF812CD8B;
	Tue,  6 May 2025 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJec/wvP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4A179A7;
	Tue,  6 May 2025 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558044; cv=none; b=EQVxssKsSiAFq6B5wgmc4PLPCwTHS5VB2Gp1QFVzsqCzK3dnT2PLmxCB+g4Pj03zN4VWaySIQP1SOfV7qqJRuhg/hukZy6WNoTHiL0QadMgkZ/cghLBPA/Vz044nEgwCWf31ukj680JK8e88vwdnOGYppQ/GwRekneIiddPNFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558044; c=relaxed/simple;
	bh=7DulNIlOMXIXu4sTVm9DFCKXNGwWEUU67HTnXQli5XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUqXyEDB0sYWdfJi5I/KTdSd/gKClr8H8axz/1nzajYh9bFH7bgWcP1ASq7LMZSJjW9BpWxKlOewMKe/4GfR1/8BdeFS4ttoBoSX/yHidZa5V508PQ2AxmeIb5uG6UtCaKXOvge3ZafbKsIXemEQ+oYc/g9yAi251Mr9jBJrDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJec/wvP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546IYG5Y011191;
	Tue, 6 May 2025 19:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i3vm45
	c5Yzthq8UV1UTQrKTGeJddui7WAzA3jzfj+fA=; b=TJec/wvPWeSa9bemcple4m
	nxBHX1CcWPIUZsVHnCG3UKiOUUUZ9NALwt4j3yqIpCJRjKPSnqbva2kDSMzPyywQ
	JdoxjijWbF9bstGxshOqHcYMKwXL0eje91jH7DFjsxC4tGJwMx14rijfPo7kRfNo
	WYf0ycDBnuGFXWdMacR3PBv9yzL8Dtrba878dBNjYLgDOHSrPDdhuL0yYcnN2Ys2
	QBXeTz8rlBzKQz7cW/AN4cbOHC6WnDPnN+xc509xD92Z2m/BymcLMI7+aqjUXqbG
	2IwgN1/pFEhPlUMuCHsmSC3BAiDNkPF2OOGXTiOgcu7vygm2bO2uqutIsPKrbrYQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsjdgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546Iqow8010761;
	Tue, 6 May 2025 19:00:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgvsjdga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546Fjgq2025807;
	Tue, 6 May 2025 19:00:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuyw0eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:23 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546J0M1211403790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 19:00:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A89158054;
	Tue,  6 May 2025 19:00:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 073BC5805C;
	Tue,  6 May 2025 19:00:14 +0000 (GMT)
Received: from [9.39.22.34] (unknown [9.39.22.34])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 19:00:13 +0000 (GMT)
Message-ID: <24ed9d66-ca87-4695-af77-a587929e3e7a@linux.ibm.com>
Date: Wed, 7 May 2025 00:30:12 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc/secvar: Expose secvars relevant to the key
 management mode
To: Andrew Donnellan <ajd@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
 <20250430090350.30023-3-ssrish@linux.ibm.com>
 <43baab5747031ec84100939fe154fa2b071f3789.camel@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <43baab5747031ec84100939fe154fa2b071f3789.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CLAqXQrD c=1 sm=1 tr=0 ts=681a5c48 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=tE8uJsxgfS_J_r_r1e0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4rAWqD3Le6JRtMTweH90HDWDFwUjlpYr
X-Proofpoint-ORIG-GUID: wleImVCZbktwx7sR-BOvIfcUNmzXNMD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE3NSBTYWx0ZWRfXy//7pSs64BMD Rj09xVFw2nkYi6YyCPvYGhyQ4Eobj6aQVCH0u1QGh/Qr2LESuzgpmytJEJgFeFzJ3+rgpnx3v73 331DJM8Pd5Ijf750/VAhMfWNHgLj5cQ8DtP6+pO7HX2LNU11nd3mhZS/RZXGLPq5tORM7HxgGKm
 ZUpW6nELQB2qC6WKVuPIVyxlqKho/tHtRQdTkbU362i8bgEITK8JRl80wQyq/gI+bcdurTCE5Ci LBVuvyL4aZxDEYMFYZZaSh1KJQOVKjEv56bid/RcE/XP7x7EtZjSiLqfxiXjkGKycUMFETTGevi xEFnekF2T8JUDUUkNmeDmuXtxwZlLSAisAe/3pfek3yX4KTCNAnUIldBKaH3ADzeICQ6O2QHopO
 oBc/ZpeAe7gR50qjjqkgX7GtAyyHlOSCOnoYGPD/4V/61hcOkKSpmLcIXK96wm012aLhKiTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060175


On 5/5/25 12:53 PM, Andrew Donnellan wrote:
> On Wed, 2025-04-30 at 14:33 +0530, Srish Srinivasan wrote:
>> The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
>> secvars irrespective of the key management mode.
>>
>> The PowerVM LPAR supports static and dynamic key management for
>> secure
>> boot. The key management option can be updated in the management
>> console. Only in the dynamic key mode can the user modify the secure
>> boot secvars db, dbx, grubdb, grubdbx, and sbat, which are exposed
>> via
>> the sysfs interface. But the sysfs interface exposes these secvars
>> even
>> in the static key mode. This could lead to errors when reading them
>> or
>> writing to them in the static key mode.
>>
>> Expose only PK, trustedcadb, and moduledb in the static key mode to
>> enable loading of signed third-party kernel modules.
>>
>> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> I'm assuming it's been determined that there's no value in letting
> userspace see db/dbx/etc in a read-only way in static mode?
>
> With one comment below:
>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Hi Andrew,
Thanks a lot for your feedback.

Yes, that is correct.
>> ---
>>   Documentation/ABI/testing/sysfs-secvar        |  9 ++++--
>>   arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++-
>> --
>>   2 files changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-secvar
>> b/Documentation/ABI/testing/sysfs-secvar
>> index 857cf12b0904..2bdc7d9c0c10 100644
>> --- a/Documentation/ABI/testing/sysfs-secvar
>> +++ b/Documentation/ABI/testing/sysfs-secvar
>> @@ -22,9 +22,12 @@ Description:	A string indicating which backend is
>> in use by the firmware.
>>   		and is expected to be "ibm,edk2-compat-v1".
>>   
>>   		On pseries/PLPKS, this is generated by the kernel
>> based on the
>> -		version number in the SB_VERSION variable in the
>> keystore, and
>> -		has the form "ibm,plpks-sb-v<version>", or
>> -		"ibm,plpks-sb-unknown" if there is no SB_VERSION
>> variable.
>> +		existence of the SB_VERSION property in firmware.
>> This string
>> +		takes the form "ibm,plpks-sb-v1" in the presence of
>> SB_VERSION,
>> +		indicating the key management mode is dynamic.
>> Otherwise it
>> +		takes the form "ibm,plpks-sb-v0" in the static key
>> management
>> +		mode. Only secvars relevant to the key management
>> mode are
>> +		exposed.
> Everything except the last sentence here is relevant to the previous
> patch in the series (noting my comments on the previous patch about the
> string).
>
> The last sentence is more related to the <variable name> entry than the
> format entry, and perhaps worth including a list of what variables are
> applicable to each mode.
Sure, will fix this.

Thanks and Regards,
Srish
>
>>   
>>   What:		/sys/firmware/secvar/vars/<variable name>
>>   Date:		August 2019
>> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c
>> b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> index d57067a733ab..cbcb2c356f2a 100644
>> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
>> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> @@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
>>   		return PLPKS_SIGNEDUPDATE;
>>   }
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
>>   	"PK",
>>   	"KEK",
>>   	"db",
>> @@ -207,21 +214,34 @@ static int plpks_max_size(u64 *max_size)
>>   	return 0;
>>   }
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
>>   	.get = plpks_get_variable,
>>   	.set = plpks_set_variable,
>>   	.format = plpks_secvar_format,
>>   	.max_size = plpks_max_size,
>>   	.config_attrs = config_attrs,
>> -	.var_names = plpks_var_names,
>> +	.var_names = plpks_var_names_dynamic,
>>   };
>>   
>>   static int plpks_secvar_init(void)
>>   {
>> +	u8 mode;
>> +
>>   	if (!plpks_is_available())
>>   		return -ENODEV;
>>   
>> -	return set_secvar_ops(&plpks_secvar_ops);
>> +	mode = plpks_get_sb_keymgmt_mode();
>> +	if (mode)
>> +		return set_secvar_ops(&plpks_secvar_ops_dynamic);
>> +	return set_secvar_ops(&plpks_secvar_ops_static);
>>   }
>>   machine_device_initcall(pseries, plpks_secvar_init);

