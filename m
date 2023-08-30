Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE278DCE2
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbjH3SrA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242668AbjH3JOW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 05:14:22 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5194D2
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 02:14:18 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RbJTy5866z1L9Bk;
        Wed, 30 Aug 2023 17:12:38 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 17:14:16 +0800
Message-ID: <47e478d8-1559-a3cc-94c1-a05fd79b2f0b@huawei.com>
Date:   Wed, 30 Aug 2023 17:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <linux-integrity@vger.kernel.org>
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
 <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
 <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2023/8/19 7:17, Mimi Zohar wrote:
> On Fri, 2023-08-18 at 09:25 +0800, Guozihua (Scott) wrote:
>> On 2023/8/17 22:19, Mimi Zohar wrote:
>>> On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
> [...]
>  
>>> Other proposals have changed the hard coded hash algorithm and PCR
>>> value from SHA1 to SHA256.  Both that proposal and this will break
>>> existing userspace applications.
>>
>> This is the part I would like to "RFC" on, and thanks for the comment!
> 
> Another proposal included all of the enabled TPM bank digests.
Will this introduce some performance issue? I don't think we should be
calculating various hashes on the same thing again and again.

If we are feeding digests for all slots of the same PCR bank, we could
do a cut-down or padding on the banks we don't care, avoid unnecessary
hash operations.
> 
>> In deed this change should break userspace as well as all the existing
>> remote attestation implementation. It should be better to have a brand
>> new file for this.
> 
> True SHA1 is being phased out due to hash collisions.  Verifying the
> template data hash against the template data isn't necessary for the
> attestation server to verify a TPM quote against any of the enabled TPM
> banks.  The attestation server walks the measurement list calculating
> the bank specific template data hash.  Breaking existing applications
> is unreasonable.
> 
>>>
>>> Before we can introduce this sort of change, we would need to introduce
>>> an IMA measurement list version.  Perhaps its time to define an IMA
>>> security critical-dbata record, which would include this and other
>>> information.  The measurement list itself would need to include a
>>> version number.
>>>
>> I guess one of the easy way to do it is to make a
>> ascii_runtime_measurements_ng and binary_runtime_measurements_ng, which
>> contains a changed template supporting configurable template hash. What
>> do you think?
> 
> Defining additional pseudo filesystems would allow both the old and new
> measurement list formats to be enabled at the same time.
> 

-- 
Best
GUO Zihua

