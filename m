Return-Path: <linux-integrity+bounces-4987-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D1A44AC3
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 19:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B5E3AC886
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2025 18:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF9D14F9C4;
	Tue, 25 Feb 2025 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oGQjoobX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2718E34A;
	Tue, 25 Feb 2025 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508525; cv=none; b=BvFdyJwH1NGwnBIiW5mMSUMBUmCL6ho3eCGx9waJ/qkdlN50bRBUPnDjKBWnscNuIwA2BZT9fdB8d+wRGDayMPUw2ipd+GJG5J05yyA45yrFtd2zccNMgzRFxjwgElykcyB5UT5nTAFxzuRBPnTacslRSb49tdNNDwtpplVJMm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508525; c=relaxed/simple;
	bh=neE6Y//ifJeGR4oQHArgzrz7Pt53aD02tH8Z1xoqXRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2RXSvfCLeuqRQPAli7cpVFj7SN2G6tPc5fpijGJ113p2FOIM+47BelhPrZfyAseIPN651oi8MSYbvYZKBBnB/WNelaXwoo5aC0ubU53R1eKLOhurreuTcV794OKIpHnvtMslYDCfnuSZ/rwNS1CmTQD0VvpSAz500EgBWVRkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oGQjoobX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.147] (unknown [131.107.1.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95078203CDDE;
	Tue, 25 Feb 2025 10:35:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95078203CDDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740508523;
	bh=oAPMpgeQTX575axIRAvAGNwitPSc2FROHu2Kj3FuMr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oGQjoobXgkyRRqjRFRYg+q70hz6uhg5zsrVj8sKaiZST2hHQzUfdy24mpz723gJq3
	 wk6LbK9qyHkwSvnY/nWhMXJ+/pbvW5MV3urcV4jMxmRXdRhzymB2vjTgPaLEvtvDsr
	 QnlelFhG8GfsJ2T3GYOr1XpVnIav81F+3bT3m/g4=
Message-ID: <8504fd93-8fff-4fd9-8d2d-26b4e1e84bee@linux.microsoft.com>
Date: Tue, 25 Feb 2025 10:35:22 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-3-chenste@linux.microsoft.com>
 <Z7wOPiDfy/vtrkCS@MiWiFi-R3L-srv>
 <658b52e4-a4bb-40fc-a00b-bfdb3bf15b52@linux.microsoft.com>
 <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z70MZD+BssRG4R1H@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/2025 4:18 PM, Baoquan He wrote:
> On 02/24/25 at 03:05pm, steven chen wrote:
>> On 2/23/2025 10:14 PM, Baoquan He wrote:
>>> Hi Steve, Mimi,
>>>
>>> On 02/18/25 at 02:54pm, steven chen wrote:
>>>> Currently, the mechanism to map and unmap segments to the kimage
>>>> structure is not available to the subsystems outside of kexec.  This
>>>> functionality is needed when IMA is allocating the memory segments
>>>> during kexec 'load' operation.  Implement functions to map and unmap
>>>> segments to kimage.
>>> I am done with the whole patchset understanding. My concern is if this
>>> TPM PCRs content can be carried over through newly introduced KHO. I can
>>> see that these patchset doesn't introduce too much new code changes,
>>> while if many conponents need do this, kexec reboot will be patched all
>>> over its body and become ugly and hard to maintain.
>>>
>>> Please check Mike Rapoport's v4 patchset to see if IMA can register
>>> itself to KHO and do somthing during 2nd kernel init to restore those
>>> TPM PCRs content to make sure all measurement logs are read correctly.
>>> [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
>>>
>>> Thanks
>>> Baoquan
>> Hi Baoquan,
>>
>> For IMA, it appears that there are no current issues with TPM PCRs after a
>> kernel soft reboot.
> I mean using KHO to hold in 1st kernel and restore the IMA log in 2nd
> kernel.
>
>> This patches is used to get currently missed IMA measurements during the
>> kexec process copied to new kernel after the kernel soft reboot. I think
>> it's ok to leave it at current location: it will be easy to maintain for
>> IMA.
> Yeah, but I am saying this patchset increase unnecessary code
> complexity in kexec code maintaining.
>
>> Overall, for these patches, do you see any major blockers for kexec?
>>
>> If you have any specific concerns or need further details, please let me
>> know.
> I have no concerns for this patchset implementation itself, I saw you using
> vmap to maping the possible scattered source pages smartly and taking
> the mapped buffer pointers to update later duing kexec jumping. That's very
> great and clever method. BUT I am concerned about the solution, if we
> can make use of the existed way of KHO to implement it more simply. Could
> you please do investigation?

Hi Baoquan,

I will conduct an investigation. Thank you for your comments.

Steven


