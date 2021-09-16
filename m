Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B087340EB4C
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Sep 2021 22:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhIPUGj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Sep 2021 16:06:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233356AbhIPUGi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Sep 2021 16:06:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18GJxfNN008737;
        Thu, 16 Sep 2021 16:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W35Zz43sd/RpCqOKOqIIhpbRZIipqpXwOFqClt7MSS0=;
 b=h4GCypqdY9FsjURrrgyJ843a0uEnLG/n9xSVmz8VbyC6ECp8i0wm2A/UpRHqRSV0QTmO
 nqBh2okEkZ4Qh9A8zS/HG8wbhCYlrvBVRlJW34zmlAHdd/EpP6bBWFfOMeepTMqUZ4jc
 0tAtBde/NTU4f6syAR0ojHdGpk75UaSxNc6bA5pcfTIBNqQxxt7QYXf+BOFXTRDoNY4e
 N8xAi2fHVSeHl6VHUEc8DNYWjKIAq4klowAfaUmBxOP14ffoaGHlYjNa8JWp4VuW9eQk
 Rsc3UTlF1k8GBG8rxGNPMhGaF5D1n7vxBm0LrS7pCPNWVqtCBNFwlxTjupmTDVp9Oasa DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b4cjt83ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 16:04:39 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18GK37Bm027877;
        Thu, 16 Sep 2021 16:04:38 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b4cjt83c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 16:04:38 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18GJuwfw017386;
        Thu, 16 Sep 2021 20:04:37 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3b0m3cu3e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Sep 2021 20:04:37 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18GK3ZS126870182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 20:03:36 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D316E04E;
        Thu, 16 Sep 2021 20:03:35 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54FB6E06B;
        Thu, 16 Sep 2021 20:03:33 +0000 (GMT)
Received: from li-4b5937cc-25c4-11b2-a85c-cea3a66903e4.ibm.com (unknown [9.163.30.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Sep 2021 20:03:33 +0000 (GMT)
Subject: Re: [PATCH v6 00/13] Enroll kernel keys thru MOK
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
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <7e83a42f-22ff-350a-2017-d286b1b1b02c@linux.vnet.ibm.com>
Date:   Thu, 16 Sep 2021 16:03:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rg5R7nksQBZWN4hyZSmIXKlsCRZ5B095
X-Proofpoint-ORIG-GUID: k0Jb_UTROZz-utKMJzXNVr1vpX5Ptjv3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/14/21 5:14 PM, Eric Snowberg wrote:
> Back in 2013 Linus requested a feature to allow end-users to have the
> ability "to add their own keys and sign modules they trust". This was
> his *second* order outlined here [1]. There have been many attempts
> over the years to solve this problem, all have been rejected.  Many
> of the failed attempts loaded all preboot firmware keys into the kernel,
> including the Secure Boot keys. Many distributions carry one of these
> rejected attempts [2], [3], [4]. This series tries to solve this problem
> with a solution that takes into account all the problems brought up in
> the previous attempts.
>
> On UEFI based systems, this series introduces a new Linux kernel keyring
> containing the Machine Owner Keys (MOK) called machine. It also defines
> a new MOK variable in shim. This variable allows the end-user to decide
> if they want to load MOK keys into the machine keyring. Mimi has suggested
> that only CA keys contained within the MOK be loaded into the machine
> keyring. All other certs will load into the platform keyring instead.
>
> By default, nothing changes; MOK keys are not loaded into the machine
> keyring.  They are only loaded after the end-user makes the decision
> themselves.  The end-user would set this through mokutil using a new
> --trust-mok option [5]. This would work similar to how the kernel uses
> MOK variables to enable/disable signature validation as well as use/ignore
> the db. Any kernel operation that uses either the builtin or secondary
> trusted keys as a trust source shall also reference the new machine
> keyring as a trust source.
>
> Secure Boot keys will never be loaded into the machine keyring.  They
> will always be loaded into the platform keyring.  If an end-user wanted
> to load one, they would need to enroll it into the MOK.
>
> Steps required by the end user:
>
> Sign kernel module with user created key:
> $ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 \
>     machine_signing_key.priv machine_signing_key.x509 my_module.ko
>
> Import the key into the MOK
> $ mokutil --import machine_signing_key.x509
>
> Setup the kernel to load MOK keys into the .machine keyring
> $ mokutil --trust-mok
>
> Then reboot, the MokManager will load and ask if you want to trust the
> MOK key and enroll the MOK into the MOKList.  Afterwards the signed kernel
> module will load.

machine_signing_key.x509 appears to be a code-signing, self-signed key.  
It's not a CA key, but the intent of the patchset is to load only CA 
keys to .machine keyring.

Shouldn't there be two steps: one to load the CA key into MOK, and a 
second one to load the code-signing key which is signed by this CA ?

Thanks & Regards,

       - Nayna

