Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC278421A24
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Oct 2021 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbhJDWgA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Oct 2021 18:36:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63016 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234726AbhJDWgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Oct 2021 18:36:00 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194MVFg0005826;
        Mon, 4 Oct 2021 18:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=TLr3NwWbgQROBvXZbzmueJidPfA1Ip5xyTij4H5Yw2A=;
 b=C3ALM5VREsn2XAnClbnPKIRv0LaiX9jDla/yjMSHU1pK+nxf5mxb9kN4ogTn11jZxUQl
 YcDnAjfr3gannyFOLVLBUTIwRhKC/pCRX4YLS8NidTDnuYHpxZT53z5RVm6ctWXM02r3
 ZKvirzd84dMF/QsJjn1vzhVMMY1ox327DgQ+bDx4sf/5zHpQzFCFN3Po4ymHU/SoEa+R
 A/DeaZ12SFbxQ8d1tP7cuCjXMX96Xxpw+VVBmonmh/78cEgPkXcjw78UAM0M1xr277Tl
 yYimaIGsct7qlm7d4tUXzqohw+11OurzKX05hZ7Ju2Ek5QQoM+X8n+XngfmlH8XVmc9x DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgaft81de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:34:04 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 194MY4bU019122;
        Mon, 4 Oct 2021 18:34:04 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgaft81cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 18:34:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 194MMapM023958;
        Mon, 4 Oct 2021 22:34:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3bef29t7m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Oct 2021 22:34:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 194MUvib49283430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Oct 2021 22:30:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF9B042042;
        Mon,  4 Oct 2021 22:30:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656284203F;
        Mon,  4 Oct 2021 22:30:56 +0000 (GMT)
Received: from sig-9-77-130-197.ibm.com (unknown [9.77.130.197])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Oct 2021 22:30:56 +0000 (GMT)
Message-ID: <e6d38bb046c85ecf1eb76ba45b989fd6853c416a.camel@linux.ibm.com>
Subject: Re: [PATCH linux rebase] ima: add gid support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alex Henrie <alexh@vpitech.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it, pvorel@suse.cz, alexhenrie24@gmail.com
Cc:     Curtis Veit <veit@vpieng.com>
Date:   Mon, 04 Oct 2021 18:30:55 -0400
In-Reply-To: <20210909165111.51038-1-alexh@vpitech.com>
References: <20210909165111.51038-1-alexh@vpitech.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dho3GLFOHKF5Nd6XTz5k3DRicLcIWLL1
X-Proofpoint-ORIG-GUID: FyFlaXdYlPXtshAsdkbPs4M0ZcZExl4R
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040148
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-09 at 10:51 -0600, Alex Henrie wrote:
> From: Curtis Veit <veit@vpieng.com>
> 
> IMA currently supports the concept of rules based on uid where the rule
> is based on the uid of the file owner or the uid of the user accessing
> the file. It is useful to have similar rules based on gid. This patch
> provides that ability.
> 
> Signed-off-by: Curtis Veit <veit@vpieng.com>
> Co-developed-by: Alex Henrie <alexh@vpitech.com>
> Signed-off-by: Alex Henrie <alexh@vpitech.com>

Thanks, Alex.  There are a couple of places were the code is
duplicated, except for the indentation.   At least for now, let's keep
the line length at 80 chars.  Similarly, when extending a
comment/documentation, please split the line.

A few minor comments below, otherwise:

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> This is the patch that Curtis sent in 2015,[1] rebased and with support
> for effective GID and the new greater-than and less-than operators.
> Moreover, the policy_opt enum is now in the same order as the
> policy_tokens array, which I'm guessing is the bug that prevented the
> patch from being accepted before.

That sounds right.

> 
> [1] https://sourceforge.net/p/linux-ima/mailman/message/34210250/
> ---
>  Documentation/ABI/testing/ima_policy |   5 +-
>  security/integrity/ima/ima_policy.c  | 197 +++++++++++++++++++++++----
>  2 files changed, 174 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 5c2798534950..f8e5b5598548 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -23,7 +23,7 @@ Description:
>  			  audit | hash | dont_hash
>  		  condition:= base | lsm  [option]
>  			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [uid=]
> -				[euid=] [fowner=] [fsname=]]
> +				[euid=] [gid=] [egid=] [fowner=] [fgroup=] [fsname=]]

Like in other places where you modified the ordering, let's group uid,
euid, git, egid, etc together on the same line.

>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
>  			option:	[[appraise_type=]] [template=] [permit_directio]
> @@ -40,7 +40,10 @@ Description:
>  			fsuuid:= file system UUID (e.g 8bcbe394-4f13-4144-be8e-5aa9ea2ce2f6)
>  			uid:= decimal value
>  			euid:= decimal value
> +			gid:= decimal value
> +			egid:= decimal value
>  			fowner:= decimal value
> +			fgroup:= decimal value
>  		  lsm:  are LSM specific
>  		  option:
>  			appraise_type:= [imasig] [imasig|modsig]
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 87b9b71cb820..0f2287699f85 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -36,6 +36,9 @@
>  #define IMA_KEYRINGS	0x0400
>  #define IMA_LABEL	0x0800
>  #define IMA_VALIDATE_ALGOS	0x1000
> +#define IMA_GID		0x2000
> +#define IMA_EGID	0x4000
> +#define IMA_FGROUP	0x8000

Ok, any additional changes after this will need to increase the "flags"
size.

>  
>  #define UNKNOWN		0
>  #define MEASURE		0x0001	/* same as IMA_MEASURE */
> @@ -78,9 +81,13 @@ struct ima_rule_entry {
>  	unsigned long fsmagic;
>  	uuid_t fsuuid;
>  	kuid_t uid;
> +	kgid_t gid;
>  	kuid_t fowner;
> +	kgid_t fgroup;
>  	bool (*uid_op)(kuid_t, kuid_t);    /* Handlers for operators       */
> +	bool (*gid_op)(kgid_t, kgid_t);
>  	bool (*fowner_op)(kuid_t, kuid_t); /* uid_eq(), uid_gt(), uid_lt() */
> +	bool (*fgroup_op)(kgid_t, kgid_t); /* gid_eq(), gid_gt(), gid_lt() */
>  	int pcr;
>  	unsigned int allowed_algos; /* bitfield of allowed hash algorithms */
>  	struct {
> @@ -104,7 +111,8 @@ static_assert(
>  
>  /*
>   * Without LSM specific knowledge, the default policy can only be
> - * written in terms of .action, .func, .mask, .fsmagic, .uid, and .fowner
> + * written in terms of .action, .func, .mask, .fsmagic, .uid, .gid,
> + * .fowner, and .fgroup
>   */
>  
>  /*
> @@ -582,10 +590,23 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
>  		} else if (!rule->uid_op(cred->euid, rule->uid))
>  			return false;
>  	}
> -
> +	if ((rule->flags & IMA_GID) && !rule->gid_op(rule->gid, cred->gid))
> +		return false;
> +	if (rule->flags & IMA_EGID) {
> +		if (has_capability_noaudit(current, CAP_SETGID)) {
> +			if (!rule->gid_op(cred->egid, rule->gid)
> +			    && !rule->gid_op(cred->sgid, rule->gid)
> +			    && !rule->gid_op(cred->gid, rule->gid))
> +				return false;
> +		} else if (!rule->gid_op(cred->egid, rule->gid))
> +			return false;
> +	}
>  	if ((rule->flags & IMA_FOWNER) &&
>  	    !rule->fowner_op(i_uid_into_mnt(mnt_userns, inode), rule->fowner))
>  		return false;
> +	if ((rule->flags & IMA_FGROUP) &&
> +	    !rule->fgroup_op(i_gid_into_mnt(mnt_userns, inode), rule->fgroup))
> +		return false;
>  	for (i = 0; i < MAX_LSM_RULES; i++) {
>  		int rc = 0;
>  		u32 osid;
> @@ -987,16 +1008,19 @@ void ima_update_policy(void)
>  }
>  
>  /* Keep the enumeration in sync with the policy_tokens! */
> -enum {
> +enum policy_opt {
>  	Opt_measure, Opt_dont_measure,
>  	Opt_appraise, Opt_dont_appraise,
>  	Opt_audit, Opt_hash, Opt_dont_hash,
>  	Opt_obj_user, Opt_obj_role, Opt_obj_type,
>  	Opt_subj_user, Opt_subj_role, Opt_subj_type,
> -	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname,
> -	Opt_fsuuid, Opt_uid_eq, Opt_euid_eq, Opt_fowner_eq,
> -	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
> -	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
> +	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
> +	Opt_uid_eq, Opt_euid_eq, Opt_gid_eq, Opt_egid_eq,
> +	Opt_fowner_eq, Opt_fgroup_eq,
> +	Opt_uid_gt, Opt_euid_gt, Opt_gid_gt, Opt_egid_gt,
> +	Opt_fowner_gt, Opt_fgroup_gt,
> +	Opt_uid_lt, Opt_euid_lt, Opt_gid_lt, Opt_egid_lt,
> +	Opt_fowner_lt, Opt_fgroup_lt,
>  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
>  	Opt_label, Opt_err
> @@ -1023,13 +1047,22 @@ static const match_table_t policy_tokens = {
>  	{Opt_fsuuid, "fsuuid=%s"},
>  	{Opt_uid_eq, "uid=%s"},
>  	{Opt_euid_eq, "euid=%s"},
> +	{Opt_gid_eq, "gid=%s"},
> +	{Opt_egid_eq, "egid=%s"},
>  	{Opt_fowner_eq, "fowner=%s"},
> +	{Opt_fgroup_eq, "fgroup=%s"},
>  	{Opt_uid_gt, "uid>%s"},
>  	{Opt_euid_gt, "euid>%s"},
> +	{Opt_gid_gt, "gid>%s"},
> +	{Opt_egid_gt, "egid>%s"},
>  	{Opt_fowner_gt, "fowner>%s"},
> +	{Opt_fgroup_gt, "fgroup>%s"},
>  	{Opt_uid_lt, "uid<%s"},
>  	{Opt_euid_lt, "euid<%s"},
> +	{Opt_gid_lt, "gid<%s"},
> +	{Opt_egid_lt, "egid<%s"},
>  	{Opt_fowner_lt, "fowner<%s"},
> +	{Opt_fgroup_lt, "fgroup<%s"},
>  	{Opt_appraise_type, "appraise_type=%s"},
>  	{Opt_appraise_flag, "appraise_flag=%s"},
>  	{Opt_appraise_algos, "appraise_algos=%s"},
> @@ -1073,22 +1106,36 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
>  }
>  
>  static void ima_log_string_op(struct audit_buffer *ab, char *key, char *value,
> -			      bool (*rule_operator)(kuid_t, kuid_t))
> +			      enum policy_opt rule_operator)
>  {
>  	if (!ab)
>  		return;
>  
> -	if (rule_operator == &uid_gt)
> +	switch (rule_operator) {
> +	case Opt_uid_gt:
> +	case Opt_euid_gt:
> +	case Opt_gid_gt:
> +	case Opt_egid_gt:
> +	case Opt_fowner_gt:
> +	case Opt_fgroup_gt:
>  		audit_log_format(ab, "%s>", key);
> -	else if (rule_operator == &uid_lt)
> +		break;
> +	case Opt_uid_lt:
> +	case Opt_euid_lt:
> +	case Opt_gid_lt:
> +	case Opt_egid_lt:
> +	case Opt_fowner_lt:
> +	case Opt_fgroup_lt:
>  		audit_log_format(ab, "%s<", key);
> -	else
> +		break;
> +	default:
>  		audit_log_format(ab, "%s=", key);
> +	}
>  	audit_log_format(ab, "%s ", value);
>  }
>  static void ima_log_string(struct audit_buffer *ab, char *key, char *value)
>  {
> -	ima_log_string_op(ab, key, value, NULL);
> +	ima_log_string_op(ab, key, value, Opt_err);
>  }
>  
>  /*
> @@ -1163,7 +1210,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
>  				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
>  				     IMA_INMASK | IMA_EUID | IMA_PCR |
> -				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> +				     IMA_FSNAME | IMA_GID | IMA_EGID |
> +				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>  				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS))
>  			return false;
>  
> @@ -1174,7 +1222,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
>  				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
>  				     IMA_INMASK | IMA_EUID | IMA_PCR |
> -				     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> +				     IMA_FSNAME | IMA_GID | IMA_EGID |
> +				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
>  				     IMA_PERMIT_DIRECTIO | IMA_MODSIG_ALLOWED |
>  				     IMA_CHECK_BLACKLIST | IMA_VALIDATE_ALGOS))
>  			return false;
> @@ -1186,7 +1235,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  
>  		if (entry->flags & ~(IMA_FUNC | IMA_FSMAGIC | IMA_UID |
>  				     IMA_FOWNER | IMA_FSUUID | IMA_EUID |
> -				     IMA_PCR | IMA_FSNAME))
> +				     IMA_PCR | IMA_FSNAME | IMA_GID | IMA_EGID |
> +				     IMA_FGROUP))
>  			return false;
>  
>  		break;
> @@ -1195,7 +1245,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  			return false;
>  
>  		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> -				     IMA_KEYRINGS))
> +				     IMA_KEYRINGS | IMA_GID))
>  			return false;
>  
>  		if (ima_rule_contains_lsm_cond(entry))
> @@ -1207,7 +1257,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  			return false;
>  
>  		if (entry->flags & ~(IMA_FUNC | IMA_UID | IMA_PCR |
> -				     IMA_LABEL))
> +				     IMA_LABEL | IMA_GID))

How about moving IMA_GID after IMA_UID?

>  			return false;
>  
>  		if (ima_rule_contains_lsm_cond(entry))
> @@ -1276,7 +1326,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	struct audit_buffer *ab;
>  	char *from;
>  	char *p;
> -	bool uid_token;
> +	bool eid_token;

Took a moment to understand the reason for this change.   Adding a
comment on the line, like "either euid or egid" might have helped.  

>  	struct ima_template_desc *template_desc;
>  	int result = 0;
>  
> @@ -1284,9 +1334,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				       AUDIT_INTEGRITY_POLICY_RULE);
>  
>  	entry->uid = INVALID_UID;
> +	entry->gid = INVALID_GID;
>  	entry->fowner = INVALID_UID;
> +	entry->fgroup = INVALID_GID;
>  	entry->uid_op = &uid_eq;
> +	entry->gid_op = &gid_eq;
>  	entry->fowner_op = &uid_eq;
> +	entry->fgroup_op = &gid_eq;
>  	entry->action = UNKNOWN;
>  	while ((p = strsep(&rule, " \t")) != NULL) {
>  		substring_t args[MAX_OPT_ARGS];
> @@ -1504,12 +1558,12 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			fallthrough;
>  		case Opt_uid_eq:
>  		case Opt_euid_eq:
> -			uid_token = (token == Opt_uid_eq) ||
> -				    (token == Opt_uid_gt) ||
> -				    (token == Opt_uid_lt);
> +			eid_token = (token == Opt_euid_eq) ||
> +				    (token == Opt_euid_gt) ||
> +				    (token == Opt_euid_lt);
>  
> -			ima_log_string_op(ab, uid_token ? "uid" : "euid",
> -					  args[0].from, entry->uid_op);
> +			ima_log_string_op(ab, eid_token ? "euid" : "uid",
> +					  args[0].from, token);
>  
>  			if (uid_valid(entry->uid)) {
>  				result = -EINVAL;
> @@ -1524,8 +1578,41 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				    (uid_t)lnum != lnum)
>  					result = -EINVAL;
>  				else
> -					entry->flags |= uid_token
> -					    ? IMA_UID : IMA_EUID;
> +					entry->flags |= eid_token
> +					    ? IMA_EUID : IMA_UID;
> +			}
> +			break;
> +		case Opt_gid_gt:
> +		case Opt_egid_gt:
> +			entry->gid_op = &gid_gt;
> +			fallthrough;
> +		case Opt_gid_lt:
> +		case Opt_egid_lt:
> +			if ((token == Opt_gid_lt) || (token == Opt_egid_lt))
> +				entry->gid_op = &gid_lt;
> +			fallthrough;
> +		case Opt_gid_eq:
> +		case Opt_egid_eq:
> +			eid_token = (token == Opt_egid_eq) ||
> +				    (token == Opt_egid_gt) ||
> +				    (token == Opt_egid_lt);
> +
> +			ima_log_string_op(ab, eid_token ? "egid" : "gid",
> +					  args[0].from, token);
> +
> +			if (gid_valid(entry->gid)) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			result = kstrtoul(args[0].from, 10, &lnum);
> +			if (!result) {
> +				entry->gid = make_kgid(current_user_ns(), (gid_t)lnum);
> +				if (!gid_valid(entry->gid) || (((gid_t)lnum) != lnum))

Example of where the indentation changes from original "uid" code.

> +					result = -EINVAL;
> +				else
> +					entry->flags |= eid_token
> +					    ? IMA_EGID : IMA_GID;
>  			}
>  			break;
>  		case Opt_fowner_gt:
> @@ -1536,8 +1623,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				entry->fowner_op = &uid_lt;
>  			fallthrough;
>  		case Opt_fowner_eq:
> -			ima_log_string_op(ab, "fowner", args[0].from,
> -					  entry->fowner_op);
> +			ima_log_string_op(ab, "fowner", args[0].from, token);
>  
>  			if (uid_valid(entry->fowner)) {
>  				result = -EINVAL;
> @@ -1553,6 +1639,30 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  					entry->flags |= IMA_FOWNER;
>  			}
>  			break;
> +		case Opt_fgroup_gt:
> +			entry->fgroup_op = &gid_gt;
> +			fallthrough;
> +		case Opt_fgroup_lt:
> +			if (token == Opt_fgroup_lt)
> +				entry->fgroup_op = &gid_lt;
> +			fallthrough;
> +		case Opt_fgroup_eq:
> +			ima_log_string_op(ab, "fgroup", args[0].from, token);
> +
> +			if (gid_valid(entry->fgroup)) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
> +			result = kstrtoul(args[0].from, 10, &lnum);
> +			if (!result) {
> +				entry->fgroup = make_kgid(current_user_ns(), (gid_t)lnum);
> +				if (!gid_valid(entry->fgroup) || (((gid_t)lnum) != lnum))

and here

> +					result = -EINVAL;
> +				else
> +					entry->flags |= IMA_FGROUP;
> +			}
> +			break;
>  		case Opt_obj_user:
>  			ima_log_string(ab, "obj_user", args[0].from);
>  			result = ima_lsm_rule_init(entry, args,

