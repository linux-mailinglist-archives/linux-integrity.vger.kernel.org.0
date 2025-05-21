Return-Path: <linux-integrity+bounces-6285-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDB4ABFB41
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7E08C6EE3
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E84221719;
	Wed, 21 May 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="enx1VokA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067B1DF754;
	Wed, 21 May 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747844973; cv=none; b=GWZa5s0KX1acRIY7doRjdKa+zuQtQGSgbDx6BDP7cxcCZqlL11cRBF8l+1WgwnFuv5KF12hJbRgt32uPpn7Hwd+1xrgRKvPbQjVULP3GXDOsP5p4+1wNn6oHb/e+H76AoVE2pmehCnuZhi6RJGcQDReW8sqywSNWn0I/RlosTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747844973; c=relaxed/simple;
	bh=zaU4BpUiukO3w2ZEfCf3wUHR9P3VDLZNtA00D1cGp7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVM4ZesRohwncqRXmcJKehWsNbShYNlYdyn59b9Xi4j3kfR4tTKFGzpq8eZvN2XfmPlT6fTFRi6Bu9TcISjR/2A6XeBexNlHZr5+FzldBh2nO0R+9BhSeRJDm2VZ/Tr4vzee2nThqDqK8jU36YSIi1dn39AVYKLt2zHpP/jvROk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=enx1VokA; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from [10.5.1.10] (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 4AA711087928;
	Wed, 21 May 2025 16:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747844969;
	bh=zaU4BpUiukO3w2ZEfCf3wUHR9P3VDLZNtA00D1cGp7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=enx1VokACY6jpTzXPrbdgL/vHyFO29Z9lzexZGUp6+AOHX2qVEX7f7kEPh6OUZ5hL
	 yA7dcMN6s/uU5955EUKuwCApsNirDV0iZVBydHEqQK5WjXbYrY8oHb3RV08UCAt31h
	 GVrYL2tm7r0h/LU37Xg6ZGIlJlmQAVUbbjd1Ya44mcUQtKsp+BSYDGxAQChyT+VVXI
	 QNaVWpF+aKjNnNFHk0Ts/24NXyK6J9KBqt4KEEPnFvBGwqoMcw4WF7azDpRC5eKjUz
	 v7s9nrZRUHwDf4zzzvAi+ARX2jdshSJoMLqvQHSQojQliBN/qTVZqLoW0/chB3/8BG
	 2+cO26bXvZQnQ==
Message-ID: <c1d89b32-d041-415a-9046-8c2c1300b788@nightmared.fr>
Date: Wed, 21 May 2025 18:29:28 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Randy Dunlap <rdunlap@infradead.org>,
 linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-10-git@nightmared.fr>
 <ef2d4d13-d8f3-4922-b3ce-54606d733b1b@infradead.org>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <ef2d4d13-d8f3-4922-b3ce-54606d733b1b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/25 18:26, Randy Dunlap wrote:
> Hi--
> 
> On 5/21/25 7:01 AM, Simon THOBY wrote:
>> Introduce a minimal documentation for Loadpol, presenting the policy
>> format and the two user interfaces: the securityfs policy file and the
>> sysctl.
>>
>> Signed-off-by: Simon THOBY <git@nightmared.fr>
>> ---
>>  Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
>>  Documentation/admin-guide/LSM/index.rst   |  1 +
>>  2 files changed, 82 insertions(+)
>>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
>>
>> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/admin-guide/LSM/Loadpol.rst
>> new file mode 100644
>> index 000000000000..0aa24a8d393c
>> --- /dev/null
>> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
>> @@ -0,0 +1,81 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=======
>> +Loadpol
>> +=======
>> +
>> +Loadpol is a Linux Security Module that enforces a user-provided policy
>> +when decided whether a dynamic module can be loaded or not.
>> +
>> +The policy can be read and rewritten at ``/sys/kernel/security/loadpol/policy``.
>> +
>> +A default policy is created that contains the current list of blacklisted modules,
> 
> Where does the current list of blacklisted modules come from?
> Is it from the kernel command line parameter "module_blacklist=" or
> somewhere else?
> 

Correct, it comes from that command line argument.
It is actually not really necessary to include it in the policy (the kernel blacklist is applied
prior to the LSM hook, so it will always apply anyway), but I thought it nice to have a "bird view"
of all the policies that apply that can prevent the load of a kernel module.

>> +and a catch-all entry that allow loading any module.
>> +
>> +Policy format
>> +=============
>> +
>> +The policy is defined as a set of line-separated entries.
>> +Each entry define the conditions for a match (the origin of the load request and
>> +the name of the kernel module), and the action to take when the load request
>> +matches the entry.
>> +
>> +
>> +Entry syntax: ``[origin=(userspace|kernel|kernel,userspace)] [module=<module_name>] action=(allow|deny)``
>> +
>> +There are two matching conditions:
>> +
>> +``origin``:
>> +    Load Requests can come from two origins:
>> +
>> +    * ``userspace`` (ie. a program in userspace called modprobe/insmod)
>                        (i.e.,
> 
>> +    * ``kernel`` (the kernel requested the module directly by calling
>> +      ``request_module(...)``, e.g. loading a filesystem when performing a
>> +      ``-o loop`` mount).
>> +
>> +    When unspecified, the condition defaults to ``kernel,userspace`` (which means
>> +    that both origins match).
>> +
>> +``module``:
>> +    Name of the kernel module being matched. The name can contain wilcards.
> 
>                                                                      wildcards.
> 
>> +    Beware, module aliases do not work!
>> +
> 
> 

Thanks for the typos, will fix.

