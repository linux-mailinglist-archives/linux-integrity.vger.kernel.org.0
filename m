Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7085F5BE0F
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2019 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfGAOWH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Jul 2019 10:22:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33038 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727465AbfGAOWH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jul 2019 10:22:07 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1284BB5E59FE6F30870C;
        Mon,  1 Jul 2019 15:22:06 +0100 (IST)
Received: from [10.47.65.207] (10.47.65.207) by smtpsuk.huawei.com
 (10.201.108.37) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 1 Jul
 2019 15:22:01 +0100
Subject: Re: Problem with the kernels trusted module on "inactive" TPM
To:     CrazyT <crazyt2019+lml@gmail.com>, <keyrings@vger.kernel.org>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>
References: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
From:   Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <f4b36912-0fb0-1e83-1ad2-fb1d2313c08e@huawei.com>
Date:   Mon, 1 Jul 2019 17:22:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.207]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding to the discussion Jarkko (the maintainer of the trusted key) and
the linux-integrity mailing list.


On 6/27/2019 7:59 PM, CrazyT wrote:
> Hi,
> 
> 
> some people (including me) have problems with the "trusted" kernel module.
> As a result to this also the ecryptfs-module won't load.
> (https://bugs.archlinux.org/task/62678)
> If you use an "inactive" TPM module, the "trusted" module won't load anymore.
> The command modprobe just responds with "Bad address".
> The strace-command shows that init_module fails with EFAULT.
> I believe the reason for this is that the trusted-module handles
> inactive modules the same as active modules.
> This results in an error.
> 
> For example:
> https://github.com/torvalds/linux/commit/0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400#diff-c01228e6d386afb29df6aac17d9dd7abR1251
> 
> My guess is that init_digests(); returns EFAULT in that case.
> The " if (!chip)" check above probably needs to check if the chip is "inactive".
> 
> "inactive" = still visible to the system, but not functional.
> It seems to be the default bios-setting for TPM on thinkpad.
> (btw.: i have no clue why anybody would need something like that)
> 
> Sadly i have no idea how you would check for an inactive chip,else i
> would have send a patch instead.
> But I hope the info i wrote is enough to get it fixed by somebody.

Thanks for the report. If you see -EFAULT, tpm_get_random() is probably
returning 0.

Jarkko, we could consider it as non-critical error, and handle it as if
the TPM is not found. What do you think?

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Jian LI, Yanli SHI
