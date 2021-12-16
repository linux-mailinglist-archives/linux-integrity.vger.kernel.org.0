Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6E476835
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 03:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhLPCmB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 21:42:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhLPCmA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 21:42:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG0PKVT016128;
        Thu, 16 Dec 2021 02:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qzkckg/+NQ4FQtLP6Nm9kJTIfHvLTLW8GszapH/EpKk=;
 b=IQ/4NBdsVzNJ78iwEFb+pMAaHS73Ws3RINOk3tO2273JTtXGYhVFL1FRCzn1RajQVQQu
 3kGuDhGonU57oISci1rdN9lOq6x7BFsTEMrfldJG+UbYTEvW+dMTypK7KU7HEDQh2Ihm
 J6u6El8uhTVqeQCXYTpKPD9TswLC8JJTuCQKQ0Ib1+u/A41IC6iUOqbJTofVQ6SDzapM
 VCckXNTBPc/YLyarD77sxz2wsJEr/hr0IyD1L0sWIivwG0En1XD70Bzfw3HeBbIL9ALV
 Fal0TOV4dMY0VPRBK8AlLkTPiJOAFgV5m6NkHO4UF4rqhs4t1u6MGH7KV3LAr3FKwBKa pA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jhc0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:41:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG2fnb3005478;
        Thu, 16 Dec 2021 02:41:49 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jhc09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:41:48 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2Ynrb008953;
        Thu, 16 Dec 2021 02:41:47 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3cy7e3pk51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:41:47 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG2fkkj25100574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 02:41:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C3972805C;
        Thu, 16 Dec 2021 02:41:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38DA228058;
        Thu, 16 Dec 2021 02:41:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 02:41:42 +0000 (GMT)
Message-ID: <2c440d28-6857-9343-2230-f0f2905fe3a7@linux.ibm.com>
Date:   Wed, 15 Dec 2021 21:41:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 17/17] ima: Setup securityfs for IMA namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-18-stefanb@linux.ibm.com>
 <11e9dbc416438575fe925c820ff7ad2d8d4b0510.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <11e9dbc416438575fe925c820ff7ad2d8d4b0510.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2aDWWgK-qH_YagsHqxCA4bWiBcbhtDEW
X-Proofpoint-GUID: ZyQbgqEAdyETNAmwJaj02yaTUJlBVN1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160010
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 16:31, Mimi Zohar wrote:
> Hi Stefan, James,
>
> On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
>> Setup securityfs with symlinks, directories, and files for IMA
>> namespacing support. The same directory structure that IMA uses on the
>> host is also created for the namespacing case.
>>
>> The securityfs file and directory ownerships cannot be set when the
>> IMA namespace is initialized. Therefore, delay the setup of the file
>> system to a later point when securityfs is in securityfs_fill_super.
>>
>> This filesystem can now be mounted as follows:
>>
>> mount -t securityfs /sys/kernel/security/ /sys/kernel/security/
>>
>> The following directories, symlinks, and files are then available.
>>
>> $ ls -l sys/kernel/security/
>> total 0
>> lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
>> drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity
> The ima symlink was introduced for backwards compatibilty.  Refer to
> commit 0c343af8065b ("integrity: Add an integrity directory in
> securityfs").  The symlink shouldn't need to be supported in IMA
> namespace.

That's backwards compatibility for applications and scripts. If we want 
to have these running unmodified inside IMA namespaces I think it's 
better to keep the symbolic link and not treat the IMA namespaces any 
different than the host.

    Stefan

>
> thanks,
>
> Mimi
>
>> $ ls -l sys/kernel/security/ima/
>> total 0
>> -r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
>> -r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
>> -rw-------. 1 root root 0 Dec  2 00:18 policy
>> -r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
>> -r--r-----. 1 root root 0 Dec  2 00:18 violations
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
