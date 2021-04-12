Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7552235CEF5
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Apr 2021 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243494AbhDLQx5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Apr 2021 12:53:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17222 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244698AbhDLQtG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Apr 2021 12:49:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13CGYX1n153949;
        Mon, 12 Apr 2021 12:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=yK3wcz6HfMKRr+Anv1JaZYvMeKi8LZVmm3oJn9Nm67k=;
 b=Mzg4WZ6ps4U6AK9Y4eQAIsOY3JL7iEJhS7hCATAalpARQnpMAUTsTS8FPlQSWXN75u9l
 YBBvArEhnOgFPxzwBpBzD54Rx3EZ3NvAZ1m2uClnz9WvFc6OAJOXCOLKLy4viVhtEL6l
 IrtfGE3WNl0ZMt4/19rXPjJ9viDlmUjHi3E4CKdNHqUuuZnzV/RnZnZaG+Vc9MKL6Xxp
 hI7kNHOOahXigG/yzCRRECUHAqAjTX8vcZYuFCWfuHGn7RoLWoUZb4ZydBi+a3OAzXuv
 Vy1rLpSvtGLwmgj1xWlD9TN7BUEzxxj80mST1srvl+D1IXyYV4Z18wBCYJX/J2kZ+HLV Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtt97y5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 12:48:24 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13CGZGAU160201;
        Mon, 12 Apr 2021 12:48:23 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37vjtt97xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 12:48:23 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13CGlsPB019257;
        Mon, 12 Apr 2021 16:48:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 37u3n9spgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Apr 2021 16:48:23 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13CGmMfo61407758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 16:48:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 086277805C;
        Mon, 12 Apr 2021 16:48:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAFFD7805E;
        Mon, 12 Apr 2021 16:48:19 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.203.222])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 12 Apr 2021 16:48:19 +0000 (GMT)
Message-ID: <adeb7c73d0bb354f04f8117c5ccf6b006dfc15de.camel@linux.ibm.com>
Subject: Re: [PATCH][next] KEYS: trusted: Fix missing null return from
 kzalloc call
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Colin King <colin.king@canonical.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 12 Apr 2021 09:48:18 -0700
In-Reply-To: <20210412160101.1627882-1-colin.king@canonical.com>
References: <20210412160101.1627882-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lwvJeeXsjtjq2GtvbjWudOdZYnX9b8u3
X-Proofpoint-ORIG-GUID: sdwC6w6xF5MD7wQIQbzEaD3PM4KA4XWi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-12_11:2021-04-12,2021-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-04-12 at 17:01 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The kzalloc call can return null with the GFP_KERNEL flag so
> add a null check and exit via a new error exit label. Use the
> same exit error label for another error path too.
> 
> Addresses-Coverity: ("Dereference null return value")
> Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys
> framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/keys/trusted-keys/trusted_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_core.c
> b/security/keys/trusted-keys/trusted_core.c
> index ec3a066a4b42..90774793f0b1 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -116,11 +116,13 @@ static struct trusted_key_payload
> *trusted_payload_alloc(struct key *key)
>  
>  	ret = key_payload_reserve(key, sizeof(*p));
>  	if (ret < 0)
> -		return p;
> +		goto err;
>  	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		goto err;
>  
>  	p->migratable = migratable;
> -
> +err:
>  	return p;

This is clearly a code migration bug in 

commit 251c85bd106099e6f388a89e88e12d14de2c9cda
Author: Sumit Garg <sumit.garg@linaro.org>
Date:   Mon Mar 1 18:41:24 2021 +0530

    KEYS: trusted: Add generic trusted keys framework

Which has for addition to trusted_core.c:

+static struct trusted_key_payload *trusted_payload_alloc(struct key
*key)
+{
+       struct trusted_key_payload *p = NULL;
+       int ret;
+
+       ret = key_payload_reserve(key, sizeof(*p));
+       if (ret < 0)
+               return p;
+       p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+       p->migratable = migratable;
+
+       return p;
+}

And for trusted_tpm1.c:

-static struct trusted_key_payload *trusted_payload_alloc(struct key
*key)
-{
-       struct trusted_key_payload *p = NULL;
-       int ret;
-
-       ret = key_payload_reserve(key, sizeof *p);
-       if (ret < 0)
-               return p;
-       p = kzalloc(sizeof *p, GFP_KERNEL);
-       if (p)
-               p->migratable = 1; /* migratable by default */
-       return p;
-}

The trusted_tpm1.c code was correct and we got this bug introduced by
what should have been a simple cut and paste ... how did that happen? 
And therefore, how safe is the rest of the extraction into
trusted_core.c?

James


