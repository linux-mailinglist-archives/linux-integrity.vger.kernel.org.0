Return-Path: <linux-integrity+bounces-9135-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKE/KY001WnY2gcAu9opvQ
	(envelope-from <linux-integrity+bounces-9135-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 18:45:01 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE643B1F57
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Apr 2026 18:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B3C3058563
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Apr 2026 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499DE33D503;
	Tue,  7 Apr 2026 16:39:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA13C5522;
	Tue,  7 Apr 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579993; cv=none; b=R9t00b5fFdDSQjKQDwJ8Z7DCkVr5OdwWnJQKvPL6bj20CeWT+E6NbqqGIiUv0ZaQXYykoFwVn51pRH81QHiDO+FDU/MgiI8plx5TVoYxJOzddY7BROpUm1HZRV0AEbFjRa74Plytuo3noF82+HysfX5YEaiO1vMCqk47MJ4LjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579993; c=relaxed/simple;
	bh=8Dmp8/MLAIawsSHXLLY5W+2KqrT3qH/aICp1erHzz/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GQV9leU1SVDliW5tCkusyBoyKCd2fpcuiGS2sxKAytcRlc0txbyKaZ/q1yZ+jXqE51Phjqp4Bx3XFq9n/dMeTiUK4Wu6edDXiQ8O+R9tAcJZfeUkEGIqgYyjmfVY/GHU87Wlki5Hw5W/475zEhVzFXNo3BKT+ZLYYK2gkk2FzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fqrsY6qjyz1HBtl;
	Wed,  8 Apr 2026 00:16:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 810F84056B;
	Wed,  8 Apr 2026 00:20:04 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDH_+yqLtVpEB_oAQ--.2286S2;
	Tue, 07 Apr 2026 17:20:03 +0100 (CET)
Message-ID: <b0b65c5a2d407301905dc4232eee4b16030920c8.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/3] ima: trim N IMA event log records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, corbet@lwn.net,
 serge@hallyn.com, paul@paul-moore.com,  jmorris@namei.org,
 linux-security-module@vger.kernel.org,  anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com,  nramas@linux.microsoft.com,
 sushring@linux.microsoft.com,  linux-doc@vger.kernel.org
Date: Tue, 07 Apr 2026 18:19:51 +0200
In-Reply-To: <20260401172956.4581-3-chenste@linux.microsoft.com>
References: <20260401172956.4581-1-chenste@linux.microsoft.com>
	 <20260401172956.4581-3-chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDH_+yqLtVpEB_oAQ--.2286S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr17urW3XF4kGF1DZryxKrg_yoW8WrWDto
	Z3KFZxCa18Kr1rurWUKrn3tFyUWa98Gws7trZ8Wws8ZF12qr1jyayxXF45Aa4Igw1rXr4U
	C34kX348XFs2q3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	aFAJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGnUby0NewAGsa
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9135-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.307];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 4CE643B1F57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-01 at 10:29 -0700, steven chen wrote:
> Trim N entries of the IMA event logs. Do not clean the hash table.

The very first change of this patch is the kernel option
ima_flush_htable option that I introduced for my use case.

At the bottom of this patch you actually check the ima_flush_htable
boolean, and delete the measurements entries without disconnecting them
from the hash table, so the digest lookup is done on freed memory.

Next, you duplicated my changes regarding the measurements list
counter. But instead of removing the old counter from the hash table,
you keep incrementing both, but use the new one.

In ima_log_trim_open(), you use again my duplicated code to manage
exclusive write/concurrent read scheme for the measurement interfaces.
However, for read, if the process does not have CAP_SYS_ADMIN it falls
back calling _ima_measurements_open(). Not sure it was intended.

And, in ima_log_trim_release(), you check again CAP_SYS_ADMIN which is
redundant, you would not reach this code if the same requirements were
not met at open time. You also return an error on close().

In ima_log_trim_write(), you do manual string to number conversion for
your first number and use kstrtoul() for the second.

The measurements lists and the associated counter are atomically
updated in ima_add_digest_entry(), but not atomically accessed in
ima_delete_event_log(). Also, the measurements list is traversed
without _rcu variant or lock.

While this trimming scheme aims at minimizing the kernel space and user
space delay, it also introduces the following problem. If two agents
perform a TPM quote that include a different number of entries, there
is no guarantee that the one willing to trim less entries wins. Which
means that, one agent could end up not seeing the most recent entries,
as they were already trimmed by the other agent.

My solution is not affected by this problem, since there will be only
one process collecting all the measurements in user space and exposing
them to the agents.

Also, I didn't understand why T and ima_measure_users have to be
preserved on soft reboots. Especially ima_measure_users reflects the
state of open files for a particular kernel, but on soft reboot a new
kernel is booted.

I personally will not endorse a solution based on the ima_trim_log
interface. I could accept trimming N even more efficiently than we
currently do with a lockless walk to determine the cutting position in
ima_queue_stage(), so that we don't need to splice back entries to the
measurement list. This would be a replacement of patch 11 in my patch
set, but this would be as far as I would like to go.

Roberto

> The values saved in hash table were already used.
>=20
> Provide a userspace interface ima_trim_log:
> When read this interface, it returns total number T of entries trimmed
> since system boot up.
> When write to this interface need to provide two numbers T:N to let
> kernel to trim N entries of IMA event logs.
>=20
> Kernel measurement list lock time performance improvement by not
> clean the hash table.
>=20
> when kernel get log trim request T:N
>  - Get the T, compare with the total trimmed number
>  - if equal, then do trim N and change T to T+N
>  - else return error
>=20
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  security/integrity/ima/ima.h                  |   4 +-
>  security/integrity/ima/ima_fs.c               | 198 +++++++++++++++++-
>  security/integrity/ima/ima_kexec.c            |   2 +-
>  security/integrity/ima/ima_queue.c            |  96 +++++++++
>  5 files changed, 296 insertions(+), 8 deletions(-)
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
> index e3d71d8d56e3..5cbee3a295a0 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -243,11 +243,13 @@ void ima_post_key_create_or_update(struct key *keyr=
ing, struct key *key,
>  				   const void *payload, size_t plen,
>  				   unsigned long flags, bool create);
>  #endif
> -
> +extern atomic_long_t ima_number_entries;
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
> index 87045b09f120..8e26e0f34311 100644
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
> +#define IMA_LOG_TRIM_REQ_NUM_LENGTH 15
> +#define IMA_LOG_TRIM_REQ_TOTAL_LENGTH 32
> +atomic_long_t ima_number_entries =3D ATOMIC_LONG_INIT(0);
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
> @@ -64,8 +78,7 @@ static ssize_t ima_show_measurements_count(struct file =
*filp,
>  					   char __user *buf,
>  					   size_t count, loff_t *ppos)
>  {
> -	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
> -
> +	return ima_show_htable_value(buf, count, ppos, &ima_number_entries);
>  }
> =20
>  static const struct file_operations ima_measurements_count_ops =3D {
> @@ -202,16 +215,77 @@ static const struct seq_operations ima_measurments_=
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
> +		if (!write)
> +			ima_measure_users--;
> +		else
> +			ima_measure_users++;
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
> @@ -279,14 +353,114 @@ static const struct seq_operations ima_ascii_measu=
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
> +	char tmpbuf[IMA_LOG_TRIM_REQ_NUM_LENGTH];
> +	ssize_t len;
> +
> +	len =3D scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
> +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
> +}
> +
> +static ssize_t ima_log_trim_write(struct file *file,
> +				  const char __user *buf, size_t datalen, loff_t *ppos)
> +{
> +	char tmpbuf[IMA_LOG_TRIM_REQ_TOTAL_LENGTH];
> +	char *p =3D tmpbuf;
> +	long count, ret, val =3D 0, max =3D LONG_MAX;
> +
> +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_TOTAL_LENGTH || datalen < 2=
) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (copy_from_user(tmpbuf, buf, datalen) !=3D 0) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	p =3D tmpbuf;
> +
> +	while (*p && *p !=3D ':') {
> +		if (!isdigit((unsigned char)*p))
> +			return -EINVAL;
> +
> +		/* digit value */
> +		int d =3D *p - '0';
> +
> +		/* overflow check: val * 10 + d > max -> (val > (max - d) / 10) */
> +		if (val > (max - d) / 10)
> +			return -ERANGE;
> +
> +		val =3D val * 10 + d;
> +		p++;
> +	}
> +
> +	if (*p !=3D ':')
> +		return -EINVAL;
> +
> +	/* verify trim count matches */
> +	if (val !=3D trimcount)
> +		return -EINVAL;
> +
> +	p++; /* skip ':' */
> +	ret =3D kstrtoul(p, 0, &count);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	ret =3D ima_delete_event_log(count);
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	trimcount +=3D ret;
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
> @@ -528,6 +702,18 @@ int __init ima_fs_init(void)
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
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 7362f68f2d8b..bee997683e03 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -41,7 +41,7 @@ void ima_measure_kexec_event(const char *event_name)
>  	int n;
> =20
>  	buf_size =3D ima_get_binary_runtime_size();
> -	len =3D atomic_long_read(&ima_htable.len);
> +	len =3D atomic_long_read(&ima_number_entries);
> =20
>  	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>  		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 590637e81ad1..07225e19b9b5 100644
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
> @@ -114,6 +122,7 @@ static int ima_add_digest_entry(struct ima_template_e=
ntry *entry,
>  	list_add_tail_rcu(&qe->later, &ima_measurements);
> =20
>  	atomic_long_inc(&ima_htable.len);
> +	atomic_long_inc(&ima_number_entries);
>  	if (update_htable) {
>  		key =3D ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
>  		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
> @@ -220,6 +229,93 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  	return result;
>  }
> =20
> +/**
> + * ima_delete_event_log - delete IMA event entry
> + * @num_records: number of records to delete
> + *
> + * delete num_records entries off the measurement list.
> + * Returns num_records, or negative error code.
> + */
> +long ima_delete_event_log(long num_records)
> +{
> +	long len, cur =3D num_records, tmp_len =3D 0;
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	LIST_HEAD(ima_measurements_to_delete);
> +	struct list_head *list_ptr;
> +
> +	if (!IS_ENABLED(CONFIG_IMA_LOG_TRIMMING))
> +		return -EOPNOTSUPP;
> +
> +	if (num_records <=3D 0)
> +		return num_records;
> +
> +	list_ptr =3D &ima_measurements;
> +
> +	len =3D atomic_long_read(&ima_number_entries);
> +
> +	if (num_records <=3D len) {
> +		list_for_each_entry(qe, list_ptr, later) {
> +			if (cur > 0) {
> +				tmp_len +=3D get_binary_runtime_size(qe->entry);
> +				--cur;
> +			}
> +			if (cur =3D=3D 0) {
> +				qe_tmp =3D qe;
> +				break;
> +			}
> +		}
> +	}
> +	else {
> +		return -ENOENT;
> +	}
> +
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	len =3D atomic_long_read(&ima_number_entries);
> +
> +	if (num_records =3D=3D len) {
> +		list_replace(&ima_measurements, &ima_measurements_to_delete);
> +		INIT_LIST_HEAD(&ima_measurements);
> +		atomic_long_set(&ima_number_entries, 0);
> +		list_ptr =3D &ima_measurements_to_delete;
> +	}
> +	else {
> +		__list_cut_position(&ima_measurements_to_delete, &ima_measurements,
> +				    &qe_tmp->later);
> +		atomic_long_sub(num_records, &ima_number_entries);
> +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +			binary_runtime_size -=3D tmp_len;
> +	}
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	if (ima_flush_htable)
> +		synchronize_rcu();
> +
> +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_to_delete, later=
) {
> +		/*
> +		 * Ok because after list delete qe is only accessed by
> +		 * ima_lookup_digest_entry().
> +		 */
> +		for (int i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> +			kfree(qe->entry->template_data[i].data);
> +			qe->entry->template_data[i].data =3D NULL;
> +			qe->entry->template_data[i].len =3D 0;
> +		}
> +
> +		list_del(&qe->later);
> +
> +		/* No leak if !ima_flush_htable, referenced by ima_htable. */
> +		if (ima_flush_htable) {
> +			kfree(qe->entry->digests);
> +			kfree(qe->entry);
> +			kfree(qe);
> +		}
> +	}
> +
> +	return num_records;
> +}
> +
>  int ima_restore_measurement_entry(struct ima_template_entry *entry)
>  {
>  	int result =3D 0;


