Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91D1A9123
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2020 04:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbgDOCxQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 22:53:16 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34352 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727839AbgDOCxO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 22:53:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tva36kW_1586919187;
Received: from 30.27.118.45(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tva36kW_1586919187)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Apr 2020 10:53:08 +0800
Subject: Re: [PATCH] ima: optimize ima_pcr_extend function by asynchronous
To:     Ken Goldman <kgold@linux.ibm.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        zhangliguang@linux.alibaba.com, zhang.jia@linux.alibaba.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200414115020.99288-1-tianjia.zhang@linux.alibaba.com>
 <0fdd1c13-51c6-e65c-1ca5-38621fa21f53@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <7335613b-0a18-1c28-9b65-687d0b44d01f@linux.alibaba.com>
Date:   Wed, 15 Apr 2020 10:53:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0fdd1c13-51c6-e65c-1ca5-38621fa21f53@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020/4/15 2:07, Ken Goldman wrote:
> I wonder if there's a different issue?  I just ran selftest with 
> fullTest = yes in two different TPM vendors.
> 
> One took 230 msec, the other 320 msec.
> 
> I've never seen anything near 10 seconds.
> 
> Note that this is worse than the worst case because it's forcing a full 
> retest.  The TPM typically starts its self test immediately at power up 
> and could be complete by the time the OS starts to boot.
> 
> When I run selftest with fullTest = no, I get 30 msec, probably
> because it's not doing anything.
> 
> On 4/14/2020 7:50 AM, Tianjia Zhang wrote:
>> Because ima_pcr_extend() to operate the TPM chip, this process is
>> very time-consuming, for IMA, this is a blocking action, especially
>> when the TPM is in self test state, this process will block for up
>> to ten seconds.
> 

Ten seconds is an extreme scenario, and I haven't seen this worst case, 
but the TPM driver will fail to return in this scenario.

Thanks and best,
Tianjia
