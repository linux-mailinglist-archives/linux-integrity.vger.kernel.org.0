Return-Path: <linux-integrity+bounces-5977-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0036A95771
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 22:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9025C171CDE
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 20:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004D1F0E37;
	Mon, 21 Apr 2025 20:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZYBrkbU/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF191EFFBB;
	Mon, 21 Apr 2025 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745268065; cv=none; b=cVEOvG9czqlAZPSGrYNyY3zZFhKqlukHVeNyj3KOzFBxx+kP9gTLnrZhRGdWMVHpPFBXfbHxqPAJ874iE/oKx5xGaBBNc7XLz89HyaG+RMBQIR1/jqH8YaWPyR8B3wDceoU68XhTMmOTrw41GYFl3PkeitLCuHNkK4vgIHPF8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745268065; c=relaxed/simple;
	bh=k/KvvdmYqnq20t4QpYKRC5H2tOPmgmWGmQI2x5qrhVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+9LH9s8fvOmTL7uj3WJifE4qLeGCdUGphfZ2zcOZ2KXysTSjLFenSiLJj1ldimmjhlBnQi6NkmedzwYk7u1tMPC9bK8Lwcr5wBLSaWXaOtX2uIqCcI8OUk/LDDCoEdnf3WlZFgd/vRtTGqel/IzXNY853+z9JhQDzBwUirtRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZYBrkbU/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.226.168] (unknown [172.172.34.12])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D1FE203B867;
	Mon, 21 Apr 2025 13:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D1FE203B867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745268060;
	bh=g0iye+uMwzSnSSeghwU6QTJxGHXm0NSZS7e1/drAZPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZYBrkbU/LFFdjvk6DLcNcYdLDKhhaGSQR/VM+5s0eBYMJ1WmqQvw2jeEg+kjCCJcr
	 mAZrX5xhGwPSSokj4TSa6TuNWe4itLJKu6yqKfDtdvb6ksfjPB/Ztl36SqHC6mcAdR
	 PVjR03iqBgEl8blRnYvobIEdJlyW2oh2xpSBveQM=
Message-ID: <a9e3713f-4edf-479c-8be1-fe5b3dc22866@linux.microsoft.com>
Date: Mon, 21 Apr 2025 13:40:56 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap segments
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-4-chenste@linux.microsoft.com>
 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
 <dcde124baec01318e661f5430ce8a008a6d196c0.camel@linux.ibm.com>
 <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <ef18ae186cd17431b9ff6b8a443b63fd6fb78b98.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/2025 7:18 AM, Mimi Zohar wrote:
> On Mon, 2025-04-21 at 09:51 -0400, Mimi Zohar wrote:
>> On Fri, 2025-04-18 at 12:36 +0800, Baoquan He wrote:
>>> On 04/15/25 at 07:10pm, steven chen wrote:
>>>> From: Steven Chen <chenste@linux.microsoft.com>
>>>   ^^^^^^
>> As James Bottomley previously explained[1], if you haven't made any changes to
>> Tushar's patch, then the very first line of the patch description would be
>> "From: Tushar Sugandhi <tusharsu@linux.microsoft.com>" followed by a blank line.
>> If there is a minor change, you would add "<your email address>: explanation".
>> For example:
>>
>> Steven Chen <chenste@linux.microsoft.com>: modified patch description
> To clarify: This line would be included below with your Signed-off-by tag.
>
>> [1]
>> https://lore.kernel.org/lkml/58e70121aaee33679ac295847197c1e5511b2a81.camel@HansenPartnership.com/
>>
>>>> Implement kimage_map_segment() to enable IMA to map the measurement log
>>>> list to the kimage structure during the kexec 'load' stage. This function
>>>> gathers the source pages within the specified address range, and maps them
>>>> to a contiguous virtual address range.
>>>>
>>>> This is a preparation for later usage.
>>>>
>>>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>>>
>>>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>    ^^^^^^
>> Neither "Author:" nor "From:" belong here.  Please remove.
>>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>    ^^^^^^^
>> Having Tushar's "Signed-off-by" tag and yours below indicate that you modified
>> the original author's patch.
> To clarify: "Just" having Tushar's "Signed-off-by" tag and yours below indicate
> that you modified the original author's patch.

Hi Mimi,

I will update it in next version.

Just wandering are you done reviewing or still need more time?

Thanks,

Steven

>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> Cc: Baoquan He <bhe@redhat.com>
>>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>>> Cc: Dave Young <dyoung@redhat.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>    ^^^^^
>>>
>>> The signing on this patch is a little confusing. I can't see who is the
>>> real author, who is the co-author, between you and Tushar. You may need
>>> to refer to Documentation/process/5.Posting.rst to make that clear.
>>>
>>>> Acked-by: Baoquan He <bhe@redhat.com>



