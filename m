Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC61149C15A
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 03:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiAZCcu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 21:32:50 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16739 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiAZCcu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 21:32:50 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Jk72F6gZszZfSK;
        Wed, 26 Jan 2022 10:28:53 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 10:32:47 +0800
Message-ID: <64bb3746-07b4-aad4-7ee0-dccda6c7d4e1@huawei.com>
Date:   Wed, 26 Jan 2022 10:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, <zohar@linux.ibm.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <roberto.sassu@huawei.com>, <wangweiyang2@huawei.com>,
        <xiujianfeng@huawei.com>, <linux-integrity@vger.kernel.org>
References: <20220125090237.120357-1-guozihua@huawei.com>
 <87o83zwdxm.fsf@meer.lwn.net>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <87o83zwdxm.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2022/1/26 8:14, Jonathan Corbet wrote:
> GUO Zihua <guozihua@huawei.com> writes:
> 
>> From: Guo Zihua <guozihua@huawei.com>
>>
>> Commandline parameter ima_hash= and ima_template= has order requirement
>> for them to work correctly together. Namely ima_hash= must be
>> specified after ima_template=, otherwise ima_template= will be ignored.
>>
>> The reason is that when handling ima_hash=, ima template would be set to
>> the default value if it has not been initialized already, and that value
>> cannot be changed afterwards by ima_template=.
>>
>> This patch adds this limitation to the documentation.
>>
>> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
>> Signed-off-by: Guo Zihua <guozihua@huawei.com>
> 
> I've applied this, but I'm wondering: where did this review take place?
> I can't find it on the lists...
> 
> Thanks,
> 
> jon
> .

Hi Jonathan,

Thank you very much and sorry for the confusion here. The reviewed by is 
more like a face-to-face peer review and I would like to mention that in 
the patch. If this is problematic I would stop doing that from now on.

-- 
Best
GUO Zihua
