Return-Path: <linux-integrity+bounces-858-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B13D838871
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 09:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEDB1F23530
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 08:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3F555E6C;
	Tue, 23 Jan 2024 08:04:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA055E65
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997058; cv=none; b=fkd0Wo9lekwxvwWdvDDIKXlOIZbGFnNUNTX0JwlBm9ELmdOVR2lMUc5tCdhjt9ljVeMPfAvNC4abHuD8o0C/g4WMNg8gL8YPYRUNDT1gK7vpmrpRgQitDDDrqklnXJmw6oK1SQe4qwZNCJjt5zydVPB+DT544eTnM5EVCuAuYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997058; c=relaxed/simple;
	bh=F2U02YkbjXEiX6u85N4Ajg0dsi/lgEH6TRzwPQLAU9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o53Ipz9x8E9RYeF1OSZXbAMt3k9CH4VLfYlvWVzFxKKT11U/+P7vNaYYaZo+4tllrJK87DegSj1115GntxQnFy/bLq9+ryzL4EP6oaITHadM88v3Gr1MDDCuW9EC5YqFPNXgmbq5M3H94qZZCrGbSiWLt/gsHRPhJXXCHmVC/vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TJzfB05Grz9xwvd
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 15:45:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 7E1581400E8
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 16:04:01 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXBCjrcq9loPQUAQ--.40912S2;
	Tue, 23 Jan 2024 09:04:01 +0100 (CET)
Message-ID: <c600cfadf5cc7cb890adeab9b6f3053c37bbb89f.camel@huaweicloud.com>
Subject: Re: [PATCH v2] ima: add crypto agility support for template-hash
 algorithm
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Date: Tue, 23 Jan 2024 09:03:52 +0100
In-Reply-To: <e0664bb2-8caf-42f3-9344-ee4159782eda@polito.it>
References: <20240121161633.2302285-1-enrico.bravi@polito.it>
	 <aa50966e78c74539f6379c7c2215880db22d2752.camel@huaweicloud.com>
	 <e0664bb2-8caf-42f3-9344-ee4159782eda@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXBCjrcq9loPQUAQ--.40912S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Zr15Aw4DXw45tFWruFyDKFg_yoWkWF48pa
	93WF1akF1kJFWxKr1S93Z7Wr4Sv3yrKrnrWr4DJ3Wjyrn0vrn2kayYkr1FkryDtr4DJF10
	qF47trZxCFn8taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5TVjAAAsx

On Mon, 2024-01-22 at 18:41 +0100, Enrico Bravi wrote:
> Hi Roberto,
>=20
> thanks a lot for your quick feedback.
>=20
> On 22/01/24 09:20, Roberto Sassu wrote:
> > On Sun, 2024-01-21 at 17:16 +0100, Enrico Bravi wrote:
> > > The template hash showed by the ascii_runtime_measurements and
> > > binary_runtime_measurements is the one calculated using sha1 and ther=
e is no
> > > possibility to change this value, despite the fact that the template =
hash is
> > > calculated using the hash algorothms corresponding to all the PCR ban=
ks
> > > configured in the TPM.
> > >=20
> > > This patch introduce the support to retrieve the ima log with the tem=
plate data
> > > hash calculated with a specific hash algorithm.
> > > Add a new file in the securityfs ima directory for each hash algo con=
figured
> > > for the PCR banks of the TPM. Each new file has the name with the fol=
lowing
> > > structure:
> > >=20
> > > 	{binary, ascii}_runtime_measurements_<hash_algo_name>
> > >=20
> > > except for sha1 which it remains associated with the standard file na=
mes.
> > > The <hash_algo_name> is used to select the template data hash algorit=
hm to show
> > > in ima_ascii_measurements_show() and in ima_measurements_show().
> > >=20
> > > As example, in the case sha1 and sha256 are the configured PCR banks,=
 the
> > > listing of the security/ima directory is the following:
> > >=20
> > > -r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements
> > > -r--r----- 1 root root 0 gen 20 15:06 ascii_runtime_measurements_sha2=
56
> > > -r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements
> > > -r--r----- 1 root root 0 gen 20 15:06 binary_runtime_measurements_sha=
256
> > > --w------- 1 root root 0 gen 20 15:06 policy
> > > -r--r----- 1 root root 0 gen 20 15:06 runtime_measurements_count
> > > -r--r----- 1 root root 0 gen 20 15:06 violations
> > >=20
> > > v2:
> > >  - Changed the behaviour of configuring at boot time the template dat=
a hash
> > >    algorithm.
> > >  - Removed template data hash algo name prefix.
> > >  - Removed ima_template_hash command line option.
> > >  - Introducing a new file in the securityfs ima subdir for each PCR b=
anks
> > >    algorithm configured in the TPM.
> > >    (suggested by Roberto)
> > >=20
> > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> > > Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
> > >=20
> > > ---
> > >  security/integrity/ima/ima_fs.c | 164 ++++++++++++++++++++++++++++++=
--
> > >  1 file changed, 157 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima=
/ima_fs.c
> > > index cd1683dad3bf..db57edeb112d 100644
> > > --- a/security/integrity/ima/ima_fs.c
> > > +++ b/security/integrity/ima/ima_fs.c
> > > @@ -118,7 +118,7 @@ void ima_putc(struct seq_file *m, void *data, int=
 datalen)
> > > =20
> > >  /* print format:
> > >   *       32bit-le=3Dpcr#
> > > - *       char[20]=3Dtemplate digest
> > > + *       char[n]=3Dtemplate digest
> > >   *       32bit-le=3Dtemplate name size
> > >   *       char[n]=3Dtemplate name
> > >   *       [eventdata length]
> > > @@ -130,9 +130,37 @@ int ima_measurements_show(struct seq_file *m, vo=
id *v)
> > >  	struct ima_queue_entry *qe =3D v;
> > >  	struct ima_template_entry *e;
> > >  	char *template_name;
> > > +	const char *filename;
> > > +	char algo_name[16];
> > >  	u32 pcr, namelen, template_data_len; /* temporary fields */
> > >  	bool is_ima_template =3D false;
> > > -	int i;
> > > +	int i, rc, algo_idx;
> > > +	enum hash_algo algo;
> > > +
> > > +	filename =3D m->file->f_path.dentry->d_name.name;
> > > +	rc =3D sscanf(filename, "binary_runtime_measurements%s", algo_name)=
;
> > > +
> > > +	if (rc !=3D 0) {
> > > +		for (i =3D 0; i < HASH_ALGO__LAST; i++) {
> > > +			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
> > > +				algo =3D i;
> > > +				break;
> > > +			}
> > > +		}
> > > +		if (i =3D=3D HASH_ALGO__LAST)
> > > +			algo =3D HASH_ALGO_SHA1;
> > > +
> > > +		for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> > > +			if (algo =3D=3D ima_tpm_chip->allocated_banks[i].crypto_id) {
> > > +				algo_idx =3D i;
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> >=20
> > Hi Enrico, Silvia
> >=20
> > I would find more efficient if you create an array of dentries in the
> > same order as ima_tpm_chip->allocated_banks, so that you can compare
> > dentry addresses and find already the right index.
>=20
> Your are absolutely right, there is no need of two loops.
>=20
> > > +	else {
> > > +		algo_idx =3D ima_sha1_idx;
> > > +		algo =3D HASH_ALGO_SHA1;
> > > +	}
> > > =20
> > >  	/* get entry */
> > >  	e =3D qe->entry;
> > > @@ -151,7 +179,7 @@ int ima_measurements_show(struct seq_file *m, voi=
d *v)
> > >  	ima_putc(m, &pcr, sizeof(e->pcr));
> > > =20
> > >  	/* 2nd: template digest */
> > > -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> > > +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> > > =20
> > >  	/* 3rd: template name size */
> > >  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> > > @@ -220,7 +248,35 @@ static int ima_ascii_measurements_show(struct se=
q_file *m, void *v)
> > >  	struct ima_queue_entry *qe =3D v;
> > >  	struct ima_template_entry *e;
> > >  	char *template_name;
> > > -	int i;
> > > +	const char *filename;
> > > +	char algo_name[16];
> > > +	int i, algo_idx, rc;
> > > +	enum hash_algo algo;
> > > +
> > > +	filename =3D m->file->f_path.dentry->d_name.name;
> > > +	rc =3D sscanf(filename, "ascii_runtime_measurements%s", algo_name);
> > > +
> > > +	if (rc !=3D 0) {
> > > +		for (i =3D 0; i < HASH_ALGO__LAST; i++) {
> > > +			if (!strcmp(algo_name + 1, hash_algo_name[i])) {
> > > +				algo =3D i;
> > > +				break;
> > > +			}
> > > +		}
> > > +		if (i =3D=3D HASH_ALGO__LAST)
> > > +			algo =3D HASH_ALGO_SHA1;
> > > +
> > > +		for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> > > +			if (algo =3D=3D ima_tpm_chip->allocated_banks[i].crypto_id) {
> > > +				algo_idx =3D i;
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> >=20
> > Same.
> >=20
> > > +	else {
> > > +		algo_idx =3D ima_sha1_idx;
> > > +		algo =3D HASH_ALGO_SHA1;
> > > +	}
> > > =20
> > >  	/* get entry */
> > >  	e =3D qe->entry;
> > > @@ -233,8 +289,8 @@ static int ima_ascii_measurements_show(struct seq=
_file *m, void *v)
> > >  	/* 1st: PCR used (config option) */
> > >  	seq_printf(m, "%2d ", e->pcr);
> > > =20
> > > -	/* 2nd: SHA1 template hash */
> > > -	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZ=
E);
> > > +	/* 2nd: template hash */
> > > +	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[a=
lgo]);
> > > =20
> > >  	/* 3th:  template name */
> > >  	seq_printf(m, " %s", template_name);
> > > @@ -363,6 +419,8 @@ static struct dentry *ascii_runtime_measurements;
> > >  static struct dentry *runtime_measurements_count;
> > >  static struct dentry *violations;
> > >  static struct dentry *ima_policy;
> > > +static struct dentry **ima_ascii_measurements_files;
> > > +static struct dentry **ima_binary_measurements_files;
> > > =20
> > >  enum ima_fs_flags {
> > >  	IMA_FS_BUSY,
> > > @@ -379,6 +437,31 @@ static const struct seq_operations ima_policy_se=
qops =3D {
> > >  };
> > >  #endif
> > > =20
> > > +/*
> > > + * Remove the securityfs files created for each hash algo configured
> > > + * in the TPM, excluded ascii_runtime_measurements and
> > > + * binary_runtime_measurements.
> > > + */
> > > +static void remove_measurements_list_files(void)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> > > +		if (ima_ascii_measurements_files[i]) {
> > > +			securityfs_remove(ima_ascii_measurements_files[i]);
> > > +			kfree(ima_ascii_measurements_files[i]);
> > > +		}
> > > +
> > > +		if (ima_binary_measurements_files[i]) {
> > > +			securityfs_remove(ima_binary_measurements_files[i]);
> > > +			kfree(ima_binary_measurements_files[i]);
> > > +		}
> > > +	}
> > > +
> > > +	kfree(ima_ascii_measurements_files);
> > > +	kfree(ima_binary_measurements_files);
> >=20
> > Oh, you actually put them in a array and order the elements by PCR
> > bank.
> >=20
> > > +}
> > > +
> > >  /*
> > >   * ima_open_policy: sequentialize access to the policy file
> > >   */
> > > @@ -452,7 +535,10 @@ static const struct file_operations ima_measure_=
policy_ops =3D {
> > > =20
> > >  int __init ima_fs_init(void)
> > >  {
> > > -	int ret;
> > > +	int ret, i;
> > > +	u16 algo;
> > > +	char file_name[50];
> > > +	struct dentry *dfile;
> > > =20
> > >  	ima_dir =3D securityfs_create_dir("ima", integrity_dir);
> > >  	if (IS_ERR(ima_dir))
> > > @@ -483,6 +569,69 @@ int __init ima_fs_init(void)
> > >  		goto out;
> > >  	}
> > > =20
> > > +	/*
> > > +	 * Allocate a file in the securityfs for each hash algo configured
> > > +	 * in the TPM but sha1 (for ascii and binary output).
> > > +	 */
> > > +	if (ima_tpm_chip) {
> > > +
> > > +		ima_ascii_measurements_files =3D kmalloc_array(NR_BANKS(ima_tpm_ch=
ip),
> > > +					sizeof(struct dentry *), GFP_KERNEL);
> >=20
> > Since you added a function for freeing the arrays, I would do the same
> > for adding.
>=20
> Sure.
>=20
> > > +		if(ima_ascii_measurements_files =3D=3D NULL) {
> > > +			ret =3D -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +
> > > +		ima_binary_measurements_files =3D kmalloc_array(NR_BANKS(ima_tpm_c=
hip),
> > > +					sizeof(struct dentry *), GFP_KERNEL);
> > > +		if(ima_binary_measurements_files =3D=3D NULL) {
> > > +			ret =3D -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +
> > > +		for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> > > +			algo =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> > > +
> > > +			/* Skip sha1 */
> > > +			if (algo =3D=3D HASH_ALGO_SHA1)
> > > +				continue;
> >=20
> > I would go ahead, create also the dentry for SHA1 and add a symbolic
> > link for the legacy files.
>=20
> ima_ascii_measurements_files and ima_binary_measurements_files are alloca=
ted
> just in the case a tpm chip is detected. What you are suggesting is to al=
locate
> in any case these lists, with at least one element, and creating the lega=
cy file
> always as symbolic links? Or to define them as symbolic links only in the=
 case a
> tpm chip is detected, otherwise creating them as usual?

Hi Enrico

I would keep the same scheme, even if there is no TPM chip. So SHA1
files, plus symbolic links in this case.

Thanks

Roberto

> > > +
> > > +			dfile =3D kmalloc(sizeof(struct dentry), GFP_KERNEL);
> > > +			if (!dfile) {
> > > +				ret =3D -ENOMEM;
> > > +				goto out;
> > > +			}
> >=20
> > I don't remember if the lines above are really necessary. You actually
> > overwrite the pointer below.
>=20
> Yes these lines are definitely not necessary.
>=20
> Thanks a lot,
>=20
> Enrico
>=20
> >=20
> > > +
> > > +			sprintf(file_name, "ascii_runtime_measurements_%s",
> > > +						hash_algo_name[algo]);
> > > +			dfile =3D securityfs_create_file(file_name,
> > > +						S_IRUSR | S_IRGRP, ima_dir, NULL,
> > > +						&ima_ascii_measurements_ops);
> > > +			if (IS_ERR(dfile)) {
> > > +				ret =3D PTR_ERR(dfile);
> > > +				goto out;
> > > +			}
> > > +			ima_ascii_measurements_files[i] =3D dfile;
> > > +
> > > +			dfile =3D kmalloc(sizeof(struct dentry), GFP_KERNEL);
> > > +			if (!dfile) {
> > > +				ret =3D -ENOMEM;
> > > +				goto out;
> > > +			}
> > > +
> > > +			sprintf(file_name, "binary_runtime_measurements_%s",
> > > +						hash_algo_name[algo]);
> > > +			dfile =3D securityfs_create_file(file_name,
> > > +						S_IRUSR | S_IRGRP, ima_dir, NULL,
> > > +						&ima_measurements_ops);
> > > +			if (IS_ERR(dfile)) {
> > > +				ret =3D PTR_ERR(dfile);
> > > +				goto out;
> > > +			}
> > > +			ima_binary_measurements_files[i] =3D dfile;
> > > +		}
> > > +	}
> > > +
> > >  	runtime_measurements_count =3D
> > >  	    securityfs_create_file("runtime_measurements_count",
> > >  				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> > > @@ -515,6 +664,7 @@ int __init ima_fs_init(void)
> > >  	securityfs_remove(runtime_measurements_count);
> > >  	securityfs_remove(ascii_runtime_measurements);
> > >  	securityfs_remove(binary_runtime_measurements);
> > > +	remove_measurements_list_files();
> > >  	securityfs_remove(ima_symlink);
> > >  	securityfs_remove(ima_dir);
> > >=20
> > > base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b


