Return-Path: <linux-integrity+bounces-7909-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ACCB57A9
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 027A6300DA74
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0373C246770;
	Thu, 11 Dec 2025 10:15:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42C2FB983;
	Thu, 11 Dec 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448124; cv=none; b=r5cQe91+tOZuv63+m6vJ8YKXK2WDKBPXcMi4/VfOOso3sDJK9o7YdkavlNgbJ1qJUSKAzLJD8JXKB2y+oiC66Z0mskhKC1b35uqJJe6SwST2bGx4Jcm+pETMLfNdtyKAwgbwCvLuJoekUMBfwBgKX5Ik4YipHwWv+c5JfsF1CcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448124; c=relaxed/simple;
	bh=lKbO+eXGkfwPTKlhc4lQ5uzPe2P6W5/BH9ZKteh8FOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BldGmoMYElOr6BpEdERqCbcPOknEd3x/BmbxaMPm7slGGseH+C61i6WRM2NwWA2TrF6edrMPSlX3Sc2jb/IXWksT8OK6yF/U9NjRQoyVWgXjLIhnk5mD4awzzoMdbXxZ81egvTkRr0uQaOab7h5TBsb+Dp0jB2rFr5s54uJMJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dRpMK2VxlzpV2L;
	Thu, 11 Dec 2025 18:13:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E9A114056F;
	Thu, 11 Dec 2025 18:15:12 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHHQ6lmTppUZq6AA--.22613S2;
	Thu, 11 Dec 2025 11:15:12 +0100 (CET)
Message-ID: <561786c2505cae94913809ac0cf3d916e1a50a68.camel@huaweicloud.com>
Subject: Re: [PATCH V2 1/1] IMA event log trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, corbet@lwn.net,
 serge@hallyn.com, paul@paul-moore.com,  jmorris@namei.org,
 linux-security-module@vger.kernel.org,  anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com,  nramas@linux.microsoft.com,
 sushring@linux.microsoft.com,  linux-doc@vger.kernel.org
Date: Thu, 11 Dec 2025 11:14:59 +0100
In-Reply-To: <20251210235314.3341-2-chenste@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
	 <20251210235314.3341-2-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAHHQ6lmTppUZq6AA--.22613S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1xJFy3Ww47AFW5KFWxWFg_yoWkJry3pa
	yv9a4IkrWkJrW7Wr18ta4UZFnY9a48Ka1DW34rK343AFn8XrnF9r4Ykr1ayFs5trW8Gr1I
	qan0grs0ka1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGk5YO8NcQACs3

On Wed, 2025-12-10 at 15:53 -0800, steven chen wrote:
> This patch is for trimming N entries of the IMA event logs. It will also
> cleaning the hash table if ima_flush_htable is set.
>=20
> It provides a userspace interface ima_trim_log that can be used to input
> number N to let kernel to trim N entries of IMA event logs. When read
> this interface, it returns number of entries trimmed last time.

I was trying to find a common solution for both approaches, and instead
you took part of my code and removed the part that you didn't like.
This is not nice.

Let's do the following. Please review my patch, and check if it makes
you achieve your goal. Then, please send follow-up patches with the
additional functionality you need (e.g. the new critical data
measurement entry).

Thanks

Roberto

> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  security/integrity/ima/ima.h                  |   2 +
>  security/integrity/ima/ima_fs.c               | 175 +++++++++++++++++-
>  security/integrity/ima/ima_queue.c            |  64 +++++++
>  4 files changed, 241 insertions(+), 4 deletions(-)
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
> index e3d71d8d56e3..ab0e30ee25ea 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyri=
ng, struct key *key,
> =20
>  #ifdef CONFIG_IMA_KEXEC
>  void ima_measure_kexec_event(const char *event_name);
> +long ima_purge_event_log(long number_logs);
>  #else
>  static inline void ima_measure_kexec_event(const char *event_name) {}
> +static inline long ima_purge_event_log(long number_logs) { return 0; }
>  #endif
> =20
>  /*
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 87045b09f120..410f7d03c43f 100644
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
> @@ -38,6 +41,14 @@ __setup("ima_canonical_fmt", default_canonical_fmt_set=
up);
> =20
>  static int valid_policy =3D 1;
> =20
> +#define IMA_LOG_TRIM_REQ_LENGTH 11
> +#define IMA_LOG_TRIM_EVENT_LEN 256
> +
> +static long trimcount;
> +/* mutex protects atomicity of trimming measurement list requests */
> +static DEFINE_MUTEX(ima_measure_lock);
> +static long ima_measure_users;
> +
>  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>  				     loff_t *ppos, atomic_long_t *val)
>  {
> @@ -202,16 +213,65 @@ static const struct seq_operations ima_measurments_=
seqops =3D {
>  	.show =3D ima_measurements_show
>  };
> =20
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
> @@ -279,14 +339,111 @@ static const struct seq_operations ima_ascii_measu=
rements_seqops =3D {
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
> +static void ima_measure_trim_event(const long number_logs)
> +{
> +	char ima_log_trim_event[IMA_LOG_TRIM_EVENT_LEN];
> +	struct timespec64 ts;
> +	u64 time_ns;
> +	int n;
> +
> +	ktime_get_real_ts64(&ts);
> +	time_ns =3D (u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> +	n =3D scnprintf(ima_log_trim_event, IMA_LOG_TRIM_EVENT_LEN,
> +		      "time=3D%llu; log trim this time=3D%lu;",
> +		       time_ns, number_logs);
> +
> +	ima_measure_critical_data("ima_log_trim", "trim ima event logs", ima_lo=
g_trim_event, n, false, NULL, 0);
> +}
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
> +	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
> +	long count, n;
> +	int ret;
> +
> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	n =3D (int)datalen;
> +
> +	ret =3D copy_from_user(req, buf, datalen);
> +	if (ret < 0)
> +		goto out;
> +
> +	count =3D 0;
> +	for (int i =3D 0; i < n; ++i) {
> +		if (req[i] < '0' || req[i] > '9') {
> +			ret =3D -EINVAL;
> +			goto out;
> +		}
> +		count =3D count * 10 + req[i] - '0';
> +	}
> +	ret =3D ima_purge_event_log(count);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	trimcount =3D ret;
> +
> +	if (trimcount > 0)
> +		ima_measure_trim_event(trimcount);
> +
> +	ret =3D datalen;
> +out:
> +	return ret;
> +}
> +
> +static int ima_log_trim_release(struct inode *inode, struct file *file)
> +{
> +	bool write =3D !!(file->f_mode & FMODE_WRITE);
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
> @@ -528,6 +685,16 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
> =20
> +	dentry =3D securityfs_create_file("ima_trim_log",
> +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> +					ima_dir, NULL, &ima_log_trim_ops);
> +	if (IS_ERR(dentry)) {
> +		ret =3D PTR_ERR(dentry);
> +		goto out;
> +	}
> +
> +	trimcount =3D 0;
> +
>  	dentry =3D securityfs_create_file("runtime_measurements_count",
>  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
>  				   &ima_measurements_count_ops);
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 590637e81ad1..77ab52469727 100644
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
> @@ -220,6 +228,62 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  	return result;
>  }
> =20
> +/* Delete the IMA event logs */
> +long ima_purge_event_log(long number_logs)
> +{
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	LIST_HEAD(ima_measurements_staged);
> +	unsigned int i;
> +	long cur =3D number_logs;
> +
> +	if (number_logs <=3D 0)
> +		return number_logs;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +
> +
> +	list_for_each_entry(qe, &ima_measurements, later) {
> +		if (--number_logs =3D=3D 0)
> +			break;
> +	}
> +
> +	if (number_logs > 0) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	__list_cut_position(&ima_measurements_staged, &ima_measurements,
> +				    &qe->later);
> +	atomic_long_sub(cur, &ima_htable.len);
> +
> +	if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) && ima_flush_htable) {
> +		list_for_each_entry(qe, &ima_measurements_staged, later)
> +			/* It can race with ima_lookup_digest_entry(). */
> +			hlist_del_rcu(&qe->hnext);
> +	}
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +
> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later) {
> +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> +			kfree(qe->entry->template_data[i].data);
> +			qe->entry->template_data[i].data =3D NULL;
> +			qe->entry->template_data[i].len =3D 0;
> +		}
> +
> +		list_del(&qe->later);
> +
> +		if (ima_flush_htable) {
> +			kfree(qe->entry->digests);
> +			kfree(qe->entry);
> +			kfree(qe);
> +		}
> +	}
> +
> +	return cur;
> +}
> +
>  int ima_restore_measurement_entry(struct ima_template_entry *entry)
>  {
>  	int result =3D 0;


