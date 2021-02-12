Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5031A6F0
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 22:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBLVeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 16:34:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBLVeg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 16:34:36 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CLVg6V103242;
        Fri, 12 Feb 2021 16:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5p6ZBUC00sXClQHiQSDglDNizhDSoZxipEWEEINbfNw=;
 b=dYA9G+Og+LXeSdAwcspVRopRWHhvuFkCoB7RHOwiLwc2KSoX7gU5HWiutFZ/gTrfSsgR
 2ycvuuRCtoNolZRZwYh5QRtNS0ELsFNz9Gn1jNadwqCz4OBMetLJ2nxB+YN4xc5/rmqO
 cVfGp3uVmyizIuwcgjC8tzmc8jp0FUOK/xT6xAOsfiDZl3NtCdGOelc6+RNMxhB9H9pp
 54ctPgCnT+qsckIuXvwPGnBMPemyKdWXQ+RD0CKLJ6DnmfUU2byqLcDbl9mJ16aQwg9O
 jZ+lhnDgY6aQXqCjd4k1g471LFgtvZFkNlsAej2ka0VaItruynZZ2s7T8pBBglXDHuES Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36p1mq82k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 16:33:53 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11CLWwPr109665;
        Fri, 12 Feb 2021 16:33:53 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36p1mq82jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 16:33:53 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CLWPav027327;
        Fri, 12 Feb 2021 21:33:52 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 36hjrav4x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 21:33:52 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CLXoCJ13435266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 21:33:50 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 645387805F;
        Fri, 12 Feb 2021 21:33:50 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EECC67805E;
        Fri, 12 Feb 2021 21:33:48 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.160.81.209])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 21:33:48 +0000 (GMT)
Subject: Re: [PATCH 1/5] keys: cleanup build time module signing keys
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
References: <20210211195435.135582-1-nayna@linux.ibm.com>
 <20210211195435.135582-2-nayna@linux.ibm.com>
 <0f5c8c18-2a53-d3c4-e252-44aaee76a9e6@linux.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <48b93c21-594b-2598-2fbc-bbb56fc1b277@linux.vnet.ibm.com>
Date:   Fri, 12 Feb 2021 16:33:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <0f5c8c18-2a53-d3c4-e252-44aaee76a9e6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_09:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120156
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/11/21 4:57 PM, Stefan Berger wrote:
> On 2/11/21 2:54 PM, Nayna Jain wrote:
>> The "mrproper" target is still looking for build time generated keys
>> in the old path instead of certs/ directory.
>> This patch fixes the path as well removes the names of the files which
>> are no longer generated.
>>
>> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
>> Fixes: 28a68f828266 ("modsign: Use single PEM file for autogenerated 
>> key")
> I was curious about some of the files and how they were created in the
> past but couldn't see it in the hostory of the Makefile. The above
> Fixes tag seems to give the wrong commit id:
>
>
> commit 28a68f828266754c2bd64b87873e8099e3f8fe0c
>
> Author: Dave Airlie <airlied@redhat.com>
> Date:   Thu Oct 29 13:59:45 2020 +1000
>
>     drm/radeon/ttm: use multihop
>

Thanks Stefan for noticing it. I will fix this in v2.

Thanks & Regards,

        - Nayna

