Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054C4615FB2
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 10:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKBJ26 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiKBJ2s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 05:28:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427E1CB
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 02:28:46 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N2M5P3Jy9z15MKd;
        Wed,  2 Nov 2022 17:28:41 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:28:25 +0800
Received: from [10.174.178.163] (10.174.178.163) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 17:28:25 +0800
Message-ID: <cafa3c5b-dcbe-0fbf-c769-9d42aa9ef9a4@huawei.com>
Date:   Wed, 2 Nov 2022 17:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ima: Fix a potential null pointer access problem in
 ima_restore_measurement_list
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>
References: <20221016122047.16788-1-luhuaxin1@huawei.com>
 <be3cceef770591bd56ef1816607daf1e4b2debb2.camel@linux.ibm.com>
From:   Huaxin Lu <luhuaxin1@huawei.com>
In-Reply-To: <be3cceef770591bd56ef1816607daf1e4b2debb2.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/11/2 6:55, Mimi Zohar wrote:
> scripts/checkpatch.pl complains:
> -  The "Subject:" line being too long.  Refer to "summary phrase"  in
> Documentation/process/submitting-patches.rst.
> - Instead of "Co-authored-by" submitting-patches suggests "Co-
> developed-by".
> 
> In addition, the patch author and your mailer need to be sync.  Please
> fix your mailer so that the "From:" line is unnecessary.
> 

Fixed in v2 patch, thanks.
