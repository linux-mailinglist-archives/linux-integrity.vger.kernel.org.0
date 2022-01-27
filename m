Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E829E49E84A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 18:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiA0RCu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 12:02:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244285AbiA0RCr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 12:02:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RGZuc3002115;
        Thu, 27 Jan 2022 17:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XR99+5C2bK2xEEVFSEV7u/LqNan1tohHz6Q54+3Jkvo=;
 b=k1IxiR1urKzVi3tQ/55VeoyT7b25Ya2Pmf/NW5tcQEuPawIXYJfVBVXFWONQbfeZul6J
 +LZwdjMCU63TVs2EJQQW3hg5u4gYZszLjsSpY9DHi4O2ZrpkYCkvDbGS6kWFZAccrVcP
 8Y10Xkjkb7s2yooDAC07A3JOeZDDPEcxxY4537JYKUgYKKG0AdMcGLjYH0gehmGV6I5g
 D78fR53Rm8/9TpD4n2vcLSEzYkelzY2DBrOm51APFkrZlYJ+Efo1oWM+g/mb5n/HCTLZ
 ZdcrR3uRmDmqA78XINaqcSQjv0hiACkG7jsM+IrvKWH3DzIkZGZazhoM0snLMzthgmnT sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duxqcgwdt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 17:02:32 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RGgcoe030726;
        Thu, 27 Jan 2022 17:02:30 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3duxqcgwd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 17:02:30 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RGrCK8004479;
        Thu, 27 Jan 2022 17:02:29 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3dt1xbamvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 17:02:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RH2RSS34406772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 17:02:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34D19B206A;
        Thu, 27 Jan 2022 17:02:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A07DB205F;
        Thu, 27 Jan 2022 17:02:25 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 17:02:25 +0000 (GMT)
Message-ID: <af944c80-aaa0-357d-eac3-f902c196fa0b@linux.ibm.com>
Date:   Thu, 27 Jan 2022 12:02:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 10/23] ima: Move IMA securityfs files into
 ima_namespace or onto stack
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
 <20220125224645.79319-11-stefanb@linux.vnet.ibm.com>
 <20220126094042.l6jqu5swwsyhlt7v@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126094042.l6jqu5swwsyhlt7v@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AI1qMepFUSGt1tPFslU94FZspmk1-bpq
X-Proofpoint-GUID: 5qIyij198JJAlJL5OQBDc-HXxbGc7jy3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 04:40, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:32PM -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Only the securityfs IMA policy file is ever removed based on Kconfig
>> options. For this reason, move the IMA securityfs policy file variable
>> 'ima_policy' into the ima_namespace.
>>
>> Move the other IMA securityfs files onto the stack since they are not
>> needed outside the function where they are created in. Also, their cleanup
>> is automatically handled by the filesystem upon umount of a virtualized
>> securityfs instance, so they don't need to be explicitly freed.
> I'd reverse the explantion in the commit and mention the securityfs
> change that makes this move possible which is patch 3 in this version of
> the series ("securityfs: rework dentry creation"); something like:
>
> 	Earlier we simplified how dentry creation and deletion is manged in
> 	securityfs. This allows us to move IMA securityfs files from global
> 	variables directly into ima_fs_ns_init() itself. We can now rely on
> 	those dentries to be cleaned up when the securityfs instance is cleaned
> 	when the last reference to it is dropped.
> 	
> 	Things are slightly different for the initial ima namespace. In contrast
> 	to non-initial ima namespaces it has pinning logic binding the lifetime
> 	of the securityfs superblock to created dentries. We need to keep this
> 	behavior to not regress userspace. Since ima never removes most of the
> 	securityfs files the initial securityfs instance stays pinned. This also
> 	means even for the initial ima namespace we don't need to keep
> 	references to these dentries anywhere.
> 	
> 	The ima_policy file is the exception since ima can end up removing it if
> 	a non-default policy is written at some point.
>
> Last sentence should be checked for sensibility by ima folks.

I remove the if clause and took the other text as-is...

Thanks.

    Stefan


