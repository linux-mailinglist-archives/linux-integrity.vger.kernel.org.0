Return-Path: <linux-integrity+bounces-4012-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D139BB3E7
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C924E283784
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65841B4F0C;
	Mon,  4 Nov 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="NSAO5wUQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E5A1B3939;
	Mon,  4 Nov 2024 11:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721161; cv=pass; b=TapUsP5hf2xgdoXRflD23AGtdr+tMXUfxLhb3u0/0VYiUADCOlNZZG6lorS4jmZUEQ9hwwB+zFzgeZfoYUZTzNIDkxhWYLpAUBj3uJo+Lh1Jgx47mk91o5TL5MszpQal79Fz/poW7VIxFRaflO4+fwpDQLuBrUiQVrcgy+AnAJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721161; c=relaxed/simple;
	bh=8KJWCxV18F2YvSUH5nVbcfzOgjVb60K7Ryn3Rhxn3i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRsqDR9dpinwFdKpkZcZIOX8JNhUUwJhR+aJ03gQtEO1YLqgXG8x2m3L4b9qOLFm6xAEmceJduE2UZxCs4k9vorVkH0Xl8nvop/740grpFPhUQZ3NGtJcNVEt6xj5+XjziEE4gAD7OzoF5VEF/FLF4vfJylmqwxrjdTW6Qw1/wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=NSAO5wUQ; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730721149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JbrtvIUwTj6u9c9dUCHeb7xFzSI6s8KT9yUw7Ut56FRBIJzu1WDVRp/RW4aWaKE+tKDQRfADYqVASfsiU1r4NOfJWWUyt0PXlhVLQIm/sWo0X/i30DPBTie/phQx0MVtPg2ViMrKHOUis67rjZPQELAttwKYB7++FzATPMwh4PI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730721149; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1xuVj2Wq2Who34zQ8ZQSheUl2Bxvzvh0GIHAzkj+6Ds=; 
	b=NoCitT2zJxEPjA731jTyjApui7H68HZ5b8BdlLM2wIhpLfjuBSUpWupLew41MspdAXfQYBdWfhKxu/HoWPVNHkiRiN7MgG34WPoWaelFxQe8xbW8NmBgMbjPexnpOVaPqpy0/Gck8AenrLODa4F5vFh6ksCRkwgPVAekqoaMrxg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730721149;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1xuVj2Wq2Who34zQ8ZQSheUl2Bxvzvh0GIHAzkj+6Ds=;
	b=NSAO5wUQx69Fl9/pLGwABrgXfbtNq17W619+tLJHre/jFEUbIf44MslyN0VluzxB
	HQnXZUDiMx0fHEios0ITxFeJQ0gG8NldIlsTlPyBAlUDixPtboVO9XjjO9goYPoFjUU
	fD2N3uNmWbbdAUEJwJ9W7P9Fpy4uZ1U4vpnA//8c=
Received: by mx.zohomail.com with SMTPS id 1730721148847251.89438493661555;
	Mon, 4 Nov 2024 03:52:28 -0800 (PST)
Message-ID: <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
Date: Mon, 4 Nov 2024 06:52:26 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: Ard Biesheuvel <ardb@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: x86@kernel.org, Ross Philipson <ross.philipson@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, trenchboot-devel@googlegroups.com
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/4/24 06:27, Ard Biesheuvel wrote:
> On Mon, 4 Nov 2024 at 12:18, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>
>> On Mon Nov 4, 2024 at 12:57 PM EET, Daniel P. Smith wrote:
>>> On 11/2/24 14:00, Jarkko Sakkinen wrote:
>>>> On Sat Nov 2, 2024 at 5:22 PM EET, Jarkko Sakkinen wrote:
>>>>> It is not really my problem but I'm also wondering how the
>>>>> initialization order is managed. What if e.g. IMA happens to
>>>>> initialize before slmodule?
>>>>
>>>> The first obvious observation from Trenchboot implementation is that it
>>>> is 9/10 times worst idea ever to have splitted root of trust. Here it
>>>> is realized by an LKM for slmodule.
>>>
>>> First, there is no conflict between IMA and slmodule. With your change
>>> to make locality switching a one shot, the only issue would be if IMA
>>> were to run first and issue a locality switch to Locality 0, thus
>>> blocking slmodule from switching to Locality 2. As for PCR usage, IMA
>>> uses the SRTM PCRs, which are completely accessible under Locality 2.
>>
>> Just pointing out a possible problem (e.g. with  TPM2_PolicyLocality).
>>
>>> Honestly, a better path forward would be to revisit the issue that is
>>> driving most of that logic existing, which is the lack of a TPM
>>> interface code in the setup kernel. As a reminder, this issue is due to
>>> the TPM maintainers position that the only TPM code in the kernel can be
>>> the mainline driver. Which, unless something has changed, is impossible
>>> to compile into the setup kernel due to its use of mainline kernel
>>> constructs not present in the setup kernel.
>>
>> I don't categorically reject adding some code to early setup. We have
>> some shared code EFI stub but you have to explain your changes
>> proeprly. Getting rejection in some early version to some approach,
>> and being still pissed about that years forward is not really way
>> to go IMHO.
>>
> 
> Daniel has been nothing but courteous and patient, and you've waited
> 11 revision to come up with some bikeshedding patches that don't
> materially improve anything.
> 
> So commenting on Daniel's approach here is uncalled for.
> 
> Can we please converge on this?
> 
> Daniel - if no component can be built as a module, there should be no
> reason for the set_default_locality() hook to be exported to modules
> right? And do we even need a sysfs node to expose this information?

Hi Ard,

The only reason off the top of my head of why it was exported was to 
support the fact that the tpm module itself could be built as a module, 
not that we were looking for it to be done so.

As to sysfs, there is the TXT register content that we would like to 
have exposed, and they should be readonly. For context to contrast with, 
tboot user space utility txt-stat worked by trying to read the TXT 
register address space via /dev/mem, think enough is said there. The 
other purpose we used sysfs was management of the DRTM log. We used it 
to provide a means to ensure the DRTM eventlog is extended when 
measurements are sent to the DRTM PCRs and then to be able to retrieve 
the final log.

v/r,
dps

