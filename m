Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80DD405C03
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbhIIR1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Sep 2021 13:27:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241332AbhIIR1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Sep 2021 13:27:38 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189H2kKl056795;
        Thu, 9 Sep 2021 13:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=lkzpx1Tn5acnD+EXNOoAfCaAc3jKeDS5YG+LLNQ9m1g=;
 b=HYXQrEgqpMgJDlu8pmGGcwOJJkcsonjOqpFpjahq3ervorr34Vi6L60chLRSkwS4zu08
 7ljpSGzuFi5IRZUi8OC0CMpCWkh+UYawBy5p21gnwW9uOfrSnOSy7sLYkXqXE/PdYyLf
 4dmutXLL+5o8eJB7NP2ezCzMr0idME6m5EcBi5ijSMbCiREI4RQcRcePyrurxJgdCBX5
 AUwc39fNvJFoVGjonTaPCtzdA2iYIoO9BFDlhiHWYTztPfp9Hu19di/2Yf5wqEmOpH9K
 1eaqOg784e+aNMDaHUFJSB4NvwuvSzQzuswt3ZcziALowU+8uW5T0LxFsuGdh9KSxHaL Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aymu9tve8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:26:08 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 189HGvmE136511;
        Thu, 9 Sep 2021 13:26:07 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aymu9tvcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 13:26:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 189HNV8x029025;
        Thu, 9 Sep 2021 17:26:04 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ayfv2wv05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 17:26:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 189HQ2pZ52560160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Sep 2021 17:26:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F1C4A405C;
        Thu,  9 Sep 2021 17:26:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77A8AA405B;
        Thu,  9 Sep 2021 17:25:57 +0000 (GMT)
Received: from sig-9-65-72-231.ibm.com (unknown [9.65.72.231])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Sep 2021 17:25:57 +0000 (GMT)
Message-ID: <c5d8d846cd03a97344700f8ce4f038cdc3e3b8fd.camel@linux.ibm.com>
Subject: Re: [PATCH v5 04/12] integrity: restrict INTEGRITY_KEYRING_MACHINE
 to restrict_link_by_ca
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 09 Sep 2021 13:25:56 -0400
In-Reply-To: <20210907160110.2699645-5-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
         <20210907160110.2699645-5-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hf4ARJoNwkPG4FqevaTM8ylFDiRu77J6
X-Proofpoint-GUID: 05MiVjz0dLkr1TJhs_lx_If7lMhv2QtJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_06:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-09-07 at 12:01 -0400, Eric Snowberg wrote:
> Set the restriction check for INTEGRITY_KEYRING_MACHINE keys to
> restrict_link_by_ca.  This will only allow CA keys into the machine
> keyring.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Normally the new function, in this case the restriction, and usage
should be defined together.  Any reason why 3/12 and 4/12 are two
separate patches?  I would squash them together.

> ---
> v1: Initial version
> v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
>     keyring gets created even when it isn't enabled
> v3: Rename restrict_link_by_system_trusted_or_ca to restrict_link_by_ca
> v4: removed unnecessary restriction->check set
> v5: Rename to machine keyring
> ---
>  security/integrity/digsig.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 5a75ac2c4dbe..2b75bbbd9e0e 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -132,14 +132,18 @@ int __init integrity_init_keyring(const unsigned int id)
>  		goto out;
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
> +	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id != INTEGRITY_KEYRING_MACHINE)

Over 80 chars, please split the line.

thanks,

Mimi

>  		return 0;
>  
>  	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
>  	if (!restriction)
>  		return -ENOMEM;
>  
> -	restriction->check = restrict_link_to_ima;
> +	if (id == INTEGRITY_KEYRING_MACHINE)
> +		restriction->check = restrict_link_by_ca;
> +	else
> +		restriction->check = restrict_link_to_ima;
> +
>  	if (id != INTEGRITY_KEYRING_MACHINE)
>  		perm |= KEY_USR_WRITE;
>  


