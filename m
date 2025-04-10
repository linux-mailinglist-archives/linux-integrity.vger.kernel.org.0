Return-Path: <linux-integrity+bounces-5779-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E7A84A92
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAAB3B4CB9
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C3B1E9B14;
	Thu, 10 Apr 2025 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JHT8LCdC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555581EE7DA;
	Thu, 10 Apr 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304387; cv=none; b=du2KgvecShP9APFd0V3ykowGL1HefNhc9n8gnMz3T8kL/p78/MYgnRFcY8pXW3CvFXvQ3FytEjIOidLXbsPz5XjUPr1dAahUK0QfAe9mpSCs84sa/MO3FpCwROCq3gUCF7QWOsZnTCRVR6YLF4BOkNYulxBuLJfuhugl+35FtOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304387; c=relaxed/simple;
	bh=ud40hiuGG5TAQs7UCvIro5914kQp42ofgoH6rUYjU1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrXFHcCI2tsBUAwp+72AZ7HsTWktNdB9WCJQNGDBfpeMKgLYYOg5TFVX+2m/v1I+MUOtlgSVDgdB7dgi3zjPwgVDK8j+jTZD6uLtY9p4d0/rhLS4wShEQvVBSuphVNxQ4eSjhLwfOoO266fGEmgKoz3lPFudA7XkaXFoimBlkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JHT8LCdC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.65.11] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C81DA2113E87;
	Thu, 10 Apr 2025 09:59:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C81DA2113E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744304385;
	bh=vxXwkdEOn7BTRh/cnvKn+B0GcVvl6i4koOpR5p1bqWc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JHT8LCdCXgjdyTqcygVEM0A4oBfxyGSsACAFVgSqpF/r46yj9ypHpbSf9+HHuLb0X
	 pmX4Hwe5MUrRUG6uvpniItcbSKg3gVhZwQfhXHOUMDNCscbXA/4LlNcntMgVGA1fl7
	 7Dm1oub7U52nP9dRwCvWoI+slg2g3jGZNsdYjDak=
Message-ID: <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
Date: Thu, 10 Apr 2025 09:59:41 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-9-chenste@linux.microsoft.com>
 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/2025 2:54 AM, Baoquan He wrote:
> On 04/02/25 at 05:47am, steven chen wrote:
>> The extra memory allocated for carrying the IMA measurement list across
>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added during
>> kexec soft reboot.  Ensure the default value of the option is set such
>> that extra half a page of memory for additional measurements is allocated
>> for the additional measurements.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hard-coded one.
>>
>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/ima/Kconfig     | 10 ++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 475c32615006..d73c96c3c1c9 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>>   
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>> +	depends on IMA_KEXEC
>> +	default 0
> Usually a new Kconfig item which accepts a range should define the range
> boundary, otherwise it's not clear to people how large or how small it
> can be set. For example, can I set it as value of 1<<40? We should at
> least estimate a possible upper limit for it for other people's
> reference. My personal opinion.

Hi Baoquan,

How about I set range 2-40? Default set as 2, same as the fixed setting.

Thanks,

Steven

> The rest looks good to me.
>
>
>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>> +	  If set to the default value of 0, an extra half page of memory for those
>> +	  additional measurements will be allocated.
>> +
>>   endif
> ...snip...



