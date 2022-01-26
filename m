Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C88149D4BA
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 22:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbiAZVym (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 16:54:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbiAZVyl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 16:54:41 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QLro09018925;
        Wed, 26 Jan 2022 21:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=k5Qmzq3J+k6wRqHENCA+dE6q5ypLkR0KPfCSRPzq53M=;
 b=To499lXgIh0TGd3l8FVHOBOyybrM+6VPJ4fih/acCqkchXu2LhbZ0aq3P7JGNGxfR4JE
 hJndCbJoARZy71cIxa8XqhhisXC2PyNyQNSFAflU2aIBZnr70HQhJIPeTjaU+VCtDnsI
 YudHgxNKyRc3rh+uLL6CDi2VyuFBim/jCGlc4PtZX6it1M5SPJIBC5qK/xQbIn+q11X8
 24GkzUepcm0F870UOr+e55X08ZFXvyPc61XxO0ZhK2JN4twpDU84nqOs5tRv/0pl97yK
 Kp6LjqxVsGYxA2cPwZHHoiC6h5PLS8Wpo3+SFyXYk0CFvkcneKEvxFuBC935Gb08t3s3 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du9j67qkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 21:54:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QLsLtI020580;
        Wed, 26 Jan 2022 21:54:21 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du9j67qka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 21:54:21 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QLm6nu024784;
        Wed, 26 Jan 2022 21:54:20 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jc0vd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 21:54:20 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QLsIbf35586546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 21:54:18 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB8E112070;
        Wed, 26 Jan 2022 21:54:18 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D6C112076;
        Wed, 26 Jan 2022 21:54:18 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 21:54:18 +0000 (GMT)
Message-ID: <f9af66c8-955d-0788-3e70-3a1cd1e96267@linux.ibm.com>
Date:   Wed, 26 Jan 2022 16:54:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 11/23] ima: Move ima_lsm_policy_notifier into
 ima_namespace
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-12-stefanb@linux.vnet.ibm.com>
 <20220126130532.gvswwt333ojh5xae@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126130532.gvswwt333ojh5xae@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wp2I7hmMkxpe4awLYjxRKq5-rGi53Ba6
X-Proofpoint-ORIG-GUID: kc4HWy58GvpKCJlQKCXFyp7WZqEi1wXe
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 08:05, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:33PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Move the ima_lsm_policy_notifier into the ima_namespace. Each IMA
>> namespace can now register its own LSM policy change notifier callback.
>> The policy change notifier for the init_ima_ns still remains in init_ima()
>> and therefore handle the registration of the callback for all other
>> namespaces in init_ima_namespace().
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
> I'd double-check that this cannot be used to cause rcu stalls when a lot
> of ima namespace with a lot of rules are used leading to a dos situation
> during LSM policy update. The good thing at least is that an LSM policy
> update can only be triggered for selinux for the whole system.


I just ran a test with up to 1920 IMA-namespaces each with 2 audit rules 
with the vmtools_exec_t label. Disabling of the vmtools SELinux module 
caused the rules to disappear in all IMA namespaces, as expected. 
However, it also added many kernel log lines 'ima: rule for LSM 
'vmtools_exec_t' is undefined' to the kernel log that should probably be 
suppressed for ns != &init_ima_ns. Nothing bad happened otherwise. Also 
re-enabling the vmtools module didn't cause any kernel errors.  So I 
think we should be fine.

https://github.com/stefanberger/ima-namespaces-tests/tree/master/audit-many-2


