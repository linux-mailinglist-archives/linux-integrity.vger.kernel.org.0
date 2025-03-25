Return-Path: <linux-integrity+bounces-5424-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B90A70CE7
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 23:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A337A6030
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 22:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C97269D1B;
	Tue, 25 Mar 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ys7MDF98"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2197A269D04;
	Tue, 25 Mar 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941667; cv=none; b=qIup1Qhy2+9Rzyy2okgpboEiMNYlaC3+uIsn5SeClO2I123bX5jk/BGgz/hJEm2s7gjX2K0CN6J4FWDJIOe6U/i2q1EQ3yhqPnmIp7vduN3reMfj0a+aUBfpaxPhi9vC7IChlpSYsnl/T9JvaN1QNxqU/Kd9d+yv1olwMn9X6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941667; c=relaxed/simple;
	bh=I6Bh2Pj6j0LoG+gyB+9U4Am8CJTmsjj3+N2uNJx+TkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k6gznCpay4J1C0P44S+BOYY2BU2EKpR54ZzSPcSZbJsZnuwQMa0AGoZmIODpJByV6xkHBculQ41HAvughlzuqYhKc9ysTq/O+GgEkBd8csnFrIHpnN6WLTJIuia8SpG6wbAoi9jbzDmphHD8gzMlEgH9UWus5gFIHaalCYGQVoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ys7MDF98; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.173] (unknown [131.107.8.109])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AD04204E596;
	Tue, 25 Mar 2025 15:27:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AD04204E596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742941665;
	bh=yu+zl6twDuJmGCQvb+BJhKb1ZJUDVREmR4BMuDWngzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ys7MDF98d7F6l7lO9UCnXF/KFQKz7cXYNKkmxX7+w/ntWkDq23pjCzvFEabp0ldlI
	 yZr6ADwe2o1JSR5oVDNsw3uMxSyxVLVT+h+iKf2UIUheJgaUP+FqcD3CVAFghPZ4WW
	 GBj5l4/HREsMBvqHdkzChu8fcboRIvH/w57jXdeU=
Message-ID: <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
Date: Tue, 25 Mar 2025 15:27:44 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/2025 4:00 AM, Baoquan He wrote:
> On 03/21/25 at 09:23am, steven chen wrote:
>> On 3/19/2025 7:06 PM, Baoquan He wrote:
>>> On 03/17/25 at 06:04pm, steven chen wrote:
>>> ...snip...
>>>> ---
>>>>    kernel/kexec_file.c                | 10 ++++++
>>>>    security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>>>>    2 files changed, 40 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index 606132253c79..ab449b43aaee 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>>>>    }
>>>>    #endif
>>>> +static void kimage_file_post_load(struct kimage *image)
>>>> +{
>>>> +#ifdef CONFIG_IMA_KEXEC
>>>> +	ima_kexec_post_load(image);
>>>> +#endif
>>>> +}
>>>> +
>>>>    /*
>>>>     * In file mode list of segments is prepared by kernel. Copy relevant
>>>>     * data from user space, do error checking, prepare segment list
>>>> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>    	kimage_terminate(image);
>>>> +	if (!(flags & KEXEC_FILE_ON_CRASH))
>>>> +		kimage_file_post_load(image);
>>> machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
>>> we should use it to do things post load, but not introducing another
>>> kimage_file_post_load().
>> Hi Baoquan,
>>
>> Could you give me more detail about this?
> I mean machine_kexec_post_load() is the place where post load operations
> are done, including kexec_load and kexec_file_load. There's no need to
> specifically introduce a kimage_file_post_load() to do post load
> operaton for kexec_file_load.

Hi Baoquan,

Updating the machine_kexec_post_load() API to carry flags would indeed 
require changes to multiple files. This approach involves the condition 
check if (!(flags & KEXEC_FILE_ON_CRASH)) and ensuring that the flags 
are properly passed and handled across the relevant file

if just adding a API kimage_file_post_load() here, it is much easy and 
clean, right?

How do you think?

Thanks,

Steven


