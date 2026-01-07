Return-Path: <linux-integrity+bounces-8191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678E9CFD26A
	for <lists+linux-integrity@lfdr.de>; Wed, 07 Jan 2026 11:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D19B63008798
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jan 2026 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA9315D5D;
	Wed,  7 Jan 2026 10:24:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC2315D25;
	Wed,  7 Jan 2026 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781443; cv=none; b=GUByyHjyktX+h35TfNwMdi9aFaSQAAQrkbrY7erUVOfnDhaofZja3IZzzJcn0B4GEotbJuH9Th/XYrueuvNQK58ytT7Vx0pgB3F4HW0V3zYFiVgAKCG7Jn+lEjKCyNe23topehoWOG7B7gjZCe1f8cjcJlkB82xZlU/pFBPd1jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781443; c=relaxed/simple;
	bh=pEgcycLhWrpgeg27oMrLpuHJOVbGKPoTS0+rvXfDynw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KFbB/VYR3x+6pj9arsM8dUPo5wC1zBkm358adxh7hT1iirKEU76fsRZKbrck8YnZp7Sns1ugkBG6dRpfmXUXac9T6SORK3dN5M0g4G4JWOfxzMca2YK8USwGGv4aFfY3vnOv1XOFKrwsfkD0xoHkdsl5vkqmIb06gBzoDvmdyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dmNtH2DqSzpThf;
	Wed,  7 Jan 2026 18:04:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 43DD740569;
	Wed,  7 Jan 2026 18:06:35 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAn820gMF5pSBeCAQ--.57748S2;
	Wed, 07 Jan 2026 11:06:34 +0100 (CET)
Message-ID: <74ae5c5c4cb6644537b2643d02b649a2064b718d.camel@huaweicloud.com>
Subject: Re: [PATCH v3 2/3] ima: trim N IMA event log records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, corbet@lwn.net,
 serge@hallyn.com, paul@paul-moore.com,  jmorris@namei.org,
 linux-security-module@vger.kernel.org,  anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com,  nramas@linux.microsoft.com,
 sushring@linux.microsoft.com,  linux-doc@vger.kernel.org
Date: Wed, 07 Jan 2026 11:06:21 +0100
In-Reply-To: <20260106020713.3994-3-chenste@linux.microsoft.com>
References: <20260106020713.3994-1-chenste@linux.microsoft.com>
	 <20260106020713.3994-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAn820gMF5pSBeCAQ--.57748S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1xJFy3Ww1rGw1kCrW7urg_yoWkWr1rpa
	ykWa4xCrWkJrWxWr18GasrZrnY9348KF4DW3s8K343AFn8Xrn29r45Cr129Fs5trWUGr1I
	qws0gr4Ykan0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFk
	u4UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGld0RoD3wABsi

On Mon, 2026-01-05 at 18:07 -0800, steven chen wrote:
> Trim N entries of the IMA event logs. Clean the hash table if
> ima_flush_htable is set.
>=20
> Provide a userspace interface ima_trim_log that can be used to input
> number N to let kernel to trim N entries of IMA event logs. When read
> this interface, it returns number of entries trimmed last time.
>=20
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  security/integrity/ima/ima.h                  |   2 +
>  security/integrity/ima/ima_fs.c               | 164 +++++++++++++++++-
>  security/integrity/ima/ima_queue.c            |  85 +++++++++
>  4 files changed, 251 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index e92c0056e4e0..cd1a1d0bf0e2 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2197,6 +2197,10 @@
>  			Use the canonical format for the binary runtime
>  			measurements, instead of host native format.
> =20
> +	ima_flush_htable  [IMA]
> +			Flush the measurement list hash table when trim all
> +			or a part of it for deletion.
> +
>  	ima_hash=3D	[IMA]
>  			Format: { md5 | sha1 | rmd160 | sha256 | sha384
>  				   | sha512 | ... }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e3d71d8d56e3..2102c523dca0 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyri=
ng, struct key *key,
> =20
>  #ifdef CONFIG_IMA_KEXEC
>  void ima_measure_kexec_event(const char *event_name);
> +long ima_delete_event_log(long req_val);
>  #else
>  static inline void ima_measure_kexec_event(const char *event_name) {}
> +static inline long ima_delete_event_log(long req_val) { return 0; }
>  #endif
> =20
>  /*
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 87045b09f120..67ff0cfc3d3f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -21,6 +21,9 @@
>  #include <linux/rcupdate.h>
>  #include <linux/parser.h>
>  #include <linux/vmalloc.h>
> +#include <linux/ktime.h>
> +#include <linux/timekeeping.h>
> +#include <linux/ima.h>
> =20
>  #include "ima.h"
> =20
> @@ -38,6 +41,17 @@ __setup("ima_canonical_fmt", default_canonical_fmt_set=
up);
> =20
>  static int valid_policy =3D 1;
> =20
> +#define IMA_LOG_TRIM_REQ_LENGTH 11
> +#define IMA_LOG_TRIM_EVENT_LEN 256

Shouldn't this belong to the next patch?

> +
> +static long trimcount;
> +/* mutex protects atomicity of trimming measurement list
> + * and also protects atomicity the measurement list read
> + * write operation.
> + */
> +static DEFINE_MUTEX(ima_measure_lock);
> +static long ima_measure_users;
> +
>  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>  				     loff_t *ppos, atomic_long_t *val)
>  {
> @@ -202,16 +216,77 @@ static const struct seq_operations ima_measurments_=
seqops =3D {
>  	.show =3D ima_measurements_show
>  };
> =20
> +/*
> + * _ima_measurements_open - open the IMA measurements file
> + * @inode: inode of the file being opened
> + * @file: file being opened
> + * @seq_ops: sequence operations for the file
> + *
> + * Returns 0 on success, or negative error code.
> + * Implements mutual exclusion between readers and writer
> + * of the measurements file. Multiple readers are allowed,
> + * but writer get exclusive access only no other readers/writers.
> + * Readers is not allowed when there is a writer.
> + */
> +static int _ima_measurements_open(struct inode *inode, struct file *file=
,
> +				  const struct seq_operations *seq_ops)
> +{
> +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> +	int ret;
> +
> +	if (write && !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	mutex_lock(&ima_measure_lock);
> +	if ((write && ima_measure_users !=3D 0) ||
> +	    (!write && ima_measure_users < 0)) {
> +		mutex_unlock(&ima_measure_lock);
> +		return -EBUSY;
> +	}
> +
> +	ret =3D seq_open(file, seq_ops);
> +	if (ret < 0) {
> +		mutex_unlock(&ima_measure_lock);
> +		return ret;
> +	}
> +
> +	if (write)
> +		ima_measure_users--;
> +	else
> +		ima_measure_users++;
> +
> +	mutex_unlock(&ima_measure_lock);
> +	return ret;
> +}
> +
>  static int ima_measurements_open(struct inode *inode, struct file *file)
>  {
> -	return seq_open(file, &ima_measurments_seqops);
> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> +}
> +
> +static int ima_measurements_release(struct inode *inode, struct file *fi=
le)
> +{
> +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> +	int ret;
> +
> +	mutex_lock(&ima_measure_lock);
> +	ret =3D seq_release(inode, file);
> +	if (!ret) {
> +		if (write)
> +			ima_measure_users++;
> +		else
> +			ima_measure_users--;
> +	}
> +
> +	mutex_unlock(&ima_measure_lock);
> +	return ret;
>  }
> =20
>  static const struct file_operations ima_measurements_ops =3D {
>  	.open =3D ima_measurements_open,
>  	.read =3D seq_read,
>  	.llseek =3D seq_lseek,
> -	.release =3D seq_release,
> +	.release =3D ima_measurements_release,
>  };
> =20
>  void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
> @@ -279,14 +354,83 @@ static const struct seq_operations ima_ascii_measur=
ements_seqops =3D {
> =20
>  static int ima_ascii_measurements_open(struct inode *inode, struct file =
*file)
>  {
> -	return seq_open(file, &ima_ascii_measurements_seqops);
> +	return _ima_measurements_open(inode, file, &ima_ascii_measurements_seqo=
ps);
>  }
> =20
>  static const struct file_operations ima_ascii_measurements_ops =3D {
>  	.open =3D ima_ascii_measurements_open,
>  	.read =3D seq_read,
>  	.llseek =3D seq_lseek,
> -	.release =3D seq_release,
> +	.release =3D ima_measurements_release,
> +};
> +
> +static int ima_log_trim_open(struct inode *inode, struct file *file)
> +{
> +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> +
> +	if (!write && capable(CAP_SYS_ADMIN))
> +		return 0;
> +	else if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> +}
> +
> +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, si=
ze_t size, loff_t *ppos)
> +{
> +	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' st=
ring value */
> +	ssize_t len;
> +
> +	len =3D scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
> +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
> +}
> +
> +static ssize_t ima_log_trim_write(struct file *file,
> +				  const char __user *buf, size_t datalen, loff_t *ppos)
> +{
> +	long count, n, ret;
> +
> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	n =3D (int)datalen;
> +
> +	ret =3D kstrtol_from_user(buf, n, 10, &count);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D ima_delete_event_log(count);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	trimcount =3D ret;
> +
> +	ret =3D datalen;
> +out:
> +	return ret;
> +}
> +
> +static int ima_log_trim_release(struct inode *inode, struct file *file)
> +{
> +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> +
> +	if (!write && capable(CAP_SYS_ADMIN))
> +		return 0;
> +	else if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	return ima_measurements_release(inode, file);
> +}
> +
> +static const struct file_operations ima_log_trim_ops =3D {
> +	.open =3D ima_log_trim_open,
> +	.read =3D ima_log_trim_read,
> +	.write =3D ima_log_trim_write,
> +	.llseek =3D generic_file_llseek,
> +	.release =3D ima_log_trim_release
>  };
> =20
>  static ssize_t ima_read_policy(char *path)
> @@ -528,6 +672,18 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_IMA_LOG_TRIMMING)) {
> +		dentry =3D securityfs_create_file("ima_trim_log",
> +						S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> +						ima_dir, NULL, &ima_log_trim_ops);
> +		if (IS_ERR(dentry)) {
> +			ret =3D PTR_ERR(dentry);
> +			goto out;
> +		}
> +	}
> +
> +	trimcount =3D 0;
> +
>  	dentry =3D securityfs_create_file("runtime_measurements_count",
>  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>  				   &ima_measurements_count_ops);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 590637e81ad1..33bb5414b8cc 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -22,6 +22,14 @@
> =20
>  #define AUDIT_CAUSE_LEN_MAX 32
> =20
> +bool ima_flush_htable;
> +static int __init ima_flush_htable_setup(char *str)
> +{
> +	ima_flush_htable =3D true;
> +	return 1;
> +}
> +__setup("ima_flush_htable", ima_flush_htable_setup);
> +
>  /* pre-allocated array of tpm_digest structures to extend a PCR */
>  static struct tpm_digest *digests;
> =20
> @@ -220,6 +228,83 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  	return result;
>  }
> =20
> +/**
> + * ima_delete_event_log - delete IMA event entry
> + * @num_records: number of records to delete
> + *
> + * delete num_records entries off the measurement list.
> + * Returns the number of entries deleted, or negative error code.

This is not according to the format stated in the documentation.

> + */
> +long ima_delete_event_log(long num_records)
> +{
> +	long len, cur =3D num_records, tmp_len =3D 0;
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	LIST_HEAD(ima_measurements_staged);
> +	struct list_head *list_ptr;
> +
> +	if (num_records <=3D 0)
> +		return num_records;
> +
> +	if (!IS_ENABLED(CONFIG_IMA_LOG_TRIMMING))
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	len =3D atomic_long_read(&ima_htable.len);
> +
> +	if (num_records > len) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	list_ptr =3D &ima_measurements;
> +
> +	if (cur =3D=3D len) {
> +		list_replace(&ima_measurements, &ima_measurements_staged);
> +		INIT_LIST_HEAD(&ima_measurements);
> +		atomic_long_set(&ima_htable.len, 0);
> +		list_ptr =3D &ima_measurements_staged;
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size =3D 0;

Like in my patch, we should have kept the original value of
binary_runtime_size, to avoid breaking the kexec critical data records.

> +	}
> +
> +	list_for_each_entry(qe, list_ptr, later) {
> +		if (num_records > 0) {
> +			if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) && ima_flush_htable)
> +				hlist_del_rcu(&qe->hnext);
> +
> +			--num_records;
> +			if (num_records =3D=3D 0)
> +				qe_tmp =3D qe;
> +			continue;
> +		}
> +		if (len !=3D cur && IS_ENABLED(CONFIG_IMA_KEXEC))
> +			tmp_len +=3D get_binary_runtime_size(qe->entry);
> +		else
> +			break;
> +	}
> +
> +	if (len !=3D cur) {
> +		__list_cut_position(&ima_measurements_staged, &ima_measurements,
> +				    &qe_tmp->later);
> +		atomic_long_sub(cur, &ima_htable.len);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size =3D tmp_len;
> +	}
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	if (ima_flush_htable)
> +		synchronize_rcu();
> +
> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later) {
> +		ima_free_template_entry(qe->entry);
> +		list_del(&qe->later);
> +		kfree(qe);

If you don't flush the hash table, you cannot delete the entry.

Roberto

> +	}
> +
> +	return cur;
> +}
> +
>  int ima_restore_measurement_entry(struct ima_template_entry *entry)
>  {
>  	int result =3D 0;


