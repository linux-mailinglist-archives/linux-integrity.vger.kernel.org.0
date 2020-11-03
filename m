Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128632A50AC
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 21:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgKCUF0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 15:05:26 -0500
Received: from linux.microsoft.com ([13.77.154.182]:36156 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCUF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 15:05:26 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id B307F20B4905;
        Tue,  3 Nov 2020 12:05:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B307F20B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604433925;
        bh=FpRaU+1eA08DHDzzs2SLgSYuS0jFUegfVIwGSw2MrPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ow5SVZ/xuAOhzp4Gps8tIL5ExIsBerckCwQ+gbwRldD48gb0cbTNKextoK9tcQLE8
         QIZpQOczJZO+5O9w6sd6HuJlKll9ibyG9qnXqVGlM07/NVnPTttih9uLvj6lxSVUEH
         gFTDxBqxhYtJBY60Ky5uwXO3lRaqmh0dbY5qDM4k=
Subject: Re: [PATCH v8 2/4] powerpc: Refactor kexec functions to move arch
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
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
 <20201030174429.29893-3-nramas@linux.microsoft.com>
 <87f63dc12739b346d556f85537324d3ae055097d.camel@linux.ibm.com>
 <397f1bbf-46bf-b522-616b-2e006ef30e70@linux.microsoft.com>
 <f45e865c005ce05a6bc376e14c089937197e2aeb.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <5032768c-779b-a03f-aacc-0c2da51ecc87@linux.microsoft.com>
Date:   Tue, 3 Nov 2020 12:05:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f45e865c005ce05a6bc376e14c089937197e2aeb.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/3/20 11:50 AM, Mimi Zohar wrote:
> On Tue, 2020-11-03 at 11:23 -0800, Lakshmi Ramasubramanian wrote:
>> On 11/3/20 6:55 AM, Mimi Zohar wrote:
>>
>> Hi Mimi,
>>
>>>
>>> On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
>>>> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
>>>> that handle carrying forward the IMA measurement logs on kexec for
>>>> powerpc do not have architecture specific code, but they are currently
>>>> defined for powerpc only.
>>>>
>>>> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
>>>> subsystem. A later patch in this series will use these functions for
>>>> carrying forward the IMA measurement log for ARM64.
>>>>
>>>> With the above refactoring arch/powerpc/kexec/ima.c contains only
>>>> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
>>>> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
>>>> when CONFIG_IMA_KEXEC is enabled.
>>>>
>>>> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>>
>>> Similar comments to 1/4.
>>> -  Last line of first paragraph can be rephrased like " ... on kexec,
>>> do not contain architecture specific code, but are currently limited to
>>> powerpc."
>> Sure.
>>
>>> -  This patch should be limited to moving existing functions.
>>> Truncate the Subject line to "Move arch independent IMA kexec functions
>>> to ima_kexec.c."
>> Will do.
>>
>>> - Don't refer to a later patch, but explain the purpose here.  For
>>> example, "Move ... , making them accessible to other archs."
>> Sure.
>>
>>> - The definition of "FDT_PROP_IMA_KEXEC_BUFFER" should be made as a
>>> separate, prepartory patch, prior to the existing 1/4.  The resulting
>>> code being moved in this patch (and similarly for 1/4) will be exactly
>>> the same as the code being deleted.
>>
>> Definition of FDT_PROP_IMA_KEXEC_BUFFER will be made as a preparatory
>> patch as you'd mentioned in the comments for [PATCH 1/4].
>>
>> Will split [PATCH 2/4] as listed below:
>>
>> PATCH #1: Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to
>> IMA, along with deleting them in arch/powerpc/kexec/ima.c
> 
> No, other than the comments above, this patch is fine.  It moves
> ima_get_kexec_buffer() and ima_free_kexec_buffer() to ima_kexec.c.
> 

Ok - I will do the updates in the patch description only and keep the 
code changes as is. Thanks for clarifying.

  -lakshmi


