Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35D5B5B6C
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Sep 2022 15:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILNlF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Sep 2022 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiILNlE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Sep 2022 09:41:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FA17AAE
        for <linux-integrity@vger.kernel.org>; Mon, 12 Sep 2022 06:41:01 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MR71353Lhz687vm;
        Mon, 12 Sep 2022 21:36:39 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 15:40:58 +0200
Received: from [10.227.153.99] (10.227.153.99) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 12 Sep 2022 14:40:57 +0100
Message-ID: <221a6029-d742-6728-23d6-0c645120fd10@huawei-partners.com>
Date:   Mon, 12 Sep 2022 16:41:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v1 4/4] ima: Extend the real PCR12 with tempPCR value.
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>,
        <linux-integrity@vger.kernel.org>
CC:     <anton.sirazetdinov@huawei.com>, <artem.kuzin@huawei.com>,
        <konstantin.meskhidze@huawei.com>, <yusongping@huawei.com>,
        <hukeping@huawei.com>, <roberto.sassu@huawei.com>,
        <krzysztof.struczynski@huawei.com>, <stefanb@linux.ibm.com>
References: <20220824151140.234654-1-denis.semakin@huawei.com>
 <4c40d3f7-470c-efc2-ccfc-5a40b0ec486e@linux.ibm.com>
From:   dwx1040679 <denis.semakin@huawei-partners.com>
In-Reply-To: <4c40d3f7-470c-efc2-ccfc-5a40b0ec486e@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.227.153.99]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 30.08.2022 00:22, Ken Goldman wrote:
> On 8/24/2022 11:11 AM, Denis Semakin wrote:
>> For each namespace do this calculation:
>>     tempPCR := HASH(tempPCR || tempValue);
>>
>> And finally extend the real PCR12P:
>>     PCR12 := PCR_Extend(PCR12,tempPCR);
>>
>> Then read the PCR12 and return its value to user-space.
>>
>
> Sorry I missed the original context.  Is this namespacing for containers?
I think it's better to call "integrity for containers" based on namespaces
>   Is PCR 12 becoming the 'standard' PCR for this?

Well... I guess so. If all will be agree with that.


