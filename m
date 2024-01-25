Return-Path: <linux-integrity+bounces-886-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AC83BC3F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 09:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4320CB21491
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jan 2024 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C721B94B;
	Thu, 25 Jan 2024 08:47:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F079CF
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172446; cv=none; b=CgKON4qM1FZ1t0orsZ2tPbV+Rk4xnbZ2JoxwwNQwupKuqAoJToywDO+/65tZD07nmtDTpoGsZI06+DR19uA2BrkidT9Y8tN9P7+smW5pa4tk3E1d2n+WxR3fGHL5g2vIFAG0COszs51O8kkgvS4YGD2ngCDvmlt+6CScHrymSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172446; c=relaxed/simple;
	bh=xJ/gif5XyyDpC2bvm73NqF3sjDVB8y5XVJR1PKhlIKE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVLND1FV5wEE0XJn5ou7Bv1p4Ruib1uAqAKZNn/4SC1v7S5SznGNj2vPOFgP1b7z9gEn/1grlYZ1NymmCjVoEHSP1JOtYRVWwZX4oZ+MsZVeDOF2+1PkozwVu6rxpf4JC4LwyGx1fDhPrrsOyb3Pwa2fgfu4WjUQ3FyhiNjvlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TLDD36HJYz9xrsS
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 16:15:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 985CD140636
	for <linux-integrity@vger.kernel.org>; Thu, 25 Jan 2024 16:30:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC38CQlHLJlrZA1AQ--.62429S2;
	Thu, 25 Jan 2024 09:30:35 +0100 (CET)
Message-ID: <aaf771a59ff6c1fd99e579028f63f2278f6bed23.camel@huaweicloud.com>
Subject: Re: [PATCH v3] ima: add crypto agility support for template-hash
 algorithm
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, roberto.sassu@huawei.com
Cc: Silvia Sisinni <silvia.sisinni@polito.it>
Date: Thu, 25 Jan 2024 09:30:26 +0100
In-Reply-To: <20240124193223.46383-1-enrico.bravi@polito.it>
References: <20240124193223.46383-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC38CQlHLJlrZA1AQ--.62429S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ZrW3XFWUGFW3CF17CF45KFg_yoWDKr18pa
	93Wr1fCr1kJayxtrn7Cwn7Xr4fu3yFqwnrWr1kX34UArn8G34FkF4Ykr10yFWDKrWDJF40
	qa13trW3CFn0yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBF1jj5TsBQAAsH

On Wed, 2024-01-24 at 20:32 +0100, Enrico Bravi wrote:
> The template hash showed by the ascii_runtime_measurements and
> binary_runtime_measurements is the one calculated using sha1 and there is=
 no
> possibility to change this value, despite the fact that the template hash=
 is
> calculated using the hash algorithms corresponding to all the PCR banks
> configured in the TPM.

Hi Enrico

the missing part is that we should not modify existing files, to avoid
breaking existing applications.

> Add the support to retrieve the ima log with the template data hash calcu=
lated
> with a specific hash algorithm.
> Add a new file in the securityfs ima directory for each hash algo configu=
red
> for the PCR banks of the TPM. Each new file has the name with the followi=
ng
> structure:
>=20
>         {binary, ascii}_runtime_measurements_<hash_algo_name>
>=20
> The <hash_algo_name> is used to select the template data hash algorithm t=
o show
> in ima_ascii_measurements_show() and in ima_measurements_show().
> Legacy files are kept but as sysmbolic links which point to

Typo. Please use codespell on the patch.

> {binary, ascii}_runtime_measurements_sha1 files. These two files are crea=
ted
> even if a TPM chip is not detected.
>=20
> As example, in the case a TPM chip is present and sha1 and sha256 are the
> configured PCR banks, the listing of the security/ima directory is the fo=
llowing:
>=20
> lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements=
_sha1
> -r--r----- [...] ascii_runtime_measurements_sha1
> -r--r----- [...] ascii_runtime_measurements_sha256
> lr--r--r-- [...] binary_runtime_measurements -> binary_runtime_measuremen=
ts_sha1
> -r--r----- [...] binary_runtime_measurements_sha1
> -r--r----- [...] binary_runtime_measurements_sha256
> --w------- [...] policy
> -r--r----- [...] runtime_measurements_count
> -r--r----- [...] violations

Ok, great.

> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
>=20
> ---
>=20
> v3:
>  - Added create_measurements_list_files function for measurements files c=
reation.
>  - Parametrized the remove_measurements_list_files function and add NULL
>    check before freeing files' list.
>  - Removed algorithm selection based on file name during ima_measurements=
_show
>    and ima_ascii_mesurements_show, and selecting it comparing dentry addr=
ess.
>  - Allocate also sha1 file following the schema
>    {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
>    files as symbolic links to those files.
>  - Allocate measurements files lists even if a TPM chip is not detected,
>    adding only sha1 files.
>=20
> v2:
>  - Changed the behaviour of configuring at boot time the template data ha=
sh
>    algorithm.
>  - Removed template data hash algo name prefix.
>  - Removed ima_template_hash command line option.
>  - Introducing a new file in the securityfs ima subdir for each PCR banks
>    algorithm configured in the TPM.
>    (suggested by Roberto)
>=20
>  security/integrity/ima/ima_fs.c | 145 +++++++++++++++++++++++++++++---
>  1 file changed, 131 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index cd1683dad3bf..fb65ba9426a1 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -116,9 +116,12 @@ void ima_putc(struct seq_file *m, void *data, int da=
talen)
>  		seq_putc(m, *(char *)data++);
>  }
> =20
> +static struct dentry **ima_ascii_measurements_files;
> +static struct dentry **ima_binary_measurements_files;
> +
>  /* print format:
>   *       32bit-le=3Dpcr#
> - *       char[20]=3Dtemplate digest
> + *       char[n]=3Dtemplate digest
>   *       32bit-le=3Dtemplate name size
>   *       char[n]=3Dtemplate name
>   *       [eventdata length]
> @@ -130,9 +133,25 @@ int ima_measurements_show(struct seq_file *m, void *=
v)
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> +	struct dentry *dentry;
>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>  	bool is_ima_template =3D false;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	dentry =3D m->file->f_path.dentry;

I like more file_dentry(m->file).

> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (ima_tpm_chip) {
> +		for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> +			if (dentry =3D=3D ima_binary_measurements_files[i]) {
> +				algo_idx =3D i;
> +				algo =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> +				break;
> +			}
> +		}
> +	}
> =20
>  	/* get entry */
>  	e =3D qe->entry;
> @@ -151,7 +170,7 @@ int ima_measurements_show(struct seq_file *m, void *v=
)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
> =20
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> =20
>  	/* 3rd: template name size */
>  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> @@ -220,7 +239,23 @@ static int ima_ascii_measurements_show(struct seq_fi=
le *m, void *v)
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> -	int i;
> +	struct dentry *dentry;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	dentry =3D m->file->f_path.dentry;

Same.

> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (ima_tpm_chip) {
> +		for (i =3D 0; i < NR_BANKS(ima_tpm_chip); i++) {
> +			if (dentry =3D=3D ima_ascii_measurements_files[i]) {

Uhm, why not iterating over ima_ascii_measurements_files?

But I have another comment on this.

Have a look at ima_crypto.c:

	if (ima_sha1_idx < 0) {
		ima_sha1_idx =3D NR_BANKS(ima_tpm_chip) + ima_extra_slots++;
		if (ima_hash_algo =3D=3D HASH_ALGO_SHA1)
			ima_hash_algo_idx =3D ima_sha1_idx;
	}

This is done because not necessarily the TPM has a SHA1 bank.

ima_extra_slots is already exported, you could use that to determine if
you need more slots than NR_BANKS(ima_tpm_chip).

> +				algo_idx =3D i;
> +				algo =3D ima_tpm_chip->allocated_banks[i].crypto_id;
> +				break;
> +			}
> +		}
> +	}
> =20
>  	/* get entry */
>  	e =3D qe->entry;
> @@ -233,8 +268,8 @@ static int ima_ascii_measurements_show(struct seq_fil=
e *m, void *v)
>  	/* 1st: PCR used (config option) */
>  	seq_printf(m, "%2d ", e->pcr);
> =20
> -	/* 2nd: SHA1 template hash */
> -	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	/* 2nd: template hash */
> +	ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size[algo]=
);
> =20
>  	/* 3th:  template name */
>  	seq_printf(m, " %s", template_name);
> @@ -379,6 +414,84 @@ static const struct seq_operations ima_policy_seqops=
 =3D {
>  };
>  #endif
> =20
> +/*
> + * Remove the securityfs files created for each hash algo configured
> + * in the TPM, excluded ascii_runtime_measurements and
> + * binary_runtime_measurements.
> + */

It does not hurt following the kernel-doc format.

> +static void remove_measurements_list_files(struct dentry **files)
> +{
> +	int i, len;
> +	len =3D ima_tpm_chip ? NR_BANKS(ima_tpm_chip) : 1;

It is much better having a global variable with the number of array
elements.

> +
> +	if (files)
> +	{

This bracket should be one line up.

> +		for (i =3D 0; i < len; i++) {
> +			if (files[i]) {
> +				securityfs_remove(files[i]);
> +			}
> +		}
> +
> +		kfree(files);
> +	}
> +}
> +
> +/*
> + * Allocate a file in the securityfs for each hash algo configured
> + * in the TPM (for ascii and binary output). In case no TPM chip is
> + * detected only sha1 files are created.
> + */
> +static int create_measurements_list_files(void)
> +{=09
> +	int i, len;
> +	u16 algo;
> +	char file_name[NAME_MAX+1];
> +	struct dentry *dfile;
> +
> +	/*=20
> +	 * Allocate NR_BANKS(ima_tpm_chip) files in case a tpm chip is detected=
,
> +	 * otherwise allocate just one file for sha1.
> +	 */
> +	len =3D ima_tpm_chip ? NR_BANKS(ima_tpm_chip) : 1;

See the comment above regarding ima_extra_slots.

If you export len (static), you can always use that without extra
logic.

> +
> +	ima_ascii_measurements_files =3D kmalloc_array(len,
> +				sizeof(struct dentry *), GFP_KERNEL);
> +	if(!ima_ascii_measurements_files)
> +		return -ENOMEM;
> +
> +	ima_binary_measurements_files =3D kmalloc_array(len,
> +				sizeof(struct dentry *), GFP_KERNEL);
> +	if(!ima_binary_measurements_files)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < len; i++) {
> +		algo =3D ima_tpm_chip ? ima_tpm_chip->allocated_banks[i].crypto_id :
> +								HASH_ALGO_SHA1;

I'm starting to think that maybe we should export ima_algo_array
instead, and follow that.

> +
> +		sprintf(file_name, "ascii_runtime_measurements_%s",
> +					hash_algo_name[algo]);
> +		dfile =3D securityfs_create_file(file_name,
> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
> +					&ima_ascii_measurements_ops);
> +		if (IS_ERR(dfile))
> +			return PTR_ERR(dfile);
> +
> +		ima_ascii_measurements_files[i] =3D dfile;
> +
> +		sprintf(file_name, "binary_runtime_measurements_%s",
> +					hash_algo_name[algo]);
> +		dfile =3D securityfs_create_file(file_name,
> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
> +					&ima_measurements_ops);
> +		if (IS_ERR(dfile))
> +			return PTR_ERR(dfile);
> +
> +		ima_binary_measurements_files[i] =3D dfile;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * ima_open_policy: sequentialize access to the policy file
>   */
> @@ -465,19 +578,21 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
> =20
> -	binary_runtime_measurements =3D
> -	    securityfs_create_file("binary_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_measurements_ops);
> +	ret =3D create_measurements_list_files();
> +	if (ret !=3D 0)
> +		goto out;
> +
> +	binary_runtime_measurements =3D securityfs_create_symlink(
> +		"binary_runtime_measurements", ima_dir,=20
> +		"binary_runtime_measurements_sha1", NULL);
>  	if (IS_ERR(binary_runtime_measurements)) {
>  		ret =3D PTR_ERR(binary_runtime_measurements);
>  		goto out;
>  	}
> =20
> -	ascii_runtime_measurements =3D
> -	    securityfs_create_file("ascii_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_ascii_measurements_ops);
> +	ascii_runtime_measurements =3D securityfs_create_symlink(
> +		"ascii_runtime_measurements", ima_dir,
> +		"ascii_runtime_measurements_sha1", NULL);
>  	if (IS_ERR(ascii_runtime_measurements)) {
>  		ret =3D PTR_ERR(ascii_runtime_measurements);
>  		goto out;
> @@ -515,6 +630,8 @@ int __init ima_fs_init(void)
>  	securityfs_remove(runtime_measurements_count);
>  	securityfs_remove(ascii_runtime_measurements);
>  	securityfs_remove(binary_runtime_measurements);
> +	remove_measurements_list_files(ima_ascii_measurements_files);
> +	remove_measurements_list_files(ima_binary_measurements_files);

The rest is ok.

Thanks

Roberto

>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
>=20
> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b=20


