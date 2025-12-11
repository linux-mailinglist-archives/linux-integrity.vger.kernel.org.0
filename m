Return-Path: <linux-integrity+bounces-7934-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F6CB764F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Dec 2025 00:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D35CA3013971
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 23:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6171FBC8C;
	Thu, 11 Dec 2025 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oxL25IST"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E44315F;
	Thu, 11 Dec 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765496311; cv=none; b=QpFvKvpSK0JnbX42Rn0hcN3hml+cEvUKF2eiZH0fl/tUFhUUfLNSMUOxNl72SPb2QOS1m977sQ497LYy80BEigj40pQxT9QpQKcBQTJxzT9zngqqG0onnLOkRRjATVNYLUn3Kb9DXp4Lbh8OUfZvGmL/rCBMznexfTpv3h8hRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765496311; c=relaxed/simple;
	bh=Lo/47LstOqThQPqCZRizXUU9dFcBzIbKaCnK2InAUNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXYxjCf10j3daLRwAmywmxxY7k0Gc6YiPd47wRo//6uxwdSn+u+rijktFvXuZc32udqM7E1LJPJ3XohjMDpVG/5eCUeEmrQe8OP52XFs5Er6xRgB2tvfDhDsdguaOa7T8drP5tfT4DerXlfjOlzjswGBlHl+YRejlq2j6ky2C/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oxL25IST; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.150] (unknown [131.107.8.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id D89F6201D7F7;
	Thu, 11 Dec 2025 15:38:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D89F6201D7F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765496309;
	bh=IPYACiDEyzfbolYY+BDO7FkL7SnFoIolqgjmnaJf5gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oxL25IST5ttFIQ7Hvi3EEfMlkYc96i1NTQATPAYDZTM3GSk1MT+sVqpqWEA6FQYpP
	 vYcG6bkl/+4AUhJMPF6TZ66mFYZqSjplqMoZHRuCBA0k7gs2iyAEaWuOcR4lPD+WG0
	 Ffr5mYYuRa54WgY53713AmvARUMDQ7EKktBQJojI=
Message-ID: <a795db5a-938a-458b-ab65-a29e025ae656@linux.microsoft.com>
Date: Thu, 11 Dec 2025 15:38:27 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
 <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
 <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
 <2f550d4cd860022e990d1de62049df85a6a86df8.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <2f550d4cd860022e990d1de62049df85a6a86df8.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 6:50 AM, Roberto Sassu wrote:
> On Thu, 2025-12-11 at 10:56 +0100, Roberto Sassu wrote:
>> On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
>>> Roberto,
>>>
>>> The proposed approach appears to be workable. However, if our primary goal
>>> here is to enable UM to free kernel memory consumed by the IMA log with an
>>> absolute minimum of kernel functionality/change, then I would argue that
>>> the proposed Stage-then-delete approach still represents unnecessary
>>> complexity when compared to a trim-to-N solution. Specifically:
> The benefit of the Stage-then-delete is that you don't need to scan the
> IMA measurements list in advance to determine what to trim, you just
> trim everything by swapping list head (very fast) and then you can read
> and delete the measurements out of the hot path.
>
> [...]

Trim N entries proposal can do the same speed as staged proposal or 
faster than staged proposal.

Steven

>>> - There exists a potential UM measurement-loss race condition introduced
>>> by the staging functionality that would not exist with a trim-to-N
>>> approach. (Occurs if a kexec call occurs after a UM agent has staged
>>> measurements for deletion, but has not completed copying them to
>>> userspace). This could be avoided by persisting staged measurements across
>>> kexec calls at the cost of making the proposed change larger.
>> The solution is to coordinate the staging with kexec in user space.
> To avoid requiring coordination in user space, I will try to see if I
> could improve my patch to prepend the staged entries to the current
> measurement list, before serializing them for kexec().

Trim N entries proposal does not need this at all.

Steven

> Roberto



