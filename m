Return-Path: <linux-integrity+bounces-5774-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23192A84622
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C364C232C
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2228A41A;
	Thu, 10 Apr 2025 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n7LJlLUT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A3281369;
	Thu, 10 Apr 2025 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294559; cv=none; b=Y1cFNcnOeNSWX9LMbykr2W6hLAZYTgQdrUbllr11hy9gH5o34Wu4b/FdNGbUqdkrOuY1DNW09c1H4tFzFf8Ke77uIQmcl5fdrr5wmrt4JV/clMrRZROSbL14C4UxZ3203U4PavjDDNHHeNmE4AXP07VlhdOtA2lMvSpuB3j952s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294559; c=relaxed/simple;
	bh=LEbTWlzpaihB6IQHTlbaA5Ot/ypsjb5J6qcme4C6YZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCMv71okVNUtXYK1cgajqCIt61UubtQFwOThimM5kT3hzXWMmelJ58wHeSoZJoNIb1Pn6zF2D0it1SVNnBUH+G6RrS9AkH5JFSE0rtfpOo81mJw11onGorbqZePioDro2y1I+70BARPL12xG018kSMc9NYGj0mBJ9weEIjvuCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n7LJlLUT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.180] (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 680852113E88;
	Thu, 10 Apr 2025 07:15:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 680852113E88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294556;
	bh=XmfJAaDZRcuR0IspL/CV2qpL+dgL7BxJ5z1ZXihUDxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n7LJlLUTIHoUKqUDPHHPpZzH1WJi5CQ8KlXno+uTZvwvdN8pM4Z+WPo2tZqF/BKwG
	 0ktcd7KAKLp+gQVRrUeYUhJAPVHUk0l+0DtBVoLoHkF3BF8hLT8JYqFQ3Yui4nCDQg
	 sKieQ7MXh4X0Af+AcESsv9OuyreI5id5K4RRqudY=
Message-ID: <98c63e22-b9f7-40b9-90d0-aa67534f9107@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:15:52 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 6/9] ima: kexec: move IMA log copy from kexec load to
 execute
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-7-chenste@linux.microsoft.com>
 <96ae5a8efbcb894e096881f1dd7a4939ce0a9490.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <96ae5a8efbcb894e096881f1dd7a4939ce0a9490.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/2025 9:17 AM, Mimi Zohar wrote:
> On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot. Due to
>> missed measurements that only occurred after kexec 'load', this function
>> needs to be called during kexec 'execute'.
> Re-use the motivation from 5/9 (with tweak):
>
> The IMA log is currently copied to the new kernel during kexec 'load' using
> ima_dump_measurement_list(). However, the IMA measurement list copied at kexec
> 'load' may result in loss of IMA measurements records that only occurred after
> the kexec 'load'.
>
> And finish the paragraph with:
> Move the IMA measurement list log copy from kexec 'load' to 'execute'.
>
>> Make the kexec_segment_size variable a local static variable within the
>> file, so it can be accessed during both kexec 'load' and 'execute'.
>>   
>> Implement the kexec_post_load() function to be invoked after the new kernel
>> image has been loaded for kexec. Instead of calling machine_kexec_post_load()
>> directly from the kexec_file_load() syscall, call kexec_post_load(), which in
>> turn calls machine_kexec_post_load() to maintain the original image processing.
> Define kexec_post_load() as a wrapper for calling ima_kexec_post_load() and
> machine_kexec_post_load().  Replace the existing direct call to
> machine_kexec_post_load() with kexec_post_load().
>
>>   
>> Invoke ima_kexec_post_load() within the kexec_post_load() API only for kexec
>> soft reboot scenarios, excluding KEXEC_FILE_ON_CRASH.
> "Don't call ima_kexec_post_load() on KEXEC_FILE_ON_CRASH" would be listed in the
> Changelog if it changed, not here in the patch description.  Please remove.
>
>>   
>> Register a reboot notifier for the ima_update_kexec_buffer() API within
>> ima_kexec_post_load() to ensure it is called upon receiving a reboot
>> notification.
> Registering the reboot notifier was done in "[PATCH v11 5/9] ima: kexec: define
> functions to copy IMA log at soft boot", not here.  Please remove.
>
>>   
>> Move the ima_dump_measurement_list() call from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer() to copy the IMA log at the kexec 'execute' stage.
> This information was already stated in the first paragraph as part of the
> motivation for the patch.  Please remove.
>
>>   
>> When there is insufficient memory to copy all the measurement logs, copy as
>> much of the measurement list as possible.
> Is this comment still applicable to this patch?
>
> Please review your patch descriptions before posting, making sure that
> everything is still applicable.
>
> thanks,
>
> Mimi

Hi Mimi,

Thanks for your comments. I will update in next version.

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



