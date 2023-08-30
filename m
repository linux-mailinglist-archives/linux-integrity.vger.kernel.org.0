Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB178DCCE
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjH3Sqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242789AbjH3Jiv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 05:38:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD5137
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 02:38:48 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RbK1G5f2YzVk2w;
        Wed, 30 Aug 2023 17:36:18 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 17:38:45 +0800
Message-ID: <b56c97d6-830a-f1a9-d99e-304821dabc94@huawei.com>
Date:   Wed, 30 Aug 2023 17:38:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>, <zohar@linux.ibm.com>,
        <corbet@lwn.net>, <dmitry.kasatkin@gmail.com>
CC:     <linux-integrity@vger.kernel.org>
References: <20230817061334.1910-1-guozihua@huawei.com>
 <245b0517-4c13-2815-4b99-c3691f3b86eb@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <245b0517-4c13-2815-4b99-c3691f3b86eb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2023/8/29 4:35, Ken Goldman wrote:
> On 8/17/2023 2:13 AM, GUO Zihua wrote:
>> TPM2 chips supports algorithms other than SHA1. However, the original
>> IMA design hardcode template hash to be SHA1.
>>
>> This patch added CONFIG_IMA_TEMPLATE_HASH as well as ima_tpm_hash=
>> cmdline argument for configurating template hash. The usage is simuliar
>> to CONFIG_IMA_DEFAULT_HASH and ima_hash=. The configured hash is checked
>> against TPM and make sure that the hash algorithm is supported by
>> ima_tpm_chip.
>>
>> To accommodate the change, we must put a digest length into binary
>> measurement list items. The binary measurement list item format is
>> changed to this:
>>     16bit-le=pcr#
>>     16bit-le=template digest size
>>     char[n]=template digest
>>     32bit-le=template name size
>>     char[n]=template name
>>     [eventdata length]
>>     eventdata[n]=template specific data
>> The first element is now a 16bit pcr number and a 16bit template digest
>> size, instead of the original 32bit pcr number.
>>
>> The format of ascii_measurement_list is also changed. For sha1 template
>> hash, the format is the same as before. For other hash algorithms, a
>> hash name is prepended as such:
>> "sha256:30ee3e25620478759600be00e06fda7b4fe23bbf575621d480400d536cf54f5b"
> 
> I would not change the PCR handle to 16 bits.  The TPM supports NVRAM
> based PCRs, and their handles would be 0x01xxxxxx. In the future, there
> may be other 'first byte' values.
> 
> A template digest size does not describe the digest algorithm.  E.g.,
> SM3 and SHA-256 are both 32 bytes.

Oops that's a miss. We would need a brand new format for this I guess.
> 
> If one wants to describe the digest algorithm in 2 bytes, a reasonable
> choice would be the values in the TCG Algorithm registry.  Se TPM Spec
> Part 2 Table 9 — Definition of (UINT16) TPM_ALG_ID Constants <IN/OUT, S>
> 
> E.g., SHA-256 is 000b and SM3 is 0012.
> 

-- 
Best
GUO Zihua

