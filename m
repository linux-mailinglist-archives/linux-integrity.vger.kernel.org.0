Return-Path: <linux-integrity+bounces-6148-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738AAACD9D
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 21:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B708B5031B2
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854E24B28;
	Tue,  6 May 2025 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DLv4NxFs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B76179A7;
	Tue,  6 May 2025 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746558037; cv=none; b=E+5tUBnmy2jY8eJwJDNOnHaoDDYlvXl8Jp0pPE/S4Fioy3jNZ2PzoUYMgcXRKT7kpuonrxxexIkW/84MhpVFaw5BYjawylPmFp9sqtZm88Z9f7Wl1H0EwQhYsCifMGaPE6jKYQQSFmk2QifGJ6cQCMzDN7c9reVfF8efcMuFq/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746558037; c=relaxed/simple;
	bh=02inlSyY+HBJNQyW4q9jR+rJd+gsTGlIX/2AzboNIaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goTKgxE+HutuuaFNyBIDfk2PHUUCDQI8pFdt2YPM/LTcmKwPyBLtOMti05DkPrksDJ6+XeV4o/Pd1aQsfSZTPtDHLLuCecNVb+Zz+25NTSFGN2jz80Za9dRkeNWtE9ltAAt8gqVB3fOj2I9pcx2VJ3sdJLNvFI25g97flaYL9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DLv4NxFs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546HqpUQ010209;
	Tue, 6 May 2025 19:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q0MTLu
	Mq9GJQsuaxY8CU/FZ5CU08WvQxGmpW7OCbWeo=; b=DLv4NxFsbxeVULgkfqp06g
	RbYC7ArtZx9cNgqyvOdnwyQ1B7SZFfiZDNOoPav6TgUVBbEFr/oKTpa2SlGrjgzE
	aF/GnA8BbTxIlaS5T24+4CxtpTeURFUOxjmhdDMUnKZehuLwhJ1dn/sA9p/pXIu0
	Wpm5R08s3ou6kESFrXYA/GAAIgZCGWoQHkylqrQVeDYa4wsqt+Wqu0llRdvy7iCz
	Snyw7sZToW35A6034kuK5e4IeIKffUGthiZdjBNWY5FQ16Ug9tmyJrtc31bRpCKP
	D/LqtnUGQtThSR7fPflgCo3ucwiyCgj2CUcM9rZhzFLnf1oArjO0sYKLH7kMzrRw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbjaka1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 546J02hM004826;
	Tue, 6 May 2025 19:00:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46fgbjak9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 546GO2rt002734;
	Tue, 6 May 2025 19:00:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfnvv7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 19:00:00 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 546Ixx9o30736940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 May 2025 18:59:59 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54DEF5805A;
	Tue,  6 May 2025 18:59:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 051565805C;
	Tue,  6 May 2025 18:59:52 +0000 (GMT)
Received: from [9.39.22.34] (unknown [9.39.22.34])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 May 2025 18:59:51 +0000 (GMT)
Message-ID: <2b7145a2-1cfb-4b1a-929c-10a03747119e@linux.ibm.com>
Date: Wed, 7 May 2025 00:29:50 +0530
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc/pseries: Correct secvar format representation
 for static key management
To: Andrew Donnellan <ajd@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20250430090350.30023-1-ssrish@linux.ibm.com>
 <20250430090350.30023-2-ssrish@linux.ibm.com>
 <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <87e1185273ce21e5fd69ff071a1be986c2a0301a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oD1gVoxlLOwlz-tQ37K3oxNxipaz2nGU
X-Proofpoint-GUID: Qbb7VxQdaELoKldB5GBBY37Do6Vk87eE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDE3NSBTYWx0ZWRfX+h29MpY/uKbH Ub4jUdmEYIR7+kZKUMAC1jLkAEUXPRtLWAyd6HhvSSGMaV+T6+4ZpZsD3aCfWDmULb8bvMqFwtn 5FaaVCC+fuJTzZrOLNKDrIWIoO2HkMGpUK3jfXO3Q0H96aW3kdDYkN0tqjBmtwWyZnNUroWEBZu
 jNzqbNKqvrmS94hI0dn/DyzGbhJHeNNArcZ3/PuHOEe1AGw871puRyXhOe0AezmeJOADQCM6fc/ gwQl/8KcT1YGg+qNX0VBfk28MWug/xYRk5rgoNSY4f29JqRZrfJQjtFJ/4pJJ2viVYddv2fDDjH ErqlOzbdjV5sOr0Teq5cqz1scDEw1ASNpUUO06NUTd0rbJNsKv7lTHr/soNuGHyS/STZlfn1a5h
 m763HGQbBUc+0LkN7AedAarlaYDuhh9qG7vdZ/RwGEGQQwm6KEgdvPj3bxdk66D7LaWDKmim
X-Authority-Analysis: v=2.4 cv=FJcbx/os c=1 sm=1 tr=0 ts=681a5c32 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=1mVJ_uiqAAAA:8 a=VnNF1IyMAAAA:8 a=29poTW6gvZIBSQWbZqAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=h67g7WpEjx8dfGT80pje:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_08,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505060175


On 5/5/25 2:06 PM, Andrew Donnellan wrote:
> On Wed, 2025-04-30 at 14:33 +0530, Srish Srinivasan wrote:
>> On a PLPKS enabled PowerVM LPAR, the secvar format property for
>> static
>> key management is misrepresented as "ibm,plpks-sb-unknown", creating
>> reason for confusion.
>>
>> Static key management mode uses fixed, built-in keys. Dynamic key
>> management mode allows keys to be updated in production to handle
>> security updates without firmware rebuilds.
>>
>> Define a function named plpks_get_sb_keymgmt_mode() to retrieve the
>> key management mode based on the existence of the SB_VERSION property
>> in the firmware.
>>
>> Set the secvar format property to either "ibm,plpks-sb-v1" or
>> "ibm,plpks-sb-v0" based on the key management mode, and return the
>> length of the secvar format property.
>>
>> Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/plpks-secvar.c | 70 +++++++++++------
>> --
>>   1 file changed, 40 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c
>> b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> index 257fd1f8bc19..d57067a733ab 100644
>> --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
>> +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
>> @@ -152,39 +152,49 @@ static int plpks_set_variable(const char *key,
>> u64 key_len, u8 *data,
>>   	return rc;
>>   }
>>   
>> -// PLPKS dynamic secure boot doesn't give us a format string in the
>> same way OPAL does.
>> -// Instead, report the format using the SB_VERSION variable in the
>> keystore.
>> -// The string is made up by us, and takes the form "ibm,plpks-sb-
>> v<n>" (or "ibm,plpks-sb-unknown"
>> -// if the SB_VERSION variable doesn't exist). Hypervisor defines the
>> SB_VERSION variable as a
>> -// "1 byte unsigned integer value".
>> -static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
>> +/*
>> + * Return the key management mode.
>> + *
>> + * SB_VERSION is defined as a "1 byte unsigned integer value". It is
>> owned by
>> + * the Partition Firmware and its presence indicates that the key
>> management
>> + * mode is dynamic. Only signed variables have null bytes in their
>> names.
>> + * SB_VERSION does not.
>> + *
>> + * Return 1 to indicate that the key management mode is dynamic.
>> Otherwise
>> + * return 0, indicating that the key management mode is static.
>> + */
> This description isn't accurate.
>
> For dynamic mode, it doesn't return 1, it returns whatever version is
> defined in SB_VERSION, which could be 1, or could at some later point be
> a higher version.
>
> Which makes the function name a bit of a misnomer too - it is returning
> the version number, just the version number can now be zero.
Hi Andrew,
Thanks a lot for your feedback.

Thanks for noticing this. Yes, will fix it.
>
>> +static u8 plpks_get_sb_keymgmt_mode(void)
>>   {
>> -	struct plpks_var var = {0};
>> -	ssize_t ret;
>> -	u8 version;
>> -
>> -	var.component = NULL;
>> -	// Only the signed variables have null bytes in their names,
>> this one doesn't
>> -	var.name = "SB_VERSION";
>> -	var.namelen = strlen(var.name);
>> -	var.datalen = 1;
>> -	var.data = &version;
>> -
>> -	// Unlike the other vars, SB_VERSION is owned by firmware
>> instead of the OS
>> -	ret = plpks_read_fw_var(&var);
>> -	if (ret) {
>> -		if (ret == -ENOENT) {
>> -			ret = snprintf(buf, bufsize, "ibm,plpks-sb-
>> unknown");
>> -		} else {
>> -			pr_err("Error %ld reading SB_VERSION from
>> firmware\n", ret);
>> -			ret = -EIO;
>> -		}
>> -		goto err;
>> +	u8 mode;
>> +	ssize_t rc;
>> +	struct plpks_var var = {
>> +		.component = NULL,
>> +		.name = "SB_VERSION",
>> +		.namelen = 10,
>> +		.datalen = 1,
>> +		.data = &mode,
>> +	};
>> +
>> +	rc = plpks_read_fw_var(&var);
>> +	if (rc) {
>> +		pr_info("Error %ld reading SB_VERSION from
>> firmware\n", rc);
> We need to check for -ENOENT, otherwise this message is going to be
> printed every time you boot a machine in static mode.
Yes, I agree with your concern. I just want to add that, as per my 
understanding, we need to check for both -ENOENT and -EPERM,
as explained below:

As per H_PKS_READ_OBJECT semantics described in the PAPR v10.60 
(https://files.openpower.foundation/s/XFgfMaqLMD5Bcm8),

* If the object is not world readable, verify that the consumer password 
matches the stored value in the hypervisor. Else return H_AUTHORITY.
* Verify if the object exists, else return H_NOT_FOUND.
* Verify if the policy for the object is met, else return H_AUTHORITY.

So, the hypervisor returns H_NOT_FOUND only for the authenticated 
consumer. For unauthenticated consumers, which is the case here,
it would return H_AUTHORITY.
> I think you should handle this as the existing code does: if it's
> ENOENT, return 0, and for other codes print an error and return -EIO.
Currently, the other layers in the boot stack assume static key mode for 
any failure in reading SB_VERSION. We added the same interpretation
in the kernel to keep it consistent with the other layers, and represent 
the same to the user. This is the reason for not parsing the error codes
when trying to read SB_VERSION, and defaulting to the static key 
management mode. However, we want the exact error code to be logged
for debugging purposes. And, it does make sense to have logging only for 
error codes other than -ENOENT and -EPERM, as you suggested.
Does this sound okay?
>
>> +		mode = 0;
>>   	}
>> +	return mode;
>> +}
>>   
>> -	ret = snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
>> -err:
>> -	return ret;
>> +// PLPKS dynamic secure boot doesn't give us a format string in the
>> same way
>> +// OPAL does. Instead, report the format using the SB_VERSION
>> variable in the
>> +// keystore. The string, made up by us, takes the form "ibm,plpks-
>> sb-v<n>".Set
>> +// the secvar format property to either "ibm,plpks-sb-v1" or
>> "ibm,plpks-sb-v0",
>> +// based on the key management mode, and return the length of the
>> secvar format
>> +// property.
>> +static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
>> +{
>> +	u8 mode;
>> +
>> +	mode = plpks_get_sb_keymgmt_mode();
>> +	return snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", mode);
> It might be better to use something like "ibm,plpks-sb-static" in place
> of "ibm,plpks-sb-v0" to make it instantly clear that static mode
> doesn't use the same version numbering scheme as dynamic mode.
Sure.

Thanks and Regards,
Srish
>
>>   }
>>   
>>   static int plpks_max_size(u64 *max_size)

