Return-Path: <linux-integrity+bounces-762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FA82C55A
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4501F247FB
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jan 2024 18:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F625610;
	Fri, 12 Jan 2024 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Z94CzjSn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E22560A
	for <linux-integrity@vger.kernel.org>; Fri, 12 Jan 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C41020B3CDE;
	Fri, 12 Jan 2024 10:23:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C41020B3CDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705083828;
	bh=gpxTcvKnkoBsHVJNPTQQphS77esyYUMo75E4RxbL2x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z94CzjSnbTd/Zr7L4YugLYetotrKcRgm4vMmsgdyzJS+6gyjvHChRAdvNWv12x68H
	 E10T9asTjMJtM8CiQv12PDU4V150aFF9ygovIuXsc8Tuj0exOkQd/7U2jWw1jt9cOQ
	 H+1l9j6GtA9taAh8vy4bpYbcTwm2p6RdbxyEIXK8=
Message-ID: <a09613f2-0d9f-41a3-b78d-b1b1fd35614c@linux.microsoft.com>
Date: Fri, 12 Jan 2024 10:23:47 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
 <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
 <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
 <6acf82dcefd349941b05ff2a3b7e4bf651dc4429.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <6acf82dcefd349941b05ff2a3b7e4bf651dc4429.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/12/24 09:44, Mimi Zohar wrote:
> On Thu, 2024-01-11 at 12:52 -0800, Tushar Sugandhi wrote:
> [...]
>> If we go with the KBs approach -
>>
>> half-a-page translates to different KBs on different architectures.
>> And setting the right default value in KBs which would translate to
>> the desired half-a-page, on a given arch, inside the Kconfig seems
>> fragile (as I mentioned in the context of Option A in my previous
>> response.
> 
> How about setting the default value to 0, indicating not to change the current
> half page default.  Any other value would be KBs, as Stefan suggested.
> 
Thanks.
That's way more elegant than the other alternatives.
It's definitely doable in KConfig and handle the default in code 
appropriately.

It may cause some confusion in the documentation of the config param.
But it would be a wording issue, and we can work on it.

Thanks for the suggestion.  I like it honestly.

~Tushar

