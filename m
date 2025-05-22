Return-Path: <linux-integrity+bounces-6296-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7269AC0891
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4C977A3DB8
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5D8288C93;
	Thu, 22 May 2025 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="QvFmsSjY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB7286D6A;
	Thu, 22 May 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905802; cv=none; b=fT0ntwAnFNFT+Z7k7MYDHdJMwfPmayZkSdt8GVXI2kvKlO/MCFLG1COKFpPU6TtIMyJ8+jgRxvknmcygNfKozxtW6cQoSwcgElrpsA7SvUCp5ugsWj7bRjHYMAA5u2claWiXo3dujgoOwzkF1qrC4NnR//jCK7+8ej6ocGeoE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905802; c=relaxed/simple;
	bh=GYHcv6MvZpxVUoean/5bgtYwr54F9fFoIfvq/nJQSDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ETbb+qQRbhI26y7Ir6aC4BlwXG96b3X/142SHo88qLPRPQxKulJ9B/JgovQqMMjVWuMkNSCEHYrsH69zarYjB/dzE3dOc3Q+HBDqRhWTGmQ8YiQ2SAeDEBPZHmXhCv4Oajtmyw7Ja9PQAKo6OCA9CWGdF8E7hUIjutT0m2ODF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=QvFmsSjY; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from [10.5.1.10] (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 8DD021087AA5;
	Thu, 22 May 2025 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747905796;
	bh=GYHcv6MvZpxVUoean/5bgtYwr54F9fFoIfvq/nJQSDg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QvFmsSjYF2wDo3nOjfj7KYMSk7xCzW8n39XPFbShYrzqg2K9wt/Tkfdta/NlltdWg
	 OH8OLhNMNqMQ8XRdpCnx1VeKHRmqgkLe+E6l/HzQi11sPsWR2DzyWWwYeYfhCRnAYm
	 vT8wmqlAtYT6r/ePVAt2h6ODKhIHoeLkbLGW+ro1VP5pic86JNkAaP9hkj0mFMvssC
	 1lw3FUaUiQZazMR1s+XKmX9oldarAcIk3RnapnqGrb8Ho6IjINaGpR0KsT/v2c1/G0
	 g1nNjP3uHz6wOg+JqZLHzShycE5E6OaHzawu8ZCcn0ccpz3mc13mStiyy/4WNyjAO7
	 dJmhamsTwsiWA==
Message-ID: <4939d8ab-3911-4759-b8d6-cb57ff9f9cda@nightmared.fr>
Date: Thu, 22 May 2025 11:23:15 +0200
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
Content-Language: en-US
From: Simon Thoby <git@nightmared.fr>
In-Reply-To: <CAHC9VhR-80zxgo+q07Aw8HqK+qiPdnuXC0axONGac0e9JxXvmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/21/25 23:31, Paul Moore wrote:
> On Wed, May 21, 2025 at 10:03 AM Simon THOBY <git@nightmared.fr> wrote:
>>
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
> 
> Considering the relatively small scope of Loadpol, I have to ask if
> you've considered augmenting other LSMs to meet your needs?  While
> LoadPin is different from what you are proposing here, it does
> similarly limit its scope to kernel module load operations, and given
> the current simplicity of LoadPin I imagine one could find a creative
> way to extend it to support what you are trying to do.
> 

I indeed felt a bit ridiculous introducing a new LSM for a limited feature
like that!
What's more, I don't see it being extended much in the future - we could
always imagine things like signed policy updates, but other than that it's
probably "feature-complete", as the feature itself is fairly small.
The difficulty with LoadPin is that it rely relies on the notion of
filesystem (which is coupled with the origin of the kernel modules) to ensure
that modules are valid. On a general-purpose distributions, the modules
would be stored on the same (non-integrity-verified) filesystem, so
segregating the modules by filesystem is not really possible there.
Extending LoadPin to provide the same features is probably possible, but I
fear this would add complexity to loading by trying to make it do two
slightly different jobs at once.

CC-ing Kees Cook as he is the maintainer of the LoadPin module, he may have
opinions on what features may or may not fit inside LoadPin.

As for other LSMs, I don't really see one that tries to provide similar
features, but I someone is open to extending an existing LSM for that, I
would be happy to help.

To stop the proliferation of LSMs (if this proves to be a problem),
I could see a "miscellaneous" one that groups the tiny LSMs (which each
feature set hidden behind a configuration option), like loadpin, yama,
safesetid, and future feature sets like loadpol.


>> +The policy can be read and rewritten at ``/sys/kernel/security/loadpol/policy``.
>> +
>> +A default policy is created that contains the current list of blacklisted modules,
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
>> +    * ``kernel`` (the kernel requested the module directly by calling
>> +      ``request_module(...)``, e.g. loading a filesystem when performing a
>> +      ``-o loop`` mount).
>> +
>> +    When unspecified, the condition defaults to ``kernel,userspace`` (which means
>> +    that both origins match).
>> +
>> +``module``:
>> +    Name of the kernel module being matched. The name can contain wilcards.
>> +    Beware, module aliases do not work!
> 
> It would be good to have a section in the documentation where you
> discuss how the risks inherent to filtering on the module name, and
> approaches that can be used to ensure that a malicious module is not
> simply "borrowing" a known good module's name.
> 
I understand the concern, but the idea of the LSM is not to substitute itself
to existing security mechanisms (as you know, it technically couldn't anyway, LSM
being all about stacking additional layers).
So we still rely on kernel module signing. To forge a malicious module with a valid
name, one would have to have access to the signing key. If that happens, I consider
the game to be over, as they can forge arbitrary kernel modules.
In most practical cases, I think people will trust two keys:
- the distributor key, built in the kernel
- User-supplied keys, distributed via MOK (or in the UEFI KEK maybe?)
Most modules would be signed with the distributor key, with security software
(or custom kernel drivers) being signed with the user key (hopefully off-system,
so that the end-users systems do not contain the signing key, otherwise this
defeats the whole point of signing).
All modules would still be signed, and we should be safe from a module lying about
its name (naming conflicts notwithstanding, but this shouldn't happen anyway).
But I could have an explanation in the documentation about that!

