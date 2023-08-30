Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AB978DCE1
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbjH3Sq6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242767AbjH3JdD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 05:33:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43195
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 02:32:59 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RbJvW0cYRz1L9MY;
        Wed, 30 Aug 2023 17:31:19 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 30 Aug 2023 17:32:57 +0800
Message-ID: <6a4766e4-1c50-f0a1-3efe-b3aada612bda@huawei.com>
Date:   Wed, 30 Aug 2023 17:32:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-integrity@vger.kernel.org>
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
 <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
 <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
 <76227f6b-a0ac-d198-fc0b-2029899cfe15@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <76227f6b-a0ac-d198-fc0b-2029899cfe15@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2023/8/29 5:05, Ken Goldman wrote:
> I'd like to present three possible cases, expanding on Mimi's
> observation that the template hash is currently the hash of the
> template data.
> 
> My vote is #2, but all have merits.
> 
> ----------
> 
> 1. Leave the SHA-1 template hash.
> 
> A. This does not break existing applications.
> 
> B. The template data is protected by the TPM quote, which does not
> have to be SHA-1.
> 
> C. The SHA-1 digest provides some debug usefulness against a
> non-malicious alteration of the template data. The application can
> report which event record is incorrect.

What the verifier can't do as of now is to tell which file has been
corrupted, given the attacker managed to achieve a SHA-1 collision while
keeping the measurement items reasonable.

Even worse, as the TPM quote contains only an accumulated digest, there
leaves a chance for the attacker to "fix" the TPM digest by generating
additional measurement items. Without the ability to verify each and
every individual measurement item verifier could produce a false
negative result.
> 
> ----------
> 
> 2. Include template hashes for all PCR banks.
> 
> A. This breaks existing applications on the attestor side, but could
> be made backward compatible / deprecated at the verifier side.
> 
> B. The redundant data is an attack surface, in that the verifier must
> remember to check the hashes against the quote AND against the
> template data.
> 
> C. The digest provides debug usefulness against malicious attacks on
> the template data.
> 
> D. This permits the use case where the template hash is NOT a hash of
> the template data. In the UEFI event log (using IMA terms), the
> template hash can be a digest of some other data and the template data
> is a hint as to where and what that data is.
> 
> E.g., the UEFI event EV_CPU_MICROCODE template data field has a patch
> descriptor, while the template hash is a digest of the patch itself.

As of now, IMA stores template hash with it's measurement item in the
memory, and storing digest value from all banks would make the digest
list N times bigger, where N would be an increasing number of supported
algorithms by TPM.
> 
> ----------
> 
> 3. Include a template hash for the strongest hash algorithm.
> 
> A. It's not always clear what the strongest algorithm is.
> 
> Otherwise, this is the same as #2.

"strongest" algorithm does not exist. I think it would be better to find
a extensible solution allowing for future upgrade.
> 
> On 8/18/2023 7:17 PM, Mimi Zohar wrote:
>> On Fri, 2023-08-18 at 09:25 +0800, Guozihua (Scott) wrote:
>>> On 2023/8/17 22:19, Mimi Zohar wrote:
>>>> On Thu, 2023-08-17 at 14:13 +0800, GUO Zihua wrote:
>>
>> True SHA1 is being phased out due to hash collisions.  Verifying the
>> template data hash against the template data isn't necessary for the
>> attestation server to verify a TPM quote against any of the enabled TPM
>> banks.  The attestation server walks the measurement list calculating
>> the bank specific template data hash.  Breaking existing applications
>> is unreasonable.
> 
> 

-- 
Best
GUO Zihua

