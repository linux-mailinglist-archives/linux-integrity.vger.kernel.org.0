Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501F44A525C
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Jan 2022 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiAaW3H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jan 2022 17:29:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230136AbiAaW3H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jan 2022 17:29:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VKbvEr009980;
        Mon, 31 Jan 2022 22:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4eXcaHmhWTiu+7oqk4vWOVXF3/bem6IjIMLlTy7RVY8=;
 b=AoE+6hEBLHLmVHF3YKz/jH5VHmUpO3XjUjk3rPkQ9nfP7PcMpNfnFpCHTniEhLRPT4vZ
 8JSNw16Ld3w5w90LzLbS7Pu9wPJpD+GEYKsEd1Zd0wMBj8BPsefxu0HW5l6FUxmpYBqC
 SSkurLuFaTmMHDwU2Hf+qgoMxiPncnsvrUM+1N71Lw6SdhQalf2g1TrunPFClkOmvC2F
 Mdxf3hRivGpTs0bL6rkxVK39yFETpOZZxCYeqIKJjE9MRoIpGfRbXP5OmW2DGC6V9bOt
 aZLRzFx/liTatG0tvVrEHw+CnZlCY12Aq7gZ1C7TgyENyRabemz7piKRofifua6N5Y1J /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxpm0ad4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 22:28:46 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VMPH6P032240;
        Mon, 31 Jan 2022 22:28:46 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxpm0ad4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 22:28:46 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VMCMCt025889;
        Mon, 31 Jan 2022 22:28:45 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma05wdc.us.ibm.com with ESMTP id 3dvw7ad1t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 22:28:45 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VMSi0I35651866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 22:28:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCB9E2806A;
        Mon, 31 Jan 2022 22:28:44 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B7B328067;
        Mon, 31 Jan 2022 22:28:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 22:28:44 +0000 (GMT)
Message-ID: <d31e8276-9303-fff8-427f-afc859131202@linux.ibm.com>
Date:   Mon, 31 Jan 2022 17:28:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 04/23] securityfs: Extend securityfs with namespacing
 support
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-5-stefanb@linux.vnet.ibm.com>
 <dc60e85030ac6423fb2af7361d9e47b01f8c63f7.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <dc60e85030ac6423fb2af7361d9e47b01f8c63f7.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nFq2x2eitfspJ_HLSCAsg1WGApgokuHr
X-Proofpoint-GUID: RsegNeuOqmQo1kOzNJWLj4jWZrjohNyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310139
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/27/22 11:53, Mimi Zohar wrote:
> On Tue, 2022-01-25 at 17:46 -0500, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Enable multiple instances of securityfs by keying each instance with a
>> pointer to the user namespace it belongs to.
>>
>> Since we do not need the pinning of the filesystem for the virtualization
>> case, limit the usage of simple_pin_fs() and simpe_release_fs() to the
>> case when the init_user_ns is active. This simplifies the cleanup for the
>> virtualization case where usage of securityfs_remove() to free dentries
>> is not needed anymore.
> Could you add a sentence here explaining why securityfs_remove() isn't
> needed in the virtualization case?

At this point the reason is that simple_pin_fs() is not used for the 
virtualization case.

Maybe it should say: ... to free dentries is *therefore* not needed anymore.

    Stefan
