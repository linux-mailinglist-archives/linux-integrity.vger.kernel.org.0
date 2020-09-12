Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6542678CA
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgILIPD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 04:15:03 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35371 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgILIPB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 04:15:01 -0400
Received: from [192.168.0.2] (ip5f5af00b.dynamic.kabel-deutschland.de [95.90.240.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D6FAE206462B7;
        Sat, 12 Sep 2020 10:14:59 +0200 (CEST)
Subject: Re: [Bug Report] Kernel 4.14+ TPM Driver Bug for Atmel TPM Chip
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Hamza Attak <hamza@hpe.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>
References: <9173F912-F682-44CC-8408-565A6C675749@rubrik.com>
 <20200911041800.GA541925@kroah.com>
 <5518aa6e-a10f-9e07-e885-2ab43a0906e9@linux.ibm.com>
 <d9fc244f-f8ac-64cf-2b8f-0b13685fe6be@molgen.mpg.de>
 <B003F2A9-2DF5-4633-91C4-FD6B8A3353ED@rubrik.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <5a62669c-59e2-861a-f851-bd28e5e84e36@molgen.mpg.de>
Date:   Sat, 12 Sep 2020 10:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <B003F2A9-2DF5-4633-91C4-FD6B8A3353ED@rubrik.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Hao,


Thank you for the reply.

Am 12.09.20 um 10:10 schrieb Hao Wu:

> Thanks for quick responses over this report.

Thank you for the quick follow-up.

>> Hao, I wouldn’t expect a longer timeout causing the TPM to be
>> queried less frequently, but I do not know the code well.
> From our understanding, the TPM queries might be retried due to some
> reason, increase timeout 3x would lower the query frequency to 1/3.
> The explanation might be wrong, but the fact looks like the timeout
> matters.  Unfortunately, engineers from Rubrik are not experts over
> the TPM driver code neither :(
> 
>>> Be careful about making this a global change.  It could reduce
>>> the TPM performance by 3x. We don't want to affect all TPMs to
>>> fix a bug in an old TPM 1.2 chip from one vendor.
>> 
>> Linux has a no regression policy, so the performance penalty
>> wouldn’t matter. Unfortunately, the regression was only noticed
>> several years after being introduced in Linux v4.14-rc2.
> 
> So does that mean we are good to apply the global change ? Or we need
> to discuss about the actual fix further?
To get a fix into the stable series, it first needs to be applied to the 
master branch. I guess you tested also with Linux master, right?

Please add the explanation from your email to Greg into the git commit 
message, format the patch with `git format-patch -1 -o outgoing` and 
send it with `git send-email outgoing/*` to the addresses listed for the 
subsystem in `MAINTAINERS` and the people listed in the commit 
introducing the regression.

Then it can be properly reviewed and discussed.


Kind regards,

Paul
