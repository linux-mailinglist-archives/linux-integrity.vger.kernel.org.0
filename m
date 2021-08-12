Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFF23EAB3C
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhHLTrR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 15:47:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229601AbhHLTrR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 15:47:17 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CJg770073156;
        Thu, 12 Aug 2021 15:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+b7f8kmyAbEAYIPfbVpueDbEOKVt9EAqfwZVIomWLBs=;
 b=SQbXn9B9a5MiZQGrKoZMT/zWEPAlL5MXC/2k20PvJjujcKWFdKSiZf/g2PLAnP5cWubP
 I/NDYojcGnYGpEhIS8f8apDZEhgLzr7ZpO9mAWphVpqOaGCybeYIHSQVr5AJOod1zhX1
 ChFMFaty27s99dMGkhN2ZEDU3rze+XZi80OolEIr2/w2UA0u99H2FKe4E0wlJI+wDjzL
 Qi/nt5qWv14d8ODKr2Q4YknleALToB80XjVVJ8N/lIsV11ievfuMBRMoD60CNKyJ07M0
 CRJC/LERiVTOtY2/+tULIRxTG2Cbyp2zFh3yBqth2bNIpgw46Th/gwowuwHWYwLAuNOi kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ad4hxt5n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:46:17 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17CJgIxR076407;
        Thu, 12 Aug 2021 15:46:17 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ad4hxt5me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 15:46:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CJc5L3017821;
        Thu, 12 Aug 2021 19:46:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3acn76afb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 19:46:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CJkCMe48890112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 19:46:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7484442052;
        Thu, 12 Aug 2021 19:46:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9752242047;
        Thu, 12 Aug 2021 19:46:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.76.214])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 19:46:06 +0000 (GMT)
Message-ID: <58e6e03b69b8fadfb854669086020c633837be88.camel@linux.ibm.com>
Subject: Re: [PATCH v3 10/14] KEYS: change link restriction for secondary to
 also trust mok
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
        glin@suse.com, konrad.wilk@oracle.com
Date:   Thu, 12 Aug 2021 15:46:05 -0400
In-Reply-To: <20210812021855.3083178-11-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
         <20210812021855.3083178-11-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4vvybyiNZxsZ3JHqLfIuYe8NXFawec5W
X-Proofpoint-GUID: p2xhzbzAUj0ugUT-yhXXK5xGCmJBi_tE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_06:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Wed, 2021-08-11 at 22:18 -0400, Eric Snowberg wrote:
> With the introduction of the mok keyring, the end-user may choose to
> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
> trust them, the .mok keyring will contain these keys.  If not, the mok
> keyring will always be empty.  Update the restriction check to allow the
> secondary trusted keyring to also trust mok keys.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
> v3: Initial version
> ---
>  certs/system_keyring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index cb773e09ea67..8cc19a1ff051 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -110,7 +110,7 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
>  	if (!restriction)
>  		panic("Can't allocate secondary trusted keyring restriction\n");
>  
> -	restriction->check = restrict_link_by_builtin_and_secondary_trusted;
> +	restriction->check = restrict_link_by_builtin_secondary_and_ca_trusted;
>  
>  	return restriction;
>  }

Not everyone needs to build a generic kernel, like the distros.  As
previously discussed, not everyone is willing to trust the new MOK
keyring nor the UEFI variable for enabling it.  For those environments,
they should be able to totally disable the MOK keyring.

Please define a Kconfig similar to "CONFIG_SECONDARY_TRUSTED_KEYRING"
for MOK.  The "restriction" would be based on the new Kconfig being
enabled.

thanks,

Mimi

