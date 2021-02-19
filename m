Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFB031FB83
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhBSPAN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 10:00:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229498AbhBSPAL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 10:00:11 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JEXBNf046343;
        Fri, 19 Feb 2021 09:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DmjTMspybTAP0gLH018aBzVAdBBAVLNG8P4fmWI/iCo=;
 b=AI6N8PGwkswNFf0P5iMjAUt+Rpc3AlYlKpcJZJjL4AnmeIopLtB6sFGPTWmKWFWuHMSb
 wLkTLnQYkI8RIMb/7MgmC67kb8zOmf3xbK8x4bgaO4XM7b4b72oYWnxrZ3y5hobDRFkN
 hf6n1bdVYKOAeyNKOV3iJb+Pb2bNk7v1TpgOvRpLzi8HjMJXs1E6m9Vy9WDDZJormEGW
 oYs5d/rBO4Lc0UnjyAiHFo4RMjomWndHzmK6WHKMJ0A5ZIUu2pQvfG98OfGFiq4157hG
 SQuIkRo34r7IT2lYVjhXrDjYoXvGpGCMkTLoWp3+yfBV8D9RatEaFGs5hFd4l1dJ7QsE dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tf488u05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:59:27 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JEXdfJ047284;
        Fri, 19 Feb 2021 09:59:22 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36tf488ttv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 09:59:21 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JEpo8e007086;
        Fri, 19 Feb 2021 14:59:09 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 36p6d9x4s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:59:09 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JEx9QW22151452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 14:59:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E59A12405B;
        Fri, 19 Feb 2021 14:59:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EF00124053;
        Fri, 19 Feb 2021 14:59:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 14:59:08 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] ima: enable loading of build time generated key on
 .ima keyring
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210218220011.67625-1-nayna@linux.ibm.com>
 <20210218220011.67625-6-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c53a186b-23ca-f27d-44f3-e8b308886ea8@linux.ibm.com>
Date:   Fri, 19 Feb 2021 09:59:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210218220011.67625-6-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_05:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/18/21 5:00 PM, Nayna Jain wrote:
> The kernel currently only loads the kernel module signing key onto
> the builtin trusted keyring. To support IMA, load the module signing
> key selectively either onto the builtin or IMA keyring based on MODULE_SIG
> or MODULE_APPRAISE_MODSIG config respectively; and loads the CA kernel
> key onto the builtin trusted keyring.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


