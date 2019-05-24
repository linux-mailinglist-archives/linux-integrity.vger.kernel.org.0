Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6E0298F6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 15:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391359AbfEXNcD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 09:32:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391124AbfEXNcD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 09:32:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4ODU2Kh127991
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 09:32:02 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sphj0036r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 09:32:02 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 May 2019 14:32:00 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 14:31:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4ODVuGQ41877722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 13:31:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FF39A404D;
        Fri, 24 May 2019 13:31:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92050A4059;
        Fri, 24 May 2019 13:31:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.111.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 13:31:55 +0000 (GMT)
Subject: Re: [PATCH V2] IMA: Allow profiles to define the desired IMA
 template
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, prsriva02@gmail.com,
        bauerman@linux.ibm.com, roberto.sassu@huawei.com,
        Matthew Garrett <mjg59@google.com>
In-Reply-To: <20190523181827.207274-1-matthewgarrett@google.com>
References: <20190523181827.207274-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 24 May 2019 09:31:20 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052413-0008-0000-0000-000002E9FF1E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052413-0009-0000-0000-00002256C1FF
Message-Id: <1558704680.3977.15.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240091
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Matthew,

On Thu, 2019-05-23 at 11:18 -0700, Matthew Garrett wrote:
> Admins may wish to log different measurements using different IMA
> templates. Add support for overriding the default template on a per-rule
> basis.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> Rebased on next-integrity without relying on any other patches.

Thank you.

<snip>

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..f23069d9e43d 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -174,7 +174,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  {
>  	struct inode *inode = file_inode(file);
>  	struct integrity_iint_cache *iint = NULL;
> -	struct ima_template_desc *template_desc;
> +	struct ima_template_desc *template_desc = NULL;
>  	char *pathbuf = NULL;
>  	char filename[NAME_MAX];
>  	const char *pathname = NULL;
> @@ -192,7 +192,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	 * bitmask based on the appraise/audit/measurement policy.
>  	 * Included is the appraise submask.
>  	 */
> -	action = ima_get_action(inode, cred, secid, mask, func, &pcr);
> +	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
> +				&template_desc);
>  	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
>  			   (ima_policy_flag & IMA_MEASURE));
>  	if (!action && !violation_check)
> @@ -275,7 +276,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  		goto out_locked;
>  	}
> 
> -	template_desc = ima_template_desc_current();
> +	if (!template_desc)
> +		template_desc = ima_template_desc_current();
> +
>  	if ((action & IMA_APPRAISE_SUBMASK) ||
>  		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
>  		/* read 'security.ima' */


Once you have "template_desc", it somehow needs to be passed to
ima_store_measurement() and on to ima_alloc_init_template().


> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 0f6fe53cef09..643490f9f0ad 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c

< snip >

> @@ -1058,6 +1066,16 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			else
>  				entry->flags |= IMA_PCR;
> 
> +			break;
> +		case Opt_template:
> +			ima_log_string(ab, "template", args[0].from);
> +			template_desc = lookup_template_desc(args[0].from);
> +			if (!template_desc) {
> +				result = -EINVAL;
> +			} else {
> +				entry->template = template_desc;
> +				entry->flags |= IMA_TEMPLATE;
> +			}
>  			break;

The "template" option is only relevant to measurement.  Please make
sure that the policy rule action is for "MEASURE".  The documentation
should reflect that as well.

Mimi


>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
> 

