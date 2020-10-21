Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21129467E
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 04:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411191AbgJUCZr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 22:25:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394315AbgJUCZr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 22:25:47 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9029B20B4905;
        Tue, 20 Oct 2020 19:25:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9029B20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603247146;
        bh=7j4DI1zJza4+H/jcfo3TGQaCvC0DXTMy+KSSuPeHMjo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RLwge0paUjQ1U9AlKDwOt29twHMF2T7zIy48Z3Rstd4MpxJsWtx+Id/Q3YVYfLWOr
         pkw/0F7PCT6eF7VBcAG5l4WZZKb38nyCVaNfzZ3SyHIz+0F+YIs2CrQPZIJLeEdfzU
         ulQg4kvrnrJg2TTlbzy/ZPpoDJ0LqnjO9vSwUCOI=
Subject: Re: [PATCH v7 1/4] powerpc: Refactor kexec functions to move arch
 independent code to kernel
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
References: <20200930205941.1576-1-nramas@linux.microsoft.com>
 <20200930205941.1576-2-nramas@linux.microsoft.com>
 <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <81c4a9ce-c363-a87a-06de-4a8729702b97@linux.microsoft.com>
Date:   Tue, 20 Oct 2020 19:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bfaadaffafa3b8c12fce7e8491ea77e22a5821a8.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/20 1:00 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
>> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
>> carrying forward the IMA measurement logs on kexec for powerpc do not
>> have architecture specific code, but they are currently defined for
>> powerpc only.
>>
>> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
>> the IMA log entry from the device tree and free the memory reserved
>> for the log. These functions need to be defined even if the current
>> kernel does not support carrying forward IMA log across kexec since
>> the previous kernel could have supported that and therefore the current
>> kernel needs to free the allocation.
>>
>> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
>> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in kernel.
>> A later patch in this series will use these functions to free
>> the allocation, if any, made by the previous kernel for ARM64.
>>
>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
> 
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Reported-by: kernel test robot <lkp@intel.com> error: implicit declaration of function 'delete_fdt_mem_rsv' [-Werror,-Wimplicit-function-declaration]
> 
> Much better!  This version limits unnecessarily changing the existing
> code to adding a couple of debugging statements, but that looks to be
> about it.
Yes Mimi - that's correct.

> 
> Based on Chester Lin's "ima_arch" support for arm64 discussion, the IMA generic
> EFI support will be defined in ima/ima-efi.c.  Similarly, I think it would make sense to put the generic device tree support in ima/ima_kexec_fdt.c or ima/ima_fdt.c, as opposed to kernel/.  (Refer to my comments on 2/4 about the new file named ima_kexec_fdt.c.)

The functions remove_ima_kexec_buffer() and delete_fdt_mem_rsv(), which 
are defined in kernel/ima_kexec.c and kernel/kexec_file_fdt.c 
respectively, are needed even when CONFIG_IMA is not defined. These 
functions need to be called by the current kernel to free the ima kexec 
buffer resources allocated by the previous kernel. This is the reason, 
these functions are defined under "kernel" instead of 
"security/integrity/ima".

If there is a better location to move the above C files, please let me 
know. I'll move them.

thanks,
  -lakshmi


