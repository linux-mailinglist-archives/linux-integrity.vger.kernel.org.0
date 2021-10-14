Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4080142D65F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Oct 2021 11:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhJNJsc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Oct 2021 05:48:32 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:60790 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhJNJsb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Oct 2021 05:48:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UroTJsU_1634204772;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UroTJsU_1634204772)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 17:46:13 +0800
Subject: Re: [PATCH 2/2] tpm: use SM3 instead of SM3_256
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
 <20211009130828.101396-3-tianjia.zhang@linux.alibaba.com>
 <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <5db32f21-1df7-c92e-42a1-a2a85b29dfbf@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 17:46:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <c6c2337ed83c237f70716cb4c62794d1d3da31f2.camel@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On 10/12/21 11:21 PM, Jarkko Sakkinen wrote:
> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
>> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
>> SM3 always produces a 256-bit hash value and there are no plans for
>> other length development, so there is no ambiguity in the name of sm3.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> This is not enough to make any changes because the commit message
> does not describe what goes wrong if we keep it as it was.
> 
> /Jarkko
> 

This did not cause an error, just to use a more standard algorithm name. 
If it is possible to use the SM3 name instead of SM3_256 if it can be 
specified from the source, it is of course better. I have contacted the 
trustedcomputinggroup and have not yet received a reply.

Best regards,
Tianjia
