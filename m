Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4543DF9F7
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 05:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbhHDDXN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 23:23:13 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21136 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhHDDXM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 23:23:12 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Aug 2021 23:23:12 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1628046428; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Vuage8/C+0ND4RkBkK9rjTzEw0c+3+844ZAbeU86DOUv3Orm2ug5KyKzUNjU3ikQPuapyQNTEDLC8jivur82DRMJKrVcjIqrrLzhgfdYbgGkVB/mVsP4XdwjTJADWWKtkfIZhCXvuUgMCJsPPnbrBskGf3NPHZnCk6r1cVHXpoE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628046428; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=NqBoRvAywN9Gro5Luow8D32ZnnwnjQtyZoS2PTsrkg8=; 
        b=IRUeiSYoa0vgA7aLs5iuh+apYPA0fAZxVphemSvUTFgCuEK7qxsfvhGyvzKqvsE0RFw9qr3Dvwr7XTsuCuSbgLEp52SUQfClX8enQaIhZmOgXsNj4ohQxDwGu6oV0Ar8a5xJ7pjwf7FgTTQ+MYExgCZJOebzipcFA6o0Khro2/o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628046428;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=NqBoRvAywN9Gro5Luow8D32ZnnwnjQtyZoS2PTsrkg8=;
        b=dGHgOyjB0tncSAk5AgH6KZewkMuP+lGQpyH/cgkWCQsKowieQE0s6iHIeYy1IoMd
        2EKcnFuCn7an+PgXLD25TrZg8/WKRH7gjjRYNwBXGnB98O10jtanBzYc2dx6841yEZK
        vdvyoUNze6sJz7CvUY6QbLe3sJ9NKE142agJGoW0=
Received: from [10.10.1.171] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1628046423716382.0922528096655; Tue, 3 Aug 2021 20:07:03 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To:     Andy Lutomirski <luto@kernel.org>,
        Ross Philipson <ross.philipson@oracle.com>,
        Andi Kleen <ak@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
 <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <7fd6733d-ad0b-90d8-7579-5d5a282964a5@apertussolutions.com>
Date:   Tue, 3 Aug 2021 23:05:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/21/21 5:15 PM, Andy Lutomirski wrote:
> On Mon, Jun 21, 2021 at 10:51 AM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>>
>> On 6/18/21 2:32 PM, Robin Murphy wrote:
>>> On 2021-06-18 17:12, Ross Philipson wrote:
>>>> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>>>>    {
>>>>        if (cmd_line)
>>>>            iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>>>> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>> +
>>>> +    /* Do not allow identity domain when Secure Launch is configured */
>>>> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
>>>> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>
>>> Quietly ignoring the setting and possibly leaving iommu_def_domain_type
>>> uninitialised (note that 0 is not actually a usable type) doesn't seem
>>> great. AFAICS this probably warrants similar treatment to the
>>
>> Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
>> though passthrough was requested. Or perhaps something more is needed here?
>>
>>> mem_encrypt_active() case - there doesn't seem a great deal of value in
>>> trying to save users from themselves if they care about measured boot
>>> yet explicitly pass options which may compromise measured boot. If you
>>> really want to go down that route there's at least the sysfs interface
>>> you'd need to nobble as well, not to mention the various ways of
>>> completely disabling IOMMUs...
>>
>> Doing a secure launch with the kernel is not a general purpose user use
>> case. A lot of work is done to secure the environment. Allowing
>> passthrough mode would leave the secure launch kernel exposed to DMA. I
>> think what we are trying to do here is what we intend though there may
>> be a better way or perhaps it is incomplete as you suggest.
>>
> 
> I don't really like all these special cases.  Generically, what you're
> trying to do is (AFAICT) to get the kernel to run in a mode in which
> it does its best not to trust attached devices.  Nothing about this is
> specific to Secure Launch.  There are plenty of scenarios in which
> this the case:
> 
>   - Virtual devices in a VM host outside the TCB, e.g. VDUSE, Xen
> device domains (did I get the name right), whatever tricks QEMU has,
> etc.
>   - SRTM / DRTM technologies (including but not limited to Secure
> Launch -- plain old Secure Boot can work like this too).
>   - Secure guest technologies, including but not limited to TDX and SEV.
>   - Any computer with a USB-C port or other external DMA-capable port.
>   - Regular computers in which the admin wants to enable this mode for
> whatever reason.
> 
> Can you folks all please agree on a coordinated way for a Linux kernel
> to configure itself appropriately?  Or to be configured via initramfs,
> boot option, or some other trusted source of configuration supplied at
> boot time?  We don't need a whole bunch of if (TDX), if (SEV), if
> (secure launch), if (I have a USB-C port with PCIe exposed), if
> (running on Xen), and similar checks all over the place.

Hey Andy,

On behalf of Ross and myself I wanted to follow up on the points raised 
here. While there is an interest to ensure a system is properly 
configured we should not be blocking the user from configuring the 
system as they desire. Instead we are taking the approach to document 
the SecureLaunch capability, in particular the recommend way to 
configure the kernel to appropriately use the capability using the 
already existing methods such as using kernel parameters. Hopefully that 
will address the concerns in the short term. Looking forward, we do have 
a vested interest in ensuring there is an ability to configure access 
control for security and safety critical solutions and would be grateful 
if we would be included in any discussions or working groups that might 
be looking into unifying how all these security technologies should be 
configuring the Linux kernel.

V/r,
Daniel P. Smith
