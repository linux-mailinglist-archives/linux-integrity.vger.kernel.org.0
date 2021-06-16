Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8D3A9E13
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Jun 2021 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhFPOwP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Jun 2021 10:52:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233860AbhFPOwP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Jun 2021 10:52:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GEXvAv102419;
        Wed, 16 Jun 2021 10:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=RElFdgSY77nr0Utu1Y6/9iGT+LtUqAaKRmmtV7ITfqA=;
 b=TC8bEpRkyETnAb7odA7Xv6QYQrnTwKGG5xNxtvlOwp6pTwnDZbwY48oflqzXq6wG/BA0
 mQybuRZE/B3OQvp/3HSO6vvwPbOqGH/J1T+J0GYR2gZ6VgW/RxWgisD2eTc+C7sjT4Uv
 JuJPpB4495bwDQsQIoNNeCZAgtam6tRVqXah3K0aBZJ4AWpRrqn/B/QKL7jbfpBcd7gW
 JsbihkNNM859EouwSMrJXrUh2SV3oQ6rAke0zdNpLEhRakCJRPJLoNiLrxeITvnE0n1U
 PWvlArrLlngxChXIUylMw/Sfkij0Uj3ijDK2t0r/Aqnuqt1C4UEbrMWKp5WE1K/52w74 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 397jgdthvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:49:58 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15GEY2gX102853;
        Wed, 16 Jun 2021 10:49:57 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 397jgdthum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:49:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GEmDhw009167;
        Wed, 16 Jun 2021 14:49:56 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 394mja19s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:49:56 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEnt5T28377586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:49:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418FA78063;
        Wed, 16 Jun 2021 14:49:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81EEE7805F;
        Wed, 16 Jun 2021 14:49:53 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.195.26])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:49:53 +0000 (GMT)
Message-ID: <80e5b6d5ef4472bd1490dc5ddf3175cfcc119418.camel@linux.ibm.com>
Subject: Re: [PATCH] tpm2_load_command leaks memory
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Dhiraj Shah <find.dhiraj@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Jun 2021 07:49:52 -0700
In-Reply-To: <20210610094952.17068-1-find.dhiraj@gmail.com>
References: <20210610094952.17068-1-find.dhiraj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DQ_0n7PBr1GupPpu9zzHNx615qJeAUhn
X-Proofpoint-ORIG-GUID: _azK9oY0wczHwaCgyLpT5Zn2arFFRKrt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-06-10 at 10:49 +0100, Dhiraj Shah wrote:
> tpm2_key_decode allocates memory which is stored in blob and it's not
> freed.
> 
> Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
> ---
>  security/keys/trusted-keys/trusted_tpm2.c | 41 +++++++++++++++----
> ----
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c
> b/security/keys/trusted-keys/trusted_tpm2.c
> index 0165da386289..52dd43bb8cdb 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -378,22 +378,31 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	}
>  
>  	/* new format carries keyhandle but old format doesn't */
> -	if (!options->keyhandle)
> -		return -EINVAL;
> +	if (!options->keyhandle) {
> +		rc = -EINVAL;
> +		goto err;
> +	}

This one is unnecessary ... for the old format there's nothing to free.

>  	/* must be big enough for at least the two be16 size counts */
> -	if (payload->blob_len < 4)
> -		return -EINVAL;
> +	if (payload->blob_len < 4) {
> +		rc = -EINVAL;
> +		goto err;
> +	}
>  
>  	private_len = get_unaligned_be16(blob);
>  
>  	/* must be big enough for following public_len */
> -	if (private_len + 2 + 2 > (payload->blob_len))
> -		return -E2BIG;
> +	if (private_len + 2 + 2 > (payload->blob_len)) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
>  	public_len = get_unaligned_be16(blob + 2 + private_len);
> -	if (private_len + 2 + public_len + 2 > payload->blob_len)
> -		return -E2BIG;
> +
> +	if (private_len + 2 + public_len + 2 > payload->blob_len) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
>  	pub = blob + 2 + private_len + 2;
>  	/* key attributes are always at offset 4 */
> @@ -406,13 +415,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		payload->migratable = 1;
>  
>  	blob_len = private_len + public_len + 4;
> -	if (blob_len > payload->blob_len)
> -		return -E2BIG;
>  
> -	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> -	if (rc)
> -		return rc;
> +	if (blob_len > payload->blob_len) {
> +		rc = -E2BIG;
> +		goto err;
> +	}
>  
> +	if (tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD) != 0)

You didn't compile this, did you?  There's no opening brace here ...

James


