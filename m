Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC42E1840
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 06:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725372AbgLWFKC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Dec 2020 00:10:02 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34680 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWFKC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Dec 2020 00:10:02 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 600E320B7192;
        Tue, 22 Dec 2020 21:09:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 600E320B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608700160;
        bh=K9J4ojol1j77p7IqxfZv/TNUZQSXNFBqPQ13ODxz9PI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fAVBFFXASa7KYYnhjb+XwFANbcvENxuS5KeUJMg/5y+WFqdoDpwGcpV1TGsmoKG7d
         mz7/vvMe6gYNzcfRfi3XMMqLCtWR+pSfe+75SjtwXCCueqVvoPMs6ZwNdjPJT5rEXs
         NROyJh7s59diZb+EoS/ksJZ+y6i86/Fg37/tqxnc=
Subject: Re: [PATCH v13 4/6] powerpc: Delete unused function
 delete_fdt_mem_rsv()
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-5-nramas@linux.microsoft.com>
 <87zh25jpmn.fsf@manicouagan.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0ce43447-c029-634b-85e5-3fd97d6d4d17@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:09:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87zh25jpmn.fsf@manicouagan.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/22/20 5:08 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> delete_fdt_mem_rsv() defined in "arch/powerpc/kexec/file_load.c"
>> has been renamed to fdt_find_and_del_mem_rsv(), and moved to
>> "drivers/of/kexec.c".
>>
>> Remove delete_fdt_mem_rsv() in "arch/powerpc/kexec/file_load.c".
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/kexec.h |  1 -
>>   arch/powerpc/kexec/file_load.c   | 32 --------------------------------
>>   2 files changed, 33 deletions(-)
> 
> As I mentioned in the other email, this patch could remove
> setup_new_fdt() as well.
> 
> I'm a bit ambivalent on whether this patch should be squashed with
> patch 2 or left on its own, but I tend toward the latter option because
> patch 2 is big enough already.
> 

I also think Patch #2 is already big enough - I don't want to make more 
changes in that patch.

I will remove delete_fdt_mem_rsv() and setup_new_fdt() in this patch 
(Patch #4) and call of_kexec_setup_new_fdt() directly (in 
setup_new_fdt_ppc64()).

thanks,
  -lakshmi
