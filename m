Return-Path: <linux-integrity+bounces-7820-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD8CA7EC0
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Dec 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EED6304DA1D
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Dec 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C531D38F;
	Fri,  5 Dec 2025 14:22:19 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A030BF5D;
	Fri,  5 Dec 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944538; cv=none; b=IHxXN8aFz04jWEoBN5tWNJ4XUbBrtgJyOhnUpmK4QfcRcnOmFoFkUXo3h00USBsJVt4MWD5oBP1uLczffzY+3sJbXL9i9h0dfhaRXStvj7uD8AqvdU5+NEHR9ZsgLmJmoUbwxaA/V3UC61f22VHJem6mF12DQM5FoI3a2zyTJgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944538; c=relaxed/simple;
	bh=1rsOHfkI29CJ+OXq7WK5lhAxnLhb/6g/5gdnpU1Ib84=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leFqcmU/+nmNLwYEFAvzGnqw0+TtGlOfG3NSPxXXsnBht1DjguVP4GDuNtMctxuwkfMjudKxVyH6fb7GgqQDjSqr4fegMyAZ/4tTqKjDnWzwaOvxkHOSVHaI6+wXOQojoFlV4U0kOXxS6kx/QTpRYRFKxeSnHBB6S7dr2kEExHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dND752MmdzpTjQ;
	Fri,  5 Dec 2025 22:20:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id EE69C4056C;
	Fri,  5 Dec 2025 22:22:05 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDH0TWD6jJphedeAA--.2040S2;
	Fri, 05 Dec 2025 15:22:05 +0100 (CET)
Message-ID: <7b4e2e25d2e554fa0b86f2dff7d090718359ffd1.camel@huaweicloud.com>
Subject: Re: [PATCH 1/1] IMA event log trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, 
	linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, 
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com, 
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, 
 sushring@linux.microsoft.com
Date: Fri, 05 Dec 2025 15:21:52 +0100
In-Reply-To: <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
	 <20251202232857.8211-2-chenste@linux.microsoft.com>
	 <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDH0TWD6jJphedeAA--.2040S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF1xXw1xtFykZFWDWF1Dtrb_yoWxur48pa
	yvgFW5KFZ5JryxKrn2va47WrZYg3yrWF1Du34rKa4ayas0vrn2gry5Gr1a9r95GryUGr1I
	va1jqrnIkan8KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQANBGkyyW4BzgAAs7

On Fri, 2025-12-05 at 10:30 +0100, Roberto Sassu wrote:
> On Tue, 2025-12-02 at 15:28 -0800, steven chen wrote:
> > This patch is for trimming N entries of the IMA event logs as well as
> > cleaning the hash table.
> >=20
> > It provides a userspace interface ima_trim_log that can be used to inpu=
t
> > number N to let kernel to trim N entries of IMA event logs. When read
> > this interface, it returns number of entries trimmed last tim.
>=20
> High-level comments:
> - It does not offer the possibility to keep the hash table
> - There is no coordination between taking a snapshot and the readers of
>   the measurements list (I think it is necessary, since reading is
>   based on *pos, which contains the entries read until a given point;
>   if there is a truncate in the middle of the read, *pos would still
>   refer=C2=A0to the non-truncated list and the next read will skip some
>   measurement entries)
> - While trimming per se is ok, I like more the idea of staging changes
>   and letting the user delete the staged measurements list later
>=20
> > A mutex ima_trim_list_mutex is provided to allow one trimming request
> > at a time.
> >=20
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > ---
> >  security/integrity/ima/ima.h       |  2 +
> >  security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++
> >  security/integrity/ima/ima_queue.c | 42 ++++++++++++++++
> >  3 files changed, 122 insertions(+)
> >=20
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index e3d71d8d56e3..ab0e30ee25ea 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *key=
ring, struct key *key,
> > =20
> >  #ifdef CONFIG_IMA_KEXEC
> >  void ima_measure_kexec_event(const char *event_name);
> > +long ima_purge_event_log(long number_logs);
> >  #else
> >  static inline void ima_measure_kexec_event(const char *event_name) {}
> > +static inline long ima_purge_event_log(long number_logs) { return 0; }
> >  #endif
> > =20
> >  /*
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 87045b09f120..ea93448feedd 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -38,6 +38,11 @@ __setup("ima_canonical_fmt", default_canonical_fmt_s=
etup);
> > =20
> >  static int valid_policy =3D 1;
> > =20
> > +#define IMA_LOG_TRIM_REQ_LENGTH 11
> > +static long trimcount;
> > +/* mutex protects atomicity of trimming measurement list requests */
> > +static DEFINE_MUTEX(ima_trim_list_mutex);
> > +
> >  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
> >  				     loff_t *ppos, atomic_long_t *val)
> >  {
> > @@ -289,6 +294,69 @@ static const struct file_operations ima_ascii_meas=
urements_ops =3D {
> >  	.release =3D seq_release,
> >  };
> > =20
> > +static int ima_log_trim_open(struct inode *inode, struct file *filp)
> > +{
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +	return 0;
> > +}
> > +
> > +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, =
size_t size, loff_t *ppos)
> > +{
> > +	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' =
string value */
> > +	ssize_t len;
> > +
> > +	len =3D scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
> > +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
> > +}
> > +
> > +static ssize_t ima_log_trim_write(struct file *file,
> > +				  const char __user *buf, size_t datalen, loff_t *ppos)
> > +{
> > +	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
> > +	long count, n;
> > +	int ret;
> > +
> > +	mutex_lock(&ima_trim_list_mutex);
> > +
> > +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	n =3D (int)datalen;
> > +
> > +	ret =3D copy_from_user(req, buf, datalen);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	count =3D 0;
> > +	for (int i =3D 0; i < n; ++i) {
> > +		if (req[i] < '0' || req[i] > '9') {
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +		count =3D count * 10 + req[i] - '0';
> > +	}
> > +	ret =3D ima_purge_event_log(count);
> > +
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	trimcount =3D ret;
> > +	ret =3D datalen;
> > +out:
> > +	mutex_unlock(&ima_trim_list_mutex);
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations ima_log_trim_ops =3D {
> > +	.open =3D ima_log_trim_open,
> > +	.read =3D ima_log_trim_read,
> > +	.write =3D ima_log_trim_write,
> > +	.llseek =3D generic_file_llseek,
> > +};
> > +
> >  static ssize_t ima_read_policy(char *path)
> >  {
> >  	void *data =3D NULL;
> > @@ -528,6 +596,16 @@ int __init ima_fs_init(void)
> >  		goto out;
> >  	}
> > =20
> > +	dentry =3D securityfs_create_file("ima_trim_log",
> > +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> > +					ima_dir, NULL, &ima_log_trim_ops);
> > +	if (IS_ERR(dentry)) {
> > +		ret =3D PTR_ERR(dentry);
> > +		goto out;
> > +	}
> > +
> > +	trimcount =3D 0;
> > +
> >  	dentry =3D securityfs_create_file("runtime_measurements_count",
> >  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >  				   &ima_measurements_count_ops);
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index 590637e81ad1..999cd42c517c 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -220,6 +220,48 @@ int ima_add_template_entry(struct ima_template_ent=
ry *entry, int violation,
> >  	return result;
> >  }
> > =20
> > +/* Delete the IMA event logs */
> > +long ima_purge_event_log(long number_logs)
> > +{
> > +	struct ima_queue_entry *qe;
> > +	long cur =3D 0;
> > +
> > +	if (number_logs <=3D 0)
> > +		return number_logs;
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	rcu_read_lock();
>=20
> Sorry, I'm missing why rcu_read_lock() is needed.

Ah, I guess it is because of list_for_each_entry_rcu(). In that case, I
think you can add 'true' as 4th argument, since you are holding
ima_extend_list_mutex.

Roberto

> > +
> > +	/*
> > +	 * Remove this entry from both hash table and the measurement list
> > +	 * When removing from hash table, decrease the length counter
> > +	 * so that the hash table re-sizing logic works correctly
> > +	 */
> > +	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> > +		int i;
> > +
> > +		/* if CONFIG_IMA_DISABLE_HTABLE is set, the hash table is not used *=
/
> > +		if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
> > +			hlist_del_rcu(&qe->hnext);
> > +
> > +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> > +			kfree(qe->entry->template_data[i].data);
> > +			qe->entry->template_data[i].data =3D NULL;
> > +			qe->entry->template_data[i].len =3D 0;
> > +		}
> > +
> > +		atomic_long_dec(&ima_htable.len);
> > +		list_del_rcu(&qe->later);
>=20
> Missing kfree() of qe->entry and qe?
>=20
> Thanks
>=20
> Roberto
>=20
> > +		++cur;
> > +		if (cur >=3D number_logs)
> > +			break;
> > +	}
> > +
> > +	rcu_read_unlock();
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +	return cur;
> > +}
> > +
> >  int ima_restore_measurement_entry(struct ima_template_entry *entry)
> >  {
> >  	int result =3D 0;


