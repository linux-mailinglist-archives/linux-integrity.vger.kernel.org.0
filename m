Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A6E5203
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505832AbfJYRIP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 13:08:15 -0400
Received: from foss.arm.com ([217.140.110.172]:43370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505811AbfJYRIG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 13:08:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A6A328;
        Fri, 25 Oct 2019 10:08:05 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D79FC3F71A;
        Fri, 25 Oct 2019 10:08:02 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, yamada.masahiro@socionext.com,
        duwe@lst.de, tglx@linutronix.de, allison@lohutok.net,
        ard.biesheuvel@linaro.org
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
 <1571190256.5250.200.camel@linux.ibm.com>
Message-ID: <3879883b-8c27-df25-ce20-97ed7274dc80@arm.com>
Date:   Fri, 25 Oct 2019 18:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571190256.5250.200.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 16/10/2019 02:44, Mimi Zohar wrote:
> On Tue, 2019-10-15 at 18:39 +0100, James Morse wrote:
>> If SecureBoot isn't relevant, I'm confused as to why kexec_file_load() is.
>>
>> I thought kexec_file_load() only existed because SecureBoot systems need to validate the
>> new OS images's signature before loading it, and we can't trust user-space calling Kexec
>> to do this.
>>
>> If there is no secure boot, why does this thing only work with kexec_file_load()?
>> (good news! With the UEFI memreseve table, it should work transparently with regular kexec
>> too)

> I'm so sorry for the confusion.  IMA was originally limited to
> extending trusted boot concepts to the OS.  As of Linux 3.10, IMA
> added support for extending secure boot concepts and auditing file
> hashes (commit e7c568e0fd0cf).
> 
> True, kexec_file_load is required for verifying the kexec kernel
> image, but it is also required for measuring the kexec kernel image as
> well.
> 
> After reading the kernel image into memory (kernel_read_file_from_fd),
> the hash is calculated and then added to the IMA measurement list and
> used to extend the TPM.  All of this is based on the IMA policy,
> including the TPM PCR.

Don't we get a set of segments with the regular kexec syscall? These could equally be
hashed and measured, and logged via IMA and/or extending the TPMs measurements.

(obviously this would include the command-line and maybe purgatory, which makes it less
predictable, but these are still the binary blobs that were given privileged access to the
system).


>>> I am not sure if i addressed all your concerns, please let me know
>>> if i missed anything. To me most concerns look to be towards the kexec case and dependency
>>> on hardware(ACPI/TPM) during boot and early boot services, where as carrying the logs is
>>> only during the kexec_file_load sys call and does not interfere with that code path.
>>> IMA documentation: https://sourceforge.net/p/linux-ima/wiki/Home/
>>
>> Supporting ACPI in the same way is something we need to do from day one. kexec_file_load()
>> already does this. I'm not sure "only kexec_file_load()" is a justifiable restriction...

> The TPM PCRs are not reset on a soft reboot.  As a result, in order to
> validate the IMA measurement list against the TPM PCRs, the IMA
> measurement list is saved on kexec load, restored on boot, and then
> the memory allocated for carrying the measurement list across kexec is
> freed.

Hmm, this is why the reserved memory gets freed.

What happens to stuff that happens between kexec-load and boot?
There is a comment:
| /* segment size can't change between kexec load and execute */

But I can't see anywhere that enforces that. I guess those measurements will go missing,
and the TPM value will not match after kexec.



Thanks,

James
