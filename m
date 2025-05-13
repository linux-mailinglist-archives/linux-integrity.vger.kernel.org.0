Return-Path: <linux-integrity+bounces-6191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C881FAB5882
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BFC64C190E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A382BE0F2;
	Tue, 13 May 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VReNskEF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457421D555;
	Tue, 13 May 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149716; cv=none; b=mwF+HKfzmiKo8SOemBAcGiYiNmCE/manSB7gUWl1JYxpyVNo3T07vrG6k7Yclk0KxO2RgkYXZyluK/igmoFSD/c9btln+9vfn+R0Ri6A9RrSn/wwHPlYSEi3gag38VTnS+Bc8ubtg6hGLuGuYPcUxopQ5/mHU74m2uXXDjMDnZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149716; c=relaxed/simple;
	bh=vTad0k0Z95Cip0/QJKGFBGCXmnYML80Ek1w8efRTVlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+JDZz/mcDGfmoii5Kufm0sflDopUU/bCWZBCVMYHf55WTJUrZpMWiirxC6SdfFzdTHNCHC08VAPEIr9NrSe8lXvTMG7K7bRh0U9D+JFs8Djh4d1g7caEuylCYiRW5sNGwM2fwtvBnvIyOJC+b6j9O4Xcn6F4SDmuT8Umua+TKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VReNskEF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.65.85] (unknown [20.1.194.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 873B5201DB17;
	Tue, 13 May 2025 08:21:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 873B5201DB17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747149714;
	bh=hb7Kk1GYJlwj73IqJFxNS4iF7nkINP060GXNS8ftp34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VReNskEFToT5zqzhoNgTGn+GoXBLuNeT62GG3iA7pbi/R2DhrjIel2HDliQdlITxi
	 tFvCbJXJD9HwWiokiU0dGQle3wzjFNbYme0tM/V0/sQKICee4ieBmpsgWMLMX0hWGQ
	 /C2L+BV8mL0Q7A6vEYk3jJUcPsBxSHGb8jTfOxIg=
Message-ID: <71439e57-87e2-436f-ba55-77c0539e9538@linux.microsoft.com>
Date: Tue, 13 May 2025 08:21:51 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
 <aCKtlthQWnq+xyat@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aCKtlthQWnq+xyat@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/2025 7:25 PM, Baoquan He wrote:
> On 05/02/25 at 01:03pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> Kdump kernel doesn't need IMA to do integrity measurement.
>> Hence the measurement list in 1st kernel doesn't need to be copied to
>> kdump kenrel.
>>
>> Here skip allocating buffer for measurement list copying if loading
>> kdump kernel. Then there won't be the later handling related to
>> ima_kexec_buffer.
>>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 3 +++
>>   1 file changed, 3 insertions(+)
> I applied this patch on top of below IMA patchset, and did a test.
> [PATCH v13 0/9] ima: kexec: measure events between kexec load and execute
>
> When I loaded kdump kernel as below with '-d' specified:
>
> /sbin/kexec -s -d -p --command-line=BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.15.0-rc6+ ro console=ttyS0,115200N81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 pcie_ports=compat disable_cpu_apicid=0 --initrd=/boot/initramfs-6.15.0-rc6+kdump.img /boot/vmlinuz-6.15.0-rc6+
>
> I can see that this patch works to skip copying measurement list to kdump
> kernel as expected..
>
> =====Without this patch===
> [48522.060422] kexec_file: kernel: 000000006fbcb87f kernel_size: 0xe99200
> [48522.067742] PEFILE: Unsigned PE binary
> [48522.094849] ima: kexec measurement buffer for the loaded kernel at 0x6efff000.
> [48522.102982] crash_core: Crash PT_LOAD ELF header. phdr=00000000cae5d7e6 vaddr=0xffff8da640100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
> ......snip...
> =====
>
> =====With this patch applied====
> [ 2101.704125] kexec_file: kernel: 0000000046d8985c kernel_size: 0xeab200
> [ 2101.711436] PEFILE: Unsigned PE binary
> [ 2101.734752] crash_core: Crash PT_LOAD ELF header. phdr=000000006fc83a51 vaddr=0xffff899480100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
> ......snip...
> =====>
>
> My only concern is the patch subject is not very sepcific, it better
> relfect the exact action taken in this patch, like:
>
> ima: do not copy measurement list to kdump kernel
>
> Other than above concern, please feel free to add my:
>
> Tested-by: Baoquan He <bhe@redhat.com>
> Acked-by: Baoquan He <bhe@redhat.com>
Thanks!
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 38cb2500f4c3..7362f68f2d8b 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	void *kexec_buffer = NULL;
>>   	int ret;
>>   
>> +	if (image->type == KEXEC_TYPE_CRASH)
>> +		return;
>> +
>>   	/*
>>   	 * Reserve extra memory for measurements added during kexec.
>>   	 */
>> -- 
>> 2.43.0
>>


