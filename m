Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D9B3E162F
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbhHEN7Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 09:59:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241235AbhHEN7T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 09:59:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175DZ8FV064903;
        Thu, 5 Aug 2021 09:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zSZ9A2qcFRPam56xDZE8mujmitp004celpm398/q/7I=;
 b=rzRak7c3fKoH3xeFmBNSrvPZqHW+yuqL5V7247G9bLPr+O7pW69vwyhX2Wd858NW7txg
 qYCNjC1hDRlzNW66cX7V7XTnGd5UcvOEJDQ/tINBln241hnljKuu8DSrNoquXQEiBF71
 kVuQos3NVbxgCEzxuqnCNYIiqWaB6YAY3SDOsZegjMTPhPXg5WyolPizSov/v9LLhbbW
 xChKbgUu2gNunG4g1TRzcJGRwnzNqG9mTwojmmXODBy3vfTtrXNfKnyMyXj624NmFjNj
 CEMQJLtnzP2Mp7FacBRWLkOQiZEXK7Jjf6EUItxPSOg6UehGdqKwJpzMZ+B05kHFt9Ej cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a897nn5xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 09:58:28 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175Do0NF136780;
        Thu, 5 Aug 2021 09:58:27 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a897nn5w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 09:58:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175Dvt5c013733;
        Thu, 5 Aug 2021 13:58:25 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3a4x58t5k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 13:58:24 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175DwMdK57016762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 13:58:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21198A4051;
        Thu,  5 Aug 2021 13:58:22 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44933A406B;
        Thu,  5 Aug 2021 13:58:17 +0000 (GMT)
Received: from sig-9-65-205-127.ibm.com (unknown [9.65.205.127])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 13:58:17 +0000 (GMT)
Message-ID: <6c751dadf4ce7385d0391ea26f1c7e4e910219e0.camel@linux.ibm.com>
Subject: Re: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to
 mok_trusted_keys
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
Date:   Thu, 05 Aug 2021 09:58:16 -0400
In-Reply-To: <20210726171319.3133879-11-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
         <20210726171319.3133879-11-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W7RHB-q0aESJWvL70dKLiJbKZwnmYalX
X-Proofpoint-GUID: WEh5OEXhZCm13AjZALKU6wZPGxDnZwnN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_04:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-07-26 at 13:13 -0400, Eric Snowberg wrote:

> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> index dcaf74102ab2..b27ae30eaadc 100644
> --- a/certs/system_keyring.c
> +++ b/certs/system_keyring.c
> @@ -45,6 +45,15 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
>  				     const union key_payload *payload,
>  				     struct key *restriction_key)
>  {
> +	/* If the secondary trusted keyring is not enabled, we may link
> +	 * through to the mok keyring and the search may follow that link.
> +	 */

Refer to section "8) Commenting" of Documentation/process/coding-
style.rst for the format of multi line comments.

> +	if (mok_trusted_keys && type == &key_type_keyring &&
> +	    dest_keyring == builtin_trusted_keys &&
> +	    payload == &mok_trusted_keys->payload)
> +		/* Allow the mok keyring to be added to the builtin */
> +		return 0;
> +

Unless you're changing the meaning of the restriction, then a new
restriction needs to be defined.  In this case, please don't change the
meaning of restrict_link_by_builtin_trusted().  Instead define a new
restriction named restrict_link_by_builtin_and_ca_trusted().

>  	return restrict_link_by_signature(dest_keyring, type, payload,
>  					  builtin_trusted_keys);
>  }
> @@ -91,6 +100,15 @@ int restrict_link_by_builtin_and_secondary_trusted(
>  		/* Allow the builtin keyring to be added to the secondary */
>  		return 0;
>  
> +	/* If we have a secondary trusted keyring, it may contain a link
> +	 * through to the mok keyring and the search may follow that link.
> +	 */
> +	if (mok_trusted_keys && type == &key_type_keyring &&
> +	    dest_keyring == secondary_trusted_keys &&
> +	    payload == &mok_trusted_keys->payload)
> +		/* Allow the mok keyring to be added to the secondary */
> +		return 0;
> +

Similarly here, please define a new restriction maybe named
restrict_link_by_builtin_secondary_and_ca_trusted().   To avoid code
duplication, the new restriction could be a wrapper around the existing
function.

>  	return restrict_link_by_signature(dest_keyring, type, payload,
>  					  secondary_trusted_keys);
>  }
> @@ -321,5 +339,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
>  void __init set_mok_trusted_keys(struct key *keyring)
>  {
>  	mok_trusted_keys = keyring;
> +
> +	if (key_link(system_trusted_keys, mok_trusted_keys) < 0)
> +		panic("Can't link (mok) trusted keyrings\n");
>  }

From the thread discussion on 00/12:

Only the builtin keys should ever be on the builtin keyring.  The
builtin keyring would need to be linked to the mok keyring.  But in the
secondary keyring case, the mok keyring would be linked to the
secondary keyring, similar to how the builtin keyring is linked to the
secondary keyring.

        if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
                panic("Can't link trusted keyrings\n");


thanks,

Mimi

>  #endif


