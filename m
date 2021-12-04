Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B90468150
	for <lists+linux-integrity@lfdr.de>; Sat,  4 Dec 2021 01:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383731AbhLDAhf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 19:37:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354317AbhLDAhd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 19:37:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B40HYZZ011700;
        Sat, 4 Dec 2021 00:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+hROM4sO6hA+iv7/9x++tjAsBm8+dd1jwZt+bNLs8l0=;
 b=jfP+Y7uL+GY4OwllaHNpQdMmGEzZ/BLSOQjNzT7wFJVpdN8clQX5HjJ36KqaExDVijVD
 LtN3pXeo4uew3AkaL5aj2a3TyIlSF/z9euf9ldmnsNptPMiNwGiSdoKdhARnbaQa9grq
 8bi3Q1t2MCGD0g2JKuuybGSLeR6czdsb/jFnvcBBrY7eenfsx5YGt7l6cpBH6nkGq7Gz
 FDPzKcL7Nt8CCCsyIet2dmeWJ1Po0xGlb/rDeibvjZY2MUZvdFFDi3JmxbR1cZzpJ0uP
 bP5iFrIWG/CQe3bPJ+cuhbfGlI5HC9n5GfwItgtGhJHgGj966f3CYOE21CP0msupTAmT qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqwnpg6gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Dec 2021 00:33:44 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B40OgJY030422;
        Sat, 4 Dec 2021 00:33:44 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqwnpg6gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Dec 2021 00:33:44 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B40V1As024895;
        Sat, 4 Dec 2021 00:33:43 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3ckcaes9fy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Dec 2021 00:33:42 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B40XeEl60948756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Dec 2021 00:33:41 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76CE6A051;
        Sat,  4 Dec 2021 00:33:40 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB9F16A047;
        Sat,  4 Dec 2021 00:33:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat,  4 Dec 2021 00:33:39 +0000 (GMT)
Message-ID: <b285b0d4-e615-bea4-f22f-09d83f8f8edb@linux.ibm.com>
Date:   Fri, 3 Dec 2021 19:33:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 19/19] ima: Setup securityfs for IMA namespace
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jejb@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
 <20211203023118.1447229-20-stefanb@linux.ibm.com>
 <df433bc52ca1e0408d48bbace4c34a573991f5ba.camel@linux.ibm.com>
 <6306b4e5-f26d-1704-6344-354eb5387abf@linux.ibm.com>
 <11b557b58de74828b1c16334a5fb52c4d3f6ad0f.camel@linux.ibm.com>
 <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
In-Reply-To: <cd05433a-3630-e7f5-e144-ff766d7792fa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CZ0cfq8uxoQhgGLsVAoOmsRdPCs2uWjB
X-Proofpoint-GUID: evADAffd-nUhjqi_m_Mz1yuxXpiFgQ5o
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112040002
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/3/21 14:11, Stefan Berger wrote:
>
> On 12/3/21 13:50, James Bottomley wrote:
>
>
>>
>>> Where would the vfsmount pointer reside? For now it's in
>>> ima_namespace, but it sounds like it should be in a more centralized
>>> place? Should it also be  connected to the user_namespace so we can
>>> pick it up using get_user_ns()?
>> exactly.  I think struct user_namespace should have two elements gated
>> by a #ifdef CONFIG_SECURITYFS which are the vfsmount and the
>> mount_count for passing into simple_pin_fs.
>
> Also that we can do for as long as it flies beyond the conversation 
> here... :-) Anyone else have an opinion ?

I moved it now and this greatly reduced the amount of changes. The 
dentries are now all in the ima_namespace and it works with one API. Thanks!

I wonder whether to move the integrity dir also into the ima_namespace. 
It's generated in integrity/iint.c, so not in the IMA territory... For 
the IMA namespacing case I need to create it as well, though.

https://elixir.bootlin.com/linux/latest/source/security/integrity/iint.c#L218

    Stefan


