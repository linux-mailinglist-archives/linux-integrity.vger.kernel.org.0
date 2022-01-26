Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F266149D00F
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 17:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243313AbiAZQw5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 11:52:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236507AbiAZQwz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 11:52:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QGNe1v006702;
        Wed, 26 Jan 2022 16:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7u2u3rFW02ZkxIyF7TLdzwITK6HH45z2mzepZDeo0sY=;
 b=gJjZyGiz/GKR33cQFKdbUYttJ/6Tr5/qWFGyb8j2QKN7v8YvBZ0kgVlswJL368WOsbc/
 XWixuNmLi4C65mfkyX3npj/IMuUG3HZrmX25xd0WzapsszZccZ7wHHzb5jKI0UvF9jhI
 PnOAxoJYTj/jASpuvwPopAWtfDLU4nKmXIg2NQjYkUhqWZq3WyfCU5tL9S0Crlq+yFc6
 rfRSLou1CuWF2/ol//ybm0lfqiz9nfn7nkZ+W3Z9zMuNERJMloT4PYpqZc20PJeT04T2
 wPqHnct2Wwl3S2VByPaez/2hNe3v73ZTBdETEywrJrN9YeLtRjZR1hfmsT59yrWytRyZ jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du8qy2cv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 16:52:40 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QGPGuQ011482;
        Wed, 26 Jan 2022 16:52:39 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du8qy2cuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 16:52:39 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QGi0T4031038;
        Wed, 26 Jan 2022 16:52:38 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3dr9jax4aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 16:52:38 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QGqap425100614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 16:52:36 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A8D0AC064;
        Wed, 26 Jan 2022 16:52:36 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 32602AC062;
        Wed, 26 Jan 2022 16:52:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 16:52:35 +0000 (GMT)
Message-ID: <d41434d2-150a-1e4e-8b40-73fe5c834e97@linux.ibm.com>
Date:   Wed, 26 Jan 2022 11:52:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 00/23] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bMuTzmAyMNb2kEiMQJ5fEoCjDKWarK1-
X-Proofpoint-GUID: fphgyMOFc0ysuv6xAGaW4ohp4P7qTLgz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_05,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/25/22 17:46, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> The goal of this series of patches is to start with the namespacing of
> IMA and support auditing within an IMA namespace (IMA-ns) as the first
> step.
[...]
>
>
> My tree with these patches is here:
>
> git fetch https://github.com/stefanberger/linux-ima-namespaces v5.16+imans.v9.posted

Thanks a lot for the first round of Ack's, Christian. I haven't looked 
through all the comments, yet, though.

If one pulls this branch one will see that there's a directory STAGE3. 
This is where I have been storing patches that explore how deep the can 
is that we are opening here. So yeah, it's pretty deep... In my latest 
branch I now have 40 patches beyond what we have here that add IMA 
-measurement support, inheritance of hash algo and IMA template from 
parent to child, and IMA-appraisal to the IMA namespaces but it doesn't 
tackle yet all of the issues. At some point it pulls in integrity and 
EVM for namespacing as well... All 'dimensions of this problem' look 
good but the patches there are not as clean as we have them here right 
now. So considering the depth of the problem this may take a while...

I also have a test suite just for IMA namespacing that tests IMA-audit 
in IMA-ns and these upcoming aspects and try to test a lot of things 
with running many namespace in parallel to test the locking. I run 
certain tests with up to 1920 namespaces concurrently and so far it's 
been good, especially with the lock groups from v9 18/23. So don't shake 
that tree there too hard.

https://github.com/stefanberger/ima-namespaces-tests

The test suite should be able to skip any tests for which there's no 
support in Linux. So with this series applied the audit related tests 
should all work.

You can check out the test suite but you may need to move along with my 
Linux patch branches as I update the test suite. The problem is of 
course that design changes in Linux patches affect the test suite. So 
this may cause hiccups. And I have been using forced-updates to solve 
this issue... The tests have been working on Fedora 34 x86 and ppc64. 
The unshare tool on Ubuntu 20.04 seems to be too old to run certain 
tests correctly.

Cheers!

    Stefan


