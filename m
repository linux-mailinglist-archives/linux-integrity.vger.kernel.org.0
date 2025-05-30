Return-Path: <linux-integrity+bounces-6346-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E145AC8878
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09FE1738D7
	for <lists+linux-integrity@lfdr.de>; Fri, 30 May 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813401FAC42;
	Fri, 30 May 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="BIItrHsI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA41B6CE4;
	Fri, 30 May 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748588667; cv=none; b=hAHy5tm+Y2ck1SgwT6UQOahF5QgSlIqx15BnXOPt9CalENQwmy10XLPhcH7EC7EW08H6WiilN9rmAU3Vg+YwMhKXZE5kD7FCzEOTYdhq6CuFTOrXY3RywbqnmHO6VReO/Q/r2uLr58XgyCa+eLN32bkLOsyZS5lishr3uPZGAZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748588667; c=relaxed/simple;
	bh=j35dvvKjo4tcgD/DKN08smRYTU9B0YKcUJzYlkwAGyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrA3tF0Sa22sBmN1vPd5j8eKS3IhPF2qLTAqr9jA23ilJNbyevUwGHrW9AxjEaX/F8/7smR9jEvDfCDyd4fQGSEpQI66P8m40mp0WqLDST+n84ZqsYDdpI5BH/tW59wpakL9U//lYY9RwuyLXGGjOshzu8fujrwHX8DwBRaqo+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=BIItrHsI; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from [192.168.1.46] (88-123-72-235.subs.proxad.net [88.123.72.235])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 5021E1087394;
	Fri, 30 May 2025 07:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1748588591;
	bh=j35dvvKjo4tcgD/DKN08smRYTU9B0YKcUJzYlkwAGyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BIItrHsIqNBLfPoOSM/8b7YN8tgqE1IjOwTP1BQ0n6XwVrbD5q4TLeVoyhILN6R+y
	 VumkObE8gMnoZ3FPxRyz6rIDF1rD1d3JjtvATDAYeXBYJjzSOCyPvADkMRihlCiy5y
	 s1PSPny+mko04+iSb/mKIg+yP5FUDHskqVbz3SRq41KXMwb5/QhxjSlPYiP7Dv8yJt
	 lUIgqO5dIBQt8VsgSMpw0NK5NtjeZ2DB4Xw2f4hVhUKjd8ERE/JkqgNIvd6EfLONu8
	 U1s9SBdlphu4ozj8zKsUmsszHaI5t0zoYIqZC8UFyn79rAf8FrWKenyr8pIHzcpynV
	 vV4a2e27fQ4FA==
Message-ID: <2495c0bf-5a24-483b-835f-abf433687889@nightmared.fr>
Date: Fri, 30 May 2025 09:03:10 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] Loadpol LSM: add a minimal documentation
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20250521140121.591482-1-git@nightmared.fr>
 <20250521140121.591482-10-git@nightmared.fr>
 <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
 <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
 <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <CAHC9VhT5JrhzGhRnJ4VNo6e941o-xdAG-FC-Q6wDbSZhgSUWOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/30/25 01:49, Paul Moore wrote:
> On Thu, May 22, 2025 at 5:23 AM Simon Thoby <git@nightmared.fr> wrote:
>> On 5/21/25 23:31, Paul Moore wrote:
>>> On Wed, May 21, 2025 at 10:03 AM Simon THOBY <git@nightmared.fr> wrote:
>>>>
>>>> Introduce a minimal documentation for Loadpol, presenting the policy
>>>> format and the two user interfaces: the securityfs policy file and the
>>>> sysctl.
>>>>
>>>> Signed-off-by: Simon THOBY <git@nightmared.fr>
>>>> ---
>>>>  Documentation/admin-guide/LSM/Loadpol.rst | 81 +++++++++++++++++++++++
>>>>  Documentation/admin-guide/LSM/index.rst   |  1 +
>>>>  2 files changed, 82 insertions(+)
>>>>  create mode 100644 Documentation/admin-guide/LSM/Loadpol.rst
>>>>
>>>> diff --git a/Documentation/admin-guide/LSM/Loadpol.rst b/Documentation/admin-guide/LSM/Loadpol.rst
>>>> new file mode 100644
>>>> index 000000000000..0aa24a8d393c
>>>> --- /dev/null
>>>> +++ b/Documentation/admin-guide/LSM/Loadpol.rst
>>>> @@ -0,0 +1,81 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +=======
>>>> +Loadpol
>>>> +=======
>>>> +
>>>> +Loadpol is a Linux Security Module that enforces a user-provided policy
>>>> +when decided whether a dynamic module can be loaded or not.
>>>
>>> Considering the relatively small scope of Loadpol, I have to ask if
>>> you've considered augmenting other LSMs to meet your needs?  While
>>> LoadPin is different from what you are proposing here, it does
>>> similarly limit its scope to kernel module load operations, and given
>>> the current simplicity of LoadPin I imagine one could find a creative
>>> way to extend it to support what you are trying to do.
>>
>> I indeed felt a bit ridiculous introducing a new LSM for a limited feature
>> like that!
> 
> Please don't feel bad about it, often simply doing "something" is what
> makes things happen, even if that original "something" turns out not
> to be the final "thing" :)
> 
>> What's more, I don't see it being extended much in the future - we could
>> always imagine things like signed policy updates, but other than that it's
>> probably "feature-complete", as the feature itself is fairly small.
>> The difficulty with LoadPin is that it rely relies on the notion of
>> filesystem (which is coupled with the origin of the kernel modules) to ensure
>> that modules are valid. On a general-purpose distributions, the modules
>> would be stored on the same (non-integrity-verified) filesystem, so
>> segregating the modules by filesystem is not really possible there.
>> Extending LoadPin to provide the same features is probably possible, but I
>> fear this would add complexity to loading by trying to make it do two
>> slightly different jobs at once.
> 
> My thinking around possible augmentation of LoadPin is that both
> LoadPin and Loadpol share a similar, limited focus of controlling
> access to kernel module loading and Loadpol has support for a basic
> loadable policy, a policy that could likely be extended to support a
> LoadPin-esque construct that limit module loading based on filesystem
> pinning.  It probably makes more sense to think of adding LoadPin
> support to Loadpol, rather than augmenting LoadPin to support the
> Loadpol concepts, but for consistency with upstream we probably need
> to speak in terms of the latter.
> 
Thanks for the reply, I now see what you meant. I will try to put something
together (hopefully next week), starting with looking at how we can express
the current LoadPin feature set as a loadable and user-extensible policy, and
then add non-filesystem-related policy entries (like module name restrictions)
to that policy.

