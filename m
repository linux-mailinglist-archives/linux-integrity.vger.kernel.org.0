Return-Path: <linux-integrity+bounces-7920-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805AACB6DF3
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 19:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC1E305DCFB
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ACF3191C9;
	Thu, 11 Dec 2025 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HNjJgJjM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A33168E2;
	Thu, 11 Dec 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476403; cv=none; b=aga2UCkPTl9Wu4vwxX6sjV9sSITbLC9GP1R013J6W4Gu9m2AMBNmRlAVKWTcH+FnkFu60yYX+VZabGAfBr00tQCzYm3RJR75jfhGb/SZA2GRBmoceLeWwiGvW7wNltFGvIHr6EdRJbPvWRvr/exCbne5hvELiOaLn/NkW8JMtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476403; c=relaxed/simple;
	bh=vZAvDE0K1dN04OJvdTBY+VTqXXrY67CoWqpjW+cYP4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnlPtdtPhkaniCRk6n4rBDzO88Ss+Yn40ODV950m0ea5aN3+j32cKfWjJC28SuGWv/U6ydfD9lUA4xVNWdhgHRFbMhwX5N41QZVe3TQowmzbSz9fLglPr7hF9wxGzQ3tHK2sx2acDEViWBIZoMzro69bCz8o34l75cPxzJqNCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HNjJgJjM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.150] (unknown [131.107.8.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0E76201D7F6;
	Thu, 11 Dec 2025 10:06:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0E76201D7F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765476395;
	bh=tsWNf1A53dEvq0P1oHmMCs6r5/gQAKw3tR/g2l0a2bQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNjJgJjM2xhrIBQ3NaL35qM+q0zLsHYLhSc9t78aYZ/5YuP04ee/Hcyctx8RYEAKY
	 rLltfAXvhY0tdVEnMI8akF8pG7cJHbkPOTbt8o+cmkM0QlZO59kvNA/+P0zlVRKS+R
	 DpkGiPkOOSm6YVxKD5QDCW2amVcscgEHWeXnNbT4=
Message-ID: <d48d2f37-2c38-45ff-b161-6bb68536f840@linux.microsoft.com>
Date: Thu, 11 Dec 2025 10:06:34 -0800
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
 <75d8b82a2e493ca919926310c5f381221555d82d.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <75d8b82a2e493ca919926310c5f381221555d82d.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2025 7:24 AM, Roberto Sassu wrote:
> On Thu, 2025-12-11 at 15:50 +0100, Roberto Sassu wrote:
>> On Thu, 2025-12-11 at 10:56 +0100, Roberto Sassu wrote:
>>> On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
>>>> Roberto,
>>>>
>>>> The proposed approach appears to be workable. However, if our primary goal
>>>> here is to enable UM to free kernel memory consumed by the IMA log with an
>>>> absolute minimum of kernel functionality/change, then I would argue that
>>>> the proposed Stage-then-delete approach still represents unnecessary
>>>> complexity when compared to a trim-to-N solution. Specifically:
>> The benefit of the Stage-then-delete is that you don't need to scan the
>> IMA measurements list in advance to determine what to trim, you just
>> trim everything by swapping list head (very fast) and then you can read
>> and delete the measurements out of the hot path.
> I forgot: I will also add in my patch the ability to stage and trim in
> one step, to satisfy your use case.
>
> Roberto

Hi Roberto,

The below is what you want in one step. I think anything more than this 
does not bring any extra value.

I released version 2 of trim N entries patch as bellow:

[PATCH v2 0/1] Trim N entries of IMA event logs
<https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t>


Steven

>> [...]
>>
>>>> - There exists a potential UM measurement-loss race condition introduced
>>>> by the staging functionality that would not exist with a trim-to-N
>>>> approach. (Occurs if a kexec call occurs after a UM agent has staged
>>>> measurements for deletion, but has not completed copying them to
>>>> userspace). This could be avoided by persisting staged measurements across
>>>> kexec calls at the cost of making the proposed change larger.
>>> The solution is to coordinate the staging with kexec in user space.
>> To avoid requiring coordination in user space, I will try to see if I
>> could improve my patch to prepend the staged entries to the current
>> measurement list, before serializing them for kexec().
>>
>> Roberto



