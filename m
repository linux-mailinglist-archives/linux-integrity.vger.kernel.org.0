Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5393BD6CE5
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Oct 2019 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbfJOBbc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 21:31:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49942 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfJOBbc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 21:31:32 -0400
Received: from [10.137.104.46] (unknown [131.107.174.174])
        by linux.microsoft.com (Postfix) with ESMTPSA id DD1DC20B71C6;
        Mon, 14 Oct 2019 18:31:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD1DC20B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571103091;
        bh=JyQth7Ct3RzPrDMGGVL/0UtrVuwcC4tEO3GTBka83Hc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1vggRK+d0gb1x/O0Shq8BSQkFFU6Gm+V4FMb09ZP5prEtMCjhnrePJquxG2lyPit
         s5Wz/IivDkfxFtgXl2mZGrsvgpoVwBB9NbU3CY737tNMV8d5SejQAbiXATG8MWV9dW
         5JqQEz7TH3QBLqotT9rwGaQ2Mm9Ov8M13tLVOYuI=
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, zohar@linux.ibm.com,
        yamada.masahiro@socionext.com, kristina.martsenko@arm.org,
        duwe@lst.de, bauerman@linux.ibm.com, james.morse@arm.org,
        tglx@linutronix.de, allison@lohutok.net
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
Date:   Mon, 14 Oct 2019 18:31:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/14/19 11:02 AM, James Morse wrote:
> Hi Prakhar,
> 
> (You've CC'd a few folk who work for 'arm.org'...)
> 
> On 11/10/2019 01:35, Prakhar Srivastava wrote:
>> Add support to carry ima measurement log
>> to the next kexec'ed session triggered via kexec_file_load.
> 
> I don't know much about 'ima', I'm assuming its the list of 'stuff' that has already been
> fed into the TPM as part of SecureBoot. Please forgive the stupid questions,
> 
The IMA logs are event logs for module load time signature 
validation(based on policies) which are backed by the TPM. No SecureBoot 
information is present in the log other than the boot aggregate.

>> Currently during kexec the kernel file signatures are/can be validated
>> prior to actual load, the information(PE/ima signature) is not carried
>> to the next session. This lead to loss of information.
>>
>> Carrying forward the ima measurement log to the next kexec'ed session
>> allows a verifying party to get the entire runtime event log since the
>> last full reboot, since that is when PCRs were last reset.
> 
> Hmm, You're adding this as a linux-specific thing in the chosen node, which points at a
> memreserve.
> 
> The question that normally needs answering when adding to the stuff we have to treat as
> ABI over kexec is: how would this work from a bootloader that isn't kexec? Does it need to
> work for non-linux OS?
> 
This change is only intended to be executed in the path of 
kexec_file_load and not intended to be executed by any boot loader.(Not 
very aware of boot loader calls.). The logs are non intended to be 
injected by the boot loader at all.
The change is configurable(CONFIG_IMA_KEXEC) under the IMA subsection 
and can be disabled if not needed.

> Changing anything other than the chosen node of the DT isn't something the kernel should
> be doing. I suspect if you need reserved memory for this stuff, it should be carved out by
> the bootloader, and like all other memreserves: should not be moved or deleted.
> 
> ('fdt_delete_mem_rsv()' is a terrifying idea, we depend on the memreserve nodes to tell
> use which 'memory' we shouldn't touch!)
> 
fdt_delete_mem_rsv - is to cleanup any memory that's been mistakenly 
still lying around in the same session while creating the fdt. 
memblock_free is actually used to free up the reserved memory.

Thiago may have more insight, This is primarily a code that's been 
ported from existing kernel for PowerPC.
https://github.com/torvalds/linux/blob/master/arch/powerpc/kernel/machine_kexec_file_64.c

> 
> Sharing with powerpc is a great starting point ... but, how does this work for ACPI systems?
> How does this work if I keep kexecing between ACPI and DT?
> 

I don't have an answer to this, just going through the call stack i dont 
believe it depends on ACPI as such. I am not the expert here, but more 
than willing to try out the scenario in question.(Can you point me to 
some documentation to setup some environment to test this.) 
Kexec_file_load call depends purely on DT implementation.


> I'd prefer it we only had one way this works on arm64, so whatever we do has to cover both.
I can move the code to be only part of arm64 arch if absolutely 
necessary. Thiago do you have any concerns on going back the path of 
multiple code paths?

>
> Does ima work without UEFI secure-boot?
Yes, IMA, the measurement is not dependent on any hardware capabilities.
TPM is needed to back the measurements but the IMA module will not fail 
if TPM is not available.
In short Secure-boot has no impact on IMA.

> If not, the Linux-specific UEFI 'memreserve' table might be a better fit, this would be
> the same for both DT and ACPI systems. Given U-boot supports the UEFI API too, its
> probably the right thing to do regardless of secure-boot.
> 
> It looks like x86 doesn't support this either yet. If we have to add something to support
> ACPI, it would be good if it covers both firmware mechanisms for arm64, and works for x86
> in the same way.
> 
> (How does this thing interact with EFI's existing efi_tpm_eventlog_init()?)
> 
IMA does not interact with the TPM event log.
Only one of the PCR's is extended but not logged in the TPM logs. The 
logging is done in IMA. The IMA measurement log in question is whats 
needed to be carried over to via kexec_file_load call.

I am not sure if i addressed all your concerns, please let me know
if i missed anything. To me most concerns look to be towards the kexec 
case and dependency on hardware(ACPI/TPM) during boot and early boot 
services, where as carrying the logs is only during the kexec_file_load 
sys call and does not interfere with that code path.
IMA documentation: https://sourceforge.net/p/linux-ima/wiki/Home/

Prakhar Srivastava
> 
> Thanks,
> 
> James
> 
