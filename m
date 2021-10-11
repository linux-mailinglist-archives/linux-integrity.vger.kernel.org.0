Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EB742871C
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Oct 2021 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhJKHEa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Oct 2021 03:04:30 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55958 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234415AbhJKHEa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Oct 2021 03:04:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0UrMTA8C_1633935745;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UrMTA8C_1633935745)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Oct 2021 15:02:27 +0800
Subject: Re: [PATCH 0/2] tpm: use SM3 instead of SM3_256
To:     jejb@linux.ibm.com, Jarkko Sakkinen <jarkko@kernel.org>,
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
 <1749e7c3b528d361c09b40e5758b92c7386ffe1f.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <c39fe737-203e-b124-db70-fce471ac6459@linux.alibaba.com>
Date:   Mon, 11 Oct 2021 15:02:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1749e7c3b528d361c09b40e5758b92c7386ffe1f.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On 10/9/21 9:29 PM, James Bottomley wrote:
> On Sat, 2021-10-09 at 21:08 +0800, Tianjia Zhang wrote:
>> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
>> SM3 always produces a 256-bit hash value and there are no plans for
>> other length development, so there is no ambiguity in the name of
>> sm3.
> 
> For the TPM we're following the TPM Library specification
> 
> https://trustedcomputinggroup.org/resource/tpm-library-specification/
> 
> Which is very clear: the algorithm name is TPM_ALG_SM3_256
> 
> We're using sm3 as our exposed name because that's what linux crypto
> uses, so there should be no problem in what the end user sees, but
> changing to non standard TPM definitions is only going to cause
> confusion at the kernel level.
> 
> James
> 

Thanks for your attention. This is really tricky. I will contact 
trustedcomputinggroup first and give some suggestions, It would be best 
if a more standard algorithm name can be used from the source of the 
specification.

I think the macro definition of the crypto directory can remove this 
suffix first, that is, apply patch 1. What's your opinion?

Best regards,
Tianjia
