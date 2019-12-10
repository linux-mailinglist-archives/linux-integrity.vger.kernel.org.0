Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A84119E47
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2019 23:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfLJWnf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Dec 2019 17:43:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727265AbfLJWnf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 17:43:35 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBAMbYL8131460
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:43:33 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt12snyq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2019 17:43:33 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 10 Dec 2019 22:43:31 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Dec 2019 22:43:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBAMhRWD44826810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Dec 2019 22:43:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26DD24C06F;
        Tue, 10 Dec 2019 22:43:27 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E7D94C066;
        Tue, 10 Dec 2019 22:43:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.214.111])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Dec 2019 22:43:25 +0000 (GMT)
Subject: Re: [PATCH v10 5/6] IMA: Add support to limit measuring keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 10 Dec 2019 17:43:25 -0500
In-Reply-To: <20191204224131.3384-6-nramas@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
         <20191204224131.3384-6-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121022-0008-0000-0000-0000033F9B18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121022-0009-0000-0000-00004A5ECDF0
Message-Id: <1576017805.4579.44.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-10_07:2019-12-10,2019-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912100186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-12-04 at 14:41 -0800, Lakshmi Ramasubramanian wrote:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 1525a28fd705..5db990c8b02d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -356,6 +357,51 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>  	return NOTIFY_OK;
>  }
>  
> +/**
> + * ima_match_keyring - determine whether the keyring matches the measure rule
> + * @rule: a pointer to a rule
> + * @keyring: name of the keyring to match against the measure rule
> + * @cred: a pointer to a credentials structure for user validation
> + *
> + * Returns true if keyring matches one in the rule, false otherwise.
> + */
> +static bool ima_match_keyring(struct ima_rule_entry *rule,
> +			      const char *keyring, const struct cred *cred)
> +{
> +	char *keyrings, *next_keyring, *keyrings_ptr;
> +	bool matched = false;
> +
> +	/* If "keyrings=" is not specified all keys are measured. */

With the addiitonal "uid" support this isn't necessarily true any
more.

Mimi

> +	if (!rule->keyrings)
> +		return true;
> +
> +	if (!keyring)
> +		return false;
> +
> +	if ((rule->flags & IMA_UID) && !rule->uid_op(cred->uid, rule->uid))
> +		return false;
> +
> +	keyrings = kstrdup(rule->keyrings, GFP_KERNEL);
> +	if (!keyrings)
> +		return false;
> +
> +	/*
> +	 * "keyrings=" is specified in the policy in the format below:
> +	 * keyrings=.builtin_trusted_keys|.ima|.evm
> +	 */
> +	keyrings_ptr = keyrings;
> +	while ((next_keyring = strsep(&keyrings_ptr, "|")) != NULL) {
> +		if (!strcmp(next_keyring, keyring)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +
> +	kfree(keyrings);
> +
> +	return matched;
> +}
> +

