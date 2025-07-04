Return-Path: <linux-integrity+bounces-6611-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3EAF8537
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 03:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CD44E361E
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 01:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4F182D7;
	Fri,  4 Jul 2025 01:31:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D9360;
	Fri,  4 Jul 2025 01:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751592666; cv=none; b=OUV+QSaVUyl2xgCkfrmL7u/MQntpWKd5GrmGNNsFOgPic87RfYAgh9TjXrTmH7Nc8DwC6WtfvibgR/gm4bMsVmd8GcZZehpGAEhAZHmaxUSniWlRZYzETRIAiA5yXT4OtEUtKLvMPCP1gSsszKgl4rTGuiGZVwka/Ek7TUQY/z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751592666; c=relaxed/simple;
	bh=EDiDHVY2VAcypz2+hXBWjN+qShrbsG/qZ+SfLKHEvDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oZZsS32gEDhe1IFXJ+7UE962Zc94fwCjiU/P1zf+YiJnOUAy/i4yvC3FNh4FnZhT6OyKt7S6Ag/J0G36lV5r2DV2sRL2t0+VzNk/xpheIMrjHKnZF+DQilI2H0H09zUaOrWUeHJY2URCkrPSF2Q2n/+q4jItlX0rwCydQmmiIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bYGFZ38CFz2Cflx;
	Fri,  4 Jul 2025 09:26:58 +0800 (CST)
Received: from kwepemg100016.china.huawei.com (unknown [7.202.181.57])
	by mail.maildlp.com (Postfix) with ESMTPS id D4EE2180042;
	Fri,  4 Jul 2025 09:30:59 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by kwepemg100016.china.huawei.com
 (7.202.181.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 4 Jul
 2025 09:30:59 +0800
Message-ID: <c74b5581-b5a5-4f71-a4da-2cef73351715@huawei.com>
Date: Fri, 4 Jul 2025 09:30:58 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when secure
 boot be disabled"
To: Lennart Poettering <mzxreary@0pointer.de>, Mimi Zohar
	<zohar@linux.ibm.com>
CC: Jarkko Sakkinen <jarkko@kernel.org>, Roberto Sassu
	<roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric
 Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
	<linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Lee, Chun-Yi" <joeyli.kernel@gmail.com>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
 <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
 <aGYurikYK1ManAp3@gardel-login>
 <8401c23009db3b8447b0b06710b37b1585a081ab.camel@linux.ibm.com>
 <aGZ_x8Ar6iwzt2zV@gardel-login>
Content-Language: en-US
From: GONG Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <aGZ_x8Ar6iwzt2zV@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemg100016.china.huawei.com (7.202.181.57)



On 7/3/2025 9:04 PM, Lennart Poettering wrote:
> On Do, 03.07.25 07:23, Mimi Zohar (zohar@linux.ibm.com) wrote:
> 
>>>> The ability of loading MOK keys onto the .machine keyring and linked to the
>>>> .secondary_trusted_keys keyring is an exception based on the assumption that
>>>> that there is a secure boot chain of trust.  Allowing untrusted keys onto or
>>>> linked to the .secondary_trusted_keys keyring, would potentially allow loading
>>>> code signing keys onto the IMA keyring signed by untrusted MOK keys.
>>>>
>>>> I was really hesitant to allow this exception of loading MOK keys onto the
>>>> .machine keyring in the first place.  I'm now even more concerned.
>>>>
>>>> This is not just an issue of being more or less restrictive, but of adding a new
>>>> integrity gap when one didn't exist previously.
>>>
>>> But we are talking of the case here where SecureBoot is *off*,
>>
>> Exactly, so there is no trust in any keys other than those built into the
>> kernel.
> 
> No! There *is* *no *trust* in this case where SB is off, not in those
> keys built into the kernel nor in any other. Believing there was is
> just a really broken security model!
> 
>> True that is of course dependent on trusting the kernel.  In the case of
>> MOK, trusting additional keys requires at minimum a "safe" secure boot
>> environment and other things to prevent its abuse.
> 
> The thing is that if SB is off, then all bets are off, it's really
> pointless in assuming the kernel image had any trust left you'd need
> to protect. That's just *not* the case. Where do you think that trust
> should come from?
> 
> If SB is off, then anything that got loaded early enough could just
> patch arbitrary keys into the ELF image of the kernel before starting
> it, and everything will look perfect later on, because the image is
> not authenticated after all via SB. So there *already* is a way into
> the kernel keyring with this – it's just really messy to parse and
> patch ELF at runtime like this from the bootloader. My hope with just
> relaxing the rules on MOK keys when SB is off is to just make this
> stuff cleaner and more elegant (and also to leave the ELF image intact
> so that we get clean measurements, both of the kernel and of the keys
> we add).

Just curious: if an attacker takes control of the boot phase earlier
than the kernel, then not just this check has no value, but any check in
the kernel has no value, right? Anything that got loaded early enough
could theoretically patch the kernel with anything on anywhere. So shall
we just remove them all?

Certainly the answer is no, and they are still meaningful somehow and
somewhere. IMHO I think the concern behind the check is reasonable, but
the actual code could be an overkill. It would be better if it does:

  if (arch_ima_get_secureboot() && ima_mok_verify()) // hypothetical

, and in the future we could extend the ima policy for the boot phase
chain of trust and perform the check here accordingly, i.e. let the
users decide how things should go.

While for the current situation, my personal advice would be to add a
config to control whether or not the check is conducted. Let's call it
CONFIG_LOAD_UEFI_KEYS_STRICT temporarily:

#ifdef CONFIG_LOAD_UEFI_KEYS_STRICT
  /* the MOK/MOKx can not be trusted when secure boot is disabled */
  if (!arch_ima_get_secureboot())
          return 0;
#endif

so that both sides are happy, and we can think of more fine-grained
verification methods, like the one I said above, for the strict mode
afterwards.

-Ruiqi

> 
>>> i.e. there is a concious decision in place that there is no trust
>>> chain, and that the firmware *happily* *already* accepts unsigned boot
>>> loaders/kernels and just runs with them. If SecureBoot is already off,
>>> then an attacker can patch around in the kernel invoked at boot
>>> completely freely anyway, there is *no* authentication done. Hence
>>> it's really weird to then insist that the path into the kernel keyring
>>> via mok keys is off in *only* this case, because an attacker can get
>>> into that anyway in this case, it's just a lot more cumbersome.
>>>
>>> It's really strange that currently when people ask for tight security
>>> (i.e. SB on) the linux kernel is super relaxed and allows any keys to
>>> be inserted, but if people ask for security checks to be off (i.e. SB
>>> off) the kernel starts being super strict and doesn't allow any keys
>>> to propagate into mok. That's really confusing and contradictory, no?
>>
>> That all may be true, but you're ignoring what I said about only "trusting" MOK
>> in certain situations.  If you have another safer, better mechanism for
>> establishing a new root of trust for keys (e.g. TPM), then by all means share it
>> and we can make additional exceptions.
> 
> Yes, we have that in systemd: there's local attestation in place
> already in systemd via the "systemd-pcrlock" feature. i.e. the idea is
> that the disk encryption keys are only released to the OS if the
> measurements of the boot phase match some golden measurements. This is
> in a way a reasonable alternative (or addition) to SecureBoot: instead of
> prohibiting code to run if it doesn't carry a signature of some
> trusted key, you let it all run, but then later on you refuse to give
> it the disk encryptions keys – the keys to the kingdom – unless the
> measurements all along the way match what you expect them to be. This
> protects the OS quite nicely, and makes SB to some level optional, as
> we basically enforce security "a-posteriori" rather than "a-priori" – by
> means of the TPM's key policies.
> 
> Now you might wonder: if we have such local attestation policies, why
> do we *also* want to get keys into the kernel keyring? That's because
> the attestation policies are checked (primarily) when FDE is unlocked,
> so that's our security boundary, our milestone where eveything
> *before* is protected via attestation, but which cannot protect
> anything *after*. In my model we then want to protect
> any further resources via the kernel keyring then. hence it matters to
> us to have a clean, elegant way, to insert keys *before* that
> milestone that then can protect resources comeing *after* it.
> 
> Why do I want to avoid SB at all for these setups? Mostly, because
> it's a bureacractic effort to get your keys intot he Microsoft
> keyring, and if you do get them there, then their security value is
> kinda weak anyway, because the allowlist that the keyring is is such
> an extremely wide net, it's at best a denylist of bad stuff rather
> than an allowlist of good stuff at this point. It's kinda undemocratic
> too. But anyway, the pros and cons of SB are another discussion. I am
> primarily interested in making it optional, so that you can get
> security with SB and without SB, because you always have someting to
> protect the boot, and always something that protects the rest.
> 
> Lennart
> 
> --
> Lennart Poettering, Berlin
> 


