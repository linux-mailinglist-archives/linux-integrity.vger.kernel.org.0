Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB0255FE2
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgH1RlF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 13:41:05 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56974 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1RlE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 13:41:04 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id C868220B7178;
        Fri, 28 Aug 2020 10:41:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C868220B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598636463;
        bh=B5UrEdKDUH9jR7Ae1rEu3ipYxtxUO5TupJFw9Ld6H34=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kJxyjpGZXpgz/YZTr4JpGPULSjbavcGe/BP8zJO2pLyO2Txe97CE+o9uT928hiyDo
         pt/EplTowulkW7Ooj+R7raJMvQCOK/ecQqBfj1LEsCddVsCTZZE4mYAtlvfFNjb6OY
         hSmGdxieqHZcIN0Q11pWLHcqs8mvm2PWdYu8rwCw=
Subject: Re: [PATCH v4 1/5] powerpc: Refactor kexec functions to move arch
 independent code to IMA
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-2-nramas@linux.microsoft.com>
 <875z938xwy.fsf@morokweng.localdomain>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <3897c55e-11d2-113a-5cef-db750b33772f@linux.microsoft.com>
Date:   Fri, 28 Aug 2020 10:40:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z938xwy.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/27/20 4:35 PM, Thiago Jung Bauermann wrote:
> 
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:
> 
>> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer() that
>> handle carrying forward the IMA measurement logs on kexec for powerpc
>> do not have architecture specific code, but they are currently defined
>> for powerpc only.
>>
>> Move these functions to IMA subsystem so that it can be used for other
>> architectures as well. A later patch in this series will use these
>> functions for carrying forward the IMA measurement log for ARM64.
>>
>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>> the address and the size of the memory reserved to carry
>> the IMA measurement log.
>>
>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> 
> This patch removes two functions from arch/powerpc/kexec/ima.c, but adds
> four to security/integrity/ima/ima_kexec.c. The extra ones are
> get_addr_size_cells() and do_get_kexec_buffer(), which are being copied
> from the powerpc code but can't be removed yet because they're still
> used there by remove_ima_buffer() and setup_ima_buffer().
> 
> On the next patch you remove the need for these functions in powerpc
> code and therefore delete them. This confused me at first, so I think it
> would be cleared if you put patch 2 first in the series and then on this
> patch you can simply move the four functions and delete them from
> arch/powerpc/kexec/ima.c.
> 
> If you prefer to keep the current order, it's worth mentioning on the
> commit log where get_addr_size_cells() and do_get_kexec_buffer() are
> coming from.
> 
> Regardless:
> 
> Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 

Thanks for reviewing the changes Thiago.

I'll update the commit log to describe the changes related to 
get_addr_size_cells() and do_get_kexec_buffer().

  -lakshmi

