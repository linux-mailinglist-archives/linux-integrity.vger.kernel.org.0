Return-Path: <linux-integrity+bounces-7910-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95300CB57FC
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 11:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF512301C905
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 10:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2E2E62C3;
	Thu, 11 Dec 2025 10:19:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD60B3B8D64;
	Thu, 11 Dec 2025 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448352; cv=none; b=N1WPHRO/zLHCz0O7i2RifyMIXUsW1ZKFjb5Vuii+hlNWhUoP+eq3bzZKzhJ8T87I19qQqBecBr+TN0sUYtik+GT986wsiheDT+PhIrlvD2p1J4txGc1aiID1x7oepYW+HrZXh8RKHmQO8iQzoKVkWz852v9jFHBp4VkJVPdA5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448352; c=relaxed/simple;
	bh=6ywBRoXcJKXG/UQnqwabQNhE2r6YTwcSFHsC7CVa5HA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1eV4KicnMJ3+gD0yPxNfo/U2dOyLKuUxTGl7kFrOWdMo5bEmOayjvMNPcHEv9dNLjzlFgFV3R/nyy7oLXjeTLO2CkN5g7iHLM2lU/m198C7iCLybR73E9Fjh9FCmv3GfGz7YYwhiuYpnxMvN8oazgcjP9zU45fidA281lhZrvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRpRq2zWrzsjSL;
	Thu, 11 Dec 2025 18:17:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id EEC3D40099;
	Thu, 11 Dec 2025 18:19:01 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3jDCJmjppNr27AA--.17602S2;
	Thu, 11 Dec 2025 11:19:00 +0100 (CET)
Message-ID: <d6ef2d61a2c31c0ae46741b6bd78f38bc02e6141.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, corbet@lwn.net, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Thu, 11 Dec 2025 11:18:47 +0100
In-Reply-To: <9cb4cbab-bcca-4ac8-a7a5-0cf3de67353e@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
	 <9cb4cbab-bcca-4ac8-a7a5-0cf3de67353e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwA3jDCJmjppNr27AA--.17602S2
X-Coremail-Antispam: 1UD129KBjvAXoWftry8Xr4rKryrXw43AF4DXFb_yoW5Jr45Xo
	ZagrZ3GF4xGrn5Cw1UGrs8tFy8Wa98Ww1xtrW8trsxuF12gF4UKa17XF1UZa1Sqa15tw47
	Ga4kJ340vFZ2gwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGk5YOwNpwABsi

On Wed, 2025-12-10 at 16:03 -0800, steven chen wrote:
> On 12/9/2025 2:17 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the ability of staging the entire of the IMA measurement list=
, or
> > a portion, for deletion. Staging means moving the current content of th=
e
> > measurement list to a separate location, and allowing users to read and
> > delete it. This causes the measurement list to be atomically truncated
> > before new measurements can be added. Staging can be done only once at =
a
> > time.
> >=20
> > User space is responsible to concatenate the staged IMA measurements li=
st
> > portions following the temporal order in which the operations were done=
,
> > together with the current measurement list. Then, it can send the colle=
cted
> > data to the remote verifiers.
> >=20
> > The benefit of this solution is the ability to free precious kernel mem=
ory,
> > in exchange of delegating user space to reconstruct the full measuremen=
t
> > list from the chunks. No trust needs to be given to user space, since t=
he
> > integrity of the measurement list is protected by the TPM.
> >=20
> > By default, staging the measurements list for deletion does not alter t=
he
> > hash table. When staging is done, IMA is still able to detect collision=
s on
> > the staged and later deleted measurement entries, by keeping the entry
> > digests (only template data are freed).
> >=20
> > However, since during the measurements list serialization only the SHA1
> > digest is passed, and since there are no template data to recalculate t=
he
> > other digests from, the hash table is currently not populated with dige=
sts
> > from staged/deleted entries after kexec().
> >=20
> > Introduce the new kernel option ima_flush_htable to decide whether or n=
ot
> > the digests of staged measurement entries are flushed from the hash tab=
le.
> >=20
> > Then, introduce ascii_runtime_measurements_staged_<algo> and
> > binary_runtime_measurement_staged_<algo> interfaces to stage/delete the
> > measurements. Use 'echo A > <IMA interface>' and 'echo D > <IMA interfa=
ce>'
> > to respectively stage and delete the entire measurements list. Use
> > 'echo N > <IMA interface>', with N between 1 and ULONG_MAX, to stage th=
e
> > selected portion of the measurements list.
> >=20
> > The ima_measure_users counter (protected by the ima_measure_lock mutex)=
 has
> > been introduced to protect access to the measurement list and the stage=
d
> > part. The open method of all the measurement interfaces has been extend=
ed
> > to allow only one writer at a time or, in alternative, multiple readers=
.
> > The write permission is used to stage/delete the measurements, the read
> > permission to read them. Write requires also the CAP_SYS_ADMIN capabili=
ty.
>=20
> Hi Roberto,
>=20
> I released version 2 of trim N entries patch as bellow:
>=20
> [PATCH v2 0/1] Trim N entries of IMA event logs=20
> <https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@li=
nux.microsoft.com/T/#t>
>=20
> I adapted some of your idea and I think trim N has following advantages:
> 1: less measurement list hold time than your current implementation
> 2. operation much simple for user space
> 3. less kernel code change
> 4. no potential issue as Gregory mentioned.

Please have a look at:

https://marc.info/?l=3Dlinux-integrity&m=3D176545085325473&w=3D2

and let me know if I'm missing something.

Thanks

Roberto

> Thanks,
>=20
> Steven
>=20
> > Finally, introduce the _notrim version of the run-time measurements cou=
nt
> > and the binary measurements list size, to display them in the kexec-rel=
ated
> > critical data records.
> >=20
> > Note: This code derives from the Alt-IMA Huawei project, and is being
> >        released under the dual license model (GPL-2.0 OR MIT).
> >=20
> > Link: https://github.com/linux-integrity/linux/issues/1
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   .../admin-guide/kernel-parameters.txt         |   4 +
> >   security/integrity/ima/ima.h                  |  10 +-
> >   security/integrity/ima/ima_fs.c               | 222 +++++++++++++++++=
-
> >   security/integrity/ima/ima_kexec.c            |  13 +-
> >   security/integrity/ima/ima_queue.c            | 111 ++++++++-
> >   5 files changed, 340 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 6c42061ca20e..355d8930e3ac 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2215,6 +2215,10 @@
> >   			Use the canonical format for the binary runtime
> >   			measurements, instead of host native format.
> >  =20
> > +	ima_flush_htable  [IMA]
> > +			Flush the measurement list hash table when staging all
> > +			or a part of it for deletion.
> > +
> >   	ima_hash=3D	[IMA]
> >   			Format: { md5 | sha1 | rmd160 | sha256 | sha384
> >   				   | sha512 | ... }
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index e3d71d8d56e3..d7aa4a0f79b1 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -117,6 +117,8 @@ struct ima_queue_entry {
> >   	struct ima_template_entry *entry;
> >   };
> >   extern struct list_head ima_measurements;	/* list of all measurements=
 */
> > +extern struct list_head ima_measurements_staged; /* list of staged mea=
s. */
> > +extern bool ima_measurements_staged_exist;	/* If there are staged meas=
. */
> >  =20
> >   /* Some details preceding the binary serialized measurement list */
> >   struct ima_kexec_hdr {
> > @@ -281,10 +283,12 @@ struct ima_template_desc *ima_template_desc_curre=
nt(void);
> >   struct ima_template_desc *ima_template_desc_buf(void);
> >   struct ima_template_desc *lookup_template_desc(const char *name);
> >   bool ima_template_has_modsig(const struct ima_template_desc *ima_temp=
late);
> > +int ima_queue_stage(unsigned long req_value);
> > +int ima_queue_delete_staged(void);
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry);
> >   int ima_restore_measurement_list(loff_t bufsize, void *buf);
> >   int ima_measurements_show(struct seq_file *m, void *v);
> > -unsigned long ima_get_binary_runtime_size(void);
> > +unsigned long ima_get_binary_runtime_size(bool notrim);
> >   int ima_init_template(void);
> >   void ima_init_template_list(void);
> >   int __init ima_init_digests(void);
> > @@ -298,11 +302,13 @@ int ima_lsm_policy_change(struct notifier_block *=
nb, unsigned long event,
> >   extern spinlock_t ima_queue_lock;
> >  =20
> >   struct ima_h_table {
> > -	atomic_long_t len;	/* number of stored measurements in the list */
> > +	atomic_long_t len;	/* current num of stored meas. in the list */
> > +	atomic_long_t len_notrim; /* total num of stored meas. in the list */
> >   	atomic_long_t violations;
> >   	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
> >   };
> >   extern struct ima_h_table ima_htable;
> > +extern struct mutex ima_extend_list_mutex;
> >  =20
> >   static inline unsigned int ima_hash_key(u8 *digest)
> >   {
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 87045b09f120..321c98ae0e55 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -24,7 +24,12 @@
> >  =20
> >   #include "ima.h"
> >  =20
> > +/* Requests: ('A', [1, ULONG_MAX])\n (stage all/N) or D\n (delete stag=
ed) */
> > +#define STAGED_REQ_LENGTH 21
> > +
> >   static DEFINE_MUTEX(ima_write_mutex);
> > +static DEFINE_MUTEX(ima_measure_lock);
> > +static long ima_measure_users;
> >  =20
> >   bool ima_canonical_fmt;
> >   static int __init default_canonical_fmt_setup(char *str)
> > @@ -74,14 +79,15 @@ static const struct file_operations ima_measurement=
s_count_ops =3D {
> >   };
> >  =20
> >   /* returns pointer to hlist_node */
> > -static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
> > +static void *_ima_measurements_start(struct seq_file *m, loff_t *pos,
> > +				     struct list_head *head)
> >   {
> >   	loff_t l =3D *pos;
> >   	struct ima_queue_entry *qe;
> >  =20
> >   	/* we need a lock since pos could point beyond last element */
> >   	rcu_read_lock();
> > -	list_for_each_entry_rcu(qe, &ima_measurements, later) {
> > +	list_for_each_entry_rcu(qe, head, later) {
> >   		if (!l--) {
> >   			rcu_read_unlock();
> >   			return qe;
> > @@ -91,7 +97,18 @@ static void *ima_measurements_start(struct seq_file =
*m, loff_t *pos)
> >   	return NULL;
> >   }
> >  =20
> > -static void *ima_measurements_next(struct seq_file *m, void *v, loff_t=
 *pos)
> > +static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	return _ima_measurements_start(m, pos, &ima_measurements);
> > +}
> > +
> > +static void *ima_measurements_staged_start(struct seq_file *m, loff_t =
*pos)
> > +{
> > +	return _ima_measurements_start(m, pos, &ima_measurements_staged);
> > +}
> > +
> > +static void *_ima_measurements_next(struct seq_file *m, void *v, loff_=
t *pos,
> > +				    struct list_head *head)
> >   {
> >   	struct ima_queue_entry *qe =3D v;
> >  =20
> > @@ -103,7 +120,18 @@ static void *ima_measurements_next(struct seq_file=
 *m, void *v, loff_t *pos)
> >   	rcu_read_unlock();
> >   	(*pos)++;
> >  =20
> > -	return (&qe->later =3D=3D &ima_measurements) ? NULL : qe;
> > +	return (&qe->later =3D=3D head) ? NULL : qe;
> > +}
> > +
> > +static void *ima_measurements_next(struct seq_file *m, void *v, loff_t=
 *pos)
> > +{
> > +	return _ima_measurements_next(m, v, pos, &ima_measurements);
> > +}
> > +
> > +static void *ima_measurements_staged_next(struct seq_file *m, void *v,
> > +					  loff_t *pos)
> > +{
> > +	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
> >   }
> >  =20
> >   static void ima_measurements_stop(struct seq_file *m, void *v)
> > @@ -202,16 +230,138 @@ static const struct seq_operations ima_measurmen=
ts_seqops =3D {
> >   	.show =3D ima_measurements_show
> >   };
> >  =20
> > +static int _ima_measurements_open(struct inode *inode, struct file *fi=
le,
> > +				  const struct seq_operations *seq_ops)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +	int ret;
> > +
> > +	if (write && !capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&ima_measure_lock);
> > +	if ((write && ima_measure_users !=3D 0) ||
> > +	    (!write && ima_measure_users < 0)) {
> > +		mutex_unlock(&ima_measure_lock);
> > +		return -EBUSY;
> > +	}
> > +
> > +	ret =3D seq_open(file, seq_ops);
> > +	if (ret < 0) {
> > +		mutex_unlock(&ima_measure_lock);
> > +		return ret;
> > +	}
> > +
> > +	if (write)
> > +		ima_measure_users--;
> > +	else
> > +		ima_measure_users++;
> > +
> > +	mutex_unlock(&ima_measure_lock);
> > +	return ret;
> > +}
> > +
> >   static int ima_measurements_open(struct inode *inode, struct file *fi=
le)
> >   {
> > -	return seq_open(file, &ima_measurments_seqops);
> > +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> > +}
> > +
> > +static int ima_measurements_release(struct inode *inode, struct file *=
file)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +	int ret;
> > +
> > +	mutex_lock(&ima_measure_lock);
> > +	ret =3D seq_release(inode, file);
> > +	if (!ret) {
> > +		if (write)
> > +			ima_measure_users++;
> > +		else
> > +			ima_measure_users--;
> > +	}
> > +
> > +	mutex_unlock(&ima_measure_lock);
> > +	return ret;
> >   }
> >  =20
> >   static const struct file_operations ima_measurements_ops =3D {
> >   	.open =3D ima_measurements_open,
> >   	.read =3D seq_read,
> >   	.llseek =3D seq_lseek,
> > -	.release =3D seq_release,
> > +	.release =3D ima_measurements_release,
> > +};
> > +
> > +static const struct seq_operations ima_measurments_staged_seqops =3D {
> > +	.start =3D ima_measurements_staged_start,
> > +	.next =3D ima_measurements_staged_next,
> > +	.stop =3D ima_measurements_stop,
> > +	.show =3D ima_measurements_show
> > +};
> > +
> > +static int ima_measurements_staged_open(struct inode *inode, struct fi=
le *file)
> > +{
> > +	return _ima_measurements_open(inode, file,
> > +				      &ima_measurments_staged_seqops);
> > +}
> > +
> > +static ssize_t ima_measurements_staged_read(struct file *file, char __=
user *buf,
> > +					    size_t size, loff_t *ppos)
> > +{
> > +	if (!ima_measurements_staged_exist)
> > +		return -ENOENT;
> > +
> > +	return seq_read(file, buf, size, ppos);
> > +}
> > +
> > +static ssize_t ima_measurements_staged_write(struct file *file,
> > +					     const char __user *buf,
> > +					     size_t datalen, loff_t *ppos)
> > +{
> > +	char req[STAGED_REQ_LENGTH], *req_ptr =3D req;
> > +	unsigned long req_value;
> > +	int ret;
> > +
> > +	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> > +		return -EINVAL;
> > +
> > +	ret =3D copy_from_user(req, buf, datalen);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (strsep(&req_ptr, "\n") =3D=3D NULL)
> > +		return -EINVAL;
> > +
> > +	switch (req[0]) {
> > +	case 'A':
> > +		if (datalen !=3D 2 || req[1] !=3D '\0')
> > +			return -EINVAL;
> > +
> > +		ret =3D ima_queue_stage(ULONG_MAX);
> > +		break;
> > +	case 'D':
> > +		if (datalen !=3D 2 || req[1] !=3D '\0')
> > +			return -EINVAL;
> > +
> > +		ret =3D ima_queue_delete_staged();
> > +		break;
> > +	default:
> > +		ret =3D kstrtoul(req, 0, &req_value);
> > +		if (!ret)
> > +			ret =3D ima_queue_stage(req_value);
> > +	}
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return datalen;
> > +}
> > +
> > +static const struct file_operations ima_measurements_staged_ops =3D {
> > +	.open =3D ima_measurements_staged_open,
> > +	.read =3D ima_measurements_staged_read,
> > +	.write =3D ima_measurements_staged_write,
> > +	.llseek =3D seq_lseek,
> > +	.release =3D ima_measurements_release,
> >   };
> >  =20
> >   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
> > @@ -279,14 +429,37 @@ static const struct seq_operations ima_ascii_meas=
urements_seqops =3D {
> >  =20
> >   static int ima_ascii_measurements_open(struct inode *inode, struct fi=
le *file)
> >   {
> > -	return seq_open(file, &ima_ascii_measurements_seqops);
> > +	return _ima_measurements_open(inode, file,
> > +				      &ima_ascii_measurements_seqops);
> >   }
> >  =20
> >   static const struct file_operations ima_ascii_measurements_ops =3D {
> >   	.open =3D ima_ascii_measurements_open,
> >   	.read =3D seq_read,
> >   	.llseek =3D seq_lseek,
> > -	.release =3D seq_release,
> > +	.release =3D ima_measurements_release,
> > +};
> > +
> > +static const struct seq_operations ima_ascii_measurements_staged_seqop=
s =3D {
> > +	.start =3D ima_measurements_staged_start,
> > +	.next =3D ima_measurements_staged_next,
> > +	.stop =3D ima_measurements_stop,
> > +	.show =3D ima_ascii_measurements_show
> > +};
> > +
> > +static int ima_ascii_measurements_staged_open(struct inode *inode,
> > +					      struct file *file)
> > +{
> > +	return _ima_measurements_open(inode, file,
> > +				      &ima_ascii_measurements_staged_seqops);
> > +}
> > +
> > +static const struct file_operations ima_ascii_measurements_staged_ops =
=3D {
> > +	.open =3D ima_ascii_measurements_staged_open,
> > +	.read =3D ima_measurements_staged_read,
> > +	.write =3D ima_measurements_staged_write,
> > +	.llseek =3D seq_lseek,
> > +	.release =3D ima_measurements_release,
> >   };
> >  =20
> >   static ssize_t ima_read_policy(char *path)
> > @@ -419,6 +592,25 @@ static int __init create_securityfs_measurement_li=
sts(void)
> >   						&ima_measurements_ops);
> >   		if (IS_ERR(dentry))
> >   			return PTR_ERR(dentry);
> > +
> > +		sprintf(file_name, "ascii_runtime_measurements_staged_%s",
> > +			hash_algo_name[algo]);
> > +		dentry =3D securityfs_create_file(file_name,
> > +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> > +					ima_dir, (void *)(uintptr_t)i,
> > +					&ima_ascii_measurements_staged_ops);
> > +		if (IS_ERR(dentry))
> > +			return PTR_ERR(dentry);
> > +
> > +		sprintf(file_name, "binary_runtime_measurements_staged_%s",
> > +			hash_algo_name[algo]);
> > +		dentry =3D securityfs_create_file(file_name,
> > +						S_IRUSR | S_IRGRP |
> > +						S_IWUSR | S_IWGRP,
> > +						ima_dir, (void *)(uintptr_t)i,
> > +						&ima_measurements_staged_ops);
> > +		if (IS_ERR(dentry))
> > +			return PTR_ERR(dentry);
> >   	}
> >  =20
> >   	return 0;
> > @@ -528,6 +720,20 @@ int __init ima_fs_init(void)
> >   		goto out;
> >   	}
> >  =20
> > +	dentry =3D securityfs_create_symlink("binary_runtime_measurements_sta=
ged",
> > +		ima_dir, "binary_runtime_measurements_staged_sha1", NULL);
> > +	if (IS_ERR(dentry)) {
> > +		ret =3D PTR_ERR(dentry);
> > +		goto out;
> > +	}
> > +
> > +	dentry =3D securityfs_create_symlink("ascii_runtime_measurements_stag=
ed",
> > +		ima_dir, "ascii_runtime_measurements_staged_sha1", NULL);
> > +	if (IS_ERR(dentry)) {
> > +		ret =3D PTR_ERR(dentry);
> > +		goto out;
> > +	}
> > +
> >   	dentry =3D securityfs_create_file("runtime_measurements_count",
> >   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >   				   &ima_measurements_count_ops);
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..23a20300da7b 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -40,8 +40,8 @@ void ima_measure_kexec_event(const char *event_name)
> >   	long len;
> >   	int n;
> >  =20
> > -	buf_size =3D ima_get_binary_runtime_size();
> > -	len =3D atomic_long_read(&ima_htable.len);
> > +	buf_size =3D ima_get_binary_runtime_size(true);
> > +	len =3D atomic_long_read(&ima_htable.len_notrim);
> >  =20
> >   	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> >   		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> > @@ -93,8 +93,10 @@ static int ima_dump_measurement_list(unsigned long *=
buffer_size, void **buffer,
> >  =20
> >   	memset(&khdr, 0, sizeof(khdr));
> >   	khdr.version =3D 1;
> > -	/* This is an append-only list, no need to hold the RCU read lock */
> > -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> > +
> > +	/* It can race with ima_queue_stage(). */
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	list_for_each_entry(qe, &ima_measurements, later) {
> >   		if (ima_kexec_file.count < ima_kexec_file.size) {
> >   			khdr.count++;
> >   			ima_measurements_show(&ima_kexec_file, qe);
> > @@ -103,6 +105,7 @@ static int ima_dump_measurement_list(unsigned long =
*buffer_size, void **buffer,
> >   			break;
> >   		}
> >   	}
> > +	mutex_unlock(&ima_extend_list_mutex);
> >  =20
> >   	/*
> >   	 * fill in reserved space with some buffer details
> > @@ -157,7 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
> >   	else
> >   		extra_memory =3D CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> >  =20
> > -	binary_runtime_size =3D ima_get_binary_runtime_size() + extra_memory;
> > +	binary_runtime_size =3D ima_get_binary_runtime_size(false) + extra_me=
mory;
> >  =20
> >   	if (binary_runtime_size >=3D ULONG_MAX - PAGE_SIZE)
> >   		kexec_segment_size =3D ULONG_MAX;
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index 590637e81ad1..868f216ac343 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -22,19 +22,32 @@
> >  =20
> >   #define AUDIT_CAUSE_LEN_MAX 32
> >  =20
> > +bool ima_flush_htable;
> > +static int __init ima_flush_htable_setup(char *str)
> > +{
> > +	ima_flush_htable =3D true;
> > +	return 1;
> > +}
> > +__setup("ima_flush_htable", ima_flush_htable_setup);
> > +
> >   /* pre-allocated array of tpm_digest structures to extend a PCR */
> >   static struct tpm_digest *digests;
> >  =20
> >   LIST_HEAD(ima_measurements);	/* list of all measurements */
> > +LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
> > +bool ima_measurements_staged_exist; /* If there are staged measurement=
s */
> >   #ifdef CONFIG_IMA_KEXEC
> >   static unsigned long binary_runtime_size;
> > +static unsigned long binary_runtime_size_notrim;
> >   #else
> >   static unsigned long binary_runtime_size =3D ULONG_MAX;
> > +static unsigned long binary_runtime_size_notrim =3D ULONG_MAX;
> >   #endif
> >  =20
> >   /* key: inode (before secure-hashing a file) */
> >   struct ima_h_table ima_htable =3D {
> >   	.len =3D ATOMIC_LONG_INIT(0),
> > +	.len_notrim =3D ATOMIC_LONG_INIT(0),
> >   	.violations =3D ATOMIC_LONG_INIT(0),
> >   	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] =3D HLIST_HEAD_INIT
> >   };
> > @@ -43,7 +56,7 @@ struct ima_h_table ima_htable =3D {
> >    * and extending the TPM PCR aggregate. Since tpm_extend can take
> >    * long (and the tpm driver uses a mutex), we can't use the spinlock.
> >    */
> > -static DEFINE_MUTEX(ima_extend_list_mutex);
> > +DEFINE_MUTEX(ima_extend_list_mutex);
> >  =20
> >   /*
> >    * Used internally by the kernel to suspend measurements.
> > @@ -114,15 +127,19 @@ static int ima_add_digest_entry(struct ima_templa=
te_entry *entry,
> >   	list_add_tail_rcu(&qe->later, &ima_measurements);
> >  =20
> >   	atomic_long_inc(&ima_htable.len);
> > +	atomic_long_inc(&ima_htable.len_notrim);
> >   	if (update_htable) {
> >   		key =3D ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
> >   		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
> >   	}
> >  =20
> > -	if (binary_runtime_size !=3D ULONG_MAX) {
> > +	if (binary_runtime_size_notrim !=3D ULONG_MAX) {
> >   		int size;
> >  =20
> >   		size =3D get_binary_runtime_size(entry);
> > +		binary_runtime_size_notrim =3D
> > +		     (binary_runtime_size_notrim < ULONG_MAX - size) ?
> > +		     binary_runtime_size_notrim + size : ULONG_MAX;
> >   		binary_runtime_size =3D (binary_runtime_size < ULONG_MAX - size) ?
> >   		     binary_runtime_size + size : ULONG_MAX;
> >   	}
> > @@ -134,12 +151,18 @@ static int ima_add_digest_entry(struct ima_templa=
te_entry *entry,
> >    * entire binary_runtime_measurement list, including the ima_kexec_hd=
r
> >    * structure.
> >    */
> > -unsigned long ima_get_binary_runtime_size(void)
> > +unsigned long ima_get_binary_runtime_size(bool notrim)
> >   {
> > -	if (binary_runtime_size >=3D (ULONG_MAX - sizeof(struct ima_kexec_hdr=
)))
> > +	unsigned long *val;
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	val =3D (notrim) ? &binary_runtime_size_notrim : &binary_runtime_size=
;
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +
> > +	if (*val >=3D (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
> >   		return ULONG_MAX;
> >   	else
> > -		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
> > +		return *val + sizeof(struct ima_kexec_hdr);
> >   }
> >  =20
> >   static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
> > @@ -220,6 +243,84 @@ int ima_add_template_entry(struct ima_template_ent=
ry *entry, int violation,
> >   	return result;
> >   }
> >  =20
> > +int ima_queue_stage(unsigned long req_value)
> > +{
> > +	unsigned long req_value_copy =3D req_value, to_remove =3D 0;
> > +	struct ima_queue_entry *qe;
> > +
> > +	if (ima_measurements_staged_exist)
> > +		return -EEXIST;
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	if (list_empty(&ima_measurements)) {
> > +		mutex_unlock(&ima_extend_list_mutex);
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (req_value =3D=3D ULONG_MAX) {
> > +		list_replace(&ima_measurements, &ima_measurements_staged);
> > +		INIT_LIST_HEAD(&ima_measurements);
> > +		atomic_long_set(&ima_htable.len, 0);
> > +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> > +			binary_runtime_size =3D 0;
> > +	} else {
> > +		list_for_each_entry(qe, &ima_measurements, later) {
> > +			to_remove +=3D get_binary_runtime_size(qe->entry);
> > +			if (--req_value_copy =3D=3D 0)
> > +				break;
> > +		}
> > +
> > +		if (req_value_copy > 0) {
> > +			mutex_unlock(&ima_extend_list_mutex);
> > +			return -ENOENT;
> > +		}
> > +
> > +		__list_cut_position(&ima_measurements_staged, &ima_measurements,
> > +				    &qe->later);
> > +		atomic_long_sub(req_value, &ima_htable.len);
> > +		if (IS_ENABLED(CONFIG_IMA_KEXEC))
> > +			binary_runtime_size -=3D to_remove;
> > +	}
> > +
> > +	if (ima_flush_htable) {
> > +		list_for_each_entry(qe, &ima_measurements_staged, later)
> > +			/* It can race with ima_lookup_digest_entry(). */
> > +			hlist_del_rcu(&qe->hnext);
> > +	}
> > +
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +	ima_measurements_staged_exist =3D true;
> > +	return 0;
> > +}
> > +
> > +int ima_queue_delete_staged(void)
> > +{
> > +	struct ima_queue_entry *qe, *qe_tmp;
> > +	unsigned int i;
> > +
> > +	if (!ima_measurements_staged_exist)
> > +		return -ENOENT;
> > +
> > +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later)=
 {
> > +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> > +			kfree(qe->entry->template_data[i].data);
> > +			qe->entry->template_data[i].data =3D NULL;
> > +			qe->entry->template_data[i].len =3D 0;
> > +		}
> > +
> > +		list_del(&qe->later);
> > +
> > +		if (ima_flush_htable) {
> > +			kfree(qe->entry->digests);
> > +			kfree(qe->entry);
> > +			kfree(qe);
> > +		}
> > +	}
> > +
> > +	ima_measurements_staged_exist =3D false;
> > +	return 0;
> > +}
> > +
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry)
> >   {
> >   	int result =3D 0;
>=20


