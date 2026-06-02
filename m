Return-Path: <linux-integrity+bounces-9736-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rU99FQDMHmr4VAAAu9opvQ
	(envelope-from <linux-integrity+bounces-9736-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:26:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C121762E057
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 14:26:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9736-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9736-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE4DB301E21E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319473D6484;
	Tue,  2 Jun 2026 11:22:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A183CE4B2;
	Tue,  2 Jun 2026 11:22:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399349; cv=none; b=etpTg+bXClVwhTfH+UwTAMchwBCM7dhN4cUbbsA+KsJ9ShCdEonqS1B9/pfTAfiECxOnhPQqiH37pE3+0rIMaoFyasNKcE/BBHYNGDCHGzEV0SJRSH+BwvE2Zf3gOQ1nOchOok47bxLefhPMf4WqNxRj6V3zRbKhLTwWsQTeVwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399349; c=relaxed/simple;
	bh=H2xn7edZmPZo6zeSVFyNSc+mBX9WUrPVviBV2JeWq2M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0vmjKwmPedEnBKUFmy4BNJ0bK72PPbyUu3zGvdNbJ2ETYmcyC0asXyqA6W1U2U2CJr4N6XHe11PSa2tZH/GkRy9HempnaiAPjiu70A8XXSPAGrxmsbF1YQZK2hRT5WRrcOI+WJR+Pf+o524DN95z+WaZpcs1aSEYMCkE3LIF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gV7bC4Kg4zxYQT;
	Tue,  2 Jun 2026 19:17:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id EDA4E4056F;
	Tue,  2 Jun 2026 19:22:22 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCH9M_lvB5qBy8zAA--.58518S2;
	Tue, 02 Jun 2026 12:22:22 +0100 (CET)
Message-ID: <e8951439c59864ecec2dd21392ca442eebc06d7b.camel@huaweicloud.com>
Subject: Re: [PATCH v6 11/12] ima: Support staging and deleting N
 measurements records
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net, skhan@linuxfoundation.org, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 02 Jun 2026 13:22:11 +0200
In-Reply-To: <20260602111401.1706052-12-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
	 <20260602111401.1706052-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCH9M_lvB5qBy8zAA--.58518S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1UuFW5tF4UCw1DGFy5CFg_yoWfWr47pa
	9aga4fCry8JryfKr1kGa4Durs5u3ykKF4UWr45J342yFn3Xryq9r45Cry2kFsYkryrtr18
	tw4aqrs8Can0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUruWlDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGoeRrcEtwAAs8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:from_mime,huaweicloud.com:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9736-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,huaweicloud.com:from_mime,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C121762E057

On Tue, 2026-06-02 at 13:14 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Add support for sending a value N between 1 and ULONG_MAX to the IMA
> original measurement interface. This value represents the number of
> measurements that should be deleted from the current measurements list. I=
n
> this case, measurements are staged in an internal non-user visible list,
> and immediately deleted.
>=20
> This staging method allows the remote attestation agents to easily separa=
te
> the measurements that were verified (staged and deleted) from those that
> weren't due to the race between taking a TPM quote and reading the
> measurements list.
>=20
> In order to minimize the locking time of ima_extend_list_mutex, deleting
> N records is realized by doing a lockless walk in the current measurement=
s
> list to determine the N-th entry to cut, to cut the current measurements
> list under the lock, and by deleting the excess records after releasing t=
he
> lock.
>=20
> Flushing the hash table is not supported for N records, since it would
> require removing the N records one by one from the hash table under the
> ima_extend_list_mutex lock, which would increase the locking time.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Co-developed-by: Steven Chen <chenste@linux.microsoft.com>

Hi Steven

I did see your tags, but since I added a Co-developed-by, probably they
are redundant. If you agree, please reply with your Signed-off-by, so
that the tags are complete.

Thanks

Roberto

> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/Kconfig     |  3 ++
>  security/integrity/ima/ima.h       |  1 +
>  security/integrity/ima/ima_fs.c    | 32 +++++++++++++--
>  security/integrity/ima/ima_queue.c | 63 ++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index 02436670f746..f4d25e045808 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -341,6 +341,9 @@ config IMA_STAGING
>  	  It allows user space to stage the measurements list for deletion and
>  	  to delete the staged measurements after confirmation.
> =20
> +	  Or, alternatively, it allows user space to specify N measurements
> +	  records to stage internally, so that they can be immediately deleted.
> +
>  	  On kexec, staging is aborted and any staged measurement records are
>  	  copied to the secondary kernel.
> =20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index d2e740c8ff75..7a1b2d6a8b59 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -320,6 +320,7 @@ struct ima_template_desc *lookup_template_desc(const =
char *name);
>  bool ima_template_has_modsig(const struct ima_template_desc *ima_templat=
e);
>  int ima_queue_stage(void);
>  int ima_queue_staged_delete_all(void);
> +int ima_queue_delete_partial(unsigned long req_value);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 96d7503a605b..174a94740da1 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -28,6 +28,7 @@
>   * Requests:
>   * 'A\n': stage the entire measurements list
>   * 'D\n': delete all staged measurements
> + * '[1, ULONG_MAX]\n' delete N measurements records
>   */
>  #define STAGED_REQ_LENGTH 21
> =20
> @@ -343,6 +344,7 @@ static ssize_t _ima_measurements_write(struct file *f=
ile,
>  				       loff_t *ppos, bool staged_interface)
>  {
>  	char req[STAGED_REQ_LENGTH];
> +	unsigned long req_value;
>  	int ret;
> =20
>  	if (datalen < 2 || datalen > STAGED_REQ_LENGTH)
> @@ -370,7 +372,24 @@ static ssize_t _ima_measurements_write(struct file *=
file,
>  		ret =3D ima_queue_staged_delete_all();
>  		break;
>  	default:
> -		ret =3D -EINVAL;
> +		if (staged_interface)
> +			return -EINVAL;
> +
> +		if (ima_flush_htable) {
> +			pr_debug("Deleting staged N measurements not supported when flushing =
the hash table is requested\n");
> +			return -EINVAL;
> +		}
> +
> +		ret =3D kstrtoul(req, 10, &req_value);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (req_value =3D=3D 0) {
> +			pr_debug("Must delete at least one entry\n");
> +			return -EINVAL;
> +		}
> +
> +		ret =3D ima_queue_delete_partial(req_value);
>  	}
> =20
>  	if (ret < 0)
> @@ -379,6 +398,12 @@ static ssize_t _ima_measurements_write(struct file *=
file,
>  	return datalen;
>  }
> =20
> +static ssize_t ima_measurements_write(struct file *file, const char __us=
er *buf,
> +				      size_t datalen, loff_t *ppos)
> +{
> +	return _ima_measurements_write(file, buf, datalen, ppos, false);
> +}
> +
>  static ssize_t ima_measurements_staged_write(struct file *file,
>  					     const char __user *buf,
>  					     size_t datalen, loff_t *ppos)
> @@ -389,6 +414,7 @@ static ssize_t ima_measurements_staged_write(struct f=
ile *file,
>  static const struct file_operations ima_measurements_ops =3D {
>  	.open =3D ima_measurements_open,
>  	.read =3D seq_read,
> +	.write =3D ima_measurements_write,
>  	.llseek =3D seq_lseek,
>  	.release =3D ima_measurements_release,
>  };
> @@ -470,6 +496,7 @@ static int ima_ascii_measurements_open(struct inode *=
inode, struct file *file)
>  static const struct file_operations ima_ascii_measurements_ops =3D {
>  	.open =3D ima_ascii_measurements_open,
>  	.read =3D seq_read,
> +	.write =3D ima_measurements_write,
>  	.llseek =3D seq_lseek,
>  	.release =3D ima_measurements_release,
>  };
> @@ -603,14 +630,13 @@ static int __init create_securityfs_measurement_lis=
ts(bool staging)
>  {
>  	const struct file_operations *ascii_ops =3D &ima_ascii_measurements_ops=
;
>  	const struct file_operations *binary_ops =3D &ima_measurements_ops;
> -	umode_t permissions =3D (S_IRUSR | S_IRGRP);
> +	umode_t permissions =3D (S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP);
>  	const char *file_suffix =3D "";
>  	int count =3D NR_BANKS(ima_tpm_chip);
> =20
>  	if (staging) {
>  		ascii_ops =3D &ima_ascii_measurements_staged_ops;
>  		binary_ops =3D &ima_measurements_staged_ops;
> -		permissions |=3D (S_IWUSR | S_IWGRP);
>  		file_suffix =3D "_staged";
>  	}
> =20
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index af0502f27d57..718991ba8bcd 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -405,6 +405,69 @@ int ima_queue_staged_delete_all(void)
>  	return 0;
>  }
> =20
> +/**
> + * ima_queue_delete_partial - Delete current measurements
> + * @req_value: Number of measurements to delete
> + *
> + * Delete the requested number of measurements from the current measurem=
ents
> + * list, and update the number of records and the binary run-time size
> + * accordingly.
> + *
> + * Refuse to delete current measurements if measurement is suspended, so=
 that
> + * dump can be done in a lockless way and user space is notified about c=
urrent
> + * measurements being carried over to the secondary kernel, so that it d=
oes not
> + * save them twice.
> + *
> + * Return: Zero on success, a negative value otherwise.
> + */
> +int ima_queue_delete_partial(unsigned long req_value)
> +{
> +	unsigned long req_value_copy =3D req_value;
> +	unsigned long size_to_remove =3D 0, num_to_remove =3D 0;
> +	LIST_HEAD(ima_measurements_trim);
> +	struct ima_queue_entry *qe;
> +	int ret =3D 0;
> +
> +	/*
> +	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
> +	 * only list append can happen concurrently. No list replace due to the
> +	 * staging/delete writers mutual exclusion.
> +	 */
> +	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> +		size_to_remove +=3D get_binary_runtime_size(qe->entry);
> +		num_to_remove++;
> +
> +		if (--req_value_copy =3D=3D 0)
> +			break;
> +	}
> +
> +	/* Not enough records to delete. */
> +	if (req_value_copy > 0)
> +		return -ENOENT;
> +
> +	mutex_lock(&ima_extend_list_mutex);
> +	if (ima_measurements_suspended) {
> +		mutex_unlock(&ima_extend_list_mutex);
> +		return -ESTALE;
> +	}
> +
> +	/*
> +	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
> +	 */
> +	__list_cut_position(&ima_measurements_trim, &ima_measurements,
> +			    &qe->later);
> +
> +	atomic_long_sub(num_to_remove, &ima_num_records[BINARY]);
> +
> +	if (IS_ENABLED(CONFIG_IMA_KEXEC))
> +		binary_runtime_size[BINARY] -=3D size_to_remove;
> +
> +	mutex_unlock(&ima_extend_list_mutex);
> +
> +	ima_queue_delete(&ima_measurements_trim, false);
> +	return ret;
> +}
> +
>  /**
>   * ima_queue_delete - Delete measurements
>   * @head: List head measurements are deleted from


