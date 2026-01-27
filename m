Return-Path: <linux-integrity+bounces-8334-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIcYLD3NeGmNtQEAu9opvQ
	(envelope-from <linux-integrity+bounces-8334-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:35:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C295CFF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 15:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABE363094C1A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jan 2026 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0D235B137;
	Tue, 27 Jan 2026 14:28:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD72749FE;
	Tue, 27 Jan 2026 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524135; cv=none; b=nLwEh6iXBnClTUcYkf/1Io6axgaJ31bftOTh/ZgSw67qLdJHS4P+0uMYbsLhqcM+7SLL5IfODomRMcz9ZHyOgTX7YxkWn0PgDsHP/NPTAPSU30AqGFdwmXaJJVjMs69+bdpbtPrLQ6KCEV32Xq9jgvjh9oovvHckD6tl7iWWuVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524135; c=relaxed/simple;
	bh=H97foRdLPuQ/6WSEdqX/5g7RGtUlh/UTKwEcOSSonqk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AX7Vwrp5OfFFNWW48kclN8stbbT3+QYlOIDN6/NIq70/nNQC5VR8l820K934pUeK66hIARhzwZQ0S9kurl2Dn8pmXVlo1F5F8Csd/0ZbwvYxvynWwP6iBC8V1J4o50pJag7tiukC9Nht1TIrh12hPyfk+pEbyrEFwidRR5sEFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4f0nl30lJSzpVYy;
	Tue, 27 Jan 2026 22:26:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id A95D440567;
	Tue, 27 Jan 2026 22:28:43 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHEWyPy3hpvhy4Ag--.9947S2;
	Tue, 27 Jan 2026 15:28:42 +0100 (CET)
Message-ID: <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dima@arista.com, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,  "Serge E. Hallyn" <serge@hallyn.com>,
 Silvia Sisinni <silvia.sisinni@polito.it>, Enrico Bravi
 <enrico.bravi@polito.it>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Dmitry Safonov
	 <0x7f454c46@gmail.com>
Date: Tue, 27 Jan 2026 15:28:28 +0100
In-Reply-To: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHEWyPy3hpvhy4Ag--.9947S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XF1DZF43AF4rtF47CF1DAwb_yoWxWryDpa
	93WFyxCr4kJFW7trn7C3Zxur1fu3yYy3WUGr1kJw1UAF1kWw1vkrn8Cr10krs0gryYyFy2
	qanrJr43trn8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGl4LxwVmwABst
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8334-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[arista.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,polito.it:email,huaweicloud.com:mid,arista.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 130C295CFF
X-Rspamd-Action: no action

On Tue, 2026-01-27 at 14:18 +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
>=20
> ima_init_crypto() skips initializing ima_algo_array[i] if the alogorithm
> from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> It seems avoid adding the unsupported algorithm to ima_algo_array will
> break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).
>=20
> On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
>=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists=
+0x396/0x440
> > Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
> >=20
> > CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x61/0x90
> >  print_report+0xc4/0x580
> >  ? kasan_addr_to_slab+0x26/0x80
> >  ? create_securityfs_measurement_lists+0x396/0x440
> >  kasan_report+0xc2/0x100
> >  ? create_securityfs_measurement_lists+0x396/0x440
> >  create_securityfs_measurement_lists+0x396/0x440
> >  ima_fs_init+0xa3/0x300
> >  ima_init+0x7d/0xd0
> >  init_ima+0x28/0x100
> >  do_one_initcall+0xa6/0x3e0
> >  kernel_init_freeable+0x455/0x740
> >  kernel_init+0x24/0x1d0
> >  ret_from_fork+0x38/0x80
> >  ret_from_fork_asm+0x11/0x20
> >  </TASK>
> >=20
> > The buggy address belongs to the variable:
> >  hash_algo_name+0xb8/0x420
> >=20
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10=
7ce18
> > flags: 0x8000000000002000(reserved|zone=3D2)
> > raw: 8000000000002000 ffffea0041f38608 ffffea0041f38608 000000000000000=
0
> > raw: 0000000000000000 0000000000000000 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >=20
> > Memory state around the buggy address:
> >  ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
> >  ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
> >                                         ^
> >  ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
> >  ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Seems like the TPM chip supports sha3_256, which isn't yet in
> tpm_algorithms:
> > tpm tpm0: TPM with unsupported bank algorithm 0x0027
>=20
> Grepping HASH_ALGO__LAST in security/integrity/ima/ shows that is
> the check other logic relies on, so add files under TPM_ALG_<ID>
> and print 0 as their hash_digest_size.
>=20
> This is how it looks on the test machine I have:
> > # ls -1 /sys/kernel/security/ima/
> > ascii_runtime_measurements
> > ascii_runtime_measurements_TPM_ALG_27
> > ascii_runtime_measurements_sha1
> > ascii_runtime_measurements_sha256
> > binary_runtime_measurements
> > binary_runtime_measurements_TPM_ALG_27
> > binary_runtime_measurements_sha1
> > binary_runtime_measurements_sha256
> > policy
> > runtime_measurements_count
> > violations
>=20
> Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash a=
lgorithm")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Cc: Enrico Bravi <enrico.bravi@polito.it>
> Cc: Silvia Sisinni <silvia.sisinni@polito.it>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changes in v2:
> - Instead of skipping unknown algorithms, add files under their TPM_ALG_I=
D (Roberto Sassu)
> - Fix spelling (Roberto Sassu)
> - Copy @stable on the fix
> - Link to v1: https://lore.kernel.org/r/20260127-ima-oob-v1-1-2d42f3418e5=
7@arista.com
> ---
>  security/integrity/ima/ima_fs.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 012a58959ff0..3b442e3f84d0 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -160,7 +160,10 @@ int ima_measurements_show(struct seq_file *m, void *=
v)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
> =20
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> +	if (algo =3D=3D HASH_ALGO__LAST)
> +		ima_putc(m, "0", 1);
> +	else
> +		ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> =20
>  	/* 3rd: template name size */
>  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> @@ -252,7 +255,10 @@ static int ima_ascii_measurements_show(struct seq_fi=
le *m, void *v)
>  	seq_printf(m, "%2d ", e->pcr);
> =20
>  	/* 2nd: template hash */
> -	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]=
);
> +	if (algo =3D=3D HASH_ALGO__LAST)
> +		ima_putc(m, "0", 1);
> +	else
> +		ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo=
]);

No need, the last one is ok with ima_tpm_chip->allocated_banks[algo_idx].di=
gest_size.

Roberto

> =20
>  	/* 3th:  template name */
>  	seq_printf(m, " %s", template_name);
> @@ -404,16 +410,24 @@ static int __init create_securityfs_measurement_lis=
ts(void)
>  		char file_name[NAME_MAX + 1];
>  		struct dentry *dentry;
> =20
> -		sprintf(file_name, "ascii_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "ascii_runtime_measurements_TPM_ALG_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);
> +		else
> +			sprintf(file_name, "ascii_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_ascii_measurements_ops);
>  		if (IS_ERR(dentry))
>  			return PTR_ERR(dentry);
> =20
> -		sprintf(file_name, "binary_runtime_measurements_%s",
> -			hash_algo_name[algo]);
> +		if (algo =3D=3D HASH_ALGO__LAST)
> +			sprintf(file_name, "binary_runtime_measurements_TPM_ALG_%x",
> +				ima_tpm_chip->allocated_banks[i].alg_id);
> +		else
> +			sprintf(file_name, "binary_runtime_measurements_%s",
> +				hash_algo_name[algo]);
>  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
>  						ima_dir, (void *)(uintptr_t)i,
>  						&ima_measurements_ops);
>=20
> ---
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> change-id: 20260127-ima-oob-9fa83a634d7b
>=20
> Best regards,


