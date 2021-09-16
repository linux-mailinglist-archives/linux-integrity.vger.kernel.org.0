Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C040EB51
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Sep 2021 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbhIPUG7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 16:06:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233356AbhIPUG7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 16:06:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK0i4u018920;
        Thu, 16 Sep 2021 16:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=I8WeDmPI0MEkPVFIH6T9tJ6ZkkfSB2x0+8T7Nri6nTs=;
 b=YbHttMVptamkis3i2eSBpHlkflBgiGbF4IpmhOE1E2IR9nzI9fB+/v4FU3wJzgdT3Eey
 n+RQxvUJ7+V0lw84Rhd6ysfuXB+9DSPHRKNOodjFtdXICSgJgHToGcTnsJaygfXH8HQd
 LpsW4ogmqNMFO9juQ7YGJVhDMFRX7MsGd5/9wcem7Fuj9DG1ABve58sZ2BiUZWjPoU/N
 FboYx8bnM4MptPOALQw7daPMbbvl/EJCtne5ExgKOxdOylIKNU2M8A4ZrlhTCdFgBBke
 bd63hrVJKENQOuRdQJ0WQr+oyUKPzpBYIBUbacO0Hy/TB5MBW6Y+p+OodtRkBTez7bUy tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b48psnea4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 16:05:12 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18GK1HTu023304;
        Thu, 16 Sep 2021 16:05:08 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b48psne8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 16:05:08 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18GJwBJh021984;
        Thu, 16 Sep 2021 20:05:05 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3b0m3cxvy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 20:05:05 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18GK53Jc39453040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 20:05:03 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD39E6E06C;
        Thu, 16 Sep 2021 20:05:03 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A44C6E079;
        Thu, 16 Sep 2021 20:05:02 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.163.30.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 20:05:02 +0000 (GMT)
Subject: Re: [PATCH v6 03/13] KEYS: CA link restriction
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
 <20210914211416.34096-4-eric.snowberg@oracle.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <d3d8a1ce-a982-2662-28f6-3c06cb679d5f@linux.vnet.ibm.com>
Date:   Thu, 16 Sep 2021 16:05:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210914211416.34096-4-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8XXxDtkcikJYvbvBEOythfdkGkYX1Zys
X-Proofpoint-ORIG-GUID: Vehnqpk729pJQxbKMrLp6UJ6qaIbxbfZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/14/21 5:14 PM, Eric Snowberg wrote:
> Add a new link restriction.  Restrict the addition of keys in a keyring
> based on the key to be added being a CA (self-signed).

A self-signed cert can be a root CA cert or a code-signing cert. The way 
to differentiate a CA cert is by checking BasicConstraints CA:TRUE and 
keyUsage:keyCertSign. Refer to Section Basic Constraints and Key Usage 
in the document - https://datatracker.ietf.org/doc/html/rfc5280.

Thanks & Regards,

      - Nayna

