Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622C24615BA
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbhK2NHA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 08:07:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:43210 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241779AbhK2NE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 08:04:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0UyjobXv_1638190885;
Received: from 30.240.100.124(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UyjobXv_1638190885)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 29 Nov 2021 21:01:27 +0800
Message-ID: <cc3cf5e6-8946-65fc-014f-6641619fb2dc@linux.alibaba.com>
Date:   Mon, 29 Nov 2021 21:01:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v3 0/2] use SM3 instead of SM3_256
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        keyrings@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-security-module@vger.kernel.org
References: <20211026075626.61975-1-tianjia.zhang@linux.alibaba.com>
 <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <CAMj1kXGiC-LCc-50cfddJxJ-mezO=fcLqhJHiK110CgxKusy9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/27/21 12:08 AM, Ard Biesheuvel wrote:
> On Tue, 26 Oct 2021 at 09:56, Tianjia Zhang
> <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
>> SM3 always produces a 256-bit hash value and there are no plans for
>> other length development, so there is no ambiguity in the name of sm3.
>>
> 
> What is the point of these changes? Having '256' in the identifiers is
> merely redundant and not factually incorrect, so why can't we just
> leave these as they are?
> 

Sorry for the late reply. This is just to fix the ambiguity that may be 
caused by the macro name. It seems that there is no need to modify it. 
Please ignore this patch.

Kind regards,
Tianjia
