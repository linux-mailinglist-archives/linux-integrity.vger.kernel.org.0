Return-Path: <linux-integrity+bounces-9410-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMIJIoSW+GkhwwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9410-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 14:52:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F24BD414
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04A013011C6B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C437C10F;
	Mon,  4 May 2026 12:52:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB440DFD4;
	Mon,  4 May 2026 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899138; cv=none; b=el7D5KjdRj4igQYt23F0UGdPihSDYIGBzZUW+qbszqI2tRR3jzbxMZP+1gd2mWa3T9deUWRwvWnJlWn8JSkTvLpPOBB5n3m5UoAjHAk1qF/oMV351OX8FyJ4LGb9AnPWrkPs0RogsgMc1EJ9w842QCDiuuUUE+EpNB7vgrjYRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899138; c=relaxed/simple;
	bh=Dghzi6PAOFb3nd4Yyuus1XIeK0NG6wZaSiGIx95O2y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kty+szOJ//iDc3uJEuA1qrGdJL3N5MT+/UuvNjwsWRmG6WSb8Ogyzh+4Tmr2OUppxFP5SeqfZ5lniv2Xo1HEin6jP/dNpuG9AGbyhxCBDfs27qyGn7E3TBsIrND6GNx1MQY62vTYEtZqrmlC7W5NIAwTxjmetvaqJauP8xmOYe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4g8LyS2rM6zpV84;
	Mon,  4 May 2026 20:47:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 8F1064056F;
	Mon,  4 May 2026 20:52:04 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXSKJjlvhpWOqLAA--.31170S2;
	Mon, 04 May 2026 13:52:04 +0100 (CET)
Message-ID: <ee32d47b2090ea2d5e62dd7556037d26e384fc6b.camel@huaweicloud.com>
Subject: Re: [PATCH v5 09/13] ima: Add support for staging measurements with
 prompt
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net, skhan@linuxfoundation.org, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 04 May 2026 14:51:44 +0200
In-Reply-To: <20260429160319.4162918-10-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-10-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXSKJjlvhpWOqLAA--.31170S2
X-Coremail-Antispam: 1UD129KBjvAXoWfurWUGrWUuw1Dury5XFyxZrb_yoW8uFy7Zo
	Za9rZxGF4rWrn3Cr1UKrsxtFy0gFZ5Wws7trW8Jrs8CF12qr15KayIqa1UAa1Igw4FgryU
	G34kZ340vFZ2q3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGn4gbkBcgAAsc
X-Rspamd-Queue-Id: F05F24BD414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9410-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.933];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid]

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ability of staging the IMA measurement list and deleting th=
em
> with a prompt.
>=20
> Staging means moving the current content of the measurement list to a
> separate location, and allowing users to read and delete it. This causes
> the measurement list to be atomically truncated before new measurements c=
an
> be added. Staging can be done only once at a time. In the event of kexec(=
),
> staging is reverted and staged entries will be carried over to the new
> kernel.
>=20
> Introduce ascii_runtime_measurements_<algo>_staged and
> binary_runtime_measurements_<algo>_staged interfaces to access and delete
> the measurements. Also, add write permission to the original measurement
> interfaces.
>=20
> Use 'echo A > <IMA original interface>' and
> 'echo D > <IMA _staged interface>' to respectively stage and delete the
> entire measurements list. Locking of these interfaces is also mediated wi=
th
> a call to _ima_measurements_open() and with ima_measurements_release().

While doing the staging in the original interface looks more intuitive,
since it is interface the user operates on, it causes loss of
transaction atomicity.

An agent opening the original interface has to close it, open the
staged interface to read and delete the staged measurement. Other
agents can open the staged interface first and do operations the
original agent didn't intend to do.

Will restore the previous behavior of staging/reading/deleting on the
staged interface. Will keep deleting N entries on the original
interface, since there is no risk of races.

Roberto

> Implement the staging functionality by introducing the new global
> measurements list ima_measurements_staged, and ima_queue_stage() and
> ima_queue_staged_delete_all() to respectively move measurements from the
> current measurements list to the staged one, and to move staged
> measurements to the ima_measurements_trim list for deletion. Introduce
> ima_queue_delete() to delete the measurements.
>=20
> Finally, introduce the BINARY_STAGED and BINARY_FULL binary measurements
> list types, to maintain the counters and the binary size of staged
> measurements and the full measurements list (including entries that were
> staged). BINARY still represents the current binary measurements list.
>=20
> Use the binary size for the BINARY + BINARY_STAGED types in
> ima_add_kexec_buffer(), since both measurements list types are copied to
> the secondary kernel during kexec. Use BINARY_FULL in
> ima_measure_kexec_event(), to generate a critical data record.
>=20
> It should be noted that the BINARY_FULL counter is not passed through
> kexec. Thus, the number of entries included in the kexec critical data
> records refers to the entries since the previous kexec records.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Gregory Lumen <gregorylumen@linux.microsoft.com> (staging r=
evert)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/Kconfig     |  13 +++
>  security/integrity/ima/ima.h       |   8 +-
>  security/integrity/ima/ima_fs.c    | 181 ++++++++++++++++++++++++++---
>  security/integrity/ima/ima_kexec.c |  24 +++-
>  security/integrity/ima/ima_queue.c |  97 +++++++++++++++-
>  5 files changed, 302 insertions(+), 21 deletions(-)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 862fbee2b174..48c906793efb 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -332,4 +332,17 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
>  	  If set to the default value of 0, an extra half page of memory for th=
ose
>  	  additional measurements will be allocated.
> =20
> +config IMA_STAGING
> +	bool "Support for staging the measurements list"
> +	default y
> +	help
> +	  Add support for staging the measurements list.
> +
> +	  It allows user space to stage the measurements list for deletion and
> +	  to delete the staged measurements after confirmation.
> +
> +	  On kexec, staging is reverted and staged measurements are prepended
> +	  to the current measurements list when measurements are copied to the
> +	  secondary kernel.
> +
>  endif
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index f8ab6b604c0d..ca8fa43ec72b 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -30,9 +30,11 @@ enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_PC=
R10 =3D 10 };
> =20
>  /*
>   * BINARY: current binary measurements list
> + * BINARY_STAGED: staged binary measurements list
> + * BINARY_FULL: binary measurements list since IMA init (lost after kexe=
c)
>   */
>  enum binary_lists {
> -	BINARY, BINARY__LAST
> +	BINARY, BINARY_STAGED, BINARY_FULL, BINARY__LAST
>  };
> =20
>  /* digest size for IMA, fits SHA1 or MD5 */
> @@ -125,6 +127,7 @@ struct ima_queue_entry {
>  	struct ima_template_entry *entry;
>  };
>  extern struct list_head ima_measurements;	/* list of all measurements */
> +extern struct list_head ima_measurements_staged; /* list of staged meas.=
 */
> =20
>  /* Some details preceding the binary serialized measurement list */
>  struct ima_kexec_hdr {
> @@ -315,6 +318,8 @@ struct ima_template_desc *ima_template_desc_current(v=
oid);
>  struct ima_template_desc *ima_template_desc_buf(void);
>  struct ima_template_desc *lookup_template_desc(const char *name);
>  bool ima_template_has_modsig(const struct ima_template_desc *ima_templat=
e);
> +int ima_queue_stage(void);
> +int ima_queue_staged_delete_all(void);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> @@ -335,6 +340,7 @@ extern spinlock_t ima_queue_lock;
>  extern atomic_long_t ima_num_entries[BINARY__LAST];
>  extern atomic_long_t ima_num_violations;
>  extern struct hlist_head __rcu *ima_htable;
> +extern struct mutex ima_extend_list_mutex;
> =20
>  static inline unsigned int ima_hash_key(u8 *digest)
>  {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 7709a4576322..088d5a69aa92 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -24,6 +24,13 @@
> =20
>  #include "ima.h"
> =20
> +/*
> + * Requests:
> + * 'A\n': stage the entire measurements list
> + * 'D\n': delete all staged measurements
> + */
> +#define STAGED_REQ_LENGTH 21
> +
>  static DEFINE_MUTEX(ima_write_mutex);
>  static DEFINE_MUTEX(ima_measure_mutex);
>  static long ima_measure_users;
> @@ -97,6 +104,11 @@ static void *ima_measurements_start(struct seq_file *=
m, loff_t *pos)
>  	return _ima_measurements_start(m, pos, &ima_measurements);
>  }
> =20
> +static void *ima_measurements_staged_start(struct seq_file *m, loff_t *p=
os)
> +{
> +	return _ima_measurements_start(m, pos, &ima_measurements_staged);
> +}
> +
>  static void *_ima_measurements_next(struct seq_file *m, void *v, loff_t =
*pos,
>  				    struct list_head *head)
>  {
> @@ -118,6 +130,12 @@ static void *ima_measurements_next(struct seq_file *=
m, void *v, loff_t *pos)
>  	return _ima_measurements_next(m, v, pos, &ima_measurements);
>  }
> =20
> +static void *ima_measurements_staged_next(struct seq_file *m, void *v,
> +					  loff_t *pos)
> +{
> +	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
> +}
> +
>  static void ima_measurements_stop(struct seq_file *m, void *v)
>  {
>  }
> @@ -211,6 +229,13 @@ static const struct seq_operations ima_measurments_s=
eqops =3D {
>  	.show =3D ima_measurements_show
>  };
> =20
> +static const struct seq_operations ima_measurments_staged_seqops =3D {
> +	.start =3D ima_measurements_staged_start,
> +	.next =3D ima_measurements_staged_next,
> +	.stop =3D ima_measurements_stop,
> +	.show =3D ima_measurements_show
> +};
> +
>  static int ima_measure_lock(bool write)
>  {
>  	mutex_lock(&ima_measure_mutex);
> @@ -276,9 +301,78 @@ static int ima_measurements_release(struct inode *in=
ode, struct file *file)
>  	return ret;
>  }
> =20
> +static int ima_measurements_staged_open(struct inode *inode, struct file=
 *file)
> +{
> +	return _ima_measurements_open(inode, file,
> +				      &ima_measurments_staged_seqops);
> +}
> +
> +static ssize_t _ima_measurements_write(struct file *file,
> +				       const char __user *buf, size_t datalen,
> +				       loff_t *ppos, bool staged_interface)
> +{
> +	char req[STAGED_REQ_LENGTH];
> +	int ret;
> +
> +	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> +		return -EINVAL;
> +
> +	if (copy_from_user(req, buf, datalen) !=3D 0)
> +		return -EFAULT;
> +
> +	if (req[datalen - 1] !=3D '\n')
> +		return -EINVAL;
> +
> +	req[datalen - 1] =3D '\0';
> +
> +	switch (req[0]) {
> +	case 'A':
> +		if (datalen !=3D 2 || staged_interface)
> +			return -EINVAL;
> +
> +		ret =3D ima_queue_stage();
> +		break;
> +	case 'D':
> +		if (datalen !=3D 2 || !staged_interface)
> +			return -EINVAL;
> +
> +		ret =3D ima_queue_staged_delete_all();
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return datalen;
> +}
> +
> +static ssize_t ima_measurements_write(struct file *file, const char __us=
er *buf,
> +				      size_t datalen, loff_t *ppos)
> +{
> +	return _ima_measurements_write(file, buf, datalen, ppos, false);
> +}
> +
> +static ssize_t ima_measurements_staged_write(struct file *file,
> +					     const char __user *buf,
> +					     size_t datalen, loff_t *ppos)
> +{
> +	return _ima_measurements_write(file, buf, datalen, ppos, true);
> +}
> +
>  static const struct file_operations ima_measurements_ops =3D {
>  	.open =3D ima_measurements_open,
>  	.read =3D seq_read,
> +	.write =3D ima_measurements_write,
> +	.llseek =3D seq_lseek,
> +	.release =3D ima_measurements_release,
> +};
> +
> +static const struct file_operations ima_measurements_staged_ops =3D {
> +	.open =3D ima_measurements_staged_open,
> +	.read =3D seq_read,
> +	.write =3D ima_measurements_staged_write,
>  	.llseek =3D seq_lseek,
>  	.release =3D ima_measurements_release,
>  };
> @@ -352,6 +446,29 @@ static int ima_ascii_measurements_open(struct inode =
*inode, struct file *file)
>  static const struct file_operations ima_ascii_measurements_ops =3D {
>  	.open =3D ima_ascii_measurements_open,
>  	.read =3D seq_read,
> +	.write =3D ima_measurements_write,
> +	.llseek =3D seq_lseek,
> +	.release =3D ima_measurements_release,
> +};
> +
> +static const struct seq_operations ima_ascii_measurements_staged_seqops =
=3D {
> +	.start =3D ima_measurements_staged_start,
> +	.next =3D ima_measurements_staged_next,
> +	.stop =3D ima_measurements_stop,
> +	.show =3D ima_ascii_measurements_show
> +};
> +
> +static int ima_ascii_measurements_staged_open(struct inode *inode,
> +					      struct file *file)
> +{
> +	return _ima_measurements_open(inode, file,
> +				      &ima_ascii_measurements_staged_seqops);
> +}
> +
> +static const struct file_operations ima_ascii_measurements_staged_ops =
=3D {
> +	.open =3D ima_ascii_measurements_staged_open,
> +	.read =3D seq_read,
> +	.write =3D ima_measurements_staged_write,
>  	.llseek =3D seq_lseek,
>  	.release =3D ima_measurements_release,
>  };
> @@ -459,10 +576,20 @@ static const struct seq_operations ima_policy_seqop=
s =3D {
>  };
>  #endif
> =20
> -static int __init create_securityfs_measurement_lists(void)
> +static int __init create_securityfs_measurement_lists(bool staging)
>  {
> +	const struct file_operations *ascii_ops =3D &ima_ascii_measurements_ops=
;
> +	const struct file_operations *binary_ops =3D &ima_measurements_ops;
> +	mode_t permissions =3D (S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP);
> +	const char *file_suffix =3D "";
>  	int count =3D NR_BANKS(ima_tpm_chip);
> =20
> +	if (staging) {
> +		ascii_ops =3D &ima_ascii_measurements_staged_ops;
> +		binary_ops =3D &ima_measurements_staged_ops;
> +		file_suffix =3D "_staged";
> +	}
> +
>  	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
>  		count++;
> =20
> @@ -473,29 +600,32 @@ static int __init create_securityfs_measurement_lis=
ts(void)
> =20
>  		if (algo =3D=3D HASH_ALGO__LAST)
>  			snprintf(file_name, sizeof(file_name),
> -				 "ascii_runtime_measurements_tpm_alg_%x",
> -				 ima_tpm_chip->allocated_banks[i].alg_id);
> +				 "ascii_runtime_measurements_tpm_alg_%x%s",
> +				 ima_tpm_chip->allocated_banks[i].alg_id,
> +				 file_suffix);
>  		else
>  			snprintf(file_name, sizeof(file_name),
> -				 "ascii_runtime_measurements_%s",
> -				 hash_algo_name[algo]);
> -		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +				 "ascii_runtime_measurements_%s%s",
> +				 hash_algo_name[algo], file_suffix);
> +		dentry =3D securityfs_create_file(file_name, permissions,
>  						ima_dir, (void *)(uintptr_t)i,
> -						&ima_ascii_measurements_ops);
> +						ascii_ops);
>  		if (IS_ERR(dentry))
>  			return PTR_ERR(dentry);
> =20
>  		if (algo =3D=3D HASH_ALGO__LAST)
>  			snprintf(file_name, sizeof(file_name),
> -				 "binary_runtime_measurements_tpm_alg_%x",
> -				 ima_tpm_chip->allocated_banks[i].alg_id);
> +				 "binary_runtime_measurements_tpm_alg_%x%s",
> +				 ima_tpm_chip->allocated_banks[i].alg_id,
> +				 file_suffix);
>  		else
>  			snprintf(file_name, sizeof(file_name),
> -				 "binary_runtime_measurements_%s",
> -				 hash_algo_name[algo]);
> -		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +				 "binary_runtime_measurements_%s%s",
> +				 hash_algo_name[algo], file_suffix);
> +
> +		dentry =3D securityfs_create_file(file_name, permissions,
>  						ima_dir, (void *)(uintptr_t)i,
> -						&ima_measurements_ops);
> +						binary_ops);
>  		if (IS_ERR(dentry))
>  			return PTR_ERR(dentry);
>  	}
> @@ -503,6 +633,23 @@ static int __init create_securityfs_measurement_list=
s(void)
>  	return 0;
>  }
> =20
> +static int __init create_securityfs_staging_links(void)
> +{
> +	struct dentry *dentry;
> +
> +	dentry =3D securityfs_create_symlink("binary_runtime_measurements_stage=
d",
> +		ima_dir, "binary_runtime_measurements_sha1_staged", NULL);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	dentry =3D securityfs_create_symlink("ascii_runtime_measurements_staged=
",
> +		ima_dir, "ascii_runtime_measurements_sha1_staged", NULL);
> +	if (IS_ERR(dentry))
> +		return PTR_ERR(dentry);
> +
> +	return 0;
> +}
> +
>  /*
>   * ima_open_policy: sequentialize access to the policy file
>   */
> @@ -595,7 +742,13 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
> =20
> -	ret =3D create_securityfs_measurement_lists();
> +	ret =3D create_securityfs_measurement_lists(false);
> +	if (ret =3D=3D 0 && IS_ENABLED(CONFIG_IMA_STAGING)) {
> +		ret =3D create_securityfs_measurement_lists(true);
> +		if (ret =3D=3D 0)
> +			ret =3D create_securityfs_staging_links();
> +	}
> +
>  	if (ret !=3D 0)
>  		goto out;
> =20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index d7d0fb639d99..064cfce0c318 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -42,8 +42,8 @@ void ima_measure_kexec_event(const char *event_name)
>  	long len;
>  	int n;
> =20
> -	buf_size =3D ima_get_binary_runtime_size(BINARY);
> -	len =3D atomic_long_read(&ima_num_entries[BINARY]);
> +	buf_size =3D ima_get_binary_runtime_size(BINARY_FULL);
> +	len =3D atomic_long_read(&ima_num_entries[BINARY_FULL]);
> =20
>  	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>  		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> @@ -106,13 +106,28 @@ static int ima_dump_measurement_list(unsigned long =
*buffer_size, void **buffer,
> =20
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version =3D 1;
> -	/* This is an append-only list, no need to hold the RCU read lock */
> -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +	/*
> +	 * It can race with ima_queue_stage() and ima_queue_staged_delete_all()=
.
> +	 */
> +	mutex_lock(&ima_extend_list_mutex);
> +
> +	list_for_each_entry_rcu(qe, &ima_measurements_staged, later,
> +				lockdep_is_held(&ima_extend_list_mutex)) {
>  		ret =3D ima_dump_measurement(&khdr, qe);
>  		if (ret < 0)
>  			break;
>  	}
> =20
> +	list_for_each_entry_rcu(qe, &ima_measurements, later,
> +				lockdep_is_held(&ima_extend_list_mutex)) {
> +		if (!ret)
> +			ret =3D ima_dump_measurement(&khdr, qe);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
>  	/*
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
> @@ -167,6 +182,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		extra_memory =3D CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> =20
>  	binary_runtime_size =3D ima_get_binary_runtime_size(BINARY) +
> +			      ima_get_binary_runtime_size(BINARY_STAGED) +
>  			      extra_memory;
> =20
>  	if (binary_runtime_size >=3D ULONG_MAX - PAGE_SIZE)
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index b6d10dceb669..50519ed837d4 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -26,6 +26,7 @@
>  static struct tpm_digest *digests;
> =20
>  LIST_HEAD(ima_measurements);	/* list of all measurements */
> +LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
>  #ifdef CONFIG_IMA_KEXEC
>  static unsigned long binary_runtime_size[BINARY__LAST];
>  #else
> @@ -45,11 +46,11 @@ atomic_long_t ima_num_violations =3D ATOMIC_LONG_INIT=
(0);
>  /* key: inode (before secure-hashing a file) */
>  struct hlist_head __rcu *ima_htable;
> =20
> -/* mutex protects atomicity of extending measurement list
> +/* mutex protects atomicity of extending and staging measurement list
>   * and extending the TPM PCR aggregate. Since tpm_extend can take
>   * long (and the tpm driver uses a mutex), we can't use the spinlock.
>   */
> -static DEFINE_MUTEX(ima_extend_list_mutex);
> +DEFINE_MUTEX(ima_extend_list_mutex);
> =20
>  /*
>   * Used internally by the kernel to suspend measurements.
> @@ -174,12 +175,16 @@ static int ima_add_digest_entry(struct ima_template=
_entry *entry,
>  				lockdep_is_held(&ima_extend_list_mutex));
> =20
>  	atomic_long_inc(&ima_num_entries[BINARY]);
> +	atomic_long_inc(&ima_num_entries[BINARY_FULL]);
> +
>  	if (update_htable) {
>  		key =3D ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
>  		hlist_add_head_rcu(&qe->hnext, &htable[key]);
>  	}
> =20
>  	ima_update_binary_runtime_size(entry, BINARY);
> +	ima_update_binary_runtime_size(entry, BINARY_FULL);
> +
>  	return 0;
>  }
> =20
> @@ -280,6 +285,94 @@ int ima_add_template_entry(struct ima_template_entry=
 *entry, int violation,
>  	return result;
>  }
> =20
> +int ima_queue_stage(void)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (!list_empty(&ima_measurements_staged)) {
> +		ret =3D -EEXIST;
> +		goto out_unlock;
> +	}
> +
> +	if (list_empty(&ima_measurements)) {
> +		ret =3D -ENOENT;
> +		goto out_unlock;
> +	}
> +
> +	list_replace(&ima_measurements, &ima_measurements_staged);
> +	INIT_LIST_HEAD(&ima_measurements);
> +
> +	atomic_long_set(&ima_num_entries[BINARY_STAGED],
> +			atomic_long_read(&ima_num_entries[BINARY]));
> +	atomic_long_set(&ima_num_entries[BINARY], 0);
> +
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
> +		binary_runtime_size[BINARY_STAGED] =3D
> +					binary_runtime_size[BINARY];
> +		binary_runtime_size[BINARY] =3D 0;
> +	}
> +out_unlock:
> +	mutex_unlock(&ima_extend_list_mutex);
> +	return ret;
> +}
> +
> +static void ima_queue_delete(struct list_head *head);
> +
> +int ima_queue_staged_delete_all(void)
> +{
> +	LIST_HEAD(ima_measurements_trim);
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (list_empty(&ima_measurements_staged)) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ENOENT;
> +	}
> +
> +	list_replace(&ima_measurements_staged, &ima_measurements_trim);
> +	INIT_LIST_HEAD(&ima_measurements_staged);
> +
> +	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
> +
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +		binary_runtime_size[BINARY_STAGED] =3D 0;
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	ima_queue_delete(&ima_measurements_trim);
> +	return 0;
> +}
> +
> +static void ima_queue_delete(struct list_head *head)
> +{
> +	struct ima_queue_entry *qe, *qe_tmp;
> +	unsigned int i;
> +
> +	list_for_each_entry_safe(qe, qe_tmp, head, later) {
> +		/*
> +		 * Safe to free template_data here without synchronize_rcu()
> +		 * because the only htable reader, ima_lookup_digest_entry(),
> +		 * accesses only entry->digests, not template_data. If new
> +		 * htable readers are added that access template_data, a
> +		 * synchronize_rcu() is required here.
> +		 */
> +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> +			kfree(qe->entry->template_data[i].data);
> +			qe->entry->template_data[i].data =3D NULL;
> +			qe->entry->template_data[i].len =3D 0;
> +		}
> +
> +		list_del(&qe->later);
> +
> +		/* No leak if condition is false, referenced by ima_htable. */
> +		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
> +			kfree(qe->entry->digests);
> +			kfree(qe->entry);
> +			kfree(qe);
> +		}
> +	}
> +}
> +
>  int ima_restore_measurement_entry(struct ima_template_entry *entry)
>  {
>  	int result =3D 0;


