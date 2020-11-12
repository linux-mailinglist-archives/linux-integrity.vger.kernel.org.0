Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415212B0B55
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 18:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgKLRfa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 12:35:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49570 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgKLRf3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 12:35:29 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id F33BD20C2865;
        Thu, 12 Nov 2020 09:35:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F33BD20C2865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605202529;
        bh=cv5U3FZcZsN2eQrrMdHJ4L6mW6ngKClYvdgvUvdxA9E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P3VZoG2VnjOYebaoI1HLHrbXgLm5tBcLy6yYnOuWqhzrhvC6UfSvE0XaLdl+lwAof
         aR3aPwf+xuslR/yC52J/RlDpuvatxWHJpMzaoSOIYLKBBdFwvl80IJPRWqc8ZioNno
         Uj/My587UjOinVpe4y85J55FpFRw8ejijuylrFRg=
Subject: Re: [PATCH] ima: select ima-buf template for buffer measurement
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     tusharsu@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201111205946.503-1-nramas@linux.microsoft.com>
 <743452bc4240779e4acafda5c0d3c19482dca38f.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <20b22b9e-c11a-184a-0166-3848e88fcc06@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 09:35:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <743452bc4240779e4acafda5c0d3c19482dca38f.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/11/20 4:58 PM, Mimi Zohar wrote:
> Hi Lakshmi,
> 
> On Wed, 2020-11-11 at 12:59 -0800, Lakshmi Ramasubramanian wrote:
>> The default IMA template for measuring buffer should be 'ima-buf' - so
>> that the measured buffer is correctly included in the IMA measurement
>> log entry. But the default IMA template used for all policy rules is
>> the value set for CONFIG_IMA_DEFAULT_TEMPLATE if the policy rule does
>> not specify a template.
> 
> The second sentence defines the current status.  The first sentence
> describes the problem.  I would reverse the sentence order.
> 
> ^measuring buffer -> buffer measurements
I'll make this change.

> 
>> IMA does not take into account the template
>> requirements of different rules when choosing a default template for
>> a given policy rule. This breaks the buffer measurement if the template
>> is not provided as part of the rule because the default template could
>> be different than 'ima-buf'.
> 
> Does the above paragraph add anything new?  Instead describe the
> problem.  Perhaps something like:
> 
> With the default template format, buffer measurements are added to the
> measurement list, but do not include the buffer data, making it
> difficult, if not impossible, to validate.  Including "ima-buf"
> template records in the measurement list by default, should not impact
> existing attestation servers without "ima-buf" template support.

This sounds better - I'll make this change.

> 
>>
>> For example, the following IMA policy rule enables measuring
>> the command line arguments passed to the new kernel on kexec system call.
>>
>>   measure func=KEXEC_CMDLINE
>>
>> The IMA template selected should be 'ima-buf' to have the measured
>> command line arguments included in the IMA measurement log entry.
>> Instead the default IMA template is selected, which could be different
>> than 'ima-buf'.
> 
> When upstreaming a new type of measurement, including an example
> provides how to validate the new template data.  Not every patch
> description requires an example.
Will remove the above paragraph.

> 
>>
>> Initialize a global 'ima-buf' template and select that template,
>> by default, for measuring buffer.
> 
> Good.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h          |  1 +
>>   security/integrity/ima/ima_main.c     | 17 +++++------------
>>   security/integrity/ima/ima_policy.c   |  2 +-
>>   security/integrity/ima/ima_template.c | 25 +++++++++++++++++++++++++
>>   4 files changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 6ebefec616e4..8e8b1e3cb847 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -156,6 +156,7 @@ int template_desc_init_fields(const char *template_fmt,
>>   			      const struct ima_template_field ***fields,
>>   			      int *num_fields);
>>   struct ima_template_desc *ima_template_desc_current(void);
>> +struct ima_template_desc *ima_template_desc_buf(void);
>>   struct ima_template_desc *lookup_template_desc(const char *name);
>>   bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index a962b23e0429..3646ae763ba9 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -413,7 +413,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
>>    */
>>   int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>>   {
>> -	struct ima_template_desc *template;
>> +	struct ima_template_desc *template = NULL;
>>   	struct file *file = vma->vm_file;
>>   	char filename[NAME_MAX];
>>   	char *pathbuf = NULL;
>> @@ -802,7 +802,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   					    .filename = eventname,
>>   					    .buf = buf,
>>   					    .buf_len = size};
>> -	struct ima_template_desc *template = NULL;
>> +	struct ima_template_desc *template = ima_template_desc_buf();
>>   	struct {
>>   		struct ima_digest_data hdr;
>>   		char digest[IMA_MAX_DIGEST_SIZE];
>> @@ -833,16 +833,9 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>>   		pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>>   
>>   	if (!template) {
>> -		template = lookup_template_desc("ima-buf");
>> -		ret = template_desc_init_fields(template->fmt,
>> -						&(template->fields),
>> -						&(template->num_fields));
>> -		if (ret < 0) {
>> -			pr_err("template %s init failed, result: %d\n",
>> -			       (strlen(template->name) ?
>> -				template->name : template->fmt), ret);
>> -			return;
>> -		}
>> +		ret = -EINVAL;
>> +		audit_cause = "ima_template_desc_buf";
>> +		goto out;
> 
> Normally a test follows the variable assignment, but in this case, the
> check is being deferred in case there isn't a policy rule.
I will initialize the buf template in ima_init_template() per your 
comment below. Will move the check for template right after the check 
for the IMA policy flag.

	if (!ima_policy_flag)
		return;

	template = ima_template_desc_buf();
	if (!template) {
		ret = -EINVAL;
		audit_cause = "ima_template_desc_buf";
		goto out;
	}

> 
>>   	}
>>   
>>   	iint.ima_hash = &hash.hdr;
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 9b5adeaa47fc..823a0c1379cb 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -628,7 +628,7 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
>>   	struct ima_rule_entry *entry;
>>   	int action = 0, actmask = flags | (flags << 1);
>>   
>> -	if (template_desc)
>> +	if (template_desc && !*template_desc)
>>   		*template_desc = ima_template_desc_current();
>>   
>>   	rcu_read_lock();
>> diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
>> index 1e89e2d3851f..e53fce2c1610 100644
>> --- a/security/integrity/ima/ima_template.c
>> +++ b/security/integrity/ima/ima_template.c
>> @@ -55,6 +55,7 @@ static const struct ima_template_field supported_fields[] = {
>>   #define MAX_TEMPLATE_NAME_LEN sizeof("d-ng|n-ng|sig|buf|d-modisg|modsig")
>>   
>>   static struct ima_template_desc *ima_template;
>> +static struct ima_template_desc *ima_buf_template;
>>   
>>   /**
>>    * ima_template_has_modsig - Check whether template has modsig-related fields.
>> @@ -252,6 +253,30 @@ struct ima_template_desc *ima_template_desc_current(void)
>>   	return ima_template;
>>   }
>>   
>> +struct ima_template_desc *ima_template_desc_buf(void)
>> +{
>> +	struct ima_template_desc *template = NULL;
>> +	int ret = 0;
>> +
>> +	if (ima_buf_template)
>> +		return ima_buf_template;
>> +
>> +	ima_init_template_list();
>> +	template = lookup_template_desc("ima-buf");
>> +	if (!template)
>> +		return NULL;
>> +
>> +	ret = template_desc_init_fields(template->fmt,
>> +					&(template->fields),
>> +					&(template->num_fields));
>> +	if (ret)
>> +		return NULL;
> 
> Instead of initializing the fields here, maybe it should be done in
> ima_init_template()?  That would remove the deferred !template test in
> process_buffer_measurement() and would also simplify this function.
> 

Will do.

Thanks Mimi.

  -lakshmi

> 
>> +
>> +	ima_buf_template = template;
>> +
>> +	return ima_buf_template;
>> +}
>> +
>>   int __init ima_init_template(void)
>>   {
>>   	struct ima_template_desc *template = ima_template_desc_current();

