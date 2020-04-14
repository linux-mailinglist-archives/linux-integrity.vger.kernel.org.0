Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF721A71E0
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 05:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404833AbgDNDg0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Apr 2020 23:36:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41976 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404832AbgDNDgY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Apr 2020 23:36:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TvUm.hu_1586835380;
Received: from 30.27.118.45(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TvUm.hu_1586835380)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Apr 2020 11:36:21 +0800
Subject: Re: [PATCH 0/2] support to read and tune appraise mode in runtime
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, zhangliguang@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>
References: <20200409033907.102833-1-tianjia.zhang@linux.alibaba.com>
 <1586814958.7311.92.camel@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <a767d0e0-6c57-254a-3c95-f78026e80c1d@linux.alibaba.com>
Date:   Tue, 14 Apr 2020 11:36:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1586814958.7311.92.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020/4/14 5:55, Mimi Zohar wrote:
> On Thu, 2020-04-09 at 11:39 +0800, Tianjia Zhang wrote:
>> Support the read and write operations of ima_appraise by adding a
>> securifyfs file 'appraise_mode'.
>>
>> In order to tune appraise mode in runtime, writing a PKCS#7 signature
>> corresponding the signed content is required. The content should be off,
>> enforce, log or fix. Given a simple way to archive this:
>>
>> $ echo -n off > mode
>> $ openssl smime -sign -nocerts -noattr -binary \
>>      -in mode -inkey <system_trusted_key> \
>>      -signer <cert> -outform der -out mode.p7s
>> $ sudo cat mode.p7s \
>>      > /sys/kernel/security/ima/appraise_mode
>>
>> Note that the signing key must be a trust key located in
>> system trusted keyring. So even the root privilege cannot
>> simply disable the enforcement.
> 
> There are major problems with disabling IMA appraisal.  This patch set
> proposes disabling IMA appraisal without even providing the motivation
> for such support.
> 
> A lot of effort went into preventing custom IMA policies from
> disabling appraising the kexec or kernel module signatures.  In
> addition, the "lockdown" patch set was upstreamed permitting IMA
> signature verification.  This patch set would break both of these
> features.
> 
> IMA relies on its own keyring for verifying file signatures, not the
> builtin or secondary trusted kernel keyrings.
> 
> Two methods already exist - xattr and appended signatures - for
> verifying file signatures.  This patch set assumes creating and
> signing a file, which is then written to a securityfs file.  Like for
> loading a custom IMA policy, instead of cat'ing the file, write the
> pathname to the securityfs file.
> 
> If you must define a new IMA method for verifying file signatures,
> then it needs to be generic and added to ima_appraise_measurement().
>   (Refer to the new IMA appended signature support.)
> 
> Mimi
> 
>>
>> Tianjia Zhang (2):
>>    ima: support to read appraise mode
>>    ima: support to tune appraise mode in runtime
>>
>>   security/integrity/ima/ima_fs.c | 134 +++++++++++++++++++++++++++++++-
>>   1 file changed, 133 insertions(+), 1 deletion(-)
>>

Thanks for your suggestion, the way to close the appraise mode here is 
indeed a bit rude, I will reconsider again according to your suggestions.

In addition, [PATCH 1/2] ima: support to read appraise mode, by the way, 
see if this patch is acceptable.

Thanks and best,
Tianjia
