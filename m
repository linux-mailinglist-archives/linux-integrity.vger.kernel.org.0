Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C933D2F38C6
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 19:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404378AbhALSY5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 13:24:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34750 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391199AbhALSY5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 13:24:57 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4B82D20B6C40;
        Tue, 12 Jan 2021 10:24:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B82D20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610475856;
        bh=kqMBWN+x15udzdBrDVysSjGa/JtllSC2mi1dYfiqcNg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nz/lGdJ+VWGYcVJUzrRnQ/az6wTlrhlZD8nWstDbHaQepPqr9axhkTjLvU2iJHRDn
         JVSPiih3sfLNuT8GCEseCc89XcB+adnkVp5jeUoTKL/Sh7NJe5Ky613ket7v01ctTN
         HacFyxSKKrhVYb6q79LK5W5ANUSlLNEcMeF8r6CI=
Subject: Re: [PATCH v14 0/6] Carry forward IMA measurement log on kexec on
 ARM64
To:     Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc:     bauerman@linux.ibm.com, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@vger.kernel.org
References: <20210104192602.10131-1-nramas@linux.microsoft.com>
 <20210112144248.GA256955@robh.at.kernel.org>
 <601825013d67584b0d2de7a973b806ec3cbc05ca.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <14f80991-92db-68ec-7c60-5f868a9bd57a@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 10:24:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <601825013d67584b0d2de7a973b806ec3cbc05ca.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/12/21 10:05 AM, Mimi Zohar wrote:
> On Tue, 2021-01-12 at 08:42 -0600, Rob Herring wrote:
>> On Mon, Jan 04, 2021 at 11:25:56AM -0800, Lakshmi Ramasubramanian wrote:
>>> On kexec file load Integrity Measurement Architecture (IMA) subsystem
>>> may verify the IMA signature of the kernel and initramfs, and measure
>>> it. The command line parameters passed to the kernel in the kexec call
>>> may also be measured by IMA. A remote attestation service can verify
>>> a TPM quote based on the TPM event log, the IMA measurement list, and
>>> the TPM PCR data. This can be achieved only if the IMA measurement log
>>> is carried over from the current kernel to the next kernel across
>>> the kexec call.
>>>
>>> powerpc already supports carrying forward the IMA measurement log on
>>> kexec. This patch set adds support for carrying forward the IMA
>>> measurement log on kexec on ARM64.
>>>
>>> This patch set moves the platform independent code defined for powerpc
>>> such that it can be reused for other platforms as well. A chosen node
>>> "linux,ima-kexec-buffer" is added to the DTB for ARM64 to hold
>>> the address and the size of the memory reserved to carry
>>> the IMA measurement log.
>>>
>>> This patch set has been tested for ARM64 platform using QEMU.
>>> I would like help from the community for testing this change on powerpc.
>>> Thanks.
>>>
>>> This patch set is based on
>>> commit a29a64445089 ("powerpc: Use common of_kexec_setup_new_fdt()")
>>> in https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
>>> "dt/kexec" branch.
>>
>> This all looks good to me. I'd suggest you send the above patches out as
>> part of this series because I don't plan to do so.
>>
>> I would like to also resolve the vmalloc vs. kmalloc difference for
>> allocating the FDT. Then we can further consolidate the DT kexec code.
>>
>> It all needs some acks from arm64 and powerpc maintainers. As far as
>> merging, I think via the integrity tree makes the most sense.
> 
> Thanks, Rob.  Lakshmi,  please update Rob's patches to include patch
> descriptions before re-posting.
> 

Will do Mimi.

thanks,
  -lakshmi


