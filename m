Return-Path: <linux-integrity+bounces-9110-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJrJyC9xmnoNwUAu9opvQ
	(envelope-from <linux-integrity+bounces-9110-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 18:23:44 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1AE348420
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D63C307F74D
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Mar 2026 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6536D9E6;
	Fri, 27 Mar 2026 17:02:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BA35CB75;
	Fri, 27 Mar 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630948; cv=none; b=fU4W1uy0yYsFQFc+IsSLMSvg7udhdIBo5EnExTV5FM3b/d8tv9siFnce04rV+GMGAwmHjst8x0/B+RAgiv61Bccy7Ue3pdVwmVVF0iS/b8dwAaqa7STHbfFnV2Mlf2+6YDFHqHLPKk55Q8mCjjkklUbnBZjK5BLYSiArwgE+PZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630948; c=relaxed/simple;
	bh=MWTC6MVw5V8w3zeaRJqKJ/Y5D9fqUSmg7mnfBks57FM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahkhBmt13oJsu2XIxlj4vuMZeYdHj79fEckJ6KEWWs68F8rcgM2O8nCFHDiwLF1YOYdg83F0ducZDYvXN+pqf/c/aCRKyin3zoLRsfC7vIyJ1w3Pmnl8z8VPd3Q6LfB07dtBHyWF16QcAwBN2YEtLcJo3yCN0v/FYt+OiE6VyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fj6Kj1T1bzpW0v;
	Sat, 28 Mar 2026 00:58:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A40974056A;
	Sat, 28 Mar 2026 01:02:22 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3sO0SuMZp_pc+AQ--.5676S2;
	Fri, 27 Mar 2026 18:02:21 +0100 (CET)
Message-ID: <af6aa732b85af36e07e4a82b29170e80b13dc7c4.camel@huaweicloud.com>
Subject: Re: [PATCH v4 11/13] ima: Support staging and deleting N
 measurements entries
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: steven chen <chenste@linux.microsoft.com>, corbet@lwn.net, 
 skhan@linuxfoundation.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Fri, 27 Mar 2026 18:02:08 +0100
In-Reply-To: <0e186faf-8111-4fd9-a7df-bff30f7fb20a@linux.microsoft.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
	 <20260326173011.1191815-12-roberto.sassu@huaweicloud.com>
	 <0e186faf-8111-4fd9-a7df-bff30f7fb20a@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3sO0SuMZp_pc+AQ--.5676S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1UuFW5tF4UCw1DWry3Arb_yoWDGr4rpa
	90ga47Cry8JryxKr1kG3Z7Crsag3ykGF1UGw13Ga4xAF13ZF1v9rnxCryYkFs5Cryvqr4I
	vw4qqrsxCan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGnF7qwTrAAAsR
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9110-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A1AE348420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-26 at 16:19 -0700, steven chen wrote:
> On 3/26/2026 10:30 AM, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Add support for sending a value N between 1 and ULONG_MAX to the stagin=
g
> > interface. This value represents the number of measurements that should=
 be
> > deleted from the current measurements list.
> >=20
> > This staging method allows the remote attestation agents to easily sepa=
rate
> > the measurements that were verified (staged and deleted) from those tha=
t
> > weren't due to the race between taking a TPM quote and reading the
> > measurements list.
> >=20
> > In order to minimize the locking time of ima_extend_list_mutex, deletin=
g
> > N entries is realized by staging the entire current measurements list
> > (with the lock), by determining the N-th staged entry (without the lock=
),
> > and by splicing the entries in excess back to the current measurements =
list
> > (with the lock). Finally, the N entries are deleted (without the lock).
> >=20
> > Flushing the hash table is not supported for N entries, since it would
> > require removing the N entries one by one from the hash table under the
> > ima_extend_list_mutex lock, which would increase the locking time.
> >=20
> > The ima_extend_list_mutex lock is necessary in ima_dump_measurement_lis=
t()
> > because ima_queue_staged_delete_partial() uses __list_cut_position() to
> > modify ima_measurements_staged, for which no RCU-safe variant exists. F=
or
> > the staging with prompt flavor alone, list_replace_rcu() could have bee=
n
> > used instead, but since both flavors share the same kexec serialization
> > path, the mutex is required regardless.
> >=20
> > Link: https://github.com/linux-integrity/linux/issues/1
> > Suggested-by: Steven Chen <chenste@linux.microsoft.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >   security/integrity/ima/Kconfig     |  3 ++
> >   security/integrity/ima/ima.h       |  1 +
> >   security/integrity/ima/ima_fs.c    | 22 +++++++++-
> >   security/integrity/ima/ima_queue.c | 70 +++++++++++++++++++++++++++++=
+
> >   4 files changed, 95 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kc=
onfig
> > index e714726f3384..6ddb4e77bff5 100644
> > --- a/security/integrity/ima/Kconfig
> > +++ b/security/integrity/ima/Kconfig
> > @@ -341,6 +341,9 @@ config IMA_STAGING
> >   	  It allows user space to stage the measurements list for deletion a=
nd
> >   	  to delete the staged measurements after confirmation.
> >  =20
> > +	  Or, alternatively, it allows user space to specify N measurements
> > +	  entries to be deleted.
> > +
> >   	  On kexec, staging is reverted and staged measurements are prepende=
d
> >   	  to the current measurements list when measurements are copied to t=
he
> >   	  secondary kernel.
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index 699b735dec7d..de0693fce53c 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -319,6 +319,7 @@ struct ima_template_desc *lookup_template_desc(cons=
t char *name);
> >   bool ima_template_has_modsig(const struct ima_template_desc *ima_temp=
late);
> >   int ima_queue_stage(void);
> >   int ima_queue_staged_delete_all(void);
> > +int ima_queue_staged_delete_partial(unsigned long req_value);
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry);
> >   int ima_restore_measurement_list(loff_t bufsize, void *buf);
> >   int ima_measurements_show(struct seq_file *m, void *v);
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 39d9128e9f22..eb3f343c1138 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -28,6 +28,7 @@
> >    * Requests:
> >    * 'A\n': stage the entire measurements list
> >    * 'D\n': delete all staged measurements
> > + * '[1, ULONG_MAX]\n' delete N measurements entries
> >    */
> >   #define STAGED_REQ_LENGTH 21
> >  =20
> > @@ -319,6 +320,7 @@ static ssize_t ima_measurements_staged_write(struct=
 file *file,
> >   					     size_t datalen, loff_t *ppos)
> >   {
> >   	char req[STAGED_REQ_LENGTH];
> > +	unsigned long req_value;
> >   	int ret;
> >  =20
> >   	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
> > @@ -346,7 +348,25 @@ static ssize_t ima_measurements_staged_write(struc=
t file *file,
> >   		ret =3D ima_queue_staged_delete_all();
> >   		break;
> >   	default:
> > -		ret =3D -EINVAL;
> > +		if (ima_flush_htable) {
> > +			pr_debug("Deleting staged N measurements not supported when flushin=
g the hash table is requested\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret =3D kstrtoul(req, 10, &req_value);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (req_value =3D=3D 0) {
> > +			pr_debug("Must delete at least one entry\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret =3D ima_queue_stage();
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret =3D ima_queue_staged_delete_partial(req_value);
> The default processing is "Trim N" idea plus performance improvement.
>=20
> Here do everything in one time. And this is what I said in v3.
>=20
> [PATCH v3 1/3] ima: Remove ima_h_table structure=20
> <https://lore.kernel.org/linux-integrity/c61aeaa79929a98cb3a6d30835972891=
fac3570f.camel@linux.ibm.com/T/#t>

In your approach you do:

lock ima_extend_measure_list_mutex
scan entries until N
cut list staged -> trim
unlock ima_extend_measure_list_mutex


In my approach I do:
lock ima_extend_measure_list_mutex
list replace active -> staged
unlock ima_extend_measure_list_mutex

scan entries until N

lock ima_extend_measure_list_mutex
cut list staged -> trim
splice staged ->active
unlock ima_extend_measure_list_mutex

So, I guess if you refer to less user space locking time, you mean one
lock/unlock and one list replace + list splice less in your solution.

In exchange, you propose to hold the lock in the kernel while scanning
N. I think it is a significant increase of kernel locking time vs a
negligible increase of user space locking time (in the kernel, all
processes need to wait for the ima_extend_measure_list_mutex to be
released, in user space it is just the agent waiting).

Roberto

> The important two parts of trimming is "trim N" and performance improveme=
nt.
>=20
> The performance improvement include two parts:
>  =C2=A0 =C2=A0 hash table staging
>  =C2=A0 =C2=A0 active log list staging
>=20
> And I think "Trim N" plus performance improvement is the right direction=
=20
> to go.
> Lots of code for two steps "stage and trim" "stage" part can be removed.
>=20
> Also race condition may happen if not holding the list all time in user=
=20
> space
> during attestation period: from stage, read list, attestation and trimmin=
g.
>=20
> So in order to improve the above user space lock time, "Trim T:N" can be=
=20
> used
> not to hold list long in user space during attestation.
>=20
> For Trim T:N, T represent total log trimmed since system boot up. Please=
=20
> refer to
> https://lore.kernel.org/linux-integrity/20260205235849.7086-1-chenste@lin=
ux.microsoft.com/T/#t
>=20
> Thanks,
>=20
> Steven
> >   	}
> >  =20
> >   	if (ret < 0)
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index f5c18acfbc43..4fb557d61a88 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -371,6 +371,76 @@ int ima_queue_staged_delete_all(void)
> >   	return 0;
> >   }
> >  =20
> > +int ima_queue_staged_delete_partial(unsigned long req_value)
> > +{
> > +	unsigned long req_value_copy =3D req_value;
> > +	unsigned long size_to_remove =3D 0, num_to_remove =3D 0;
> > +	struct list_head *cut_pos =3D NULL;
> > +	LIST_HEAD(ima_measurements_trim);
> > +	struct ima_queue_entry *qe;
> > +	int ret =3D 0;
> > +
> > +	/*
> > +	 * Safe walk (no concurrent write), not under ima_extend_list_mutex
> > +	 * for performance reasons.
> > +	 */
> > +	list_for_each_entry(qe, &ima_measurements_staged, later) {
> > +		size_to_remove +=3D get_binary_runtime_size(qe->entry);
> > +		num_to_remove++;
> > +
> > +		if (--req_value_copy =3D=3D 0) {
> > +			/* qe->later always points to a valid list entry. */
> > +			cut_pos =3D &qe->later;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* Nothing to remove, undoing staging. */
> > +	if (req_value_copy > 0) {
> > +		size_to_remove =3D 0;
> > +		num_to_remove =3D 0;
> > +		ret =3D -ENOENT;
> > +	}
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +	if (list_empty(&ima_measurements_staged)) {
> > +		mutex_unlock(&ima_extend_list_mutex);
> > +		return -ENOENT;
> > +	}
> > +
> > +	if (cut_pos !=3D NULL)
> > +		/*
> > +		 * ima_dump_measurement_list() does not modify the list,
> > +		 * cut_pos remains the same even if it was computed before
> > +		 * the lock.
> > +		 */
> > +		__list_cut_position(&ima_measurements_trim,
> > +				    &ima_measurements_staged, cut_pos);
> > +
> > +	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY_STAGED]);
> > +	atomic_long_add(atomic_long_read(&ima_num_entries[BINARY_STAGED]),
> > +			&ima_num_entries[BINARY]);
> > +	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
> > +
> > +	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
> > +		binary_runtime_size[BINARY_STAGED] -=3D size_to_remove;
> > +		binary_runtime_size[BINARY] +=3D
> > +					binary_runtime_size[BINARY_STAGED];
> > +		binary_runtime_size[BINARY_STAGED] =3D 0;
> > +	}
> > +
> > +	/*
> > +	 * Splice (prepend) any remaining non-deleted staged entries to the
> > +	 * active list (RCU not needed, there cannot be concurrent readers).
> > +	 */
> > +	list_splice(&ima_measurements_staged, &ima_measurements);
> > +	INIT_LIST_HEAD(&ima_measurements_staged);
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +
> > +	ima_queue_delete(&ima_measurements_trim, false);
> > +	return ret;
> > +}
> > +
> >   static void ima_queue_delete(struct list_head *head, bool flush_htabl=
e)
> >   {
> >   	struct ima_queue_entry *qe, *qe_tmp;
>=20


