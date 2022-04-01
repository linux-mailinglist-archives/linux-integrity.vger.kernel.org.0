Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4254EEA6D
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Apr 2022 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344582AbiDAJbO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Apr 2022 05:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344578AbiDAJbN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Apr 2022 05:31:13 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684321D41B9
        for <linux-integrity@vger.kernel.org>; Fri,  1 Apr 2022 02:29:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0V8spY2g_1648805361;
Received: from 30.240.100.21(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V8spY2g_1648805361)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Apr 2022 17:29:21 +0800
Message-ID: <18217eda-f28c-508d-412b-6c10f7d2b94f@linux.alibaba.com>
Date:   Fri, 1 Apr 2022 17:29:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: Progress about SM2-with-SM3 signature support for PKCS #7.
Content-Language: en-US
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <8609c0dc-1180-f410-e9cf-8f3ceee4c4cc@huawei.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <8609c0dc-1180-f410-e9cf-8f3ceee4c4cc@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Guozihua,

On 4/1/22 3:04 PM, Guozihua (Scott) wrote:
> Hi Tianjia,
> 
> Thank you for the all the work surrounding SM crypto algorithm and 
> certificates.
> 
> I noticed that the patch implementing the support for SM2-with-SM3 
> signature parsing in PKCS #7 has not been merged yet. Would you mind me 
> asking about the progress of that patch?
> 

Thanks, I'd love you to do so, the latest series patch is v4 version,
this series also supports EC-RDSA algorithm.

Best regards,
Tianjia
