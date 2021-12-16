Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F48476825
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 03:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhLPCeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 21:34:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhLPCeh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 21:34:37 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG1kkJe021985;
        Thu, 16 Dec 2021 02:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xmUi7r9ADFJpgYejM21zZhnECJmUR3S38rJCIlhq3q8=;
 b=kCU1Xc9F/4dezwaUXrlOq65ExjJvAzBPg9H7G2p+rTI+thGoJX1SnhDprvwWZtLmRu5L
 2HOhxgniuVGo1lJWI9qPwEsEi33+9MWih+fLGrUjbdLOrl1KOBOcZpZTrkm6b4hFO74f
 3HehrpirrqDmCdsY3QrT0bCv+zZjPd570DBp7yEQGBDe14RbN6Ib8zLD/OvKVfPMAewD
 KXrvigRMHi7tYkOSns5AtaaM52hx6PUvvuESDzwiRJ7tHJho6GxM6Hj7Fsowev9dYcWB
 YEzeInYeyakYHPTvUhkQM3ZlaI/1/jT7w2q/KGhnoHGvPc6KV/czl5Rb5d+/PZk9PaS5 KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cymkvsxma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:34:24 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG2XtSV011791;
        Thu, 16 Dec 2021 02:34:24 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cymkvsxm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:34:24 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG2Xsbp021477;
        Thu, 16 Dec 2021 02:34:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02dal.us.ibm.com with ESMTP id 3cy7fvxbta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 02:34:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG2YLLf13042392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 02:34:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9CF46E053;
        Thu, 16 Dec 2021 02:34:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96CF56E058;
        Thu, 16 Dec 2021 02:34:20 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 02:34:20 +0000 (GMT)
Message-ID: <408db836-71bb-c8a9-1631-c5c1213ab746@linux.ibm.com>
Date:   Wed, 15 Dec 2021 21:34:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v6 01/17] ima: Add IMA namespace support
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
 <20211210194736.1538863-2-stefanb@linux.ibm.com>
 <004908152121f617497a71ce3602a70cb25d5a38.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <004908152121f617497a71ce3602a70cb25d5a38.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K6TIjk4NMo-aZCXqWWOoT5-b74k5vinC
X-Proofpoint-ORIG-GUID: krDa1Z_C72NeUhxas4h-xChy7QGph_DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/15/21 16:10, Mimi Zohar wrote:
> Hi Stefan,
>
> On Fri, 2021-12-10 at 14:47 -0500, Stefan Berger wrote:
>> Implement an IMA namespace data structure that gets created alongside a
>> user namespace with CLONE_NEWUSER. This lays down the foundation for
>> namespacing the different aspects of IMA (eg. IMA-audit, IMA-measurement,
>> IMA-appraisal).
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Suggested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Thanks, this patch set is looking a lot better.  Hopefully it isn't
> premature for generic comments:
>
> - With the SPDX line, the license info should be removed.

Removed the references to GPL.


>
> thanks,
>
> Mimi
>
