Return-Path: <linux-integrity+bounces-888-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A1983CBCF
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 20:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8281C21664
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C479C7;
	Thu, 25 Jan 2024 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lgb0GB5W"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CFC111AA
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209398; cv=none; b=SzOwf2cqx4o+ntZs7wnIH8GWU9YEvocf9VFRneHUxca8OGjwPHPrKYPAL/6EMULwV4iQrR9mMQe1mArSSg3sJ9oUbrR5MdB19UGSXJorQXSJXNToUSmrwapombH9OKTYOiwIPAB8RdaOQ379VeNTH4kRvE2ZxwO4RcXyP1iRjto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209398; c=relaxed/simple;
	bh=UyQ7baFXCvDKZG7h1X1KET79K+M1k7gNXhapQuIeweo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8Wd2YpRAYaUS0lp3kZuOfADnFT7e7vpD+Zp3b9kb/jSHEKP4HMtDXT3YIHC8G25SsluOf6+ICmjEfIcVCBJ8EqyOdaRiCu9pYbvm08Y2gsUt3kkvWLoTTFGsBvxnk1bD+HmFrOAi8o9kW4cg3elRMlPrX4JtVntCA4DgbmtBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lgb0GB5W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4094A20E56B9;
	Thu, 25 Jan 2024 11:03:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4094A20E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706209396;
	bh=D1T7algiUcMPxXRP8Zi7lyeKEJFua9zPhLw3U+ranoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lgb0GB5Weej/LzlBhwgz/XV56uxOR7xSl8LbRuN9OYn/eDkPnQbiPluMoGRIFd15Y
	 kO/Xs5V1q2UWK5SSBxOXolA+5Y3x+xcUZPdpmn2Z/6HWpuDeIwKDY+DIzCgrFTLrlI
	 uS0XOvfauMR4Dv5pETAM/ngtzzLwyVIuoPK/HfSU=
Message-ID: <7aec91f8-9284-4c66-bbcd-0d29a9e56881@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:03:15 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
 <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Mimi.


On 1/24/24 05:33, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Mon, 2024-01-22 at 10:37 -0800, Tushar Sugandhi wrote:
> 
> Missing from this and the other patch descriptions is the problem
> description.  Please refer to the section titled  "Describe your changes" in
> https://docs.kernel.org/process/submitting-patches.html.
> 
> "Describe your problem.  Whether your patch is a one-line bug fix or 5000 lines
> of a new feature, there must be an underlying problem that motivated you to do
> this work.  Convince the reviewer that there is a problem worth fixing and that
> it makes sense for them to read past the first paragraph."
> 
> In this case, "why" you need to refactor ima_dump_measurement_list() is the
> problem.
> 
Thanks.  I will revisit all the patch descriptions in this series to 
take into account the 'why' specific to that particular patch.

> For example:
> 
> Carrying the IMA measurement list across kexec requires allocating a buffer and
> copying the measurement records.  Separate allocating the buffer and copying the
> measurement records into separate functions in order to allocate the buffer at
> kexec "load" and copy the measurements at kexec "execute".
> 
Appreciate you giving an example in this case.
I will try to follow it in other patches too.

> "Once the problem is established, describe what you are actually doing about it
> in technical detail.  It's important to describe the change in plain English for
> the reviewer to verify that the code is behaving as you intend it to."
> 
>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_file_buf() which allocates buffer
>> of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
>> ima_kexec_file in function ima_dump_measurement_list() as local static to
>> the file, so that it can be accessed from ima_alloc_kexec_file_buf().
>> Make necessary changes to the function ima_add_kexec_buffer() to call the
>> above two functions.
> 
> Please make this into an unordered list.
> 
Will do.

Thanks again.

~Tushar

