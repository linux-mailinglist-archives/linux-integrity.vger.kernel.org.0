Return-Path: <linux-integrity+bounces-47-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A93A7EB963
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAC7B20A60
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763633306D;
	Tue, 14 Nov 2023 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OuZMcGSP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5D333072
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 22:32:58 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99F99E5
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 14:32:57 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1306B20B74C2;
	Tue, 14 Nov 2023 14:32:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1306B20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700001177;
	bh=R7/pji8gSwiSfK6k5FLodmvIRwrivnz7us3IJ3dk/io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OuZMcGSPmN9IHi7zLj9D/Vbu68wR1XT9qm2HerVSJz+ApkO2NdMqtdY4v0shN4Ug+
	 afMsJmyqXu+SUwtnyO3d4ne6DTFrndtplOHa7L3ihqoF2XITf+E7FzZqBZoBFC7/e4
	 NjdUaVRq6ledcDEgOJtRFHpLqK6/6XA/EXYJPFIQ=
Message-ID: <2c9e3b71-5416-4336-82f1-cd78e26dd62e@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:32:57 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] ima: refactor ima_dump_measurement_list to move
 memory allocation to a separate function
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-2-tusharsu@linux.microsoft.com>
 <1aa5524b52fdb46df4948a21b1139cf833758cde.camel@linux.ibm.com>
 <e4e92a1816475596b91bbbb2fdf33c11ce375cf1.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e4e92a1816475596b91bbbb2fdf33c11ce375cf1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/23 20:25, Mimi Zohar wrote:
> On Thu, 2023-10-26 at 16:16 -0400, Mimi Zohar wrote:
>> Hi Tushar,
>>
>> According to Documentation/process/submitting-patches.rst, the subject
>> line should be between 70-75 characters.
>>
>> Perhaps something like "ima: define and call ima_alloc_kexec_buffer()".
>>
>> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>>> IMA allocates memory and dumps the measurement during kexec soft reboot
>>> as a single function call ima_dump_measurement_list().  It gets called
>>> during kexec 'load' operation.  It results in the IMA measurements
>>> between the window of kexec 'load' and 'execute' getting dropped when the
>>> system boots into the new Kernel.  One of the kexec requirements is the
>>> segment size cannot change between the 'load' and the 'execute'.
>>> Therefore, to address this problem, ima_dump_measurement_list() needs
>>> to be refactored to allocate the memory at kexec 'load', and dump the
>>> measurements at kexec 'execute'.  The function that allocates the memory
>>> should handle the scenario where the kexec load is called multiple times
>>
>> The above pragraph is unnecessary.
>>
>>> Refactor ima_dump_measurement_list() to move the memory allocation part
>>> to a separate function ima_alloc_kexec_buf() to allocate buffer of size
>>> 'kexec_segment_size' at kexec 'load'.  Make the local variables in
>>> function ima_dump_measurement_list() global, so that they can be accessed
>>> from ima_alloc_kexec_buf().  Make necessary changes to the function
>>> ima_add_kexec_buffer() to call the above two functions.
>>
>> Fix the wording based on the suggested changes below.
>>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>
>> - Before re-posting this patch set, verify there aren't any
>> "checkpatch.pl --strict" issues.
>> - After applying each patch, compile the kernel and verify it still
>> works.
> 
> Doing this will detect whether or not the patch set is bisect safe.
> 
I usually just do checkpatch.pl <.patch file>.
I didn't know about --strict and it's benefits.
Will do it going forward.


>>> ---
>>>   security/integrity/ima/ima_kexec.c | 126 +++++++++++++++++++++--------
>>>   1 file changed, 93 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>>> index 419dc405c831..307e07991865 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -15,61 +15,114 @@
>>>   #include "ima.h"
>>>   
>>>   #ifdef CONFIG_IMA_KEXEC
>>> +struct seq_file ima_kexec_file;
>>
>> Define "ima_kexec_file" as static since it only used in this file.
>> Since the variable does not need to be global, is there still a reason
>> for changing its name?   Minimize code change.
> 
> Adding "static" would make ima_kexec_file a global static variable.
> Please ignore my comment about reverting the variable name change.
> 
> Mimi
> 
Sure :)

~Tushar
...

