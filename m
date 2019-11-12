Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C9DF968E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKLRF0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Nov 2019 12:05:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727298AbfKLRF0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Nov 2019 12:05:26 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACH28xq040109
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w7yx3svk5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2019 12:05:24 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 12 Nov 2019 17:05:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 17:05:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACH5H5J59441202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 17:05:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B294B4C044;
        Tue, 12 Nov 2019 17:05:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AD624C050;
        Tue, 12 Nov 2019 17:05:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.252])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 17:05:16 +0000 (GMT)
Subject: Re: [PATCH v5 04/10] IMA: Updated IMA policy functions to return
 keyrings option read from the policy
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Nov 2019 12:05:16 -0500
In-Reply-To: <20191111193303.12781-5-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
         <20191111193303.12781-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111217-0028-0000-0000-000003B64CE5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111217-0029-0000-0000-000024795188
Message-Id: <1573578316.17949.43.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-11-11 at 11:32 -0800, Lakshmi Ramasubramanian wrote:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 1aee3c8b9cf6..d1889eee9287 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -481,6 +481,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC)
>   * @pcr: set the pcr to extend
>   * @template_desc: the template that should be used for this rule
> + * @keyrings: set the keyrings for this rule, if specified
>   *
>   * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
>   * conditions.
> @@ -491,7 +492,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
>   */
>  int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		     enum ima_hooks func, int mask, int flags, int *pcr,
> -		     struct ima_template_desc **template_desc)
> +		     struct ima_template_desc **template_desc,
> +		     char **keyrings)
>  {
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
> @@ -527,6 +529,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  		if ((pcr) && (entry->flags & IMA_PCR))
>  			*pcr = entry->pcr;
>  
> +		if ((keyrings) && (entry->flags & IMA_KEYRINGS))
> +			*keyrings = entry->keyrings;

ima_match_rules() determines whether the rule is in policy or not. It
returns true on rule match, false on failure.  There's no need to
return the list of keyrings.

Mimi 

> +
>  		if (template_desc && entry->template)
>  			*template_desc = entry->template;
>  

