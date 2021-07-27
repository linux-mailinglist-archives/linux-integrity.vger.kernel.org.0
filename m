Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F29C3D7ADF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhG0QYZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:24:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229569AbhG0QYZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:24:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RGEcYv002816;
        Tue, 27 Jul 2021 12:24:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=FiF7bl34zwGeiIjUjVFkuWKyvTGUJznO3t1PTaV6vwc=;
 b=I7ydFbSnPc5UeVVCy+A+3jW81qkPgZtCWR4LrF3wIhV6M6rRmkuq/cfKY9u9yAsG7Fuj
 o1dK5kUSgnAjFRj9Nh5Lgtc+jAxTdZ2R/KBhNbKjUAsF07UYtBtADefxXT3o4vmEqdtn
 Ptz7e3s804ebyYRzrpUqteAR4HiryKdXAwJjymtH5tWdOoTi2BqmX+HzmzGkR1Rh0WHr
 0GKoi5jkpG3Bsk9EjTKhcLeofF928SDBzUwhte9Mv4v1NAs77UGDFvL9qEE+8nmTQsIR
 RgZA1IO3HhBNPh5VJSjKvI479SX9eN3q8rTB+KLEpVyOeVZm3O8YHOfvXQ9kK+QYf6ui 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2ng60au5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 12:24:24 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RGEqIr003405;
        Tue, 27 Jul 2021 12:24:24 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2ng60at7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 12:24:23 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RGIM4V013619;
        Tue, 27 Jul 2021 16:24:21 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 3a235krbp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:24:20 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RGOI0h28246278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 16:24:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F39611C054;
        Tue, 27 Jul 2021 16:24:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 719D211C04A;
        Tue, 27 Jul 2021 16:24:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 16:24:17 +0000 (GMT)
Message-ID: <bd785a9d0c029cec34514d306e110bdef945c13e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 12:24:16 -0400
In-Reply-To: <20210727102307.552052-4-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
         <20210727102307.552052-4-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1P2mVrY71wTGf7mJ-_NFPzsr_m0oxWW6
X-Proofpoint-GUID: 4YfSAE5tsYIeZLaPpV2U1LNFphssCtWC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 10:23 +0000, THOBY Simon wrote:
> This patch defines a new IMA policy rule option "appraise_hash=",
> that restricts the hash algorithms accepted for the extended attribute
> security.ima when appraising.

"Define ..."

> When a policy rule uses the 'appraise_hash' option, appraisal of a
> file referenced by that rule will now fail if the digest algorithm
> employed to hash the file was not one of those explicitly listed
> in the option. In its absence, any hash algorithm compiled in the
> kernel will be accepted.
> 
> For example, on a system where SELinux is properly deployed, the rule
>   appraise func=BPRM_CHECK obj_type=iptables_exec_t appraise_hash=sha256,sha384
> will block the execution of iptables if the xattr security.ima of its
> executables were not hashed with either sha256 or sha384.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  Documentation/ABI/testing/ima_policy |  6 ++-
>  security/integrity/ima/ima_policy.c  | 72 ++++++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 070779e8d836..365e4c91719e 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -27,7 +27,7 @@ Description:
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> -				[appraise_flag=] [keyrings=]
> +				[appraise_flag=] [keyrings=] [appraise_hash=]

Nit:
Probably nicer to keep the "appraise_" options together.  How about
placing it after "appraise_flag", instead of at the end.

>  		  base:
>  			func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  			        [FIRMWARE_CHECK]
> @@ -55,6 +55,10 @@ Description:
>  			label:= [selinux]|[kernel_info]|[data_label]
>  			data_label:= a unique string used for grouping and limiting critical data.
>  			For example, "selinux" to measure critical data for SELinux.
> +			appraise_hash:= comma-separated list of hash algorithms
> +			For example, "sha256,sha512" to only accept to appraise
> +			files where the security.ima xattr was hashed with one
> +			of these two algorithms.
>  
>  		  default policy:
>  			# PROC_SUPER_MAGIC
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 344b5b0dc1a1..a7f110cbbff0 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -92,6 +92,7 @@ struct ima_rule_entry {
>  	struct ima_template_desc *template;
>  };
>  
> +

Is this extra blank line intentional?

>  /*
>   * sanity check in case the kernels gains more hash algorithms that can
>   * fit in an unsigned int
> @@ -962,7 +963,7 @@ enum {
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>  	Opt_appraise_type, Opt_appraise_flag,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_label, Opt_appraise_hash, Opt_err

Nit: move Opt_appraise_hash after Opt_appraise_type.
>  };
>  
>  static const match_table_t policy_tokens = {
> @@ -1000,6 +1001,7 @@ static const match_table_t policy_tokens = {
>  	{Opt_template, "template=%s"},
>  	{Opt_keyrings, "keyrings=%s"},
>  	{Opt_label, "label=%s"},
> +	{Opt_appraise_hash, "appraise_hash=%s"},

ditto

>  	{Opt_err, NULL}
>  };
>  
> @@ -1125,7 +1127,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
>  				     IMA_INMASK | IMA_EUID | IMA_PCR |
>  				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> -				     IMA_PERMIT_DIRECTIO))
> +				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_HASH))
>  			return false;
>  
>  		break;
> @@ -1137,7 +1139,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  				     IMA_INMASK | IMA_EUID | IMA_PCR |
>  				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
>  				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
> -				     IMA_CHECK_BLACKLIST))
> +				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_HASH))
>  			return false;
>  
>  		break;
> @@ -1187,6 +1189,27 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  	return true;
>  }
>  
> +static unsigned int ima_parse_appraise_hash(char *arg)
> +{
> +	unsigned int res = 0;
> +	char *token;
> +
> +	while ((token = strsep(&arg, ",")) != NULL) {
> +		int idx = match_string(hash_algo_name, HASH_ALGO__LAST, token);

Move the variable definition to the beginning of the function.
> +
> +		if (idx < 0) {
> +			pr_err("unknown hash algorithm \"%s\", ignoring",
> +			       token);
> +			continue;
> +		}
> +
> +		/* Add the hash algorithm to the 'allowed' bitfield */
> +		res |= (1U << idx);
> +	}
> +
> +	return res;
> +}
> +
>  static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  {
>  	struct audit_buffer *ab;
> @@ -1204,6 +1227,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	entry->uid_op = &uid_eq;
>  	entry->fowner_op = &uid_eq;
>  	entry->action = UNKNOWN;
> +	entry->allowed_hashes = 0;
>  	while ((p = strsep(&rule, " \t")) != NULL) {
>  		substring_t args[MAX_OPT_ARGS];
>  		int token;
> @@ -1556,6 +1580,23 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  						 &(template_desc->fields),
>  						 &(template_desc->num_fields));
>  			entry->template = template_desc;
> +			break;
> +		case Opt_appraise_hash:

ditto

"appraise_hash=" should be limited to appraise rules.  Please update
ima_validate_rule().

thanks,

Mimi

> +			ima_log_string(ab, "appraise_hash", args[0].from);
> +
> +			if (entry->allowed_hashes) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			entry->allowed_hashes = ima_parse_appraise_hash(args[0].from);
> +			if (!entry->allowed_hashes) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			entry->flags |= IMA_VALIDATE_HASH;
> +
>  			break;
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
> 
<trim>

