Return-Path: <linux-integrity+bounces-1235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A1855AE3
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 07:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0902FB29986
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 06:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36606610E;
	Thu, 15 Feb 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RlGtNEBv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55E2F32
	for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980319; cv=none; b=f9P2coBGlxjjC5kXyTFZgYnoAkEROT6J3t7xjGO4P4bkNQJjMDbWyqP7IERsy/TrLQPnVIDBI/4HCTXa0MkhljRgItpLqhD1YM0hq6PdgAgsDcXmvW0MwGjn5HNrWzj6Qp86JzRee/uJBHmGVyU9voOLd/CiRqW+2p+wXdslDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980319; c=relaxed/simple;
	bh=GHxtC0+joKGslKwlKlet6k8mvxQ8rfUFJBmIeRM31dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp1sOnPFy8vQqnV5bZ+QsXGXgXme6OiVdXHr7kWIXW9SqBcFmKupq79RlIgqdWfVl0JHD8bVIwnEItB+1XYFjoF9pHPAb/JqijUgZd3CR/D0ECr3qDDmtJV1Dc9YXIvw+QAsz7t7ExI4zfg8B6P0bdNGYsRIyL+FDFUb3sau9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RlGtNEBv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BD7920B2000;
	Wed, 14 Feb 2024 22:58:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BD7920B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707980317;
	bh=T5tbJLn2I5N6skvV2Z46UPwtt8FoVbcwSRbmRBgUFG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RlGtNEBv9XKMtquqxWtmnjJdb5OPbZ0vc/2eVxeM4HZhKN8lM63g/pJYmaFcm3owp
	 fgv4UQsJlSlvYLq5m5+vgQadYLAujptjiqTdzhR6MThlNYpxRpQqDqA8k73JMJpX6N
	 ryOJd7HnAf4ner2tOH2/mpXpjSEyzHOC2tvbBG6U=
Message-ID: <648638bb-e360-4851-adfe-940706a7a51d@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:58:37 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
 <1569c07b-d66f-441d-8567-2669413c2a08@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <1569c07b-d66f-441d-8567-2669413c2a08@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/14/24 13:03, Stefan Berger wrote:
> 
> 
> On 2/14/24 10:38, Tushar Sugandhi wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  
>> The
>> indeterminate interval between kexec 'load' and 'execute' could 
>> exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot.  And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> I successfully tested this series on ppc64. I will give you a Tested-by 
> tag in the next round.
> 
>     Stefan
Awesome! Appreciate it.

~Tushar

