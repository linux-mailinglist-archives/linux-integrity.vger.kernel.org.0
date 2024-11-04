Return-Path: <linux-integrity+bounces-4015-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2764B9BB48D
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 13:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC751C213FD
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84BB1B219A;
	Mon,  4 Nov 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="U7507Z5/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1518F2F0;
	Mon,  4 Nov 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722802; cv=pass; b=UG8dW6l5kIwBwacBaJEntZTD/n7wSrMoRMkVqizNSYA/x92M7cPBs/V1/n0KASyTSp6NWKxbk7NAetIQVUDEeLb1i8NQt/zwGSzQ68LFuMkRphG4vtEqfdVNy8nL13jzPUaeZRAGmeeeSEce3JsPjzxXqqtfsLFGvDFR2jhVycc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722802; c=relaxed/simple;
	bh=h7nWCBuv+8hp6WaGK3rhdgFNlExYEkhgyF4/tB7oABU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DelAU6wB41jxS/7dIdrvbs/0s9WtPyAW881OADNuuaoN+kTWwYylIYzGCogtU+QKNNjgN+8o5DXhUK9fyFe1iSw+psDrm1VaJNM2PogOt501aeqaR1sdopb0hqcVddypFb7Mldf3Vh3Re31aSBR3eMHuwZ5RSgruVu5eth+YyW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=U7507Z5/; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730722790; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KbV1s8J0FNoGcRPF1DJpHeMAUL062grTQLnnnb+9sl9TrKmdJMBbPB6ZdI1QndcczPIyciSei4dmdovrlmPDE4Zse9fPPBNXYo0D0CCgtZf8WnYY8A9ZfZtYzhQHzjFo4OqgXaz6wJ8iSvr2LIZxlXRK0akzqF4HpCLjxctv8QQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730722790; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tT0QJ/DZ+AsU97jNiMbwbRgHwIl8wTFa42/UV3El9Aw=; 
	b=irAQF9BshtST4Eh8NIfXmHtdLDJBOmkRsp9O9dOxEyVJA6jxxPs7FQe9IJ3Nh6aCuywmx/+ZuJ2JvMaGFRMTmzEdzGic4kXLed282q3OOoZcxsvIa2Vh2XxpFRLJUSVEZ4gpksq9ihkduCvNMvCOUJZxf8vFRUU2aDOKqimu5fY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730722790;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tT0QJ/DZ+AsU97jNiMbwbRgHwIl8wTFa42/UV3El9Aw=;
	b=U7507Z5/a84vo3fl1B7bwZXbYI1rHSCguKq3s77ayDqwyME2urgXjyY6RfPij5gX
	yj1I/cOWSetuQWxWdOVTh2W2IoBK4scDbKtpzW2YBLD+CZamHOcwyI955yR6PA6dkOD
	zIDny6JTFfopmK4fQbl4GqR7p/BC922uubTCkD0w=
Received: by mx.zohomail.com with SMTPS id 1730722789167545.3811734318792;
	Mon, 4 Nov 2024 04:19:49 -0800 (PST)
Message-ID: <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
Date: Mon, 4 Nov 2024 07:19:47 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 Ross Philipson <ross.philipson@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, trenchboot-devel@googlegroups.com
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/4/24 06:55, 'Ard Biesheuvel' via trenchboot-devel wrote:
> On Mon, 4 Nov 2024 at 12:52, Daniel P. Smith
> <dpsmith@apertussolutions.com> wrote:
>>
>> On 11/4/24 06:27, Ard Biesheuvel wrote:
>>> On Mon, 4 Nov 2024 at 12:18, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>
>>>> On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
>>>>> On 11/2/24 14:00, Jarkko Sakkinen wrote:
>>>>>> On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
>>>>>>> It is not really my problem but I'm also wondering how the
>>>>>>> initialization order is managed. What if e.g. IMA happens to
>>>>>>> initialize before slmodule?
>>>>>>
>>>>>> The first obvious observation from Trenchboot implementation is that it
>>>>>> is 9/10 times worst idea ever to have splitted root of trust. Here it
>>>>>> is realized by an LKM for slmodule.
>>>>>
>>>>> First, there is no conflict between IMA and slmodule. With your change
>>>>> to make locality switching a one shot, the only issue would be if IMA
>>>>> were to run first and issue a locality switch to Locality 0, thus
>>>>> blocking slmodule from switching to Locality 2. As for PCR usage, IMA
>>>>> uses the SRTM PCRs, which are completely accessible under Locality 2.
>>>>
>>>> Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
>>>>
>>>>> Honestly, a better path forward would be to revisit the issue that is
>>>>> driving most of that logic existing, which is the lack of a TPM
>>>>> interface code in the setup kernel. As a reminder, this issue is due to
>>>>> the TPM maintainers position that the only TPM code in the kernel can be
>>>>> the mainline driver. Which, unless something has changed, is impossible
>>>>> to compile into the setup kernel due to its use of mainline kernel
>>>>> constructs not present in the setup kernel.
>>>>
>>>> I don't categorically reject adding some code to early setup. We have
>>>> some shared code EFI stub but you have to explain your changes
>>>> proeprly. Getting rejection in some early version to some approach,
>>>> and being still pissed about that years forward is not really way
>>>> to go IMHO.
>>>>
>>>
>>> Daniel has been nothing but courteous and patient, and you've waited
>>> 11 revision to come up with some bikeshedding patches that don't
>>> materially improve anything.
>>>
>>> So commenting on Daniel's approach here is uncalled for.
>>>
>>> Can we please converge on this?
>>>
>>> Daniel - if no component can be built as a module, there should be no
>>> reason for the set_default_locality() hook to be exported to modules
>>> right? And do we even need a sysfs node to expose this information?
>>
>> Hi Ard,
>>
>> The only reason off the top of my head of why it was exported was to
>> support the fact that the tpm module itself could be built as a module,
>> not that we were looking for it to be done so.
>>
> 
> But the inclusion of the secure launch module will force the TPM

Correct, I was meaning that TPM could be built as a module and since we 
were extending its public interface, the thought is it would be proper 
for us to make it exported. We have no requirement for it to be export 
for our usage.

>> As to sysfs, there is the TXT register content that we would like to
>> have exposed, and they should be readonly. For context to contrast with,
>> tboot user space utility txt-stat worked by trying to read the TXT
>> register address space via /dev/mem, think enough is said there. The
>> other purpose we used sysfs was management of the DRTM log. We used it
>> to provide a means to ensure the DRTM eventlog is extended when
>> measurements are sent to the DRTM PCRs and then to be able to retrieve
>> the final log.
>>
> 
> I was referring specifically to the read-write sysfs node that permits
> user space to update the default TPM locality. Does it need to be
> writable? And does it need to exist at all?

Right, sorry. As I recall, that was introduce due to the sequence of how 
the TPM driver handled locality, moving back to Locality 0 after done 
sending cmds. In the Oracle implementation, the initramfs takes 
integrity measurements of the environment it is about to kexec into, eg. 
target kernel, initramfs, file system, etc. Some of these measurements 
should go into PCR 17 and PCR 18, which requires Locality 2 to be able 
extend those PCRs. If the slmodule is able to set the locality for all 
PCR extends coming from user space to be Locality 2, that removes the 
current need for it.

v/r,
dps


