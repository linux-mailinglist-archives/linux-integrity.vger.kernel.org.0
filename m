Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320222F38BE
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 19:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406561AbhALSXq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 13:23:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34538 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406562AbhALSXo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 13:23:44 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id A918D20B6C40;
        Tue, 12 Jan 2021 10:23:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A918D20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610475782;
        bh=Mlkm80b1f8WhkhKW/H3c/Y4XQPYYHF6vKJ3RtWh8Y0w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V562zflJfRe3jaD/HTEifNXj5laof02eB2huBdBAMJ0x1CFhujbrGFcpof3oBoHb3
         nAjuo1l1FSwpGj74KTO6fjNZnc/SWfozEOPCiQZAvtmcQw6DLO9PZVgoiGKjXH9b3F
         ef+zWPe16tSjZbbw5jIoJL8N3xEJ71/IFMSWOjpo=
Subject: Re: [PATCH v14 0/6] Carry forward IMA measurement log on kexec on
 ARM64
To:     Rob Herring <robh@kernel.org>
Cc:     zohar@linux.ibm.com, bauerman@linux.ibm.com,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au,
        james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210112144248.GA256955@robh.at.kernel.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <c661ce17-a5a6-0aa0-ed9d-eab99020d98a@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 10:23:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112144248.GA256955@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/12/21 6:42 AM, Rob Herring wrote:
> On Mon, Jan 04, 2021 at 11:25:56AM -0800, Lakshmi Ramasubramanian wrote:
>> On kexec file load Integrity Measurement Architecture (IMA) subsystem
>> may verify the IMA signature of the kernel and initramfs, and measure
>> it. The command line parameters passed to the kernel in the kexec call
>> may also be measured by IMA. A remote attestation service can verify
>> a TPM quote based on the TPM event log, the IMA measurement list, and
>> the TPM PCR data. This can be achieved only if the IMA measurement log
>> is carried over from the current kernel to the next kernel across
>> the kexec call.
>>
>> powerpc already supports carrying forward the IMA measurement log on
>> kexec. This patch set adds support for carrying forward the IMA
>> measurement log on kexec on ARM64.
>>
>> This patch set moves the platform independent code defined for powerpc
>> such that it can be reused for other platforms as well. A chosen node
>> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
>>
>> This patch set has been tested for ARM64 platform using QEMU.
>> I would like help from the community for testing this change on powerpc.
>> Thanks.
>>
>> This patch set is based on
>> commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
>> in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>> "dt/kexec" branch.
> 
> This all looks good to me. I'd suggest you send the above patches out as
> part of this series because I don't plan to do so.

Thanks for reviewing the patches Rob.

Sure - I'll add your patches to this series.

> I would like to also resolve the vmalloc vs. kmalloc difference for
> allocating the FDT. Then we can further consolidate the DT kexec code.

I think FDT allocation using vmalloc for ARM64 can be changed to 
kmalloc. What are the other changes you'd like me to do in arm64/powerpc 
DT kexec code in this patch series?

@AKASHI Takahiro - could you please let me know if the above sounds right?

> 
> It all needs some acks from arm64 and powerpc maintainers. As far as
> merging, I think via the integrity tree makes the most sense.

I'll create the patch series in "next-integrity" branch.

Thiago/Mimi have acked some of the patches. Please review the remaining 
patches in this version.

Could arm64 maintainers please review the patches and respond?

thanks,
  -lakshmi


