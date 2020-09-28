Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C233827A75D
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 08:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI1GVJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 02:21:09 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55749 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgI1GVJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 02:21:09 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 02:21:08 EDT
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0BbG5lCQz9v0fj;
        Mon, 28 Sep 2020 07:56:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qrVmKyF7AUkt; Mon, 28 Sep 2020 07:56:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0BbG4mWfz9v0fh;
        Mon, 28 Sep 2020 07:56:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51D2F8B782;
        Mon, 28 Sep 2020 07:56:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DRoorLxFwtMj; Mon, 28 Sep 2020 07:56:17 +0200 (CEST)
Received: from [10.25.210.27] (unknown [10.25.210.27])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F27AE8B75B;
        Mon, 28 Sep 2020 07:56:16 +0200 (CEST)
Subject: Re: [PATCH] tpm: of: avoid __va() translation for event log address
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200922094128.26245-1-ardb@kernel.org>
 <20200925055626.GC165011@linux.intel.com>
 <CAMj1kXFLWsFz7HV4sHLbwBkuiEu0gT4esSH8umVrvDDrJaOLrQ@mail.gmail.com>
 <20200925102920.GA180915@linux.intel.com> <20200925120018.GH9916@ziepe.ca>
 <20200927234434.GA5283@linux.intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9be9c7e7-c424-d241-2255-ad854221bd2e@csgroup.eu>
Date:   Mon, 28 Sep 2020 07:56:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927234434.GA5283@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



Le 28/09/2020 à 01:44, Jarkko Sakkinen a écrit :
> On Fri, Sep 25, 2020 at 09:00:18AM -0300, Jason Gunthorpe wrote:
>> On Fri, Sep 25, 2020 at 01:29:20PM +0300, Jarkko Sakkinen wrote:
>>> On Fri, Sep 25, 2020 at 09:00:56AM +0200, Ard Biesheuvel wrote:
>>>> On Fri, 25 Sep 2020 at 07:56, Jarkko Sakkinen
>>>> <jarkko.sakkinen@linux.intel.com> wrote:
>>>>>
>>>>> On Tue, Sep 22, 2020 at 11:41:28AM +0200, Ard Biesheuvel wrote:
>>>>>> The TPM event log is provided to the OS by the firmware, by loading
>>>>>> it into an area in memory and passing the physical address via a node
>>>>>> in the device tree.
>>>>>>
>>>>>> Currently, we use __va() to access the memory via the kernel's linear
>>>>>> map: however, it is not guaranteed that the linear map covers this
>>>>>> particular address, as we may be running under HIGHMEM on a 32-bit
>>>>>> architecture, or running firmware that uses a memory type for the
>>>>>> event log that is omitted from the linear map (such as EfiReserved).
>>>>>
>>>>> Makes perfect sense to the level that I wonder if this should have a
>>>>> fixes tag and/or needs to be backported to the stable kernels?
>>>>>
>>>>
>>>> AIUI, the code was written specifically for ppc64, which is a
>>>> non-highmem, non-EFI architecture. However, when we start reusing this
>>>> driver for ARM, this issue could pop up.
>>>>
>>>> The code itself has been refactored a couple of times, so I think it
>>>> will require different versions of the patch for different generations
>>>> of stable kernels.
>>>>
>>>> So perhaps just add Cc: <stable@vger.kernel.org>, and wait and see how
>>>> far back it applies cleanly?
>>>
>>> Yeah, I think I'll cc it with some note before the diffstat.
>>>
>>> I'm thinking to cap it to only 5.x kernels (at least first) unless it is
>>> dead easy to backport below that.
>>
>> I have this vauge recollection of pointing at this before and being
>> told that it had to be __va for some PPC reason?
>>
>> Do check with the PPC people first, I see none on the CC list.
>>
>> Jason
> 
> Thanks, added arch/powerpc maintainers.
> 

As far as I can see, memremap() won't work on PPC32 at least:

IIUC, memremap() calls arch_memremap_wb()
arch_memremap_wb() calls ioremap_cache()
In case of failure, then ioremap_wt() and ioremap_wc() are tried.

All ioremap calls end up in __ioremap_caller() which will return NULL in case you try to ioremap RAM.

So the statement "So instead, use memremap(), which will reuse the linear mapping if
it is valid, or create another mapping otherwise." seems to be wrong, at least for PPC32.

Even for PPC64 which doesn't seem to have the RAM check, I can't see that it will "reuse the linear 
mapping".

Christophe
