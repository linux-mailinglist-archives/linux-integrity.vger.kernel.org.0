Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6F7471A7
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jul 2023 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGDMqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jul 2023 08:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjGDMqr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jul 2023 08:46:47 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1DBE70;
        Tue,  4 Jul 2023 05:46:45 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364CPDFt023929;
        Tue, 4 Jul 2023 12:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Wvq4/iEMLm0I57rx1aHSX3v1isqR4ueWDPZ+oNYDkZ4=;
 b=BlCLvpVqc24BnjcJnJ6rsHqRJN+H+NaBWrihOKXsixSjI4D+2SxowUfkr2oIwS4Y1KxZ
 iSqwsSMdarLlmVVU727Tr1ENXS7/6bWecQas+6XCRtdT066HcIS9kkuIW7gyEApbIlh7
 fxlaWtOcsrUg9aY2v3H7z4QBKvrlXIy/o1s3Xvqzn9MDTa8MPb8qpdD4hTSjV+qmyibH
 WNa3bqG2FbbzQ3OzjnwQ/GgMKWkHd+lm1Gu5oJaZIHKH4UnLqIxo9EBEH/Ct8RPIxv1U
 1YxTGtE60C+MlHemUAk+XWfOn0ogsvtXGTiXStk2LHOrK7DyAqjw4TDDWIl3VM5fhufO Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmkddrms0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:46:21 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364CRloc001207;
        Tue, 4 Jul 2023 12:46:20 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmkddrmqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:46:19 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 364BWMM3002592;
        Tue, 4 Jul 2023 12:30:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rjbs5q7wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 12:30:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 364CUelT54264096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jul 2023 12:30:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EC9558056;
        Tue,  4 Jul 2023 12:30:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C62E058061;
        Tue,  4 Jul 2023 12:30:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.36.177])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jul 2023 12:30:39 +0000 (GMT)
Message-ID: <559d380a557c2ee210c808481a1cb92e5afe6c61.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Always reference the blacklist keyring with
 apprasial
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Tue, 04 Jul 2023 08:30:39 -0400
In-Reply-To: <20230630165712.909767-1-eric.snowberg@oracle.com>
References: <20230630165712.909767-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5CPN8vXMmEdVFjXRHpbiSuqjNRSpJbTa
X-Proofpoint-GUID: Hhg_tfacabCa3tQHCKjQ9xNWqCuQSytg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_07,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Fri, 2023-06-30 at 12:57 -0400, Eric Snowberg wrote:
> Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
> modsig") introduced an appraise_flag option for referencing the blacklist
> keyring.  Any matching binary found on this keyring fails signature
> validation. This flag only works with module appended signatures.

Prior to the above change, keys could be revoked.  Finer granularity
was added based on file hash to block loading a specific kexec kernel
image on powerpc.

My concern back then with making this generic was scalability and
performance.

> An important part of a PKI infrastructure is to have the ability to do
> revocation at a later time should a vulnerability be found.  Expand the
> revocation flag usage to all appraisal functions. The flag is now
> enabled by default. Setting the flag with an IMA policy has been
> deprecated. Without a revocation capability like this in place, only
> authenticity can be maintained. With this change, integrity can now be
> achieved with digital signature based IMA appraisal.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Agreed, support for finer revocaton granularity based on file hash is
needed.

> ---
>  Documentation/ABI/testing/ima_policy  |  6 +++---
>  security/integrity/ima/ima_appraise.c | 12 +++++++-----
>  security/integrity/ima/ima_policy.c   | 10 +++++-----
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 49db0ff288e5..a712c396f6e9 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -57,9 +57,9 @@ Description:
>  				stored in security.ima xattr. Requires
>  				specifying "digest_type=verity" first.)
>  
> -			appraise_flag:= [check_blacklist]
> -			Currently, blacklist check is only for files signed with appended
> -			signature.
> +			appraise_flag:= [check_blacklist] (deprecated)
> +			Setting the check_blacklist flag is no longer necessary.
> +			All apprasial functions set it by default.
>  			digest_type:= verity
>  			    Require fs-verity's file digest instead of the
>  			    regular IMA file hash.
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 491c1aca0b1c..870dde67707b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>  		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
>  
>  		rc = is_binary_blacklisted(digest, digestsize);
> -		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> -			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> -						   "blacklisted-hash", NONE,
> -						   pcr, NULL, false, NULL, 0);
> -	}
> +	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
> +		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
> +
> +	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
> +		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
> +					   "blacklisted-hash", NONE,
> +					   pcr, NULL, false, NULL, 0);
>  
>  	return rc;
>  }
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 3ca8b7348c2e..71e270141101 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1279,7 +1279,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  				     IMA_FSNAME | IMA_GID | IMA_EGID |
>  				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>  				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
> -				     IMA_VERITY_REQUIRED))
> +				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
>  			return false;
>  
>  		break;
> @@ -1354,7 +1354,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  
>  	/* Ensure that combinations of flags are compatible with each other */
>  	if (entry->flags & IMA_CHECK_BLACKLIST &&
> -	    !(entry->flags & IMA_MODSIG_ALLOWED))
> +	    !(entry->flags & IMA_DIGSIG_REQUIRED))
>  		return false;
>  
>  	/*
> @@ -1802,11 +1802,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				if (entry->flags & IMA_VERITY_REQUIRED)
>  					result = -EINVAL;
>  				else
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>  			} else if (strcmp(args[0].from, "sigv3") == 0) {
>  				/* Only fsverity supports sigv3 for now */
>  				if (entry->flags & IMA_VERITY_REQUIRED)
> -					entry->flags |= IMA_DIGSIG_REQUIRED;
> +					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
>  				else
>  					result = -EINVAL;
>  			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> @@ -1815,7 +1815,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  					result = -EINVAL;
>  				else
>  					entry->flags |= IMA_DIGSIG_REQUIRED |
> -						IMA_MODSIG_ALLOWED;
> +						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
>  			} else {
>  				result = -EINVAL;
>  			}

Please update the "case Opt_appraise_flag:" and remove "appraise_flag="
in the powerpc arch specific policy rules.

-- 
thanks,

Mimi

