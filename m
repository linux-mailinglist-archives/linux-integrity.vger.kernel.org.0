Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC95393D13
	for <lists+linux-integrity@lfdr.de>; Fri, 28 May 2021 08:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhE1G3U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 May 2021 02:29:20 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38192 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhE1G3T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 May 2021 02:29:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UaLIcr6_1622183262;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UaLIcr6_1622183262)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 May 2021 14:27:42 +0800
Subject: Re: [PATCH v2 1/7] crypto: fix a memory leak in sm2
To:     Hongbo Li <herbert.tencent@gmail.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, dhowells@redhat.com, jarkko@kernel.org,
        herberthbli@tencent.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <1622123615-15517-1-git-send-email-herbert.tencent@gmail.com>
 <1622123615-15517-2-git-send-email-herbert.tencent@gmail.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <47cf4353-b4bb-3907-6017-60bf87805d0c@linux.alibaba.com>
Date:   Fri, 28 May 2021 14:27:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622123615-15517-2-git-send-email-herbert.tencent@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Herbert, Hongbo,

On 5/27/21 9:53 PM, Hongbo Li wrote:
> From: Hongbo Li <herberthbli@tencent.com>
> 
> SM2 module alloc ec->Q in sm2_set_pub_key(), when doing alg test in
> test_akcipher_one(), it will set public key for every test vector,
> and don't free ec->Q. This will cause a memory leak.
> 
> This patch alloc ec->Q in sm2_ec_ctx_init().
> 
> Fixes: ea7ecb66440b ("crypto: sm2 - introduce OSCCA SM2 asymmetric cipher algorithm")
> Signed-off-by: Hongbo Li <herberthbli@tencent.com>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   crypto/sm2.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)
> 

Patch 1/7 is an independent bugfix patch. If possible, consider applying 
it first.

The commit message header should start with: crypto: sm2 -

Also added:

Cc: stable@vger.kernel.org # v5.10+

Best regards,
Tianjia
