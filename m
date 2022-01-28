Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B887049F669
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 10:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbiA1JcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 04:32:13 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:32129 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347643AbiA1JcH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 04:32:07 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JlXG93hMtz8wd5;
        Fri, 28 Jan 2022 17:29:05 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 17:32:04 +0800
Message-ID: <aff671e4-6cff-d5d2-69c4-874ebd8bf54b@huawei.com>
Date:   Fri, 28 Jan 2022 17:32:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        wangweiyang <wangweiyang2@huawei.com>,
        Xiujianfeng <xiujianfeng@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20220125090237.120357-1-guozihua@huawei.com>
 <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
 <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
 <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
 <97142483-d7e7-e310-0cb0-30a81414cb57@huawei.com>
 <c1bfe53abaf24feacb676ce940edcb8899924ffc.camel@linux.ibm.com>
 <173fffb6cde54ae4ac7676d18a84c79f@huawei.com>
 <6f0890f135b61c41d81b03bf084ebab1b3e551e1.camel@linux.ibm.com>
 <220a8c9f3ab34f2183c0a88941c145d0@huawei.com>
 <df7fffa1-2068-cb0c-e43e-141ccd125b39@huawei.com>
 <4626844528c5accb70a57870168091e002affb36.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <4626844528c5accb70a57870168091e002affb36.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/1/27 20:18, Mimi Zohar wrote:
> On Thu, 2022-01-27 at 14:35 +0800, Guozihua (Scott) wrote:
> 
>>
>> I understand that the solution proposed here is to decommission template
>> "ima" and potentially removing related algo checks altogether?
> 
> Eventually we might decide to do that, but right now we just want to
> address not being able to set "ima_template" after setting "ima_hash".
> 
> thanks,
> 
> Mimi
> 
> 
> .

Sure! I would come up with a solution.

-- 
Best
GUO Zihua
