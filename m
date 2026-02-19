Return-Path: <linux-integrity+bounces-8518-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdzBVTUlml4owIAu9opvQ
	(envelope-from <linux-integrity+bounces-8518-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 10:13:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3567D15D3AD
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 10:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2944301A720
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20F334C28;
	Thu, 19 Feb 2026 09:13:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE831A56B;
	Thu, 19 Feb 2026 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771492433; cv=none; b=kYeCt6yuCl9X3zop1hmCRkQRsPi9e3FMj6/QSKkc+C7XvdlQCetsMYtgsD0DZ3laS4Mcskptls5NCHWVJ0TZUmY0IAULmHPKau3ejBMujyznjCqW7gi2JLOpsueoShldIU6sXcbranGGhDW+IVa2bSUlQt/HcepQX58VWsyxkRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771492433; c=relaxed/simple;
	bh=wTm5/8QA6bhHnJcRPcPQGelupcEBfDGoJbBf3GsH+M0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sxGMhHI1O902FBW/wL2H7JSihhR/SaD9TZWIvOauMEVnla70cBQc1iT2zImknab0I+1msA9yOhN6OQ+tNfHrfLXqIwlsBrYNxtOX3rxxMgoegwYvWMQCTjHXAhUOlhaqDl3MKMJQo+IG696ZjG0TNr2Hqu9op3Zb3mFkZfGN+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fGnF62SXHz1HBv9;
	Thu, 19 Feb 2026 16:52:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 044634056E;
	Thu, 19 Feb 2026 16:55:13 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3j2rkz5ZpPf4VBA--.50570S2;
	Thu, 19 Feb 2026 09:55:12 +0100 (CET)
Message-ID: <89f51356ba5e630a8c305e5f65abd2f3ace37a48.camel@huaweicloud.com>
Subject: Re: [PATCH v4] ima_fs: Avoid creating measurement lists for
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
Date: Thu, 19 Feb 2026 09:54:57 +0100
In-Reply-To: <701de3f87f0f6bde97872dd0c5bf150bfc1f2713.camel@huaweicloud.com>
References: <20260127-ima-oob-v4-1-bf0cd7f9b4d4@arista.com>
	 <701de3f87f0f6bde97872dd0c5bf150bfc1f2713.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3j2rkz5ZpPf4VBA--.50570S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFyxWFW7tF45CF4kGF1fCrg_yoWfWw1fpa
	93WFyfCF4kJFW7trn2k3Zxur4Fv3yFy3WUWrn5Jw18AF1DWr1qkr1kCr1FkrWqgr98AFyI
	qa1UJrsIyr15taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGmWgZsFPwAAsT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8518-lists,linux-integrity=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.947];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid,polito.it:email,arista.com:email]
X-Rspamd-Queue-Id: 3567D15D3AD
X-Rspamd-Action: no action

On Tue, 2026-01-27 at 16:20 +0100, Roberto Sassu wrote:
> On Tue, 2026-01-27 at 15:03 +0000, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <dima@arista.com>
> >=20
> > ima_init_crypto() skips initializing ima_algo_array[i] if the algorithm
> > from ima_tpm_chip->allocated_banks[i].crypto_id is not supported.
> > It seems avoid adding the unsupported algorithm to ima_algo_array will
> > break all the logic that relies on indexing by NR_BANKS(ima_tpm_chip).
>=20
> The patch looks good, although I didn't try yet myself.
>=20
> I would make the commit message slightly better, with a more fluid
> explanation.
>=20
> ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> are places relying on the algorithm to be valid because it is accessed
> by hash_algo_name[].
>=20
> Thus solve the problem by creating a file name that does not depend on
> the crypto algorithm to be initialized, ...
>=20
> Also print the template entry digest as populated by IMA.
>=20
> Something along these lines.
>=20
> Also, I have a preference for lower case instead of capital case for
> the file name, given the other names.

Hi Dmitry

do you have time to make these small changes, so that we queue the
patch for the next kernel?

Thanks

Roberto

> Could you also avoid the >, otherwise the mailer thinks it is a reply?
>=20
> Thanks
>=20
> Roberto
>=20
> > On 6.12.40 I observe the following read out-of-bounds in hash_algo_name=
:
> >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lis=
ts+0x396/0x440
> > > Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
> > >=20
> > > CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x61/0x90
> > >  print_report+0xc4/0x580
> > >  ? kasan_addr_to_slab+0x26/0x80
> > >  ? create_securityfs_measurement_lists+0x396/0x440
> > >  kasan_report+0xc2/0x100
> > >  ? create_securityfs_measurement_lists+0x396/0x440
> > >  create_securityfs_measurement_lists+0x396/0x440
> > >  ima_fs_init+0xa3/0x300
> > >  ima_init+0x7d/0xd0
> > >  init_ima+0x28/0x100
> > >  do_one_initcall+0xa6/0x3e0
> > >  kernel_init_freeable+0x455/0x740
> > >  kernel_init+0x24/0x1d0
> > >  ret_from_fork+0x38/0x80
> > >  ret_from_fork_asm+0x11/0x20
> > >  </TASK>
> > >=20
> > > The buggy address belongs to the variable:
> > >  hash_algo_name+0xb8/0x420
> > >=20
> > > The buggy address belongs to the physical page:
> > > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x=
107ce18
> > > flags: 0x8000000000002000(reserved|zone=3D2)
> > > raw: 8000000000002000 ffffea0041f38608 ffffea0041f38608 0000000000000=
000
> > > raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > >=20
> > > Memory state around the buggy address:
> > >  ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
> > >  ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > > > ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
> > >                                         ^
> > >  ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
> > >  ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Seems like the TPM chip supports sha3_256, which isn't yet in
> > tpm_algorithms:
> > > tpm tpm0: TPM with unsupported bank algorithm 0x0027
> >=20
> > Use TPM_ALG_<ID> as a postfix for file names for unsupported hashing al=
gorithms.
> >=20
> > This is how it looks on the test machine I have:
> > > # ls -1 /sys/kernel/security/ima/
> > > ascii_runtime_measurements
> > > ascii_runtime_measurements_TPM_ALG_27
> > > ascii_runtime_measurements_sha1
> > > ascii_runtime_measurements_sha256
> > > binary_runtime_measurements
> > > binary_runtime_measurements_TPM_ALG_27
> > > binary_runtime_measurements_sha1
> > > binary_runtime_measurements_sha256
> > > policy
> > > runtime_measurements_count
> > > violations
> >=20
> > Fixes: 9fa8e7625008 ("ima: add crypto agility support for template-hash=
 algorithm")
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> > Cc: Enrico Bravi <enrico.bravi@polito.it>
> > Cc: Silvia Sisinni <silvia.sisinni@polito.it>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> > Changes in v4:
> > - Use ima_tpm_chip->allocated_banks[algo_idx].digest_size instead of ha=
sh_digest_size[algo]
> >   (Roberto Sassu)
> > - Link to v3: https://lore.kernel.org/r/20260127-ima-oob-v3-1-1dd09f4c2=
a6a@arista.com
> > Testing note: I test it on v6.12.40 kernel backport, which slightly dif=
fers as
> > lookup_template_data_hash_algo() was yet present.
> >=20
> > Changes in v3:
> > - Now fix the spelling *for real* (sorry, messed it up in v2)
> > - Link to v2: https://lore.kernel.org/r/20260127-ima-oob-v2-1-f38a18c85=
0cf@arista.com
> >=20
> > Changes in v2:
> > - Instead of skipping unknown algorithms, add files under their TPM_ALG=
_ID (Roberto Sassu)
> > - Fix spelling (Roberto Sassu)
> > - Copy @stable on the fix
> > - Link to v1: https://lore.kernel.org/r/20260127-ima-oob-v1-1-2d42f3418=
e57@arista.com
> > ---
> >  security/integrity/ima/ima_fs.c | 34 ++++++++++++++++++---------------=
-
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 012a58959ff0..9a00a0547619 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -132,16 +132,12 @@ int ima_measurements_show(struct seq_file *m, voi=
d *v)
> >  	char *template_name;
> >  	u32 pcr, namelen, template_data_len; /* temporary fields */
> >  	bool is_ima_template =3D false;
> > -	enum hash_algo algo;
> >  	int i, algo_idx;
> > =20
> >  	algo_idx =3D ima_sha1_idx;
> > -	algo =3D HASH_ALGO_SHA1;
> > =20
> > -	if (m->file !=3D NULL) {
> > +	if (m->file !=3D NULL)
> >  		algo_idx =3D (unsigned long)file_inode(m->file)->i_private;
> > -		algo =3D ima_algo_array[algo_idx].algo;
> > -	}
> > =20
> >  	/* get entry */
> >  	e =3D qe->entry;
> > @@ -160,7 +156,8 @@ int ima_measurements_show(struct seq_file *m, void =
*v)
> >  	ima_putc(m, &pcr, sizeof(e->pcr));
> > =20
> >  	/* 2nd: template digest */
> > -	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> > +	ima_putc(m, e->digests[algo_idx].digest,
> > +		 ima_tpm_chip->allocated_banks[algo_idx].digest_size);
> > =20
> >  	/* 3rd: template name size */
> >  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> > @@ -229,16 +226,12 @@ static int ima_ascii_measurements_show(struct seq=
_file *m, void *v)
> >  	struct ima_queue_entry *qe =3D v;
> >  	struct ima_template_entry *e;
> >  	char *template_name;
> > -	enum hash_algo algo;
> >  	int i, algo_idx;
> > =20
> >  	algo_idx =3D ima_sha1_idx;
> > -	algo =3D HASH_ALGO_SHA1;
> > =20
> > -	if (m->file !=3D NULL) {
> > +	if (m->file !=3D NULL)
> >  		algo_idx =3D (unsigned long)file_inode(m->file)->i_private;
> > -		algo =3D ima_algo_array[algo_idx].algo;
> > -	}
> > =20
> >  	/* get entry */
> >  	e =3D qe->entry;
> > @@ -252,7 +245,8 @@ static int ima_ascii_measurements_show(struct seq_f=
ile *m, void *v)
> >  	seq_printf(m, "%2d ", e->pcr);
> > =20
> >  	/* 2nd: template hash */
> > -	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[alg=
o]);
> > +	ima_print_digest(m, e->digests[algo_idx].digest,
> > +			 ima_tpm_chip->allocated_banks[algo_idx].digest_size);
> > =20
> >  	/* 3th:  template name */
> >  	seq_printf(m, " %s", template_name);
> > @@ -404,16 +398,24 @@ static int __init create_securityfs_measurement_l=
ists(void)
> >  		char file_name[NAME_MAX + 1];
> >  		struct dentry *dentry;
> > =20
> > -		sprintf(file_name, "ascii_runtime_measurements_%s",
> > -			hash_algo_name[algo]);
> > +		if (algo =3D=3D HASH_ALGO__LAST)
> > +			sprintf(file_name, "ascii_runtime_measurements_TPM_ALG_%x",
> > +				ima_tpm_chip->allocated_banks[i].alg_id);
> > +		else
> > +			sprintf(file_name, "ascii_runtime_measurements_%s",
> > +				hash_algo_name[algo]);
> >  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> >  						ima_dir, (void *)(uintptr_t)i,
> >  						&ima_ascii_measurements_ops);
> >  		if (IS_ERR(dentry))
> >  			return PTR_ERR(dentry);
> > =20
> > -		sprintf(file_name, "binary_runtime_measurements_%s",
> > -			hash_algo_name[algo]);
> > +		if (algo =3D=3D HASH_ALGO__LAST)
> > +			sprintf(file_name, "binary_runtime_measurements_TPM_ALG_%x",
> > +				ima_tpm_chip->allocated_banks[i].alg_id);
> > +		else
> > +			sprintf(file_name, "binary_runtime_measurements_%s",
> > +				hash_algo_name[algo]);
> >  		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> >  						ima_dir, (void *)(uintptr_t)i,
> >  						&ima_measurements_ops);
> >=20
> > ---
> > base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> > change-id: 20260127-ima-oob-9fa83a634d7b
> >=20
> > Best regards,


