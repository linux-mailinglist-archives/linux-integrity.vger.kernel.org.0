Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3829469F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Oct 2020 04:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411233AbgJUCim (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Oct 2020 22:38:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49532 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394196AbgJUCil (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Oct 2020 22:38:41 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3FC5520B36E7;
        Tue, 20 Oct 2020 19:38:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FC5520B36E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603247920;
        bh=CjVmnEH3txo4yzozqwIg1TT7Kgo+aOBchlh/FVngHr0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OtE48/SVzOZEySioPfdulHPnNhcABgYm4FeRhjbGggPledhSY7pbwp8AxITLZVhuK
         FZy5vGqeOFhHg7r4xnCdXmwCEjjg54VAcMTFHSfZ0pIYCIdOVmyBKp0q+0IYoqW7PT
         Wu/5a2MfXVNaEdBOykkgBm26ay7Q9IkzDJm4MjNI=
Subject: Re: [PATCH v7 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
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
 <20200930205941.1576-3-nramas@linux.microsoft.com>
 <ecc13356983d5cff536c53c4da98a839ea9a0f19.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9a44d8aa-515d-fc97-74bd-7ae976dea35b@linux.microsoft.com>
Date:   Tue, 20 Oct 2020 19:38:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ecc13356983d5cff536c53c4da98a839ea9a0f19.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/20/20 1:01 PM, Mimi Zohar wrote:
> On Wed, 2020-09-30 at 13:59 -0700, Lakshmi Ramasubramanian wrote:
>> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
>> that handle carrying forward the IMA measurement logs on kexec for
>> powerpc do not have architecture specific code, but they are currently
>> defined for powerpc only.
>>
>> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
>> subsystem. A later patch in this series will use these functions for
>> carrying forward the IMA measurement log for ARM64.
>>
>> With the above refactoring arch/powerpc/kexec/ima.c contains only
>> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
>> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
>> when CONFIG_IMA_KEXEC is enabled.
>>
>> Move ima_dump_measurement_list() and ima_add_kexec_buffer() to
>> a new file namely ima_kexec_fdt.c in IMA. Update
>> security/integrity/ima/Makefile to include ima_kexec_fdt.c only
>> when CONFIG_IMA_KEXEC is enabled.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> The existing support for carrying the IMA measurement list across kexec
> is limited to powerpc.  This patch set is adding similar support for
> arm64, making as much of the existing code as generic as possible.
> However ima_dump_measurement_list() is already generic, but for some
> reason this patch moves it to ima_kexec_fdt.c.  ima_kexec_fdt.c should
> be limited to device tree specific code.

I wanted to split the functions defined under CONFIG_HAVE_IMA_KEXEC and 
CONFIG_IMA_KEXEC to separate files so that we can get rid of #ifdef in C 
file and instead conditionally compile the C files (using Makefile).

ima_dump_measurement_list() need to be defined only when 
CONFIG_IMA_KEXEC is defined. I moved it to ima_kexec_fdt.c

Instead of ima_kexec_fdt.c, where ima_dump_measurement_list() and 
ima_add_kexec_buffer() are defined, perhaps I can change the file name 
to "ima_kexec_buffer.c". Would that be better?

> 
> This patch is probably doing the right thing, but the way the patch is
> formatted it replaces parts of a function with a different function.
> With the changes suggested above and in 1/4,  the next version should
> be clearer.

Like I'd stated above, I wanted to remove "#ifdef" from the C files and 
hence had to move some functions. But the functionalities haven't been 
changed.

thanks,
  -lakshmi



