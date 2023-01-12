Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2877B667ACC
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 17:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbjALQ3c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 11:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjALQ2u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 11:28:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FFDC8
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 08:27:33 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFMiMU007486;
        Thu, 12 Jan 2023 16:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=G1JusZCPWWMHCPze6RKONOKtAEyA/JvY/aGsI5BFlRo=;
 b=paQoUZr/og/heLyR+ywvBLh4rBVHIEJjUM6Cck0gJV2IYluOjIjkc+OYQCJlvoDBvVrW
 L1IRoRmslICjy5MSDhy5igONcxDjWbdpB+kw66Lh3BAMq2lUYBIV/G6bD45jt/Hp/XIe
 MdjsLMwou1YFoRw4U/AOBqSZx6ZGG8kVwk/kbewTbfGu5FFL1UetCPMZe5kESJRjI/PT
 NfNwWeOGFUWEaVo/kjg9Rjeim4HMDZqyhUYpNzYemULpo2PA1P1C2CAh4FsW2RamyJ0X
 Hg1Ad7AlhzbrfsPfPDaISLUrT5hH+/phlsqWYwEAZzF4VDnAEfM+UTYAjMsiB31O5SEh +Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msmhuv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:27:03 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CGJVxd019527;
        Thu, 12 Jan 2023 16:27:02 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msmhuuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:27:02 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEYuXG001753;
        Thu, 12 Jan 2023 16:27:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n1kmaj7va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:27:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CGR1PE38994388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 16:27:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0CA45805C;
        Thu, 12 Jan 2023 16:27:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2198F58054;
        Thu, 12 Jan 2023 16:27:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 16:27:00 +0000 (GMT)
Message-ID: <b2081222-c8d7-0bc2-1e0a-368258c8a1c9@linux.ibm.com>
Date:   Thu, 12 Jan 2023 11:26:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 8/9] Use in-place built fsverity binary
 instead of installing it
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-9-roberto.sassu@huaweicloud.com>
 <42a75a49-31c8-4987-2b0d-83fef07d6cde@linux.ibm.com>
 <d6b9a9084c887372157e2deea29c20c9520ea63b.camel@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d6b9a9084c887372157e2deea29c20c9520ea63b.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 04omjvN9i2KHsPP0VOT4J0CwkMjtL33x
X-Proofpoint-ORIG-GUID: AI1PADmhL7TmoPtlmTycwxKM6aEtazK8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301120116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 11:20, Roberto Sassu wrote:
> On Thu, 2023-01-12 at 11:11 -0500, Stefan Berger wrote:
>>
>> On 1/12/23 07:24, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Instead of making changes to the system, use in-place built fsverity binary
>>> by adding ../fsverity-utils to the PATH variable, so that the binary can be
>>> found with the 'which' command.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>
>>> ---
>>>    tests/fsverity.test       | 2 +-
>>>    tests/install-fsverity.sh | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/fsverity.test b/tests/fsverity.test
>>> index 84312aa08a30..e05978be7ea6 100755
>>> --- a/tests/fsverity.test
>>> +++ b/tests/fsverity.test
>>> @@ -30,7 +30,7 @@
>>>    # custom policy rules might take precedence.
>>>    
>>>    cd "$(dirname "$0")" || exit 1
>>> -PATH=../src:$PATH
>>> +PATH=../src:../fsverity-utils:$PATH
>>>    source ./functions.sh
>>>    
>>>    # Base VERBOSE on the environment variable, if set.
>>> diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
>>> index 418fc42f472b..d00674c0d3a2 100755
>>> --- a/tests/install-fsverity.sh
>>> +++ b/tests/install-fsverity.sh
>>> @@ -2,6 +2,6 @@
>>>    
>>>    git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
>>>    cd fsverity-utils
>>> -CC=gcc make -j$(nproc) && sudo make install
>>> +CC=gcc make -j$(nproc)
>>>    cd ..
>>>    rm -rf fsverity-utils
> 
> Argh... same problem.
> 
> Will just delete the last two lines. It is just for CI.

Must be skipping tests when the tool is not found

> 
> Roberto
> 
