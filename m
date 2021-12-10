Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127E6470294
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 15:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbhLJOVM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 09:21:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1764 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235573AbhLJOVM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 09:21:12 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAD2wUn003866;
        Fri, 10 Dec 2021 14:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lcZ2Ne0Q9DIfS+eCSfK8ky9QsIcRpydSOwO5kKNkm70=;
 b=ppC8aLy6M6w+f5xec+yFqNR9zOajTgC+QOf+1coGJVjM6aDJjllL2BwMiNDLUR6IuYpg
 Dh1nPFLXt1YPPWpenPMcfcaQ6xXIGc3XbAyiL+drFJZZxjZklLwBbz4FyI/R0JWcHPZJ
 ycB2yKOleE0v6aEUpomWUrhEoQvfP6+xXCuw/A2DVtH7IoTOOdTV+uHmcXg7xvGVimSl
 c7K+kommiWtMpEK/l0yquMnlL+8Hobf8I8K1DX4R10kgksWmlXUtTPn3QqRrKCQtq2sQ
 F5p4j9wv9ddosU0PiL3scu8Miau7tPv0U/1OZ8Px8Kapk8WHAxQai/wfkJrWPA3Tf4tx bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv61jb6tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:17:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BADv02v005749;
        Fri, 10 Dec 2021 14:17:24 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv61jb6tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:17:24 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAEGSSE027277;
        Fri, 10 Dec 2021 14:17:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyyd4neb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 14:17:23 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAEHLu05570872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 14:17:21 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C20DC6074;
        Fri, 10 Dec 2021 14:17:21 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E3FAC6076;
        Fri, 10 Dec 2021 14:17:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 14:17:14 +0000 (GMT)
Message-ID: <66b377f6-40b4-77da-c02b-2650fa72d0b4@linux.ibm.com>
Date:   Fri, 10 Dec 2021 09:17:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 15/16] ima: Move dentries into ima_namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-16-stefanb@linux.ibm.com>
 <20211209143428.ip6bwry5hqtee5vy@wittgenstein>
 <20211209143749.wk4agkynfqdzftbl@wittgenstein>
 <fb99af21f029b8072435e35731b919f4ec98f89d.camel@linux.ibm.com>
 <e2feaf2f6ac4bc82f328f94ca35d14cdc3ca79d1.camel@linux.ibm.com>
 <20211210114934.tacjnwryihrsx6ln@wittgenstein>
 <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
 <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
 <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d8a6a6827da17825c1aa011256b96d195b1ebf13.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IOjL262sWXkGHJkCKlpV3zdb1tGlIk7w
X-Proofpoint-ORIG-GUID: V1Swxl0fmE7wzCmpTkIlKsqbcT3lFTSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_05,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100081
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 08:02, Mimi Zohar wrote:
> On Fri, 2021-12-10 at 07:40 -0500, Stefan Berger wrote:
>> On 12/10/21 07:09, Mimi Zohar wrote:
>>> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
>>>>> There's still the problem that if you write the policy, making the file
>>>>> disappear then unmount and remount securityfs it will come back.  My
>>>>> guess for fixing this is that we only stash the policy file reference,
>>>>> create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
>>>>> something and refuse to create it for that value.
>>>> Some sort of indicator that gets stashed in struct ima_ns that the file
>>>> does not get recreated on consecutive mounts. That shouldn't be hard to
>>>> fix.
>>> The policy file disappearing is for backwards compatibility, prior to
>>> being able to extend the custom policy.  For embedded usecases,
>>> allowing the policy to be written exactly once might makes sense.  Do
>>> we really want/need to continue to support removing the policy in
>>> namespaces?
>> I don't have an answer but should the behavior for the same #define in
>> this case be different for host and namespaces? Or should we just
>> 'select IMA_WRITE_POLICY and IMA_READ_POLICY' when IMA_NS is selected?
> The latter option sounds good.  Being able to analyze the namespace
> policy is really important.

Ok, I will adjust the Kconfig for this then. This then warrants the 
question whether to move the dentry into the ima_namespace. The current 
code looks like this.

#if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
         securityfs_remove(ns->policy_dentry);
         ns->policy_dentry = NULL;
         ns->policy_dentry_removed = true;
#elif defined(CONFIG_IMA_WRITE_POLICY)

With IMA_NS selecting IMA_WRITE_POLICY and IMA_READ_POLICY the above 
wouldn't be necessary anymore but I find it 'cleaner' to still have the 
dentry isolated rather than it being a global static as it was before...


>
> thanks,
>
> Mimi
>
