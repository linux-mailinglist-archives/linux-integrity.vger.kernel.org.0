Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EF7434AAC
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Oct 2021 14:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTMEQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Oct 2021 08:04:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46545 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhJTMEP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Oct 2021 08:04:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Ut2XJgK_1634731319;
Received: from 30.240.99.221(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ut2XJgK_1634731319)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Oct 2021 20:01:59 +0800
Message-ID: <416a13af-beee-ac09-38ba-166a691a8482@linux.alibaba.com>
Date:   Wed, 20 Oct 2021 20:01:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] tpm: use SM3 instead of SM3_256
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
 <1749e7c3b528d361c09b40e5758b92c7386ffe1f.camel@linux.ibm.com>
 <c39fe737-203e-b124-db70-fce471ac6459@linux.alibaba.com>
 <c0768f9d-ef60-1a97-ec2d-a5e1130cbe03@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <c0768f9d-ef60-1a97-ec2d-a5e1130cbe03@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ken,

On 10/20/21 6:26 AM, Ken Goldman wrote:
> 
> 
> 
> On 10/11/2021 3:02 AM, Tianjia Zhang wrote:
>>
>> Thanks for your attention. This is really tricky. I will contact 
>> trustedcomputinggroup first and give some suggestions, It would be 
>> best if a more standard algorithm name can be used from the source of 
>> the specification.
> 
> This was discussed in the TCG's TPM WG in February, 2020.  At the time,
> someone said that there was a possibility of a 512-bit version in the
> future.
> 
> For TCG members:
> 
> https://members.trustedcomputinggroup.org/wg/TPMWG/mail/thread/61442#136758
> 
> My guess is that, since it's already in many TCG specs and code, TCG
> will want to leave it as is.
> 

I got it. thanks for your information.

Best regards,
Tianjia
