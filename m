Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7562AFC4A
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 02:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKLBeW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Nov 2020 20:34:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbgKLA6m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Nov 2020 19:58:42 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC0XeIs069183;
        Wed, 11 Nov 2020 19:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y4MIbGodRBMWxrDdVLiZ+X5od4JJCs8quG1JStkJZ84=;
 b=n875d5uGhHJw1L5s8cXBpdchM6KSGg+vT0kEYkoe/eRMaANjWoN+UAG9O/N6OZ2ZPWRl
 U1NgZncAzxxfq9xFmm4NMECZz3sOTgFOd/to+iTX0mykkNf2ovSABpztR6je61fYJKVY
 HY1mAxKz5ShT/93xwK36jnTeHeyhX9I2sbLZV5HKsIDLXrINAoGwTR3PChuJJqbp/RR/
 pW2K02h4CzVF0+tXF1R5s1npDRdcNrp+JIqZ9veuTO7JqM6FB0haYQAbTz0TmMnXjvKA
 U3aty0VlnR2O2QkJf1/wk4S3aYbBcGERvguLJWnRVtxCisVsBmYydA7app9/EBnjfYdX uw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r6c4238n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 19:58:37 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC0wED5020195;
        Thu, 12 Nov 2020 00:58:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 34p26pmbxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 00:58:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC0wX4n393922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 00:58:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 019DD11C05B;
        Thu, 12 Nov 2020 00:58:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F073311C04A;
        Thu, 12 Nov 2020 00:58:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.66.19])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 00:58:31 +0000 (GMT)
Message-ID: <743452bc4240779e4acafda5c0d3c19482dca38f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: select ima-buf template for buffer measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Nov 2020 19:58:30 -0500
In-Reply-To: <20201111205946.503-1-nramas@linux.microsoft.com>
References: <20201111205946.503-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_12:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Wed, 2020-11-11 at 12:59 -0800, Lakshmi Ramasubramanian wrote:
> The default IMA template for measuring buffer should be 'ima-buf' - so
> that the measured buffer is correctly included in the IMA measurement
> log entry. But the default IMA template used for all policy rules is
> the value set for CONFIG_IMA_DEFAULT_TEMPLATE if the policy rule does
> not specify a template. 

The second sentence defines the current status.  The first sentence
describes the problem.  I would reverse the sentence order.

^measuring buffer -> buffer measurements

> IMA does not take into account the template
> requirements of different rules when choosing a default template for
> a given policy rule. This breaks the buffer measurement if the template
> is not provided as part of the rule because the default template could
> be different than 'ima-buf'.

Does the above paragraph add anything new?  Instead describe the
problem.  Perhaps something like:

With the default template format, buffer measurements are added to the
measurement list, but do not include the buffer data, making it
difficult, if not impossible, to validate.  Including "ima-buf"
template records in the measurement list by default, should not impact
existing attestation servers without "ima-buf" template support.

> 
> For example, the following IMA policy rule enables measuring
> the command line arguments passed to the new kernel on kexec system call.
> 
>  measure func=KEXEC_CMDLINE
> 
> The IMA template selected should be 'ima-buf' to have the measured 
> command line arguments included in the IMA measurement log entry.
> Instead the default IMA template is selected, which could be different
> than 'ima-buf'.

When upstreaming a new type of measurement, including an example
provides how to validate the new template data.  Not every patch
description requires an example.

> 
> Initialize a global 'ima-buf' template and select that template,
> by default, for measuring buffer.

Good.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h          |  1 +
>  security/integrity/ima/ima_main.c     | 17 +++++------------
>  security/integrity/ima/ima_policy.c   |  2 +-
>  security/integrity/ima/ima_template.c | 25 +++++++++++++++++++++++++
>  4 files changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 6ebefec616e4..8e8b1e3cb847 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -156,6 +156,7 @@ int template_desc_init_fields(const char *template_fmt,
>  			      const struct ima_template_field ***fields,
>  			      int *num_fields);
>  struct ima_template_desc *ima_template_desc_current(void);
> +struct ima_template_desc *ima_template_desc_buf(void);
>  struct ima_template_desc *lookup_template_desc(const char *name);
>  bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index a962b23e0429..3646ae763ba9 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -413,7 +413,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>   */
>  int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>  {
> -	struct ima_template_desc *template;
> +	struct ima_template_desc *template = NULL;
>  	struct file *file = vma->vm_file;
>  	char filename[NAME_MAX];
>  	char *pathbuf = NULL;
> @@ -802,7 +802,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  					    .filename = eventname,
>  					    .buf = buf,
>  					    .buf_len = size};
> -	struct ima_template_desc *template = NULL;
> +	struct ima_template_desc *template = ima_template_desc_buf();
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
> @@ -833,16 +833,9 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>  
>  	if (!template) {
> -		template = lookup_template_desc("ima-buf");
> -		ret = template_desc_init_fields(template->fmt,
> -						&(template->fields),
> -						&(template->num_fields));
> -		if (ret < 0) {
> -			pr_err("template %s init failed, result: %d\n",
> -			       (strlen(template->name) ?
> -				template->name : template->fmt), ret);
> -			return;
> -		}
> +		ret = -EINVAL;
> +		audit_cause = "ima_template_desc_buf";
> +		goto out;

Normally a test follows the variable assignment, but in this case, the
check is being deferred in case there isn't a policy rule.

>  	}
>  
>  	iint.ima_hash = &hash.hdr;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 9b5adeaa47fc..823a0c1379cb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -628,7 +628,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>  	struct ima_rule_entry *entry;
>  	int action = 0, actmask = flags | (flags << 1);
>  
> -	if (template_desc)
> +	if (template_desc && !*template_desc)
>  		*template_desc = ima_template_desc_current();
>  
>  	rcu_read_lock();
> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
> index 1e89e2d3851f..e53fce2c1610 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -55,6 +55,7 @@ static const struct ima_template_field supported_fields[] = {
>  #define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
>  
>  static struct ima_template_desc *ima_template;
> +static struct ima_template_desc *ima_buf_template;
>  
>  /**
>   * ima_template_has_modsig - Check whether template has modsig-related fields.
> @@ -252,6 +253,30 @@ struct ima_template_desc *ima_template_desc_current(void)
>  	return ima_template;
>  }
>  
> +struct ima_template_desc *ima_template_desc_buf(void)
> +{
> +	struct ima_template_desc *template = NULL;
> +	int ret = 0;
> +
> +	if (ima_buf_template)
> +		return ima_buf_template;
> +
> +	ima_init_template_list();
> +	template = lookup_template_desc("ima-buf");
> +	if (!template)
> +		return NULL;
> +
> +	ret = template_desc_init_fields(template->fmt,
> +					&(template->fields),
> +					&(template->num_fields));
> +	if (ret)
> +		return NULL;

Instead of initializing the fields here, maybe it should be done in
ima_init_template()?  That would remove the deferred !template test in
process_buffer_measurement() and would also simplify this function.

thanks,

Mimi

> +
> +	ima_buf_template = template;
> +
> +	return ima_buf_template;
> +}
> +
>  int __init ima_init_template(void)
>  {
>  	struct ima_template_desc *template = ima_template_desc_current();

