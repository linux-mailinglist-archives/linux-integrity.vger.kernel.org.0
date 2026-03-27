Return-Path: <linux-integrity+bounces-9109-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDDMBsS1xmnoNwUAu9opvQ
	(envelope-from <linux-integrity+bounces-9109-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 17:52:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F03347DA2
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 17:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E05EB304B5F5
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EE633AD99;
	Fri, 27 Mar 2026 16:45:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A21349B0A;
	Fri, 27 Mar 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629955; cv=none; b=k8voUBKpX4Nm2sSuUUZdpFn44wmGm3vLodR3NII4wyv5RH/+Kxu6S/6W9883U2Yj3gSnYyCqlBHF3W/67Ydsb+OSAvUkPTQqLiFg/BrY+jqD/HSnQ5CqCZPd69Xe/MvF9mx4z7cJfN3VpHsUKzT5b9Mg4zhsWLIJtkP11wEVLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629955; c=relaxed/simple;
	bh=Xt3HbI3lh5OcLe88yIZ0sjAuRMbDZy149zZfZvXUzHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=akz2xpApzVEsYTYvesszZ7DnCwgzvu+pqCOv/qUPZU6g0m7Yk3xxaY2nyyHfemTFXw6Z90T4v0YCxXRS5nsqo+ZrLTk4IsWvyoNnmFE/ytW3FtGz9ru02YsZeIksL7zdN2XwKTOU13mz+bQ5YP0tuckbLTxUCmPwFtA/VFgj5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fj5yp6MRnztKH7;
	Sat, 28 Mar 2026 00:42:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6E9E24056C;
	Sat, 28 Mar 2026 00:45:48 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHwe4ytMZpYGo+AQ--.53237S2;
	Fri, 27 Mar 2026 17:45:47 +0100 (CET)
Message-ID: <19a1815a1222bd78f6bfde30f60b60ebfacb65aa.camel@huaweicloud.com>
Subject: Re: [PATCH v4 09/13] ima: Add support for staging measurements with
 prompt
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, corbet@lwn.net, 
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 27 Mar 2026 17:45:36 +0100
In-Reply-To: <ef9c296a-940a-4bb5-a0b9-184532cf4bb6@linux.microsoft.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
	 <20260326173011.1191815-10-roberto.sassu@huaweicloud.com>
	 <ef9c296a-940a-4bb5-a0b9-184532cf4bb6@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHwe4ytMZpYGo+AQ--.53237S2
X-Coremail-Antispam: 1UD129KBjvAXoWfuFy8Gr13Jr1xXFWxKF4fuFg_yoW8uFyxCo
	ZagrZrGF48Wr1rCr1UGrsxtFyF9a95Ww4xJr4rJrsxCF12gF15Ka1Iqa1UZa1Iga1rG34U
	Ga4kA340vFZ2qwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGnF7qwTPgAAsD
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9109-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.991];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: C5F03347DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 15:44 -0700, steven chen wrote:
> On 3/26/2026 10:30 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the ability of staging the IMA measurement list and deleting =
them
> > with a prompt.
> >=20
> > Staging means moving the current content of the measurement list to a
> > separate location, and allowing users to read and delete it. This cause=
s
> > the measurement list to be atomically truncated before new measurements=
 can
> > be added. Staging can be done only once at a time. In the event of kexe=
c(),
> > staging is reverted and staged entries will be carried over to the new
> > kernel.
> >=20
> > Introduce ascii_runtime_measurements_<algo>_staged and
> > binary_runtime_measurements_<algo>_staged interfaces to stage and delet=
e
> > the measurements. Use 'echo A > <IMA interface>' and
> > 'echo D > <IMA interface>' to respectively stage and delete the entire
> > measurements list. Locking of these interfaces is also mediated with a =
call
> > to _ima_measurements_open() and with ima_measurements_release().
> >=20
> > Implement the staging functionality by introducing the new global
> > measurements list ima_measurements_staged, and ima_queue_stage() and
> > ima_queue_delete_staged_all() to respectively move measurements from th=
e
> > current measurements list to the staged one, and to move staged
> > measurements to the ima_measurements_trim list for deletion. Introduce
> > ima_queue_delete() to delete the measurements.
> >=20
> > Finally, introduce the BINARY_STAGED AND BINARY_FULL binary measurement=
s
> > list types, to maintain the counters and the binary size of staged
> > measurements and the full measurements list (including entries that wer=
e
> > staged). BINARY still represents the current binary measurements list.
> >=20
> > Use the binary size for the BINARY + BINARY_STAGED types in
> > ima_add_kexec_buffer(), since both measurements list types are copied t=
o
> > the secondary kernel during kexec. Use BINARY_FULL in
> > ima_measure_kexec_event(), to generate a critical data record.
> >=20
> > It should be noted that the BINARY_FULL counter is not passed through
> > kexec. Thus, the number of entries included in the kexec critical data
> > records refers to the entries since the previous kexec records.
> >=20
> > Note: This code derives from the Alt-IMA Huawei project, whose license =
is
> >        GPL-2.0 OR MIT.
> >=20
> > Link: https://github.com/linux-integrity/linux/issues/1
> > Suggested-by: Gregory Lumen <gregorylumen@linux.microsoft.com> (staging=
 revert)
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   security/integrity/ima/Kconfig     |  13 +++
> >   security/integrity/ima/ima.h       |   8 +-
> >   security/integrity/ima/ima_fs.c    | 167 ++++++++++++++++++++++++++--=
-
> >   security/integrity/ima/ima_kexec.c |  22 +++-
> >   security/integrity/ima/ima_queue.c |  97 ++++++++++++++++-
> >   5 files changed, 286 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kc=
onfig
> > index 976e75f9b9ba..e714726f3384 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -332,4 +332,17 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
> >   	  If set to the default value of 0, an extra half page of memory for=
 those
> >   	  additional measurements will be allocated.
> >  =20
> > +config IMA_STAGING
> > +	bool "Support for staging the measurements list"
> > +	default y
> > +	help
> > +	  Add support for staging the measurements list.
> > +
> > +	  It allows user space to stage the measurements list for deletion an=
d
> > +	  to delete the staged measurements after confirmation.
> > +
> > +	  On kexec, staging is reverted and staged measurements are prepended
> > +	  to the current measurements list when measurements are copied to th=
e
> > +	  secondary kernel.
> > +
> >   endif
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index 97b7d6024b5d..65db152a0a24 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -30,9 +30,11 @@ enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_=
PCR10 =3D 10 };
> >  =20
> >   /*
> >    * BINARY: current binary measurements list
> > + * BINARY_STAGED: staged binary measurements list
> > + * BINARY_FULL: binary measurements list since IMA init (lost after ke=
xec)
> >    */
> >   enum binary_lists {
> > -	BINARY, BINARY__LAST
> > +	BINARY, BINARY_STAGED, BINARY_FULL, BINARY__LAST
> >   };
> >  =20
> >   /* digest size for IMA, fits SHA1 or MD5 */
> > @@ -125,6 +127,7 @@ struct ima_queue_entry {
> >   	struct ima_template_entry *entry;
> >   };
> >   extern struct list_head ima_measurements;	/* list of all measurements=
 */
> > +extern struct list_head ima_measurements_staged; /* list of staged mea=
s. */
> >  =20
> >   /* Some details preceding the binary serialized measurement list */
> >   struct ima_kexec_hdr {
> > @@ -314,6 +317,8 @@ struct ima_template_desc *ima_template_desc_current=
(void);
> >   struct ima_template_desc *ima_template_desc_buf(void);
> >   struct ima_template_desc *lookup_template_desc(const char *name);
> >   bool ima_template_has_modsig(const struct ima_template_desc *ima_temp=
late);
> > +int ima_queue_stage(void);
> > +int ima_queue_staged_delete_all(void);
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry);
> >   int ima_restore_measurement_list(loff_t bufsize, void *buf);
> >   int ima_measurements_show(struct seq_file *m, void *v);
> > @@ -334,6 +339,7 @@ extern spinlock_t ima_queue_lock;
> >   extern atomic_long_t ima_num_entries[BINARY__LAST];
> >   extern atomic_long_t ima_num_violations;
> >   extern struct hlist_head __rcu *ima_htable;
> > +extern struct mutex ima_extend_list_mutex;
> >  =20
> >   static inline unsigned int ima_hash_key(u8 *digest)
> >   {
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 7709a4576322..39d9128e9f22 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -24,6 +24,13 @@
> >  =20
> >   #include "ima.h"
> >  =20
> > +/*
> > + * Requests:
> > + * 'A\n': stage the entire measurements list
> > + * 'D\n': delete all staged measurements
> > + */
> > +#define STAGED_REQ_LENGTH 21
> > +
> >   static DEFINE_MUTEX(ima_write_mutex);
> >   static DEFINE_MUTEX(ima_measure_mutex);
> >   static long ima_measure_users;
> > @@ -97,6 +104,11 @@ static void *ima_measurements_start(struct seq_file=
 *m, loff_t *pos)
> >   	return _ima_measurements_start(m, pos, &ima_measurements);
> >   }
> >  =20
> > +static void *ima_measurements_staged_start(struct seq_file *m, loff_t =
*pos)
> > +{
> > +	return _ima_measurements_start(m, pos, &ima_measurements_staged);
> > +}
> > +
> >   static void *_ima_measurements_next(struct seq_file *m, void *v, loff=
_t *pos,
> >   				    struct list_head *head)
> >   {
> > @@ -118,6 +130,12 @@ static void *ima_measurements_next(struct seq_file=
 *m, void *v, loff_t *pos)
> >   	return _ima_measurements_next(m, v, pos, &ima_measurements);
> >   }
> >  =20
> > +static void *ima_measurements_staged_next(struct seq_file *m, void *v,
> > +					  loff_t *pos)
> > +{
> > +	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
> > +}
> > +
> >   static void ima_measurements_stop(struct seq_file *m, void *v)
> >   {
> >   }
> > @@ -283,6 +301,68 @@ static const struct file_operations ima_measuremen=
ts_ops =3D {
> >   	.release =3D ima_measurements_release,
> >   };
> >  =20
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
> > +static ssize_t ima_measurements_staged_write(struct file *file,
> > +					     const char __user *buf,
> > +					     size_t datalen, loff_t *ppos)
> > +{
> > +	char req[STAGED_REQ_LENGTH];
> > +	int ret;
> > +
> > +	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(req, buf, datalen) !=3D 0)
> > +		return -EFAULT;
> > +
> > +	if (req[datalen - 1] !=3D '\n')
> > +		return -EINVAL;
> > +
> > +	req[datalen - 1] =3D '\0';
> > +
> > +	switch (req[0]) {
> > +	case 'A':
> > +		if (datalen !=3D 2)
> > +			return -EINVAL;
> > +
> > +		ret =3D ima_queue_stage();
> > +		break;
> > +	case 'D':
> > +		if (datalen !=3D 2)
> > +			return -EINVAL;
> > +
> > +		ret =3D ima_queue_staged_delete_all();
> > +		break;
>=20
> I think the following two steps may not work because of race condition:
>=20
> step1: ret =3D ima_queue_stage(); //this will put all logs in active list=
 into staged list;
> step2: ret =3D ima_queue_staged_delete_all(); //this will delete all logs=
 in staged list;
>=20
> The following is the step of race condition:
>  =C2=A0 =C2=A0 1. current active log list LA1;
>  =C2=A0 =C2=A0 2. user agent read the TPM quote QA1 match list LA1;
>  =C2=A0 =C2=A0 3. new event NewLog is added into active log list LA1+NewL=
og
>  =C2=A0 =C2=A0 4. user agent call ima_queue_stage() and generated staged =
list
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0including LA1+NewLog.
>  =C2=A0 =C2=A0 5. user agent call ima_queue_staged_delete_all();
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0The new log NewLog in step 3 is also deleted

Please refer to the documentation patch which explains the intended
workflow of this approach (Remote Attestation Agent Workflow).

Roberto

> Next time the attestation will fail if using the active log list in the=
=20
> kernel.
>=20
> Thanks,
>=20
> Steven
>=20
> > +	default:
> > +		ret =3D -EINVAL;
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
> > +	.read =3D seq_read,
> > +	.write =3D ima_measurements_staged_write,
> > +	.llseek =3D seq_lseek,
> > +	.release =3D ima_measurements_release,
> > +};
> > +
> >   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
> >   {
> >   	u32 i;
> > @@ -356,6 +436,28 @@ static const struct file_operations ima_ascii_meas=
urements_ops =3D {
> >   	.release =3D ima_measurements_release,
> >   };
> >  =20
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
> > +	.read =3D seq_read,
> > +	.write =3D ima_measurements_staged_write,
> > +	.llseek =3D seq_lseek,
> > +	.release =3D ima_measurements_release,
> > +};
> > +
> >   static ssize_t ima_read_policy(char *path)
> >   {
> >   	void *data =3D NULL;
> > @@ -459,10 +561,21 @@ static const struct seq_operations ima_policy_seq=
ops =3D {
> >   };
> >   #endif
> >  =20
> > -static int __init create_securityfs_measurement_lists(void)
> > +static int __init create_securityfs_measurement_lists(bool staging)
> >   {
> > +	const struct file_operations *ascii_ops =3D &ima_ascii_measurements_o=
ps;
> > +	const struct file_operations *binary_ops =3D &ima_measurements_ops;
> > +	mode_t permissions =3D S_IRUSR | S_IRGRP;
> > +	const char *file_suffix =3D "";
> >   	int count =3D NR_BANKS(ima_tpm_chip);
> >  =20
> > +	if (staging) {
> > +		ascii_ops =3D &ima_ascii_measurements_staged_ops;
> > +		binary_ops =3D &ima_measurements_staged_ops;
> > +		file_suffix =3D "_staged";
> > +		permissions |=3D (S_IWUSR | S_IWGRP);
> > +	}
> > +
> >   	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
> >   		count++;
> >  =20
> > @@ -473,29 +586,32 @@ static int __init create_securityfs_measurement_l=
ists(void)
> >  =20
> >   		if (algo =3D=3D HASH_ALGO__LAST)
> >   			snprintf(file_name, sizeof(file_name),
> > -				 "ascii_runtime_measurements_tpm_alg_%x",
> > -				 ima_tpm_chip->allocated_banks[i].alg_id);
> > +				 "ascii_runtime_measurements_tpm_alg_%x%s",
> > +				 ima_tpm_chip->allocated_banks[i].alg_id,
> > +				 file_suffix);
> >   		else
> >   			snprintf(file_name, sizeof(file_name),
> > -				 "ascii_runtime_measurements_%s",
> > -				 hash_algo_name[algo]);
> > -		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> > +				 "ascii_runtime_measurements_%s%s",
> > +				 hash_algo_name[algo], file_suffix);
> > +		dentry =3D securityfs_create_file(file_name, permissions,
> >   						ima_dir, (void *)(uintptr_t)i,
> > -						&ima_ascii_measurements_ops);
> > +						ascii_ops);
> >   		if (IS_ERR(dentry))
> >   			return PTR_ERR(dentry);
> >  =20
> >   		if (algo =3D=3D HASH_ALGO__LAST)
> >   			snprintf(file_name, sizeof(file_name),
> > -				 "binary_runtime_measurements_tpm_alg_%x",
> > -				 ima_tpm_chip->allocated_banks[i].alg_id);
> > +				 "binary_runtime_measurements_tpm_alg_%x%s",
> > +				 ima_tpm_chip->allocated_banks[i].alg_id,
> > +				 file_suffix);
> >   		else
> >   			snprintf(file_name, sizeof(file_name),
> > -				 "binary_runtime_measurements_%s",
> > -				 hash_algo_name[algo]);
> > -		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> > +				 "binary_runtime_measurements_%s%s",
> > +				 hash_algo_name[algo], file_suffix);
> > +
> > +		dentry =3D securityfs_create_file(file_name, permissions,
> >   						ima_dir, (void *)(uintptr_t)i,
> > -						&ima_measurements_ops);
> > +						binary_ops);
> >   		if (IS_ERR(dentry))
> >   			return PTR_ERR(dentry);
> >   	}
> > @@ -503,6 +619,23 @@ static int __init create_securityfs_measurement_li=
sts(void)
> >   	return 0;
> >   }
> >  =20
> > +static int __init create_securityfs_staging_links(void)
> > +{
> > +	struct dentry *dentry;
> > +
> > +	dentry =3D securityfs_create_symlink("binary_runtime_measurements_sta=
ged",
> > +		ima_dir, "binary_runtime_measurements_sha1_staged", NULL);
> > +	if (IS_ERR(dentry))
> > +		return PTR_ERR(dentry);
> > +
> > +	dentry =3D securityfs_create_symlink("ascii_runtime_measurements_stag=
ed",
> > +		ima_dir, "ascii_runtime_measurements_sha1_staged", NULL);
> > +	if (IS_ERR(dentry))
> > +		return PTR_ERR(dentry);
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * ima_open_policy: sequentialize access to the policy file
> >    */
> > @@ -595,7 +728,13 @@ int __init ima_fs_init(void)
> >   		goto out;
> >   	}
> >  =20
> > -	ret =3D create_securityfs_measurement_lists();
> > +	ret =3D create_securityfs_measurement_lists(false);
> > +	if (ret =3D=3D 0 && IS_ENABLED(CONFIG_IMA_STAGING)) {
> > +		ret =3D create_securityfs_measurement_lists(true);
> > +		if (ret =3D=3D 0)
> > +			ret =3D create_securityfs_staging_links();
> > +	}
> > +
> >   	if (ret !=3D 0)
> >   		goto out;
> >  =20
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index d7d0fb639d99..d5503dd5cc9b 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -42,8 +42,8 @@ void ima_measure_kexec_event(const char *event_name)
> >   	long len;
> >   	int n;
> >  =20
> > -	buf_size =3D ima_get_binary_runtime_size(BINARY);
> > -	len =3D atomic_long_read(&ima_num_entries[BINARY]);
> > +	buf_size =3D ima_get_binary_runtime_size(BINARY_FULL);
> > +	len =3D atomic_long_read(&ima_num_entries[BINARY_FULL]);
> >  =20
> >   	n =3D scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> >   		      "kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> > @@ -106,13 +106,26 @@ static int ima_dump_measurement_list(unsigned lon=
g *buffer_size, void **buffer,
> >  =20
> >   	memset(&khdr, 0, sizeof(khdr));
> >   	khdr.version =3D 1;
> > -	/* This is an append-only list, no need to hold the RCU read lock */
> > -	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> > +	/* It can race with ima_queue_stage() and ima_queue_delete_staged(). =
*/
> > +	mutex_lock(&ima_extend_list_mutex);
> > +
> > +	list_for_each_entry_rcu(qe, &ima_measurements_staged, later,
> > +				lockdep_is_held(&ima_extend_list_mutex)) {
> >   		ret =3D ima_dump_measurement(&khdr, qe);
> >   		if (ret < 0)
> >   			break;
> >   	}
> >  =20
> > +	list_for_each_entry_rcu(qe, &ima_measurements, later,
> > +				lockdep_is_held(&ima_extend_list_mutex)) {
> > +		if (!ret)
> > +			ret =3D ima_dump_measurement(&khdr, qe);
> > +		if (ret < 0)
> > +			break;
> > +	}
> > +
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +
> >   	/*
> >   	 * fill in reserved space with some buffer details
> >   	 * (eg. version, buffer size, number of measurements)
> > @@ -167,6 +180,7 @@ void ima_add_kexec_buffer(struct kimage *image)
> >   		extra_memory =3D CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> >  =20
> >   	binary_runtime_size =3D ima_get_binary_runtime_size(BINARY) +
> > +			      ima_get_binary_runtime_size(BINARY_STAGED) +
> >   			      extra_memory;
> >  =20
> >   	if (binary_runtime_size >=3D ULONG_MAX - PAGE_SIZE)
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index b6d10dceb669..50519ed837d4 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -26,6 +26,7 @@
> >   static struct tpm_digest *digests;
> >  =20
> >   LIST_HEAD(ima_measurements);	/* list of all measurements */
> > +LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
> >   #ifdef CONFIG_IMA_KEXEC
> >   static unsigned long binary_runtime_size[BINARY__LAST];
> >   #else
> > @@ -45,11 +46,11 @@ atomic_long_t ima_num_violations =3D ATOMIC_LONG_IN=
IT(0);
> >   /* key: inode (before secure-hashing a file) */
> >   struct hlist_head __rcu *ima_htable;
> >  =20
> > -/* mutex protects atomicity of extending measurement list
> > +/* mutex protects atomicity of extending and staging measurement list
> >    * and extending the TPM PCR aggregate. Since tpm_extend can take
> >    * long (and the tpm driver uses a mutex), we can't use the spinlock.
> >    */
> > -static DEFINE_MUTEX(ima_extend_list_mutex);
> > +DEFINE_MUTEX(ima_extend_list_mutex);
> >  =20
> >   /*
> >    * Used internally by the kernel to suspend measurements.
> > @@ -174,12 +175,16 @@ static int ima_add_digest_entry(struct ima_templa=
te_entry *entry,
> >   				lockdep_is_held(&ima_extend_list_mutex));
> >  =20
> >   	atomic_long_inc(&ima_num_entries[BINARY]);
> > +	atomic_long_inc(&ima_num_entries[BINARY_FULL]);
> > +
> >   	if (update_htable) {
> >   		key =3D ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
> >   		hlist_add_head_rcu(&qe->hnext, &htable[key]);
> >   	}
> >  =20
> >   	ima_update_binary_runtime_size(entry, BINARY);
> > +	ima_update_binary_runtime_size(entry, BINARY_FULL);
> > +
> >   	return 0;
> >   }
> >  =20
> > @@ -280,6 +285,94 @@ int ima_add_template_entry(struct ima_template_ent=
ry *entry, int violation,
> >   	return result;
> >   }
> >  =20
> > +int ima_queue_stage(void)
> > +{
> > +	int ret =3D 0;
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	if (!list_empty(&ima_measurements_staged)) {
> > +		ret =3D -EEXIST;
> > +		goto out_unlock;
> > +	}
> > +
> > +	if (list_empty(&ima_measurements)) {
> > +		ret =3D -ENOENT;
> > +		goto out_unlock;
> > +	}
> > +
> > +	list_replace(&ima_measurements, &ima_measurements_staged);
> > +	INIT_LIST_HEAD(&ima_measurements);
> > +
> > +	atomic_long_set(&ima_num_entries[BINARY_STAGED],
> > +			atomic_long_read(&ima_num_entries[BINARY]));
> > +	atomic_long_set(&ima_num_entries[BINARY], 0);
> > +
> > +	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
> > +		binary_runtime_size[BINARY_STAGED] =3D
> > +					binary_runtime_size[BINARY];
> > +		binary_runtime_size[BINARY] =3D 0;
> > +	}
> > +out_unlock:
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +	return ret;
> > +}
> > +
> > +static void ima_queue_delete(struct list_head *head);
> > +
> > +int ima_queue_staged_delete_all(void)
> > +{
> > +	LIST_HEAD(ima_measurements_trim);
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	if (list_empty(&ima_measurements_staged)) {
> > +		mutex_unlock(&ima_extend_list_mutex);
> > +		return -ENOENT;
> > +	}
> > +
> > +	list_replace(&ima_measurements_staged, &ima_measurements_trim);
> > +	INIT_LIST_HEAD(&ima_measurements_staged);
> > +
> > +	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
> > +
> > +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> > +		binary_runtime_size[BINARY_STAGED] =3D 0;
> > +
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +
> > +	ima_queue_delete(&ima_measurements_trim);
> > +	return 0;
> > +}
> > +
> > +static void ima_queue_delete(struct list_head *head)
> > +{
> > +	struct ima_queue_entry *qe, *qe_tmp;
> > +	unsigned int i;
> > +
> > +	list_for_each_entry_safe(qe, qe_tmp, head, later) {
> > +		/*
> > +		 * Safe to free template_data here without synchronize_rcu()
> > +		 * because the only htable reader, ima_lookup_digest_entry(),
> > +		 * accesses only entry->digests, not template_data. If new
> > +		 * htable readers are added that access template_data, a
> > +		 * synchronize_rcu() is required here.
> > +		 */
> > +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> > +			kfree(qe->entry->template_data[i].data);
> > +			qe->entry->template_data[i].data =3D NULL;
> > +			qe->entry->template_data[i].len =3D 0;
> > +		}
> > +
> > +		list_del(&qe->later);
> > +
> > +		/* No leak if condition is false, referenced by ima_htable. */
> > +		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
> > +			kfree(qe->entry->digests);
> > +			kfree(qe->entry);
> > +			kfree(qe);
> > +		}
> > +	}
> > +}
> > +
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry)
> >   {
> >   	int result =3D 0;
>=20


