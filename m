Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5955E33CE2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2019 03:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfFDBwL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 21:52:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfFDBwL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 21:52:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x541pp9x001076
        for <linux-integrity@vger.kernel.org>; Mon, 3 Jun 2019 21:52:10 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swef5hx90-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jun 2019 21:52:10 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 4 Jun 2019 02:52:08 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 02:52:06 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x541q5Lp60621030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 01:52:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2279DA405B;
        Tue,  4 Jun 2019 01:52:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272A1A405F;
        Tue,  4 Jun 2019 01:52:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.133])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 01:52:03 +0000 (GMT)
Subject: Re: [PATCH V3] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <mjg59@google.com>
Date:   Mon, 03 Jun 2019 21:51:53 -0400
In-Reply-To: <20190603201322.7443-1-matthewgarrett@google.com>
References: <20190603201322.7443-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19060401-0028-0000-0000-00000374ADB0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060401-0029-0000-0000-0000243482FE
Message-Id: <1559613113.3956.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040009
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-03 at 13:13 -0700, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Updated based on review feedback, verified that I can generate an event
> log that contains multiple different templates.
> 
>  Documentation/ABI/testing/ima_policy  |  6 ++++--
>  security/integrity/ima/ima.h          | 13 +++++++++----
>  security/integrity/ima/ima_api.c      | 24 ++++++++++++++++-------
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/ima/ima_init.c     |  2 +-
>  security/integrity/ima/ima_main.c     |  9 +++++----
>  security/integrity/ima/ima_policy.c   | 28 +++++++++++++++++++++++++--
>  security/integrity/ima/ima_template.c | 10 ++++++++--
>  8 files changed, 71 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index 74c6702de74e..4ded0668a22d 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -24,8 +24,7 @@ Description:
>  				[euid=] [fowner=] [fsname=]]
>  			lsm:	[[subj_user=] [subj_role=] [subj_type=]
>  				 [obj_user=] [obj_role=] [obj_type=]]
> -			option:	[[appraise_type=]] [permit_directio]
> -
> +			option:	[[appraise_type=]] [template=] [permit_directio]
>  		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
>  				[FIRMWARE_CHECK]
>  				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
> @@ -38,6 +37,9 @@ Description:
>  			fowner:= decimal value
>  		lsm:  	are LSM specific
>  		option:	appraise_type:= [imasig]
> +			template:= name or format of a defined IMA template
> +			type (eg,ima-ng or d-ng|n-ng). Only valid when action
> +			is "measure".

This patch only supports specifying the template name, not the
template format description.  Please remove "d-ng|n-ng".

>  			pcr:= decimal value
> 
>  		default policy:

<snip>

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 0f6fe53cef09..cbae2a3a9c5b 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -80,6 +80,7 @@ struct ima_rule_entry {
>  		int type;	/* audit type */
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
> +	struct ima_template_desc *template;
>  };
> 
>  /*
> @@ -397,6 +398,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
> + * @template_desc: the template that should be used for this rule
>   *
>   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>   * conditions.
> @@ -406,7 +408,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * than writes so ima_match_policy() is classical RCU candidate.
>   */
>  int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
> -		     enum ima_hooks func, int mask, int flags, int *pcr)
> +		     enum ima_hooks func, int mask, int flags, int *pcr,
> +		     struct ima_template_desc **template_desc)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -438,6 +441,11 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		if ((pcr) && (entry->flags & IMA_PCR))
>  			*pcr = entry->pcr;
> 
> +		if (template_desc && entry->template)
> +			*template_desc = entry->template;
> +		else
> +			*template_desc = ima_template_desc_current();
> +

This code is finding the template format, but is subsequently being
replaced with the current description.  One way of fixing this, is by
initializing the template_desc before walking the list.

Mimi

>  		if (!actmask)
>  			break;
>  	}
> @@ -676,7 +684,7 @@ enum {
>  	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
>  	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
>  	Opt_appraise_type, Opt_permit_directio,
> -	Opt_pcr, Opt_err
> +	Opt_pcr, Opt_template, Opt_err
>  };
> 

