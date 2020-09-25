Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFEE2793BE
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 23:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgIYVso (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 17:48:44 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21146 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYVso (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 17:48:44 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 17:48:41 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1601069575; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eaCridq/Q/bPqSpnsGv/DJP6Af6/ncIr2v/Qf8j8EGiSN5pUxISglSxhg0elB/41ayTlI2YKZ8pZnWTFbUbJklfdDvQCOj8B0fCxdc8rh0XadT/UJzFBbCBU1yMRnp75hcbcVvAFC6+rbIJMARqR4sCb6zqH6qfj1yXd+406l5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1601069575; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=0a7g0NVpSKP3n73d4Kbie2Bt3f9aurS3uIGDEm9zTs8=; 
        b=dxw/TJwnUBKaP0P0ILY/i2BLJ4r+gYKey93bBzChSs3ax3+wOsVoWVYEAJ4MPJ4mtFCK4q+H/F2y2Vosr8QSSjCLtxSASL5crgyxTGAxjtArgWXQ6miEvlSiBDketKM5Y4nieFp7HmnDQaFTsqQPZqeL1nQ+J4+oZwlKXhfgDb4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601069575;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=0a7g0NVpSKP3n73d4Kbie2Bt3f9aurS3uIGDEm9zTs8=;
        b=kQ0ksBHC73Nhf3QsqlgJGUOmpoeQQeVZL0cpPok5s92kAwdC/qZsEhhOqweVurav
        S7E5Gat7JVVnw6mD9i8b8EcmsiVW6ezfvE8uFH4GaK19nb7Na8qtR1cm3rvBTNPrlVp
        qc90V9VtyQo34Al/a6roBwy8NP/5tWpmOfVYMowA=
Received: from [10.10.1.24] (c-73-129-147-140.hsd1.md.comcast.net [73.129.147.140]) by mx.zohomail.com
        with SMTPS id 1601069573615900.4080400133685; Fri, 25 Sep 2020 14:32:53 -0700 (PDT)
Subject: Re: [PATCH 00/13] x86: Trenchboot secure dynamic launch Linux kernel
 support
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        trenchboot-devel@googlegroups.com
References: <1600959521-24158-1-git-send-email-ross.philipson@oracle.com>
 <20200925053051.GA165011@linux.intel.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <8329607a-704d-1da0-dc7b-4b97c2440afb@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Fri, 25 Sep 2020 17:32:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200925053051.GA165011@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/25/20 1:30 AM, Jarkko Sakkinen wrote:
> On Thu, Sep 24, 2020 at 10:58:28AM -0400, Ross Philipson wrote:
>> The Trenchboot project focus on boot security has led to the enabling of
>> the Linux kernel to be directly invocable by the x86 Dynamic Launch
>> instruction(s) for establishing a Dynamic Root of Trust for Measurement
>> (DRTM). The dynamic launch will be initiated by a boot loader with
>=20
> What is "the dynamic launch"?

Dynamic launch is the term used to reference the event/process of
restarting a system without reboot to establish the DRTM. It is defined
in the TCG Glossary[1], is discussed in detail in the TCG D-RTM
Architecture specification[2], and covered in minimal detail in sections
9.5.5 and 34.2 of the TCG TPM2.0 Architecture specification[3].

[1]
https://trustedcomputinggroup.org/wp-content/uploads/TCG-Glossary-V1.1-Rev-=
1.0.pdf
[2]
https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architecture=
_v1-0_Published_06172013.pdf
[3]
https://trustedcomputinggroup.org/wp-content/uploads/TCG_TPM2_r1p59_Part1_A=
rchitecture_pub.pdf

>> associated support added to it, for example the first targeted boot
>> loader will be GRUB2. An integral part of establishing the DRTM involves
>> measuring everything that is intended to be run (kernel image, initrd,
>> etc) and everything that will configure that kernel to run (command
>> line, boot params, etc) into specific PCRs, the DRTM PCRs (17-22), in
>> the TPM. Another key aspect is the dynamic launch is rooted in hardware,
>> that is to say the hardware (CPU) is what takes the first measurement
>> for the chain of integrity measurements. On Intel this is done using
>> the GETSEC instruction provided by Intel's TXT and the SKINIT
>> instruction provided by AMD's AMD-V. Information on these technologies
>> can be readily found online. This patchset introduces Intel TXT support.
>=20
> Why not both Intel and AMD? You should explain this in the cover letter.

The work for this is split across different teams with different
resourcing levels resulting in one organization working Intel and
another working AMD. This then raised the concern over submitting a
single patch set developed by two groups pseudo-independently. In this
situation the result would be patches being submitted from one
organization that had no direct development or testing and therefore
could not sign off on a subset of the patches being submitted.

> I'd be more motivated to review and test a full all encompassing x86
> solution. It would increase the patch set size but would also give it
> a better test coverage, which I think would be a huge plus in such a
> complex patch set.

We would not disagree with those sentiments but see the previous
response about the conflict that exists.

>> To enable the kernel to be launched by GETSEC, a stub must be built
>> into the setup section of the compressed kernel to handle the specific
>> state that the dynamic launch process leaves the BSP in. This is
>> analogous to the EFI stub that is found in the same area. Also this stub
>=20
> How is it analogous?

It is analogous as we used it as the pattern to follow for adding a
configurable entry point to the kernel. There was a discussion on this
when we published the RFC patches[4].

[4] https://lkml.org/lkml/2020/3/25/982

>> must measure everything that is going to be used as early as possible.
>> This stub code and subsequent code must also deal with the specific
>> state that the dynamic launch leaves the APs in.
>=20
> What is "the specific state"?

The details are a bit more than I would prefer to explain here, I would
recommend reading section 2.3 and 2.4 of Intel's TXT Software
Development Guide[5] for all the details of the state and the prescribed
initialization sequence.

[5]
https://www.intel.com/content/dam/www/public/us/en/documents/guides/intel-t=
xt-software-development-guide.pdf

>> A quick note on terminology. The larger open source project itself is
>> called Trenchboot, which is hosted on Github (links below). The kernel
>> feature enabling the use of the x86 technology is referred to as "Secure
>> Launch" within the kernel code. As such the prefixes sl_/SL_ or
>> slaunch/SLAUNCH will be seen in the code. The stub code discussed above
>> is referred to as the SL stub.
>=20
> Is this only for Trenchboot? I'm a bit lost. What is it anyway?

TrenchBoot is a meta-project that is working to bring a unified approach
to using DRTM across CPU implementations and open source projects.
Currently we are working to integrate a dynamic launch preamble (the
code that sets up for calling the dynamic launch CPU instruction) in
GRUB, building an open AMD Secure Loader that aligns with how Intel's
SINIT ACM hands off to an MLE, bring the first directly launchable
implementation to Linux (Secure Launch) with Xen being the next directly
launchable implementation, providing the u-root project a secure launch
initramfs init routine to demonstrate a policy driven measurement and
attestation framework that can be used in conjunction with a Secure
Launch kernel.


>> The basic flow is:
>>
>>  - Entry from the dynamic launch jumps to the SL stub
>>  - SL stub fixes up the world on the BSP
>=20
> What is "SL"?

As mentioned above, it is just shorthand for Secure Launch.

>>  - For TXT, SL stub wakes the APs, fixes up their worlds
>>  - For TXT, APs are left halted waiting for an NMI to wake them
>>  - SL stub jumps to startup_32
>>  - SL main runs to measure configuration and module information into the
>>    DRTM PCRs. It also locates the TPM event log.
>>  - Kernel boot proceeds normally from this point.
>>  - During early setup, slaunch_setup() runs to finish some validation
>>    and setup tasks.
>=20
> What are "some" validation and setup tasks?

The validation and setup steps are to ensure the environment was setup
in a manner that we expected as outlined in the Intel TXT Software
Development guide[4]. At this point these are,
- Ensure that SENTER completed successfully and was not initiated by TBOOT.
- Check that the private MMIO register bank is available.
- Fetch values needed from the TXT heap for later operations.
- Verify the PMR values cover the MLE and other memory regions that need
to be secure.
- Reserve certain TXT specific areas of physical memory.
- Fetch the copy of the DMAR table from the TXT heap to provide to the
IOMMU driver later.

>>  - The SMP bringup code is modified to wake the waiting APs. APs vector
>>    to rmpiggy and start up normally from that point.
>>  - Kernel boot finishes booting normally
>>  - SL securityfs module is present to allow reading and writing of the
>>    TPM event log.
>=20
> What is SL securityfs module? Why is it needed? We already have
> securityfs file for the event log. Why it needs to be writable?

The securityfs nodes provides access to the TXT registers to inspect the
details from the dynamic launch and access to the DRTM event log. The
DRTM event log is setup by the DRTM process and is a different/separate
event log from the SRTM/UEFI event log. We need write access for use
cases where the Secure Launch kernel is being used as an intermediate
launch kernel where additional measurements about the final target
environment are being collected.

>>  - SEXIT support to leave SMX mode is present on the kexec path and
>>    the various reboot paths (poweroff, reset, halt).
>=20
> What SEXIT do and why it is required on the kexec path?

The SEXIT instruction "exits" SMX mode. The why is because when in SMX
mode the CPU has a set of behaviors different than what is typically
expected, especially for SMP management. As good custodians, this
ensures that the system is in a usable state for a follow-on kernel that
is not SMX/Secure Launch aware. From a security use case perspective,
leaving SMX mode disables access to localities 1-3 of the TPM. This
essentially "locks" the values in the DRTM PCRs from further
modification/extends until another dynamic launch event is fired which
will in turn result in the DRTM PCRs being reset.

> /Jarkko
>=20


