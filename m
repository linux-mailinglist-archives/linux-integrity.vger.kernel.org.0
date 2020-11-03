Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB612A5011
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgKCT0s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 14:26:48 -0500
Received: from linux.microsoft.com ([13.77.154.182]:59626 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCT0r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 14:26:47 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 195FF20B4905;
        Tue,  3 Nov 2020 11:26:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 195FF20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604431606;
        bh=W0Zh911SvMPBVmdEXmA1HcYsG++HUAmXbKA5/8UO44g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iuF/o2WK5I9LEylsm091pAyVfXK+P1AU4Afj1Dcmwc+awaZDdF4z+OO6lS42ENqvG
         CfVTYLd/4+L/UrGBS3R714iOd07K7cQK/N6L95GDpf0QF4/L0/W3tnrXo13e9y2Qqw
         hOOWvgFlOzFOwvzya6D7NrtOnZgLm/fPEfzYEYy8=
Subject: Re: [PATCH v8 0/4] Carry forward IMA measurement log on kexec on
 ARM64
To:     Mimi Zohar <zohar@linux.ibm.com>, bauerman@linux.ibm.com,
        robh@kernel.org, gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
 <053cf58ae21f2e7088e22eedf8c5ee6e73a1e835.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1f01055c-acb8-6497-0144-dfeb78f08eee@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 11:26:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <053cf58ae21f2e7088e22eedf8c5ee6e73a1e835.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/3/20 7:18 AM, Mimi Zohar wrote:

Hi Mimi,

> On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
>> On kexec file load Integrity Measurement Architecture (IMA) subsystem
>> may verify the IMA signature of the kernel and initramfs, and measure
>> it. The command line parameters passed to the kernel in the kexec call
>> may also be measured by IMA. A remote attestation service can verify
>> the measurement through the IMA log and the TPM PCR data. This can be
>> achieved only if the IMA measurement log is carried over from
>> the current kernel to the next kernel across the kexec call.
> 
> Nice, but you might want to tweak it a bit.  This is just a suggestion.
> "A remote attestation service can verify a TPM quote based on the TPM
> event log, the IMA measurement list, and the TPM PCR data".
Sure - will make this change.

> 
>> However in the current implementation the IMA measurement logs are not
>> carried over on ARM64 platforms. Therefore a remote attestation service
>> cannot verify the authenticity of the running kernel on ARM64 platforms
>> when the kernel is updated through the kexec system call.
> 
> The paragraphs above and below are redundant.  The first paragraph
> already explained why carrying the measurement across kexec is needed.
> Perhaps drop the above paragraph.
Sure.

> 
>> This patch series adds support for carrying forward the IMA measurement
>> log on kexec on ARM64. powerpc already supports carrying forward
>> the IMA measurement log on kexec.
> 
> And invert these sentences, starting the paragraph with "Powerpc
> already" and ending with ARM64.
Sure.

> 
>>
>> This series refactors the platform independent code defined for powerpc
>> such that it can be reused for ARM64 as well. A chosen node namely
>> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
> 
> ^This patch set moves ..."
Sure - will make this change.

Thanks again for reviewing the patches. Will post the updated patch set 
shortly.

  -lakshmi
