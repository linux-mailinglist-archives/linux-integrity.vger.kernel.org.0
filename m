Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FC04A0032
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiA1SfH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jan 2022 13:35:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24360 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229827AbiA1SfH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jan 2022 13:35:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SI8tLp020845;
        Fri, 28 Jan 2022 18:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/5fP2DHU2seuRk21lH1YPFXff69uyMGRoc4nJk9F9IU=;
 b=VnE1su6pXJ9R2rDFCPdhNJ4D/I90Hl6mrhT7HXGvsLrsvS97VObpx7kMvXBtsektPD38
 dZc2joWlXhC0pCiOZhixldT71AtQ1OzsaGGuwAYPBvo+QxJLqf/AJ0Ozfss/WVBAHr0c
 TJxTsghoMZJUSU1eK3Sx7By3yzeaceEYwE+Goj+EXMXCNThyZsDFIagc0y1BPAEOBOKL
 8ufjpTFpMFxJfunGU8Jo/0j2WXxqS1MiNWbjQaeHvoVfyxqlKryZWXtTq6tV7e3iGve8
 ycqxeuTvUsnEhY/wrUC+cozaHx7tKllsWkZuoA7v03ozuFRXiGoUiNxhp+v1XA7YhtVG rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvhm3p8su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 18:34:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20SIGerh027059;
        Fri, 28 Jan 2022 18:34:53 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvhm3p8sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 18:34:53 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SIXHHP022432;
        Fri, 28 Jan 2022 18:34:52 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jdnvv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 18:34:51 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SIYoPQ19136846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 18:34:50 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00779136053;
        Fri, 28 Jan 2022 18:34:50 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C713136061;
        Fri, 28 Jan 2022 18:34:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 18:34:47 +0000 (GMT)
Message-ID: <02a1501c-bf7d-e572-e1c2-4e7eeed3cf15@linux.ibm.com>
Date:   Fri, 28 Jan 2022 13:34:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 00/23] ima: Namespace IMA with audit support in IMA-ns
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
 <20220126131907.5fauajyjfbcnienp@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126131907.5fauajyjfbcnienp@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1K_4N8kNdxFH7VYz7kzF5wMLSJacbMSR
X-Proofpoint-ORIG-GUID: cvn8N21Gxy3SROjUVnFZP2smk6B2Kqci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_05,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 08:19, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:22PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> The goal of this series of patches is to start with the namespacing of
>> IMA and support auditing within an IMA namespace (IMA-ns) as the first
>> step.
>>
>> In this series the IMA namespace is piggy backing on the user namespace
>> and therefore an IMA namespace is created when a user namespace is
>> created, although this is done late when SecurityFS is mounted inside
>> a user namespace. The advantage of piggy backing on the user namespace
>> is that the user namespace can provide the keys infrastructure that IMA
>> appraisal support will need later on.
>>
>> We chose the goal of supporting auditing within an IMA namespace since it
>> requires the least changes to IMA. Following this series, auditing within
>> an IMA namespace can be activated by a user running the following lines
>> that rely on a statically linked busybox to be installed on the host for
>> execution within the minimal container environment:
>>
>> mkdir -p rootfs/{bin,mnt,proc}
>> cp /sbin/busybox rootfs/bin
>> cp /sbin/busybox rootfs/bin/busybox2
>> echo >> rootfs/bin/busybox2
>> PATH=/bin unshare --user --map-root-user --mount-proc --pid --fork \
>>    --root rootfs busybox sh -c \
>>   "busybox mount -t securityfs /mnt /mnt; \
>>    busybox echo 1 > /mnt/ima/active; \
>>    busybox echo 'audit func=BPRM_CHECK mask=MAY_EXEC' > /mnt/ima/policy; \
> I think we need to limit the number of rules that can be added to an ima
> namespace to prevent DOS attacks. The current implementation allows
> users to write as many ima rules as they want.
>
> My suggestion would be that you look at real-world data to figure out
> what a fairly common number of rules is that people write. Then use this
> as the hard-coded limit for a first implementation. If the use-case


I would now go with a hard-coded (generous) limit of 1024 rules for 
non-init_ima_ns, and leave init_ima_ns unbounded.


> arises you can later make this limit configurable by introducing a
> ucount for ima rules via /proc/sys/user/max_ima_rules.

Ok, let's defer this.


>
> Additionally, you should probably switch a lot of ima allocations from
> GFP_KERNEL to GFP_KERNEL_ACCOUNT as allocations triggerable from userns
> should be treated as untrusted.
Ok, done.
