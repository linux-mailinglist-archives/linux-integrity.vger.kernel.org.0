Return-Path: <linux-integrity+bounces-891-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C08ED83CC07
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D40B249A4
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 19:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C15C1350CE;
	Thu, 25 Jan 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WwCnL77I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0855613474C
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210175; cv=none; b=Go7xYIzzbasbJNKjbOaNb/43GzQMj8VKYMcEIEJtHcpyrj7EJQ1ZY7YbosAfRIKtz1ZIkg5TtvOoUzeGedWi0p4cv28wG6rNbt8dZCSmJyNczVvJDbeNOMSC+Fv86Rei1OkeKo1aQ+Afk0j717N/pY9WtvijunuzBedXbiM7Yiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210175; c=relaxed/simple;
	bh=FY3mIXOFXdmjySn/uSVm1etI+xStKOObdxGsMjn86Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHgYrQM4tYwwphNES3SveZw1nZorVclZ/YIlIkrWx2jmVNTBh3IL8eAyXkx1gXIXm4a/NhYW7560riLXP9StZ/hZGkU0viAz8lbZJUj72akLNrFNxh0IDwymsJs6VgpzLI+w0S7Hx9Mzv1p6cGYk6XNodv+0jiP+eHgQLHTLnjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WwCnL77I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7BAEB20E56B9;
	Thu, 25 Jan 2024 11:16:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BAEB20E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706210173;
	bh=UHZMJ2OsiH095u2y17xITV2zIyr9WMiYCpVsdJpGjxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WwCnL77IIycm5PRY6u8vhvG3M64aiRKiWFRK4GSsx0ZdQ7/RTq4np3+Nqnvf6tsa4
	 dFta17N882f5c6fouOfQdAIrh6m/ZN9UdzsyKtiJIjmX52MgrAXSYieU1Wi5SQlOuX
	 g/KoZjK4CNsVoOzFsRHsMUkCyWCcFk2gHaEey5Ec=
Message-ID: <c8760b44-e742-49c2-809d-2120d4f93850@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:16:13 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-8-tusharsu@linux.microsoft.com>
 <494fc3a82053e71a33bccca3fe6683c59b78b6cf.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <494fc3a82053e71a33bccca3fe6683c59b78b6cf.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 06:35, Mimi Zohar wrote:
> On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
> 
> The problem statement could be written as:
> 
> The amount of memory allocated at kexec load, even with the extra memory
> allocated, might not be large enough for the entire measurement list.  The
> indeterminate interval between kexec 'load' and 'execute' could exacerbate this
> problem.
> 
> Mimi
> 
Thank you again for taking efforts to write one more example for me.
Appreciate it.

Will do.

~Tushar

>> There could be a potential mismatch between IMA measurements and TPM PCR
>> quotes caused by the indeterminate interval between kexec 'load' and
>> 'execute'.  The extra memory allocated at kexec 'load' for IMA log buffer
>> may run out.  It can lead to missing events in the IMA log after a soft
>> reboot to the new Kernel, resulting in TPM PCR quotes mismatch and remote
>> attestation failures.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> 

