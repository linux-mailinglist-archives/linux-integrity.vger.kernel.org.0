Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081AA52E652
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346505AbiETHfQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 03:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiETHfN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 03:35:13 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902E314ACB9;
        Fri, 20 May 2022 00:35:11 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L4JKJ5G84zCssy;
        Fri, 20 May 2022 15:30:12 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 15:35:09 +0800
Message-ID: <0563f30f-f5c5-f202-9091-a8ce095057e5@huawei.com>
Date:   Fri, 20 May 2022 15:35:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] keys: Use struct_size and size_add helper with alloc
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <keyrings@vger.kernel.org>
References: <20220519024702.215223-1-guozihua@huawei.com>
 <YoatVbXu5g6f7gD7@iki.fi>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <YoatVbXu5g6f7gD7@iki.fi>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/5/20 4:49, Jarkko Sakkinen wrote:
> On Thu, May 19, 2022 at 10:47:02AM +0800, GUO Zihua wrote:
>> Use struct_size helper for calculating size of flexible struct to avoid
>> potential issues and improve readibility. Use size_add to calculate
>> addition of size to prevent potential issues.
> 
> What issues? Please explicitly state the issues.
> 
> BR, Jarkko
> .

Hi Jarkko,

This is a clean-up/optimization patch mostly focuses on readability and 
no actual issue is observed at the moment.

-- 
Best
GUO Zihua
