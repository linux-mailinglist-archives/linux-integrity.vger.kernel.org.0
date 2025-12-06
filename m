Return-Path: <linux-integrity+bounces-7827-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DACA9DAC
	for <lists+linux-integrity@lfdr.de>; Sat, 06 Dec 2025 02:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0F9330EEC65
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Dec 2025 01:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5402459C9;
	Sat,  6 Dec 2025 01:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ScQsYYPz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B56F2DA755;
	Sat,  6 Dec 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764984492; cv=none; b=RuJvNiaNAEhdWX489+ZchjFXhCV28xlB+CUseBSmnudmRKbnspERe4jj9k/CMuAOoqUztG4rPfaYgJVdpW/d/h8H+GmZf6TG2+acT1L5YR4vvXthqGDKfnudb9sKiLPpQmYKwMIRaKRBSHVoNBWv1f6QdctvYTpyiwLqCj9zSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764984492; c=relaxed/simple;
	bh=q/Wsg5FfLOhQpfDdZLiCbvWCm+yqGUhoF8BfEZ8E96Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Frcadkh+ITv5yKV019FoT5OCG7sy/p3mQlDbqYiVlvBYjl9wsEYPOihS7a7ufqTR+KkZVG/KrHxxp2tvHz2UDmRi45200t7+KiDjEVIZYKLLlqUNGZrFfeXJmSD2m9/2hkXK+GWPoDf/QrzqwevGlDnIlkjeoE9ec3GWVNwlyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ScQsYYPz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.202] (unknown [131.107.1.138])
	by linux.microsoft.com (Postfix) with ESMTPSA id C565C201D7E8;
	Fri,  5 Dec 2025 17:28:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C565C201D7E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764984488;
	bh=Sn9Z9Lx1cdrnVkhf9RgH4VcFUc+lHAphm6gqI3K2mrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ScQsYYPz6wpuIz+Pely0mirAP9ST70AQFfUi3HvBErEPLGKlTzj74UtWayCykFd+i
	 7UZTBmePr0V/9w0e36xqK+QDtuO0WTmVsdGIchT3zlzwQAjU3oCtbCvv0wAXlkQXiI
	 ash1U13qSYLv6qKxcHoknrByI+U/JJ19grCBQ7/8=
Message-ID: <dd7abd9b-f1dc-4f2a-925f-cfae4ce0ee9a@linux.microsoft.com>
Date: Fri, 5 Dec 2025 17:28:06 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] IMA event log trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-security-module@vger.kernel.org,
 anirudhve@linux.microsoft.com, gregorylumen@linux.microsoft.com,
 nramas@linux.microsoft.com, sushring@linux.microsoft.com,
 steven chen <chenste@linux.microsoft.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
 <20251202232857.8211-2-chenste@linux.microsoft.com>
 <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/2025 1:30 AM, Roberto Sassu wrote:
> On Tue, 2025-12-02 at 15:28 -0800, steven chen wrote:
>> This patch is for trimming N entries of the IMA event logs as well as
>> cleaning the hash table.
>>
>> It provides a userspace interface ima_trim_log that can be used to input
>> number N to let kernel to trim N entries of IMA event logs. When read
>> this interface, it returns number of entries trimmed last tim.
> High-level comments:
> - It does not offer the possibility to keep the hash table

Hi Roberto,

Should the hash table persist after log removal? Log trimming is 
infrequent, right?

Thanks,

Steven

> - There is no coordination between taking a snapshot and the readers of
>    the measurements list (I think it is necessary, since reading is
>    based on *pos, which contains the entries read until a given point;
>    if there is a truncate in the middle of the read, *pos would still
>    refer to the non-truncated list and the next read will skip some
>    measurement entries)

Hi Roberto,

What’s your suggestion for this? Leave user space handle this (check log 
trimming
happened)?

Thanks!

Steven.

> - While trimming per se is ok, I like more the idea of staging changes
>    and letting the user delete the staged measurements list later

Hi Roberto,

This approach simplifies both the user space agent and the kernel. The 
main difference
lies in whether log purging requires one step or two; I think a single 
step is preferable
since logs must be removed from the kernel regardless.

Thanks,

Steven

>> A mutex ima_trim_list_mutex is provided to allow one trimming request
>> at a time.
>>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  2 +
>>   security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c | 42 ++++++++++++++++
>>   3 files changed, 122 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index e3d71d8d56e3..ab0e30ee25ea 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>>   void ima_measure_kexec_event(const char *event_name);
>> +long ima_purge_event_log(long number_logs);
>>   #else
>>   static inline void ima_measure_kexec_event(const char *event_name) {}
>> +static inline long ima_purge_event_log(long number_logs) { return 0; }
>>   #endif
>>   
>>   /*
>> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
>> index 87045b09f120..ea93448feedd 100644
>> --- a/security/integrity/ima/ima_fs.c
>> +++ b/security/integrity/ima/ima_fs.c
>> @@ -38,6 +38,11 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
>>   
>>   static int valid_policy = 1;
>>   
>> +#define IMA_LOG_TRIM_REQ_LENGTH 11
>> +static long trimcount;
>> +/* mutex protects atomicity of trimming measurement list requests */
>> +static DEFINE_MUTEX(ima_trim_list_mutex);
>> +
>>   static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>>   				     loff_t *ppos, atomic_long_t *val)
>>   {
>> @@ -289,6 +294,69 @@ static const struct file_operations ima_ascii_measurements_ops = {
>>   	.release = seq_release,
>>   };
>>   
>> +static int ima_log_trim_open(struct inode *inode, struct file *filp)
>> +{
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +	return 0;
>> +}
>> +
>> +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
>> +{
>> +	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' string value */
>> +	ssize_t len;
>> +
>> +	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
>> +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
>> +}
>> +
>> +static ssize_t ima_log_trim_write(struct file *file,
>> +				  const char __user *buf, size_t datalen, loff_t *ppos)
>> +{
>> +	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
>> +	long count, n;
>> +	int ret;
>> +
>> +	mutex_lock(&ima_trim_list_mutex);
>> +
>> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	n = (int)datalen;
>> +
>> +	ret = copy_from_user(req, buf, datalen);
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	count = 0;
>> +	for (int i = 0; i < n; ++i) {
>> +		if (req[i] < '0' || req[i] > '9') {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +		count = count * 10 + req[i] - '0';
>> +	}
>> +	ret = ima_purge_event_log(count);
>> +
>> +	if (ret < 0)
>> +		goto out;
>> +
>> +	trimcount = ret;
>> +	ret = datalen;
>> +out:
>> +	mutex_unlock(&ima_trim_list_mutex);
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations ima_log_trim_ops = {
>> +	.open = ima_log_trim_open,
>> +	.read = ima_log_trim_read,
>> +	.write = ima_log_trim_write,
>> +	.llseek = generic_file_llseek,
>> +};
>> +
>>   static ssize_t ima_read_policy(char *path)
>>   {
>>   	void *data = NULL;
>> @@ -528,6 +596,16 @@ int __init ima_fs_init(void)
>>   		goto out;
>>   	}
>>   
>> +	dentry = securityfs_create_file("ima_trim_log",
>> +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
>> +					ima_dir, NULL, &ima_log_trim_ops);
>> +	if (IS_ERR(dentry)) {
>> +		ret = PTR_ERR(dentry);
>> +		goto out;
>> +	}
>> +
>> +	trimcount = 0;
>> +
>>   	dentry = securityfs_create_file("runtime_measurements_count",
>>   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>>   				   &ima_measurements_count_ops);
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 590637e81ad1..999cd42c517c 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -220,6 +220,48 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>   	return result;
>>   }
>>   
>> +/* Delete the IMA event logs */
>> +long ima_purge_event_log(long number_logs)
>> +{
>> +	struct ima_queue_entry *qe;
>> +	long cur = 0;
>> +
>> +	if (number_logs <= 0)
>> +		return number_logs;
>> +
>> +	mutex_lock(&ima_extend_list_mutex);
>> +	rcu_read_lock();
> Sorry, I'm missing why rcu_read_lock() is needed.

Hi Roberto,

I will add "true" parameter in list_for_each_entry_rcu api.

Thanks,

Steven

>> +
>> +	/*
>> +	 * Remove this entry from both hash table and the measurement list
>> +	 * When removing from hash table, decrease the length counter
>> +	 * so that the hash table re-sizing logic works correctly
>> +	 */
>> +	list_for_each_entry_rcu(qe, &ima_measurements, later) {
>> +		int i;
>> +
>> +		/* if CONFIG_IMA_DISABLE_HTABLE is set, the hash table is not used */
>> +		if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
>> +			hlist_del_rcu(&qe->hnext);
>> +
>> +		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
>> +			kfree(qe->entry->template_data[i].data);
>> +			qe->entry->template_data[i].data = NULL;
>> +			qe->entry->template_data[i].len = 0;
>> +		}
>> +
>> +		atomic_long_dec(&ima_htable.len);
>> +		list_del_rcu(&qe->later);
> Missing kfree() of qe->entry and qe?
>
> Thanks
>
> Roberto

Hi Roberto,

I will update in next version.

Thanks,

Steven

>> +		++cur;
>> +		if (cur >= number_logs)
>> +			break;
>> +	}
>> +
>> +	rcu_read_unlock();
>> +	mutex_unlock(&ima_extend_list_mutex);
>> +	return cur;
>> +}
>> +
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry)
>>   {
>>   	int result = 0;



