Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353873D34C1
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 08:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhGWF4J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 01:56:09 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38910 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234058AbhGWF4J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 01:56:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UgggCV9_1627022200;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UgggCV9_1627022200)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 23 Jul 2021 14:36:41 +0800
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: Fix incorrect algorithm name
 in hash_info.gen
To:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210722052704.11031-1-tianjia.zhang@linux.alibaba.com>
 <YPluMV2uUhela5hN@pevik>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <ae7bc0d4-ac9e-5bd2-3c55-c56885c68864@linux.alibaba.com>
Date:   Fri, 23 Jul 2021 14:36:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPluMV2uUhela5hN@pevik>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr, Mimi,

On 7/22/21 9:10 PM, Petr Vorel wrote:
> Hi Tianjia,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Agree with Mimi to update the comment associated with this change.
> 
> Kind regards,
> Petr
> 

thanks, will update it soon.

Best regards,
Tianjia
