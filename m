Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F7A3C28F3
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGISVm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 14:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19528 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhGISVm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 14:21:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169I3WeW019644;
        Fri, 9 Jul 2021 14:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cFcgBIMjRZFExSLu1MOUcIIL2PdkFtlHRsVx5aIYk4A=;
 b=Ze1+9MfImnDYfZOS6IQLTqz/XdEFFRTzGg9ECjwZwQ6lF7G1zBDhLlzgLuduRQ292Wph
 3GI07EUNXvHX+A5fgDLtdhTlGfj8ibM+hy/CtIm1IKvsTXn84BKL6wOW6Ettxz7E6dIN
 dBZCBNLuqyStkgbEeb08XfGZQStVqe6+dLdFEE4PE3f00GJAVxH0qjdSbgzoT/2GBr8P
 +GGGX12JVAgiuBr6nm/7ntCABMjPmMC6RKDYKPtqqFJ7kAX0923yWTuWPzRGug7I0Sgn
 1ZsyellWfMqBeJ9/vVb0GpABEei9erAKJfAftW6aYIRVxtyyEtnfZhPNIloCJJ4Y7XF/ 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p1yctjna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 14:18:52 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 169I6dDi030341;
        Fri, 9 Jul 2021 14:18:52 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39p1yctjn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 14:18:52 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 169HvGOq010236;
        Fri, 9 Jul 2021 18:18:51 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 39jfhdqn5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 18:18:51 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 169IIpjJ40042774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jul 2021 18:18:51 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 419DB112062;
        Fri,  9 Jul 2021 18:18:51 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31442112061;
        Fri,  9 Jul 2021 18:18:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jul 2021 18:18:51 +0000 (GMT)
Subject: Re: [PATCH v2] char: tpm: vtpm_proxy: Fix race in init
To:     Saubhik Mukherjee <saubhik.mukherjee@gmail.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, andrianov@ispras.ru
References: <20210708095259.27915-1-saubhik.mukherjee@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <86011d11-522d-a686-b360-43d19366cab7@linux.ibm.com>
Date:   Fri, 9 Jul 2021 14:18:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210708095259.27915-1-saubhik.mukherjee@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vOZgn4vSeRLUVMMW_qNnd3QKtwH8SYls
X-Proofpoint-ORIG-GUID: qr1nPttsjHrQNoZNJCTYs43asoNwpa3h
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_12:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107090088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/8/21 5:52 AM, Saubhik Mukherjee wrote:
> vtpm_module_init calls vtpmx_init which calls misc_register. The file
> operations callbacks are registered. So, vtpmx_fops_ioctl can execute in
> parallel with rest of vtpm_module_init. vtpmx_fops_ioctl calls
> vtpmx_ioc_new_dev, which calls vtpm_proxy_create_device, which calls
> vtpm_proxy_work_start, which could read uninitialized workqueue.
>
> To avoid this, create workqueue before vtpmx init.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Fixes: 6f99612e2500 ("tpm: Proxy driver for supporting multiple emulated TPMs")
> Signed-off-by: Saubhik Mukherjee <saubhik.mukherjee@gmail.com>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>


