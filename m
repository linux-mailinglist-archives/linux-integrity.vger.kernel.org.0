Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A99230A3A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 14:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgG1Mcu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jul 2020 08:32:50 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:36246 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729732AbgG1Mct (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U43tYGI_1595939565;
Received: from 30.27.116.241(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U43tYGI_1595939565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jul 2020 20:32:46 +0800
Subject: Re: [PATCH] tpm: Fix the description error of the help information in
 Kconfig
To:     Peter.Huewe@infineon.com, arnd@arndb.de
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, christophe.ricard@gmail.com,
        Alexander.Steffen@infineon.com
References: <20200727025323.26712-1-tianjia.zhang@linux.alibaba.com>
 <CAK8P3a2neQUP2marbRUxpSZE4OTJtf97JKSK5-LC6EzH8rRHDQ@mail.gmail.com>
 <13d8ab17-5cea-3e00-ecdb-87c68d7f2a15@linux.alibaba.com>
 <09571889ac784850a6c5855f2dc0888e@infineon.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <21de5951-c2d3-a7fb-683e-9d18fc59d8ae@linux.alibaba.com>
Date:   Tue, 28 Jul 2020 20:32:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09571889ac784850a6c5855f2dc0888e@infineon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020/7/27 16:33, Peter.Huewe@infineon.com wrote:
> Hi,
> On 2020/7/27 15:10, Arnd Bergmann wrote:
>> On Mon, Jul 27, 2020 at 4:54 AM Tianjia Zhang
>> <tianjia.zhang@linux.alibaba.com> wrote:
>>>
>>> Obviously, the TPM version number in the help message is wrong, which
>>> will cause confusion. This patch fixes it.
>>
>> How is this "obvious"? I tried finding the specification and could not
>> see anything to back up TIS 1.3 being only supported with TPM 1.3, or
>> the existence of a TPM 1.3 specification at all.
>>
> There is no TPM 1.3.
> 
> There is a TIS Specification 1.3 which applies to TPM1.2
> These are different specs, with different version numbers.
> So the fix is incorrect.
> 
> Thanks,
> Peter
> 

You are right, I was careless, thanks for your reply.

Thanks and best,
Tianjia
