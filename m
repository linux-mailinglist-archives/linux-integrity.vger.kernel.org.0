Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F89568214
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jul 2022 10:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiGFIuY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jul 2022 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGFIuX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jul 2022 04:50:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3EC22B20
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jul 2022 01:50:19 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LdCqD1Wfjz1L8WR;
        Wed,  6 Jul 2022 16:47:52 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 16:50:17 +0800
Received: from [10.174.178.163] (10.174.178.163) by
 kwepemm600010.china.huawei.com (7.193.23.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Jul 2022 16:50:16 +0800
Message-ID: <196bc54f-3925-0755-0ae4-20a4d784abe6@huawei.com>
Date:   Wed, 6 Jul 2022 16:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ima: Fix a potential integer overflow in
 ima_appraise_measurement
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <linux-integrity@vger.kernel.org>
References: <20220705000047.1718-1-luhuaxin1@huawei.com>
 <2330515b-8f1d-a0e9-5577-5b7e16b2e5ca@molgen.mpg.de>
Content-Language: en-US
From:   Huaxin Lu <luhuaxin1@huawei.com>
In-Reply-To: <2330515b-8f1d-a0e9-5577-5b7e16b2e5ca@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/7/5 14:11, Paul Menzel wrote:
> Dear HuaxinLu,
> 
> 
> Thank you for the patch.
> 
> Am 05.07.22 um 02:00 schrieb luhuaxin1@huawei.com:
>> From: HuaxinLu <luhuaxin1@huawei.com>
> 
> If these are two names, can you please add a space?
> 
>      git config --global user.name "…"
>      git commit --amend --author="… <…>" -s
> 
>> When the ima-modsig is enabled, the rc passed to evm_verifyxattr() may be
>> negative, which may cause the integer overflow problem.
>>
>> Signed-off-by: HuaxinLu <luhuaxin1@huawei.com>
> 
> Ditto.
> 
> 
> Kind regards,
> 
> Paul
> 
Fixed in v2 patch, thanks.
