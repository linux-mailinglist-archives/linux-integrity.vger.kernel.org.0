Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48B923DCAA
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Aug 2020 18:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgHFQyq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 Aug 2020 12:54:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52960 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729111AbgHFQym (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 Aug 2020 12:54:42 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076FVtLN001663;
        Thu, 6 Aug 2020 11:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/6OwY2FMLYMMfilDKDbdLEaroXYly6ajpHy06tH7vzE=;
 b=NFp7G9kd2x96lc9KEZiGdkoiJtZVPUeCg+siGa9Rvr+HnY3ZwjZHVOiTfqDwgSCPW+Tc
 iBDfRXr0claVrFidVYxv7V2IYQzOQwBVk4nGtfYZYPN5PqB3+pk+VMlJ0chbURrLir9W
 1hgjui5lwxXaXhU+Ye7jMRSajeC8rMDRlotc7FrkXP1qwAwvsH/dbKvBKSfZjpEc+/J9
 GmEGWO4h5GI2Bgi+3kjgnQ1ycjz5i/zbYiF1M7Jncc+PMyFW1a0l6vOEd2d0+rLCUlDb
 UD2Ou4iJP+c3h7K4bcLdfqya0iBR0RxJd5IivrCFQIXoQduwt0WcXW5+HrqmSDhZWj8i OA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32repgumnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 11:34:48 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 076FWxK7005324;
        Thu, 6 Aug 2020 11:34:48 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32repgumn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 11:34:48 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076FYC00010222;
        Thu, 6 Aug 2020 15:34:47 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 32n018jgks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 15:34:47 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076FYkDv60096866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 15:34:46 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1999C605B;
        Thu,  6 Aug 2020 15:34:45 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F259C6055;
        Thu,  6 Aug 2020 15:34:44 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.68.187])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 Aug 2020 15:34:43 +0000 (GMT)
Subject: Re: [PATCH 1/2] ima: Pre-parse the list of keyrings in a KEY_CHECK
 rule
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200727140831.64251-1-tyhicks@linux.microsoft.com>
 <20200727140831.64251-2-tyhicks@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <8f749594-1214-9f2d-4614-d360772a2ab6@linux.vnet.ibm.com>
Date:   Thu, 6 Aug 2020 11:34:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727140831.64251-2-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_12:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/27/20 10:08 AM, Tyler Hicks wrote:
> The ima_keyrings buffer was used as a work buffer for strsep()-based
> parsing of the "keyrings=" option of an IMA policy rule. This parsing
> was re-performed each time an asymmetric key was added to a kernel
> keyring for each loaded policy rule that contained a "keyrings=" option.
>
> An example rule specifying this option is:
>
>   measure func=KEY_CHECK keyrings=a|b|c
>
> The rule says to measure asymmetric keys added to any of the kernel
> keyrings named "a", "b", or "c". The size of the buffer size was
> equal to the size of the largest "keyrings=" value seen in a previously
> loaded rule (5 + 1 for the NUL-terminator in the previous example) and
> the buffer was pre-allocated at the time of policy load.
>
> The pre-allocated buffer approach suffered from a couple bugs:
>
> 1) There was no locking around the use of the buffer so concurrent key
>     add operations, to two different keyrings, would result in the
>     strsep() loop of ima_match_keyring() to modify the buffer at the same
>     time. This resulted in unexpected results from ima_match_keyring()
>     and, therefore, could cause unintended keys to be measured or keys to
>     not be measured when IMA policy intended for them to be measured.
>
> 2) If the kstrdup() that initialized entry->keyrings in ima_parse_rule()
>     failed, the ima_keyrings buffer was freed and set to NULL even when a
>     valid KEY_CHECK rule was previously loaded. The next KEY_CHECK event
>     would trigger a call to strcpy() with a NULL destination pointer and
>     crash the kernel.
>
> Remove the need for a pre-allocated global buffer by parsing the list of
> keyrings in a KEY_CHECK rule at the time of policy load. The
> ima_rule_entry will contain an array of string pointers which point to
> the name of each keyring specified in the rule. No string processing
> needs to happen at the time of asymmetric key add so iterating through
> the list and doing a string comparison is all that's required at the
> time of policy check.
>
> In the process of changing how the "keyrings=" policy option is handled,
> a couple additional bugs were fixed:
>
> 1) The rule parser accepted rules containing invalid "keyrings=" values
>     such as "a|b||c", "a|b|", or simply "|".
>
> 2) The /sys/kernel/security/ima/policy file did not display the entire
>     "keyrings=" value if the list of keyrings was longer than what could
>     fit in the fixed size tbuf buffer in ima_policy_show().
>
> Fixes: 5c7bac9fb2c5 ("IMA: pre-allocate buffer to hold keyrings string")
> Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>   security/integrity/ima/ima_policy.c | 138 +++++++++++++++++++---------
>   1 file changed, 93 insertions(+), 45 deletions(-)
>
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 07f033634b27..c328cfa0fc49 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -59,6 +59,11 @@ enum policy_types { ORIGINAL_TCB = 1, DEFAULT_TCB };
>   
>   enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
>   
> +struct ima_rule_opt_list {
> +	size_t count;
> +	char *items[];
> +};
> +
>   struct ima_rule_entry {
>   	struct list_head list;
>   	int action;
> @@ -78,7 +83,7 @@ struct ima_rule_entry {
>   		int type;	/* audit type */
>   	} lsm[MAX_LSM_RULES];
>   	char *fsname;
> -	char *keyrings; /* Measure keys added to these keyrings */
> +	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyrings */
>   	struct ima_template_desc *template;
>   };
>   
> @@ -206,10 +211,6 @@ static LIST_HEAD(ima_policy_rules);
>   static LIST_HEAD(ima_temp_rules);
>   static struct list_head *ima_rules = &ima_default_rules;
>   
> -/* Pre-allocated buffer used for matching keyrings. */
> -static char *ima_keyrings;
> -static size_t ima_keyrings_len;
> -
>   static int ima_policy __initdata;
>   
>   static int __init default_measure_policy_setup(char *str)
> @@ -253,6 +254,72 @@ static int __init default_appraise_policy_setup(char *str)
>   }
>   __setup("ima_appraise_tcb", default_appraise_policy_setup);
>   
> +static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
> +{
> +	struct ima_rule_opt_list *opt_list;
> +	size_t count = 0;
> +	char *src_copy;
> +	char *cur, *next;
> +	size_t i;
> +
> +	src_copy = match_strdup(src);
> +	if (!src_copy)
> +		return NULL;

The caller of this function checks for IS_ERR(..) and not 
IS_ERR_OR_NULL(..). Shouldn't it return ERR_PTR(-EINVAL) instead of NULL ?

Thanks & Regards,

     - Nayna

