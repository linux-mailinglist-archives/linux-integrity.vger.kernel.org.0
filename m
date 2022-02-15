Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8214B7342
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Feb 2022 17:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238727AbiBOQJD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Feb 2022 11:09:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241333AbiBOQJD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Feb 2022 11:09:03 -0500
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 08:08:52 PST
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7A6C940
        for <linux-integrity@vger.kernel.org>; Tue, 15 Feb 2022 08:08:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644940382; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HXxz3GmPdHi9VJcULR+nRpA9zsW0rlX60sRmo8yOPf0h3QXRoVdNmSQqTJrAxriv+lFzmgr/eA8DOZRpDvCBQazkqXbUWl4fQBWXnf+P+rCpGP4q65P91EkgWpS8vP64nQ4LaKbfmnNC6qL40T403E/3D/Fyg2kpfNLQ5iW7NAU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644940382; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Q9rIJ8BwGgpzkzfuy7gF1S8dCxR9g5dAGFpAHarHfDU=; 
        b=ee4ME+Qz5Pm78HW/5MLfo7HkApMsiQJnpOK4VJijt23BrczkJ2iLnKmwPoVVp8H2/kvLYv7zRJ/F4709/9IZCRj04Cstkp9aeYMVhatDD6ToQOP34xRxqqPGpSBY9c8HP9fPVGuvwbI4m4GcQ8zKesQpqIWWNWMxe3y6WPLSuCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644940382;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=Q9rIJ8BwGgpzkzfuy7gF1S8dCxR9g5dAGFpAHarHfDU=;
        b=hMiI53rETvA7McBVv/5+kyNFnRmFkD4k4nvg+oEHwMhlxhhG313puEjpfZSxuFzC
        2AbXaQjR8tT1+3TLBEVXkgKb1/+trmA/Va7EA0AVmdKpCYcvTTfARfshzub967EiXf9
        ty/aZPLMBmUau7nePCtU4nfZasbJXR3pwovm4x54=
Received: from [10.10.1.138] (static-72-81-132-2.bltmmd.fios.verizon.net [72.81.132.2]) by mx.zohomail.com
        with SMTPS id 1644940378250940.8412069904673; Tue, 15 Feb 2022 07:52:58 -0800 (PST)
Message-ID: <d7b6434d-ceb5-fc87-4117-5b0341611535@apertussolutions.com>
Date:   Tue, 15 Feb 2022 10:50:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v4 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        trenchboot-devel@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <CAHC9VhTJG24iG=U0geO-ZhC6OogxOu4icBrNY22+qRNpWd5PBQ@mail.gmail.com>
 <456caf8c-b79a-e8b0-581f-3504240466ff@apertussolutions.com>
 <CAHC9VhSZx7j2sEs1H3ON-eDoeWdtXPC7XNQcv5D1WbnP=4Lchg@mail.gmail.com>
 <CAHC9VhThAbwuy+wXZfeMorc0QZ19FOfh0rk7uqaOj7uHvruM0Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHC9VhThAbwuy+wXZfeMorc0QZ19FOfh0rk7uqaOj7uHvruM0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Paul,

Apologies for missing your follow-up questions. Hopefully, the below
answers will help.

On 1/21/22 16:39, Paul Moore wrote:
> On Mon, Dec 6, 2021 at 3:56 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Dec 2, 2021 at 11:11 AM Daniel P. Smith
>> <dpsmith@apertussolutions.com> wrote:
>>> Hi Paul!
>>
>> /me waves
>>
>>> On 11/30/21 8:06 PM, Paul Moore wrote:
>>>> On Fri, Aug 27, 2021 at 9:20 AM Ross Philipson
>>>> <ross.philipson@oracle.com> wrote:
>>>>>
>>>>> The larger focus of the Trechboot project (https://github.com/TrenchBoot) is to
>>>>> enhance the boot security and integrity in a unified manner. The first area of
>>>>> focus has been on the Trusted Computing Group's Dynamic Launch for establishing
>>>>> a hardware Root of Trust for Measurement, also know as DRTM (Dynamic Root of
>>>>> Trust for Measurement).
>>>>
>>>> My apologies for such a late reply, but I'm just getting around to
>>>> looking at this and I have a few questions on the basic design/flow
>>>> (below) ...
>>>
>>> No worries, thank you so much for taking the time to review.
>>>
>>>>> The basic flow is:
>>>>>
>>>>>  - Entry from the dynamic launch jumps to the SL stub
>>>>
>>>> So I'm clear, at this point the combined stub+kernel+initramfs+cmdline
>>>> image has already been loaded into memory and the SL stub is
>>>> executing, yes?
>>>
>>> That is correct.
>>>
>>>> As TrenchBoot seems to be focused on boot measurement and not
>>>> enforcing policy, I'm guessing this is considered out-of-scope (not to
>>>> mention that the combined stub+kernel image makes this less
>>>> interesting), but has any thought been given to leveraging the TXT
>>>> launch control policy, or is it simply an empty run-everything policy?
>>>
>>> The TrenchBoot model is a bit different and takes a more flexible
>>> approach to allow users to build tailored solutions. For instance Secure
>>> Launch is able to be used in a configuration that is similar to tboot.
>>> Consider the functions of tboot, it has a portion that is the
>>> post-launch kernel that handles the handover from the ACM and a portion
>>> that provides the Verified Launch policy engine, which is only capable
>>> of enforcing policy on what is contained in the Multiboot chain. The
>>> TrenchBoot approach is to introduce the Secure Launch capability into a
>>> kernel, in this case Linux, to handle the handover from the ACM, and
>>> then transition to a running user space that can contain a distribution
>>> specific policy enforcement. As an example, the TrenchBoot project
>>> contributed to the uroot project a Secure Launch policy engine which
>>> enables the creation of an initramfs image which can then be embedded
>>> into a minimal configuration Secure Launch Linux kernel ...
>>
>> Thank you for the answers, that was helpful.
>>
>> I think I initially misunderstood TrenchBoot, thinking that a Secure
>> Launch'd kernel/userspace would be the "normal" OS that would
>> transition to multi-user mode and be available for users and
>> applications.  However, on reading your response it appears that the
>> Secure Launch'd kernel/initramfs exists only to verify a secondary
>> kernel/initramfs/userspace and then kexec() into that once verified.

Yes it can be used in this manner but this is not the only way it was
intended to be used. The goal is to enable an integrator, e.g, a distro,
to incorporate Linux Secure Launch appropriately for their security
needs, though ideally it would be preferred that a standardized approach
is adopted by Linux init tooling to provide common experience across
distros. Up until the introduction of Secure Launch, the only widely
deployed model for DRTM has been to use tboot. Tboot is an MLE/DLME that
functions as an exokernel and an intermediate loader for the Runtime
OS/MLE. This motivated the first exemplar solution to be a Linux Secure
Launch + uroot solution that would provide a similar intermediate loader
experience, but with an expanded ability of the uroot to measure
additional properties about a system. As a result a distro could use the
exemplar to replace tboot, tboot VL policy tools, and VL policy file
with a Secure Launch kernel, a u-root initrd (built-in or standalone),
and a JSON policy file.

By no means was Secure Launch meant to be limited to only being used as
an intermediate loader for a Runtime OS. There is nothing that prohibits
a Runtime Linux system to be directly started using Secure Launch.
Though it should be noted that such a solution would need to be
cognizant of the security gap across power-save modes, whereby the OS
looses the positive control that it had over the system. It should also
be mentioned that one of the motivations behind DRTM late-launch via
kexec is to provide a path for dealing with this gap by enabling a
late-launch to re-establish a known good state of the system. These all
can be considered the advanced use cases for Secure Launch.

>>> Finally if your schedule allows it and it is not too much to ask, it
>>> would be greatly appreciated if some code review could be provided.
>>> Otherwise thank you for taking the time that you have to review the
>>> approach.
>>
>> I have to admit that I'm not sure I'm the most appropriate person to
>> review all of the Intel TXT related assembly, but I could give it a
>> shot as time allows.  I would think Intel would be willing to help out
>> here if one were to ask nicely :)
>>
>> Beyond that, and with my new understanding of how TrenchBoot is
>> supposed to work, I guess my only other concern is how one might
>> verify the integrity of the Secure Launch environment on the local
>> system during boot.  My apologies if I missed some details about that
>> in your docs, responses, etc. but is this something that TrenchBoot is
>> planning on addressing (or has already addressed)?
> 
> I wanted to follow-up on this thread just in case this last question
> was lost ...

To continue from the answer above and lead into answering your question
I would first point to a presentation I gave at LPC 2020, Advanced
Applications of DRTM with TrenchBoot[1]. There I walked through how
Secure Launch could be used for different early-launch and late-launch
DRTM solutions. Under the late-launch solutions there is the "Secure
Upgrade" solutions. What I laid out there is that DRTM could be used to
launch an "Upgrade Environment" which could be locally or remotely
verified and provide a known-good and clean environment to upgrade a
system. What an implementation of that actually looks like can be seen
in the presentation by Brain Payne and myself at FOSDEM 2021, Secure
Upgrades with DRTM[2]. In this presentation the concept of a Management
MLE is introduced to provide a secure means to upgrade the Runtime MLE
along with its related policy and sealing measurements.

Now the above, like most local verification, relies on the unseal
operation as the means of local attestation. Using unseal is strong but
the reality is that remote attestation is stronger. The problem is that
remote attestation is often built as an enterprise solutions requiring a
central server/service under the control of an authority that decides
what is good or bad. Often the average user either does not have access
to such a service or does not desire to out-source control over their
system. To address this I am collaborating with 3mdeb on their Fobnail
product[3][4][5] to deliver an "attestation server in your pocket"
capability that is accessible and usable by the average user.

The answer so far is around solutions that were built from/around the
TrenchBoot project but Linux Secure Launch does not require new, special
user solutions. These solutions have been developed because DRTM enables
them to exist, not that they are the only ways Linux Secure Launch can
be utilized. For instance it is possible to setup a Clevis[6] based LUKS
full disk encryption setup using clevis' TPM2 PIN, where the TPM2 PIN
configuration uses the DRTM PCRs (17-22) as part of sealing PCRs for the
encryption key.

[1] https://lpc.events/event/7/contributions/739/
[2] https://archive.fosdem.org/2021/schedule/event/firmware_suwd/
[3] https://blog.3mdeb.com/2021/2021-10-28-fobnail-promotion/
[4] https://blog.3mdeb.com/2021/2021-12-15-fobnail_2nd_phase/
[5] https://fobnail.3mdeb.com/
[6] https://github.com/latchset/clevis

V/r,
Daniel P. Smith
