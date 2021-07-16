Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFB03CB301
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGPHPk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 03:15:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50232 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhGPHPk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 03:15:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ufx9C-D_1626419563;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ufx9C-D_1626419563)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 15:12:44 +0800
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm for
 sign and verify
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
 <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
 <YO/YFAEWN5VzYIsQ@pevik>
 <2af3724d-1fdd-1e98-1119-7ef86c2ee912@linux.alibaba.com>
 <YPAyydrnxyq3l0XK@pevik>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <80223941-e653-7c6e-3063-4797155654c7@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 15:12:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPAyydrnxyq3l0XK@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 7/15/21 9:06 PM, Petr Vorel wrote:
> Hi Tianjia, all,
> 
>> evmctl itself relies on openssl version 1.1.1 or lower. I guess, openssl 3.0
>> needs to be compiled and install to a non-standard path, such as
>> /opt/openssl, otherwise it will affect the subsequent compilation of evmctl
>> in build.sh.
> 
> OK, IMHO Debian does not allow to install both version together. I suppose
> openSUSE does, but understand if it's just easier to compile it to /opt/openssl.
> 
>> Of course, compile openssl 3.0 from source code. must to limit
>> the number of instances to avoid excessively increasing the time-consuming
>> in CI. Is that right?
> +1
> 

Yes, will do in next version patch.

Best regards,
Tianjia
