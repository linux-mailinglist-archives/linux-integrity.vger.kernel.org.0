Return-Path: <linux-integrity+bounces-50-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90477EBA37
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 00:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAF31C20898
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 23:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6C42FC21;
	Tue, 14 Nov 2023 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="moon6mDb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD452FC22
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 23:24:57 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EE61D9
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 15:24:56 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE6F420B74C1;
	Tue, 14 Nov 2023 15:24:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE6F420B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700004295;
	bh=a/ZQT3bhMqeTYxXiFgqx+wGE/tuZrVWf7f5xrC8MgJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=moon6mDbKllcLqtBGGJLJ5iAYmVVJO21o+ne7xpDose2wc4dVPnsr57BeIXRTvH9f
	 gYOxKQHCflYgZqnT3/cVQE0L6HY4xYEYLkeM/gAwj73yHmA7TiyNsCXqiuI7xRlO8e
	 8iFjMJJNYnDW+JI7kuQxFwAIaj/adwce4bNndGLw=
Message-ID: <731f818d-0e48-45f8-b009-91bd6abad704@linux.microsoft.com>
Date: Tue, 14 Nov 2023 15:24:55 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ima: kexec: measure events between kexec load and
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f87e7e4fe5c5a24cdc0d3e2267eeaf00825d1bb.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/23 08:18, Mimi Zohar wrote:
> On Thu, 2023-10-05 at 11:25 -0700, Tushar Sugandhi wrote:
>> The current Kernel behavior is IMA measurements snapshot is taken at
>> kexec 'load' and not at kexec 'execute'.  IMA log is then carried
>> over to the new Kernel after kexec 'execute'.
>>
>> Some systems can be configured to call kexec 'load' first, and followed
>> by kexec 'execute' after some time.  (as opposed to calling 'load' and
>> 'execute' in one single kexec command).
> 
> Additional measurements may be introduced by the kexec load itself.
> Saving the measurement list as close as possible to the reboot is
> beneficial, whether or not the kexec load and kexec execute are
> executed separately.
> 
True. What I am trying to say here is the longer the window between
'load' and 'execute', greater are the chances of measurements getting
added.
But as long as a single measurement gets added between 'load' and
'execute', it will break the attestation after kexec soft-reboot.

So maybe the above line in the patch description is not necessary.
I will remove.

>> In such scenario, if new IMA
>> measurements are added between kexec 'load' and kexec 'execute', the
>> TPM PCRs are extended with the IMA events between 'load' and 'execute'.
>> But those IMA events are not carried over to the new Kernel after kexec
>> soft reboot.  This results in mismatch between TPM PCR quotes, and the
>> actual IMA measurements list, after the system boots into the new kexec
>> image.  This mismatch results in the remote attestation failing for that
>> system.
>>
>> This patch series proposes a solution to solve this problem by allocating
>> the necessary buffer at kexec 'load' time, and populating the buffer
>> with the IMA measurements at kexec 'execute' time.
> 
> How about beginning the paragraph with "To solve this problem allocate
> ... and populate ..."
> 
Sure. Will do.

~Tushar

