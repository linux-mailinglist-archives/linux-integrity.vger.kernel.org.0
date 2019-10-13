Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1DE8D53D7
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Oct 2019 04:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfJMC6D (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Oct 2019 22:58:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727184AbfJMC6C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Oct 2019 22:58:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9D2qNDd024016
        for <linux-integrity@vger.kernel.org>; Sat, 12 Oct 2019 22:58:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vktr71610-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 12 Oct 2019 22:58:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 13 Oct 2019 03:57:58 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 13 Oct 2019 03:57:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9D2vNta40370532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 02:57:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 816DE42042;
        Sun, 13 Oct 2019 02:57:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B82D4203F;
        Sun, 13 Oct 2019 02:57:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.192.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 13 Oct 2019 02:57:52 +0000 (GMT)
Subject: Re: [PATCH v0 2/2] KEYS: LSM Hook for key_create_or_update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, sashal@kernel.org,
        jamorris@linux.microsoft.com, kgoldman@us.ibm.com,
        mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Date:   Sat, 12 Oct 2019 22:57:52 -0400
In-Reply-To: <20191011173547.3200-3-nramas@linux.microsoft.com>
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
         <20191011173547.3200-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101302-0020-0000-0000-000003789052
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101302-0021-0000-0000-000021CEA489
Message-Id: <1570935472.5250.124.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910130028
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-10-11 at 10:35 -0700, Lakshmi Ramasubramanian wrote:
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 764f4c57913e..973dfead490c 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -14,6 +14,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/random.h>
>  #include <linux/err.h>
> +#include <keys/system_keyring.h>
>  #include "internal.h"
>  
>  struct kmem_cache *key_jar;
> @@ -823,6 +824,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  	key_ref_t key_ref;
>  	int ret;
>  	struct key_restriction *restrict_link = NULL;
> +	bool trusted_keyring = false;
>  
>  	/* look up the key type to see if it's one of the registered kernel
>  	 * types */
> @@ -936,6 +938,16 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	/* let the security module know about the key */
> +	trusted_keyring = is_builtin_or_secondary_trusted_keyring(keyring);

Nothing should be added to the keys subsystem, other than the LSM
hook.

Mimi

> +	ret = security_key_create_or_update(keyring, key, cred, flags,
> +					    trusted_keyring);
> +	if (ret < 0) {
> +		key_put(key);
> +		key_ref = ERR_PTR(ret);
> +		goto error_link_end;
> +	}
> +

