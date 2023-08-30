Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE33D78E106
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 22:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbjH3UyA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjH3Ux7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 16:53:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAE7E51
        for <linux-integrity@vger.kernel.org>; Wed, 30 Aug 2023 13:53:29 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UJ6Q06013786;
        Wed, 30 Aug 2023 19:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=oghJ6z+IfnWLOytUGjRxOQRJEQXVYL+vX0otv/nvvjs=;
 b=RLL0eMGJbWuxxtUm0S3inm3Z+PhQSB0Bcu4kPT82DylqLLEfXGbAXDTFrJh0Z6io9NLX
 3rc3rXR6Wj31O/PfctB/WgHEC9CvUxyQKyuPD0a4mzkMuir4RYIKRl263WMFavvE8coy
 5UJpl7Jrpg+OiutRwPeImvCI0iwHwDUEvFN3bchu36W1cAB1OWCQw/xU/c8SO7bOv+aX
 27ewH4aax3Nm8YGOtBy1P0vkAlysD1ny5TNjck9FxBSr6erT7kGCwtG6hVuN/TzBrJOk
 xU6t//FKH2trWirIEKgWKUeDX80qwZMYkyvU+bEUr7Ffm14wZp28e38wk2Y73Dvz0Xyp xg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st872678p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:26:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UI1aK2009989;
        Wed, 30 Aug 2023 19:26:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7kp91f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:26:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UJQ7ak18809216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 19:26:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C164058056;
        Wed, 30 Aug 2023 19:26:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCDD58045;
        Wed, 30 Aug 2023 19:26:07 +0000 (GMT)
Received: from [9.67.11.225] (unknown [9.67.11.225])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 19:26:07 +0000 (GMT)
Message-ID: <df39ccaa-532e-c50c-fe75-0d13ab4e791c@linux.ibm.com>
Date:   Wed, 30 Aug 2023 15:26:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH -next] ima: Make tpm hash configurable
Content-Language: en-US
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-integrity@vger.kernel.org
References: <20230817061334.1910-1-guozihua@huawei.com>
 <90b4b5573182ec68b2da2f9ef2bc6567d724f8f1.camel@linux.ibm.com>
 <e2c5711c-6549-e81f-42a7-eec176b39d63@huawei.com>
 <97198ee38422fbb1891981ac5c41263d5b03b321.camel@linux.ibm.com>
 <76227f6b-a0ac-d198-fc0b-2029899cfe15@linux.ibm.com>
 <6a4766e4-1c50-f0a1-3efe-b3aada612bda@huawei.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <6a4766e4-1c50-f0a1-3efe-b3aada612bda@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cdDkEjhihHi58UBbI5RQqVNVlQ7OvGGn
X-Proofpoint-ORIG-GUID: cdDkEjhihHi58UBbI5RQqVNVlQ7OvGGn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=858 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300172
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/30/2023 5:32 AM, Guozihua (Scott) wrote:
> On 2023/8/29 5:05, Ken Goldman wrote:
>> I'd like to present three possible cases, expanding on Mimi's
>> observation that the template hash is currently the hash of the
>> template data.
>>
>> My vote is #2, but all have merits.
>>
>> ----------
>>
>> 1. Leave the SHA-1 template hash.
>>
>> A. This does not break existing applications.
>>
>> B. The template data is protected by the TPM quote, which does not
>> have to be SHA-1.
>>
>> C. The SHA-1 digest provides some debug usefulness against a
>> non-malicious alteration of the template data. The application can
>> report which event record is incorrect.
> 
> What the verifier can't do as of now is to tell which file has been
> corrupted, given the attacker managed to achieve a SHA-1 collision while
> keeping the measurement items reasonable.

That's why I said "non-malicious".  A collision in that case is unlikely.

It's just a debug aid. The quote failed.  Including a SHA-1 hash
can help in software debug.

> 
> Even worse, as the TPM quote contains only an accumulated digest, there
> leaves a chance for the attacker to "fix" the TPM digest by generating
> additional measurement items. Without the ability to verify each and
> every individual measurement item verifier could produce a false
> negative result.

The quote uses SHA-256 or better, which the attacker cannot fix.  In #1, 
the SHA-1 hash is for debug, not for security.

>>
>> ----------
>>
>> 2. Include template hashes for all PCR banks.
>>
>> A. This breaks existing applications on the attestor side, but could
>> be made backward compatible / deprecated at the verifier side.
>>
>> B. The redundant data is an attack surface, in that the verifier must
>> remember to check the hashes against the quote AND against the
>> template data.
>>
>> C. The digest provides debug usefulness against malicious attacks on
>> the template data.
>>
>> D. This permits the use case where the template hash is NOT a hash of
>> the template data. In the UEFI event log (using IMA terms), the
>> template hash can be a digest of some other data and the template data
>> is a hint as to where and what that data is.
>>
>> E.g., the UEFI event EV_CPU_MICROCODE template data field has a patch
>> descriptor, while the template hash is a digest of the patch itself.
> 
> As of now, IMA stores template hash with it's measurement item in the
> memory, and storing digest value from all banks would make the digest
> list N times bigger, where N would be an increasing number of supported
> algorithms by TPM.

N  is not the number of supported algorithms. It's the number of 
allocated PCR banks.

E.g., a typical TPM might support SHA-1, 256, 384, but only allocate 
SHA-256 and SHA-384.  The IMA log would hold those two.

In addition, while the digest list may be N times bigger, the record is 
not, because most of the record is the template name, template data, ...

>>
>> ----------
>>
>> 3. Include a template hash for the strongest hash algorithm.
>>
>> A. It's not always clear what the strongest algorithm is.
>>
>> Otherwise, this is the same as #2.
> 
> "strongest" algorithm does not exist. I think it would be better to find
> a extensible solution allowing for future upgrade.

Sometimes yes (SHA-256 vs. SHA-384).  I agree that A. is the drawback of 
#3. I voted for #2.


