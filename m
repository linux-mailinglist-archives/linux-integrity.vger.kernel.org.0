Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89E14700D4
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 13:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhLJMn6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 07:43:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55574 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241121AbhLJMn5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 07:43:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BACSZOS019764;
        Fri, 10 Dec 2021 12:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HwPvyErEfXg7u6SvtO+DYAy9MKg3s6ZngMDaqQJu1FU=;
 b=FeUTArGVi6CVOc/4s8xjKnNll8MmZmtBthlliCz/+XF2myqcV/fGCYDC53peZzE9vqNJ
 M6WDdGW3/AQntg3CChebH9Olfa1ByUbg0MGOHLoB7beOJgZjKTgCGpFBvMyQhtGR4Cuq
 UR7ZkH5nwIKjd8HyOtsYy9lGJM8/+6BeKf5nuJLNqkp/zDIQiz9fnq9VXlH9HI5i+ROv
 td2F1sKf5V5fwccosguyfE+RiqejR+nX6NZt032T4DOD/l5ii61jaAPadbcIt3fiLykt
 PqDVBgPg4t+U67CBXUVLE6dz2UN8Uuut2c5azXiG2N5w8sjNo9YGlga2IqnTOeu1H6M6 cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6xb86hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:10 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BACViMJ027011;
        Fri, 10 Dec 2021 12:40:09 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cv6xb86h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:09 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BACc43O006049;
        Fri, 10 Dec 2021 12:40:08 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3cqyyeate8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 12:40:08 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BACe6mp21561708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 12:40:06 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46C956A058;
        Fri, 10 Dec 2021 12:40:06 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 193EB6A05A;
        Fri, 10 Dec 2021 12:40:00 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 12:40:00 +0000 (GMT)
Message-ID: <6de8d349-74f8-7be4-3854-5c4ac72860ad@linux.ibm.com>
Date:   Fri, 10 Dec 2021 07:40:00 -0500
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
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <2587716d7d021c35e3b6ef22b6e30f44c2b3f98e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bxiFoK1NJFleKBxVVB3bImtUbDj4gcjL
X-Proofpoint-GUID: xlAgFySbHTUMFAHYLfVCNjQaJeFosAhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_03,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100070
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/10/21 07:09, Mimi Zohar wrote:
> On Fri, 2021-12-10 at 12:49 +0100, Christian Brauner wrote:
>>> There's still the problem that if you write the policy, making the file
>>> disappear then unmount and remount securityfs it will come back.  My
>>> guess for fixing this is that we only stash the policy file reference,
>>> create it if NULL but then set the pointer to PTR_ERR(-EINVAL) or
>>> something and refuse to create it for that value.
>> Some sort of indicator that gets stashed in struct ima_ns that the file
>> does not get recreated on consecutive mounts. That shouldn't be hard to
>> fix.
> The policy file disappearing is for backwards compatibility, prior to
> being able to extend the custom policy.  For embedded usecases,
> allowing the policy to be written exactly once might makes sense.  Do
> we really want/need to continue to support removing the policy in
> namespaces?

I don't have an answer but should the behavior for the same #define in 
this case be different for host and namespaces? Or should we just 
'select IMA_WRITE_POLICY and IMA_READ_POLICY' when IMA_NS is selected?


>
> thanks,
>
> Mimi
>
