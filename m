Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8796A780357
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Aug 2023 03:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjHRB2K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Aug 2023 21:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357048AbjHRB1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Aug 2023 21:27:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FC3C38
        for <linux-integrity@vger.kernel.org>; Thu, 17 Aug 2023 18:27:08 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRkfc13SzzVkKT;
        Fri, 18 Aug 2023 09:23:52 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 09:25:59 +0800
Message-ID: <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
Date:   Fri, 18 Aug 2023 09:25:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
CC:     <linux-integrity@vger.kernel.org>
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Mimi,

On 2023/8/17 22:19, Mimi Zohar wrote:
> Hi Scott,
> 
> This patch changes the TPM PCR hash algorithm and value in the IMA
> measurement list.  The Subject line doesn't convey that.
> 
> On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
>> TPM2 chips supports algorithms other than SHA1. However, the original
>> IMA design hardcode template hash to be SHA1.
> 
> True, IMA initially calculated and extended a SHA1 hash into the TPM,
> but Roberto addressed that years ago.  Refer to commit  1ea973df6e21
> ("ima: Calculate and extend PCR with digests in ima_template_entry").
> 
> IMA now calculates and extends each of the enabled TPM banks with the
> appropriate hash value.  The PCR value in the IMA measurement list
> remains SHA1.  Attestation servers can first verify the SHA1 template
> hash as stored in the measurement list.  Then it can walk the IMA
> measurement list calculating the template data hash based on the per
> TPM bank algorithm to verify the TPM bank PCR value. 

Yeah I noticed that. However the fact that only SHA1 digest is included
in the measurement list means that the file-data hash and file hint is
effectively "protected" by just a SHA1 digest, and at the end of the day
for remote attestation only SHA1 digest is available.

> 
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
>> 	16bit-le=pcr#
>> 	16bit-le=template digest size
>> 	char[n]=template digest
>> 	32bit-le=template name size
>> 	char[n]=template name
>> 	[eventdata length]
>> 	eventdata[n]=template specific data
>> The first element is now a 16bit pcr number and a 16bit template digest
>> size, instead of the original 32bit pcr number.
>>
>> The format of ascii_measurement_list is also changed. For sha1 template
>> hash, the format is the same as before. For other hash algorithms, a
>> hash name is prepended as such:
>> "sha256:30ee3e25620478759600be00e06fda7b4fe23bbf575621d480400d536cf54f5b"
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> Other proposals have changed the hard coded hash algorithm and PCR
> value from SHA1 to SHA256.  Both that proposal and this will break
> existing userspace applications.

This is the part I would like to "RFC" on, and thanks for the comment!
In deed this change should break userspace as well as all the existing
remote attestation implementation. It should be better to have a brand
new file for this.
> 
> Before we can introduce this sort of change, we would need to introduce
> an IMA measurement list version.  Perhaps its time to define an IMA
> security critical-data record, which would include this and other
> information.  The measurement list itself would need to include a
> version number.
> 
I guess one of the easy way to do it is to make a
ascii_runtime_measurements_ng and binary_runtime_measurements_ng, which
contains a changed template supporting configurable template hash. What
do you think?

-- 
Best
GUO Zihua

