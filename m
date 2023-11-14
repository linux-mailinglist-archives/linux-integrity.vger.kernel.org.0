Return-Path: <linux-integrity+bounces-48-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E03327EB98B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 23:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96809281312
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751426AC1;
	Tue, 14 Nov 2023 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RxR/755m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57021357
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 22:44:01 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E920793
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 14:43:59 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5430E20B74C2;
	Tue, 14 Nov 2023 14:43:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5430E20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700001839;
	bh=DTc2qI/cZVPNaic5xevm4U4kECb0RQDfzyicQEiAl80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxR/755mlILU85NviXtztSvQq2FPqlIPSdWnIQla9CLQQNb7l6/qwSYu406tYDaBj
	 axMesGQipP4CqQSv3Ix5gk5p4FCa6f5K3EktaOrBke2IlGrTBzGRGPjwcmWyN+Fjkq
	 /cbKl794sWl4Zx6FG7wP21MaHMKR+nWxU7lDMJF0=
Message-ID: <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:43:58 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
 <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/23 06:08, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>> In the current IMA implementation, ima_dump_measurement_list() is called
>> during the kexec 'load' operation.  This can result in loss of IMA
>> measurements taken between the 'load' and 'execute' phases when the
>> system goes through Kexec soft reboot to a new Kernel.  The call to the
>> function ima_dump_measurement_list() needs to be moved out of the
>> function ima_add_kexec_buffer() and needs to be called during the kexec
>> 'execute' operation.
>>
>> Implement a function ima_update_kexec_buffer() that is called during
>> kexec 'execute', allowing IMA to update the measurement list with the
>> events between kexec 'load' and 'execute'.  Move the
>> ima_dump_measurement_list() call from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer().  Make ima_kexec_buffer and kexec_segment_size
>> variables global, so that they can be accessed during both kexec 'load'
>> and 'execute'.  Add functions ima_measurements_suspend() and
>> ima_measurements_resume() to set and reset the 'suspend_ima_measurements'
>> variable respectively, to suspend/resume IMA measurements.  Use
>> the existing 'ima_extend_list_mutex' to ensure that the operations are
>> thread-safe.  These function calls will help maintaining the integrity
>> of the IMA log while it is being copied to the new Kernel's buffer.
>> Add a reboot notifier_block 'update_buffer_nb' to ensure
>> the function ima_update_kexec_buffer() gets called during kexec
>> soft-reboot.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> The lengthiness and complexity of the patch description is an
> indication that the patch  needs to be broken up.  Please refer to
> Documentation/process/submitting-patches.rst  for further info.
> 
> In addition, this patch moves the function ima_dump_measurement_list()
> to a new function named ima_update_kexec_buffer(), which is never
> called.   The patch set is thus not bisect safe.
>  > [...]
>> +void ima_measurements_suspend(void)
>> +{
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	atomic_set(&suspend_ima_measurements, 1);
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +}
>> +
>> +void ima_measurements_resume(void)
>> +{
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	atomic_set(&suspend_ima_measurements, 0);
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +}
> 
> These function are being defined and called here, but are not enforced
> until a later patch.   It would make more sense to introduce and
> enforce these functions in a single patch with an explanation as to why
> suspend/resume is needed.
> 
> The cover letter describes the problem as "... new IMA measurements are
> added between kexec 'load' and kexec 'execute'".    Please include in
> the patch description the reason for needing suspend/resume, since
> saving the measurement records is done during kexec execute.
> 
Since I am introducing a few new functions in this patch set,
I am having hard time keeping the patches bisect safe and at the same 
time managing the length/complexity of the individual patches in the series.

I will go back and revisit the bisect-safeness of the patches in this 
series again.

Thanks for the feedback, appreciate it.

