Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8E42A50B4
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 21:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgKCUHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 15:07:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36402 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCUHN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 15:07:13 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id DCF4A20B4905;
        Tue,  3 Nov 2020 12:07:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCF4A20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604434032;
        bh=M1NTe4xNIdsn0mV5KW9eOSfh3NgRZcY1lepD+xNHfhM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pFIjnEhKZdpvdCexGqIcKXTbkWuWZ4YptKGjJeQlvVOVIqhcdaX4pd8laByRlRKBr
         g4MzJMmMARYB8kqxBcFE7Q0YyLdPFsb1/nV08xieItuvtNQYl8epzx2NTmyXTxpoJy
         Qcq5YlS+a9ndPxt3ucmrX/6YelnUeUuD4Sn9oQTM=
Subject: Re: [PATCH v8 1/4] powerpc: Refactor kexec functions to move arch
 independent code to drivers/of
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
 <20201030174429.29893-2-nramas@linux.microsoft.com>
 <506372c01decf59bc2ef39c92a86ba7f6f2ae81b.camel@linux.ibm.com>
 <313e87c1-8f58-b1e0-db3e-950d2ee66927@linux.microsoft.com>
 <5f2d658f63744387fe203bb215968100200b7fb6.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <4f308bc7-81ee-6a16-0098-884005e6296a@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 12:07:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f2d658f63744387fe203bb215968100200b7fb6.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/3/20 11:59 AM, Mimi Zohar wrote:
> On Tue, 2020-11-03 at 11:15 -0800, Lakshmi Ramasubramanian wrote:
>> On 11/3/20 6:55 AM, Mimi Zohar wrote:
>>
>> Hi Mimi,
>>
>> Thanks for reviewing the patches.
>>
>>> On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
>>>> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
>>>> carrying forward the IMA measurement logs on kexec for powerpc do not
>>>> have architecture specific code, but they are currently defined for
>>>> powerpc only.
>>>
>>> ^ ... logs on kexec, do not have architecture specific code, but are
>>> currently limited to powerpc.
>> Will make this change.
>>
>>>
>>>>
>>>> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
>>>> the IMA log entry from the device tree and free the memory reserved
>>>> for the log. These functions need to be defined even if the current
>>>> kernel does not support carrying forward IMA log across kexec since
>>>> the previous kernel could have supported that and therefore the current
>>>> kernel needs to free the allocation.
>>>
>>> The first paragraph describes these function as "handle carrying
>>> forward the IMA measurement logs on kexec", while this paragraph says
>>> "are used to remove the IMA log entry".  Consider listing all of the
>>> functions being moved in the first paragrah, then "handle carrying
>>> forward" could be expanded to "carrying ... and removing".
>> Sure.
> 
> Sorry, even with naming do_get_kexec_buffer(), the measurement list
> isn't being carried across kexec.   Please adjust the wording.
Sure - will update.

> 
>>
>>>
>>>>
>>>> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
>>>> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in
>>>> drivers/of/fdt.c. A later patch in this series will use these functions
>>>> to free the allocation, if any, made by the previous kernel for ARM64.
>>>
>>> - ^Define -> Move
>>> - Three functions are being moved, but only two are listed.
>>> "do_get_kexec_buffer" is not mentioned.
>>> - Don't refer to a later patch, but explain the purpose here.  For
>>> example, "Move ... , making them accessible to other archs."
>> Sure.
>>
>>>
>>>>
>>>> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
>>>> "linux,ima-kexec-buffer", that is added to the DTB to hold
>>>> the address and the size of the memory reserved to carry
>>>> the IMA measurement log.
>>>
>>> The above two paragraphs describe renaming a function and defining a
>>> chosen node.  These two preparatory changes should be made,
>>> independently of each other, prior to this patch.  This patch should be
>>> limited to moving code, with the subject line truncated to "move arch
>>> independent code to drivers/of".
>>>
>>
>> Just to be clear -
>>
>> Split this patch into 3 parts as listed below:
>>
>> PATCH #1: Rename remove_ima_buffer() to remove_ima_kexec_buffer()
>> PATCH #2: Define the chosen node
>> PATCH #3: Move the functions to drivers/of/fdt.c
> 
> yes, thanks.

thanks,
  -lakshmi


