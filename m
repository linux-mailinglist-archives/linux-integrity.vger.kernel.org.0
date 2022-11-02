Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42029615685
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 01:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKBAZv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 20:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKBAZt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 20:25:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAD364F2
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 17:25:40 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1N7Y4X007612;
        Wed, 2 Nov 2022 00:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0HXOkgvd8ifi3/i7tZqijAvstqHU64aMmZsZdh53jzE=;
 b=XQu9Y1MP20xeashur4EvVBOW2YO/wD6PtbFnuQYSztikd0VaUUrZjP5M/iQ+Jd386rB5
 TmByEz73co6+StkjzrC14hp+0y/JLdTxtw/fhsdGS8RKS6vKHqrieMQvwsG4XCFI+0Cm
 NTget7DB5Z7iwFQXB7gI1uZ3jjclrOD1CzS6gMcN/KoPlZpoCsDyTWID4W46GvfHGrBp
 OVeOkQGPakRWpco0mXVzHmvHAhEe1PLuZEqgbm8T8B5xeA7nZ3jxe4NLjmkq+OYDIzS7
 FsjGrekSt7g+SmwEm7Hl0epvMnfi8wb1zgSyq4QXSmqGfrXHnscamUpS04J7r5/mq8HU Rw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjvbhm7xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:25:34 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A20KlL4015610;
        Wed, 2 Nov 2022 00:25:33 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 3kguta53f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 00:25:33 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A20PXZ554984986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 00:25:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A5A258056;
        Wed,  2 Nov 2022 00:25:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55C758052;
        Wed,  2 Nov 2022 00:25:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 00:25:31 +0000 (GMT)
Message-ID: <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
Date:   Tue, 1 Nov 2022 20:25:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-2-zohar@linux.ibm.com>
 <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
 <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ieDRYDesuOvLQbTmKb8aeEuPPPcMApG
X-Proofpoint-ORIG-GUID: -ieDRYDesuOvLQbTmKb8aeEuPPPcMApG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_11,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211010159
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 19:04, Mimi Zohar wrote:
> Hi Stefan,
> 
> On Tue, 2022-11-01 at 17:46 -0400, Stefan Berger wrote:
>>
>> On 11/1/22 16:17, Mimi Zohar wrote:
>>> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
>>
>> $ git show acb19d1
>> fatal: ambiguous argument 'acb19d1': unknown revision or path not in the working tree.
>>
>> Are you reverting this from a public tree? or could you just drop this patch from your series?
>>
>> Also after removing this patch from the mbox file I cannot apply these patches to my sourceforge checkout -- presumably next-testing branch:
>>
>> $ git am ./v4_20221101_zohar_address_deprecated_warnings.mbx
>> Applying: log and reset 'errno' after failure to open non-critical files
>> Applying: Log and reset 'errno' on lsetxattr failure
>> Applying: travis: update dist=focal
>> Applying: Update configure.ac to address a couple of obsolete warnings
>> Applying: Deprecate IMA signature version 1
>> error: patch failed: src/libimaevm.c:684
>> error: src/libimaevm.c: patch does not apply
>> Patch failed at 0005 Deprecate IMA signature version 1
>> hint: Use 'git am --show-current-patch=diff' to see the failed patch
>> When you have resolved this problem, run "git am --continue".
>> If you prefer to skip this patch, run "git am --skip" instead.
>> To restore the original branch and stop patching, run "git am --abort".
> 
> Sorry, I should have used "--base=auto" when generating the patch set.
> Yes, the patch set is based on the github next-testing branch.
> 

Is the github repo now the main repo and sourceforge repo is dead?

> thanks,
> 
> Mimi
> 
