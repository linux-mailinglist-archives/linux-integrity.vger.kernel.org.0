Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7953B4344
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 14:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhFYMfL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 08:35:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50268 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230346AbhFYMfK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 08:35:10 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PCHKMQ036463;
        Fri, 25 Jun 2021 08:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QmJW1TEjLltLt3gjE040AZI8l4ZEE20ZP+jcNWMeBtw=;
 b=GzzniETtTqD+QaZktyai9jMDkfr4tPaSxbfit8wofRZnhwrot+XIKY59XdiGBX5VG/t1
 oYFkaJqL1h+oGQ1VByu42w25kUE/9zdAxTz1LcE7bCZgLVQB7N+vJgdpGhxPJ1aY5Ctb
 rw2Z+VPfQTEFfogKQ7LKtwYdQixkJ1Z6SXzKNSxeWcmzK7d1nWbvQvHFzbu8pp//AAmm
 GrTBQo9dGMELD1NPmr7l2uF3CcDThA6cm6uIJQdiuqv5G5g63ngmFii9uzn+vFcUciq7
 3oQo/fYqOaYmK5nI1vL0lbp6Eyjat5n6FoxSHlW0d19qSKE9qv5vbLLUyhrVG6AFNe/c 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39df13ggbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:32:40 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15PCJ2cw042623;
        Fri, 25 Jun 2021 08:32:40 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39df13ggay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 08:32:40 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15PCSnE9012616;
        Fri, 25 Jun 2021 12:32:39 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03wdc.us.ibm.com with ESMTP id 39987a1r5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Jun 2021 12:32:39 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15PCWc6c25493890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 12:32:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E4496A04F;
        Fri, 25 Jun 2021 12:32:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0BD86A054;
        Fri, 25 Jun 2021 12:32:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 25 Jun 2021 12:32:37 +0000 (GMT)
Subject: Re: [PATCH] certs: Redirect openssl error message to null device
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        nayna@linux.ibm.com, jeyu@kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, kernel test robot <lkp@intel.com>
References: <20210625122902.4058783-1-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9e925935-529e-49c9-e499-3eac43bddb66@linux.ibm.com>
Date:   Fri, 25 Jun 2021 08:32:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210625122902.4058783-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mJ_gYx9xhzKLOCBO2vEy_PDzYlCjrdOn
X-Proofpoint-ORIG-GUID: xYF0E2_P0chFY1Pedk_eyxdNimRYAPAs
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-25_04:2021-06-25,2021-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106250069
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/21 8:29 AM, Stefan Berger wrote:

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Address the following issue detected by the kernel test robot when
> there's no certificate file at the time when checking for the type
> of key in the cert:
>
> Can't open certs/signing_key.pem for reading, No such file or directory
>
> The simplest solution is to redirect openssl's stderr output to /dev/null.
>
> Fixes: 28d62d945ded ("certs: Trigger creation of RSA module signing key if it's not an RSA key")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>


Jarkko,

can you please squash this patch into the one it fixes. Unfortunately 
when rebasing you will have to fix the subsequent patch from this merge 
error

ifeq ($(openssl_available),yes)
<<<<<<< HEAD
X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text 
2>/dev/null)
=======
X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
endif
 >>>>>>> 87e968848116 (certs: Add support for using elliptic curve keys 
for signing modules)

to this:


ifeq ($(openssl_available),yes)
X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text 
2>/dev/null)
endif

Thanks.

    Stefan


