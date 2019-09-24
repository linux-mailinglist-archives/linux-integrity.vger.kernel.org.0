Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4805BD388
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2019 22:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406216AbfIXU1I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 16:27:08 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58042 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfIXU1I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 16:27:08 -0400
Received: from [10.200.156.146] (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0EEC620BBF87;
        Tue, 24 Sep 2019 13:27:07 -0700 (PDT)
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de,
        takahiro.akashi@linaro.org, sboyd@kernel.org,
        catalin.marinas@arm.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        yamada.masahiro@socionext.com, kristina.martsenko@arm.org,
        duwe@lst.de, allison@lohutok.net, james.morse@arm.org,
        linux-integrity@vger.kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <87zhiz1x9l.fsf@morokweng.localdomain>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <baf74901-a594-c15d-b93f-f7d0a8c584b8@linux.microsoft.com>
Date:   Tue, 24 Sep 2019 13:27:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87zhiz1x9l.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/19/19 8:07 PM, Thiago Jung Bauermann wrote:
> 
> Hello Prakhar,
> 
> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
> 
>> During kexec_file_load, carrying forward the ima measurement log allows
>> a verifying party to get the entire runtime event log since the last
>> full reboot since that is when PCRs were last reset.

<snip>

> In the previous patch, you took the powerpc file and made a few
> modifications to fit your needs. This file is now somewhat different
> than the powerpc version, but I don't understand to what purpose. It's
> not different in any significant way.
> 
> Based on review comments from your previous patch, I was expecting to
> see code from the powerpc file moved to an arch-independent part of the
> the kernel and possibly adapted so that both arm64 and powerpc could use
> it. Can you explain why you chose this approach instead? What is the
> advantage of having superficially different but basically equivalent
> code in the two architectures?
> 
> Actually, there's one change that is significant: instead of a single
> linux,ima-kexec-buffer property holding the start address and size of
> the buffer, ARM64 is now using two properties (linux,ima-kexec-buffer
> and linux,ima-kexec-buffer-end) for the start and end addresses. In my
> opinion, unless there's a good reason for it Linux should be consistent
> accross architectures when possible.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center

I looked at the of_ drivers are it became apparent that the driver calls
were already available for consumption. Adding ima specific code will be
same as adding wrapper code for any other property. Which is true for
all properties, effectively setting the property name and pass through
for other parameters.

I still like to move both implementations to a arch independent code 
path, i could not convince my self that of_*ima is probably the place, 
but if that's the best place?, then i will go ahead and make that change 
as well.

Regarding using two properties, it just seemed more consistent how the
properties(start-end) are being used in the kexec, and hides the inner 
details for the cell structures, thats all.

Its just the placement of the wrapper functions, but once thats done
both archs will call the same.

Thanks,
Prakhar Srivastava

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
