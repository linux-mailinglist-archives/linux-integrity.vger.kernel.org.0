Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579C8D6904
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 20:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfJNSCe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 14:02:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJNSCe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 14:02:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 344A528;
        Mon, 14 Oct 2019 11:02:33 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F083A3F6C4;
        Mon, 14 Oct 2019 11:02:29 -0700 (PDT)
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, zohar@linux.ibm.com,
        yamada.masahiro@socionext.com, kristina.martsenko@arm.org,
        duwe@lst.de, bauerman@linux.ibm.com, james.morse@arm.org,
        tglx@linutronix.de, allison@lohutok.net
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
Date:   Mon, 14 Oct 2019 19:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011003600.22090-1-prsriva@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

(You've CC'd a few folk who work for 'arm.org'...)

On 11/10/2019 01:35, Prakhar Srivastava wrote:
> Add support to carry ima measurement log
> to the next kexec'ed session triggered via kexec_file_load.

I don't know much about 'ima', I'm assuming its the list of 'stuff' that has already been
fed into the TPM as part of SecureBoot. Please forgive the stupid questions,


> Currently during kexec the kernel file signatures are/can be validated
> prior to actual load, the information(PE/ima signature) is not carried
> to the next session. This lead to loss of information.
> 
> Carrying forward the ima measurement log to the next kexec'ed session 
> allows a verifying party to get the entire runtime event log since the
> last full reboot, since that is when PCRs were last reset.

Hmm, You're adding this as a linux-specific thing in the chosen node, which points at a
memreserve.

The question that normally needs answering when adding to the stuff we have to treat as
ABI over kexec is: how would this work from a bootloader that isn't kexec? Does it need to
work for non-linux OS?

Changing anything other than the chosen node of the DT isn't something the kernel should
be doing. I suspect if you need reserved memory for this stuff, it should be carved out by
the bootloader, and like all other memreserves: should not be moved or deleted.

('fdt_delete_mem_rsv()' is a terrifying idea, we depend on the memreserve nodes to tell
use which 'memory' we shouldn't touch!)


Sharing with powerpc is a great starting point ... but, how does this work for ACPI systems?
How does this work if I keep kexecing between ACPI and DT?

I'd prefer it we only had one way this works on arm64, so whatever we do has to cover both.

Does ima work without UEFI secure-boot?
If not, the Linux-specific UEFI 'memreserve' table might be a better fit, this would be
the same for both DT and ACPI systems. Given U-boot supports the UEFI API too, its
probably the right thing to do regardless of secure-boot.

It looks like x86 doesn't support this either yet. If we have to add something to support
ACPI, it would be good if it covers both firmware mechanisms for arm64, and works for x86
in the same way.

(How does this thing interact with EFI's existing efi_tpm_eventlog_init()?)


Thanks,

James
