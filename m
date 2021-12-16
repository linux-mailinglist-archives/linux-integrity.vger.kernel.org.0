Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8B4768E8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 05:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhLPEBH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 23:01:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7906 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233477AbhLPEBG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 23:01:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2x1WA009235;
        Thu, 16 Dec 2021 04:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=HGlFMHQUYMi3K48qUYXxEF2y7afN4tqLAJEZgMrV43s=;
 b=kjBAP3cHde8lRc9CcYeGMcJTVnLM0WvwjePrdiBIj68TbasDOSaM9naCo0HyILot/12l
 KD6agrjOdMOFqYU1qtO93c7h3aWetkVONeTXgpXfaZjEhb4gyIDLnoo0HA4tGYio7zlW
 TRDeh0yHN/6lBuD0AQKGEnGgAmifekyGOzh12PAtj3ALqxuSuDopN+GxL08AGco/qr2h
 68iEm/xeo8Yr7wYkgmdhjqiff+aO4oKxQ6JXysN4OOf8CUJqzFZ/w8oRKYiG0Hg93T7F
 7cqqR5vEpTd8V5EjMV5UuYVaj2Jonraol47m9I7YZjEWpc0bPVRDLUIpIIuzpYqfsi2O hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypc6ge58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 04:00:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG3xsxX003340;
        Thu, 16 Dec 2021 04:00:52 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cypc6ge4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 04:00:52 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG3uoEQ012452;
        Thu, 16 Dec 2021 04:00:51 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 3cy7e3qrwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 04:00:50 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG40gJU25297208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 04:00:42 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07D83124052;
        Thu, 16 Dec 2021 04:00:42 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8E3E124054;
        Thu, 16 Dec 2021 04:00:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 04:00:41 +0000 (GMT)
Message-ID: <6a2573d1-6bea-45b0-3105-2d2dc21b503b@linux.ibm.com>
Date:   Wed, 15 Dec 2021 23:00:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 02/17] ima: Define ns_status for storing namespaced
 iint data
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
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
 <20211210194736.1538863-3-stefanb@linux.ibm.com>
 <7586b43739f121041b294d9bea60bf9b1bd71f7c.camel@linux.ibm.com>
 <29381ebc-0bf7-59c5-6d16-16958e2dfcb1@linux.ibm.com>
 <7cd23e2c058752a97f04c23a4a5243a3471e2cd6.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <7cd23e2c058752a97f04c23a4a5243a3471e2cd6.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CjikH6Vj6CDvEM50aMG1z7McDINsEnQy
X-Proofpoint-GUID: nhwh-cR5eEGoX5bxjFnJdoCZndx_pxTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160022
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 22:53, Mimi Zohar wrote:
> On Wed, 2021-12-15 at 21:37 -0500, Stefan Berger wrote:
>
>>> before it is re-used.
>> KMEM_CACHE + kmem_cache_alloc/zalloc() are pretty common. What kind of
>> comment would be helpful here?
> The original reason for using kmem_cache_create() with init_once and
> deferring memory cleanup to free was for performance.  Using
> KMEM_CACHE() and kmem_cache_zalloc() instead could be for simplicity.
> The comment should note the change.

/* use KMEM_CACHE for simplicity */ ?


>
> Mimi
>
