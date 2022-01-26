Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9F249D4D4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 23:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiAZWF0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 17:05:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232435AbiAZWF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 17:05:26 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QM3dGK014328;
        Wed, 26 Jan 2022 22:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RxTuE6rmxVpW/vdK1r884JjG3O3+YWBscTGJnKvckXI=;
 b=HUAXz694ayH5nVsmPluXJaOjnzJz2ZpRwoFXpQmOSxpvATbk5QqBnw9xw9hczoQt7N7w
 on80wtOqKSxc287ZJTvoG9SZ7XPjr8ri1eNeg1uZJyRLCab2nIuwPuSt6Hg1AfSzheMS
 3KjRkeY+y9BaHFrC1rHuWEHTMPVJ2sIKDMibQ5hvzDMttS4n8Yv+dv7ga91Hc2ACpOHD
 Puuxjj92iayC+zF3Ly9CQe2sV4euwfqmxhjTlnrL66qyr6T4vPW/O2f5iDx/BT4GQ1Xw
 NYEPqAav5Fa/1y8tID5OTO/CLyoihlqBVa8Op67REeqHz1VHJESultgkXYwrAJCauvY8 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du89mja8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:05:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20QM4C7L016478;
        Wed, 26 Jan 2022 22:05:13 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3du89mja82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:05:13 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20QM27Xe024020;
        Wed, 26 Jan 2022 22:05:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3dr9jc12sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 22:05:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20QM5AxF32244212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 22:05:10 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B8856E050;
        Wed, 26 Jan 2022 22:05:10 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1F436E06D;
        Wed, 26 Jan 2022 22:05:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 22:05:07 +0000 (GMT)
Message-ID: <d64ba364-e3fa-729a-2761-b386326ee276@linux.ibm.com>
Date:   Wed, 26 Jan 2022 17:05:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 15/23] ima: Implement hierarchical processing of file
 accesses
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
 <20220125224645.79319-16-stefanb@linux.vnet.ibm.com>
 <20220126123908.q65wgvr2v52lmxpw@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220126123908.q65wgvr2v52lmxpw@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GXavbc1DSLqYJR2d4JpfnIWijqqJ4DxH
X-Proofpoint-ORIG-GUID: PcRyTm2VOWigvWeJjq8oPa4d08HxmAGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=907
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260128
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/26/22 07:39, Christian Brauner wrote:
>
> That'll break compilation as youre checking:
>
> ns == &init_ima_ns below.
>
> security/integrity/ima/ima_main.c: In function ‘ima_post_read_file’:
> security/integrity/ima/ima_main.c:798:7: error: ‘ns’ undeclared (first use in this function); did you mean ‘insl’?
>    798 |   if (ns == &init_ima_ns &&
>        |       ^~
>        |       insl
> security/integrity/ima/ima_main.c:798:7: note: each undeclared identifier is reported only once for each function it appears in
>
> it's fixed later in the series but you might want to fix this up here as
> well.

Argh. Fixed.

>
> Fwiw, a good strategy is to:
>
> git rebase -i -x "make LOCALVERSION=-imans" v5.16-rc2

I did test it but maybe something distracted me....

while :; do make -j$(nproc) security kernel || break ; git rebase 
--continue || break; done


