Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DEDF463
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2019 19:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJURiq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Oct 2019 13:38:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55542 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURip (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Oct 2019 13:38:45 -0400
Received: from [10.137.104.46] (unknown [131.107.174.174])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE02B20106BE;
        Mon, 21 Oct 2019 10:38:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE02B20106BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571679524;
        bh=OppP3iKDSw2FPx3G6reM8oMns790vjDmP2JsXIZRv10=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GwxpzdMx19YB+EITwNb0/yASP6lZVpv7uOVBwfLbkTsMI8lKaRMHq8T3aqp94ZyfQ
         1pOpEt6kBoJlE5o+iN+wepjET/nW7/1AwItQl9J0HrOBsfGul2zsQYl2peg2/EVmJi
         f0QCt6DBCuq00I5V+U+IszHLzNa7Vt1yJ5pq+qy4=
Subject: Re: [PATCH V4 0/2] Add support for arm64 to carry ima measurement
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        James Morse <james.morse@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, jean-philippe@linaro.org,
        arnd@arndb.de, Masahiro Yamada <yamada.masahiro@socionext.com>,
        sboyd@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, zohar@linux.ibm.com,
        takahiro.akashi@linaro.org, duwe@lst.de, bauerman@linux.ibm.com,
        allison@lohutok.net, linux-integrity@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191011003600.22090-1-prsriva@linux.microsoft.com>
 <87d92514-e5e4-a79f-467f-f24a4ed279b6@arm.com>
 <b35b239c-990c-0d5b-0298-8f9e35064e2b@linux.microsoft.com>
 <0053eb68-0905-4679-c97a-00c5cb6f1abb@arm.com>
 <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <11036cd6-2977-5f78-7fe7-1085ba31f005@linux.microsoft.com>
Date:   Mon, 21 Oct 2019 10:38:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBVcE91YbJx1f_BkNqbD03wGLNtyane7PjCnEu8i_cH2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 10/15/19 11:47 AM, Pavel Tatashin wrote:
>> I think the UEFI persistent-memory-reservations thing is a better fit for this [0][1].
> 
> Hi James,
> 
> Thank you for your thought. As I understand you propose the to use the
> existing method as such:
> 1. Use the existing kexec ABI to pass reservation from kernel to
> kernel using EFI the same as is done for GICv3 tables.
> 2. Allow this memory to be reservable only during first Linux boot via
> EFI memory reserve
> 3. Allow to have this memory pre-reserved by firmware or to be
> embedded into device tree.
> 
> A question I have is how to tell that a reserved region is reserved
> for IMA use. With GICv3 it is done by reading the registers, finding
> the interrupt tables memory, and check that the memory ranges are
> indeed pre-reserved.
> 
> Is there a way to name memory with the current ABI that you think is acceptable?
> 
> Thank you,
> Pasha
> 
Friendly ping.

Thanks,
Prakhar Srivastava

