Return-Path: <linux-integrity+bounces-1779-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10587E4F0
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 09:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B1C28207C
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518D325763;
	Mon, 18 Mar 2024 08:26:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1CB25776
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710750362; cv=none; b=n+Yt2aAmWxJXDKXoobIiNp9jQKM9BuwaSfg76dIZvXKpi4702RzktV5a/pKu5HVlxa4+a7TeKg5RdA3FhUralvt/bV4YTYqQpeEmLZH3nZCNzdY1d+RzhaMzyNnH6w6szoJS4oNf9vD3n0b9+fx+R0KZMNQKOglXVoAn0Iiwa/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710750362; c=relaxed/simple;
	bh=KA0rE4wHi71euxBJUWcRC2mm//cxEvJfij90zc5UmTU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uKOydQShcIzY2ALN+RQ0j959Ol8+tr01r5v0ebc7EGj+4uhMkQt9F8p9jaCR8s9FOVa1+5NELHIEtbmeGHToJ+j2ty9GTwQhMENhQdJWPMkHPs5icCc/5U6nWIfgFcOAzEZBLwcB+9fGYI2+zJKVcv0rgkuEM7IyTa7FWe0zSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TynZz2Fttz9xFGQ
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 16:10:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 61156140121
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 16:25:56 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHfSGN+vdlg1yCBA--.39748S2;
	Mon, 18 Mar 2024 09:25:55 +0100 (CET)
Message-ID: <a0bf6aa049ddebfd567a25446d05d73062a409ab.camel@huaweicloud.com>
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Mon, 18 Mar 2024 09:25:45 +0100
In-Reply-To: <20240308104953.743847-1-enrico.bravi@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHfSGN+vdlg1yCBA--.39748S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF1rAFy3GryfuFWDtw45trb_yoWkZFyUpa
	93XFyfCrykJFWxKrn7C3Z7Xr4S93yFg3WDWr4DXw1DAFn8GryvkF45Cr10krs8trZ8XF48
	tanrtr43A3Z8taDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
	WIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj5d8mQAAsD

On Fri, 2024-03-08 at 11:49 +0100, Enrico Bravi wrote:
> The template hash showed by the ascii_runtime_measurements and
> binary_runtime_measurements is the one calculated using sha1 and there is
> no possibility to change this value, despite the fact that the template
> hash is calculated using the hash algorithms corresponding to all the PCR
> banks configured in the TPM.
>=20
> Add the support to retrieve the ima log with the template data hash
> calculated with a specific hash algorithm.
> Add a new file in the securityfs ima directory for each hash algo
> configured in a PCR bank of the TPM. Each new file has the name with
> the following structure:
>=20
>         {binary, ascii}_runtime_measurements_<hash_algo_name>
>=20
> Legacy files are kept, to avoid breaking existing applications, but as
> symbolic links which point to {binary, ascii}_runtime_measurements_sha1
> files. These two files are created even if a TPM chip is not detected or
> the sha1 bank is not configure in the TPM.

Configured.

> As example, in the case a TPM chip is present and sha256 is the only
> configured PCR bank, the listing of the security/ima directory is the
> following:
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
>=20
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
>=20
> ---
>=20
> v4:
>  - Added NULL check on m->file for measurements list dump called by
>    ima_dump_measurement_list() on kexec.
>  - Exported ima_algo_array and struct ima_algo_desc declaration from
>    ima_crypto.c to access this information in ima_fs.c.
>  - Added ima_measurements_files_count global variable to avoid extra
>    logic each time the number of measurements file is needed.
>=20
> v3:
>  - Added create_measurements_list_files function for measurements files c=
reation.
>  - Parameterized the remove_measurements_list_files function and add NULL
>    check before freeing files' list.
>  - Removed algorithm selection based on file name during ima_measurements=
_show
>    and ima_ascii_measurements_show, and selecting it comparing dentry add=
ress.
>  - Allocate also sha1 file following the schema
>    {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
>    files as symbolic links to those files.
>  - Allocate measurements files lists even if a TPM chip is not detected,
>    adding only sha1 files.
>=20
> v2:
>  - Changed the behavior of configuring at boot time the template data has=
h
>    algorithm.
>  - Removed template data hash algo name prefix.
>  - Removed ima_template_hash command line option.
>  - Introducing a new file in the securityfs ima subdir for each PCR banks
>    algorithm configured in the TPM.
>    (suggested by Roberto)
>=20
>=20
>  security/integrity/ima/ima.h        |   9 ++
>  security/integrity/ima/ima_crypto.c |   7 +-
>  security/integrity/ima/ima_fs.c     | 135 +++++++++++++++++++++++++---
>  3 files changed, 131 insertions(+), 20 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..81318e294175 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -54,6 +54,15 @@ extern int ima_hash_algo __ro_after_init;
>  extern int ima_sha1_idx __ro_after_init;
>  extern int ima_hash_algo_idx __ro_after_init;
>  extern int ima_extra_slots __ro_after_init;
> +
> +/* export hash algorithms configured in ima */
> +struct ima_algo_desc {
> +	struct crypto_shash *tfm;
> +	enum hash_algo algo;
> +};
> +
> +extern struct ima_algo_desc *ima_algo_array;
> +
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  extern const char boot_aggregate_name[];
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 51ad29940f05..d42ea0d350a1 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -57,11 +57,6 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer =
size");
>  static struct crypto_shash *ima_shash_tfm;
>  static struct crypto_ahash *ima_ahash_tfm;
> =20
> -struct ima_algo_desc {
> -	struct crypto_shash *tfm;
> -	enum hash_algo algo;
> -};
> -
>  int ima_sha1_idx __ro_after_init;
>  int ima_hash_algo_idx __ro_after_init;
>  /*
> @@ -70,7 +65,7 @@ int ima_hash_algo_idx __ro_after_init;
>   */
>  int ima_extra_slots __ro_after_init;
> =20
> -static struct ima_algo_desc *ima_algo_array;
> +struct ima_algo_desc *ima_algo_array;
> =20
>  static int __init ima_init_ima_crypto(void)
>  {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index cd1683dad3bf..475ab368e32f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int da=
talen)
>  		seq_putc(m, *(char *)data++);
>  }
> =20
> +static struct dentry **ima_ascii_measurements_files;
> +static struct dentry **ima_binary_measurements_files;
> +static int ima_measurements_files_count;
> +
>  /* print format:
>   *       32bit-le=3Dpcr#
> - *       char[20]=3Dtemplate digest
> + *       char[n]=3Dtemplate digest
>   *       32bit-le=3Dtemplate name size
>   *       char[n]=3Dtemplate name
>   *       [eventdata length]
> @@ -130,9 +134,26 @@ int ima_measurements_show(struct seq_file *m, void *=
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
> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (m->file !=3D NULL) {
> +		dentry =3D file_dentry(m->file);
> +
> +		for (i =3D 0; i < ima_measurements_files_count; i++) {
> +			if (dentry =3D=3D ima_binary_measurements_files[i]) {
> +				algo_idx =3D i;
> +				algo =3D ima_algo_array[i].algo;
> +				break;
> +			}
> +		}
> +	}

Since you duplicate the same code below, I would put it in a separate
function, like lookup_algo_by_dentry().
=20
>  	/* get entry */
>  	e =3D qe->entry;
> @@ -151,7 +172,7 @@ int ima_measurements_show(struct seq_file *m, void *v=
)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
> =20
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> =20
>  	/* 3rd: template name size */
>  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> @@ -220,7 +241,24 @@ static int ima_ascii_measurements_show(struct seq_fi=
le *m, void *v)
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> -	int i;
> +	struct dentry *dentry;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (m->file !=3D NULL) {
> +		dentry =3D file_dentry(m->file);
> +
> +		for (i =3D 0; i < ima_measurements_files_count; i++) {
> +			if (dentry =3D=3D ima_ascii_measurements_files[i]) {
> +				algo_idx =3D i;
> +				algo =3D ima_algo_array[i].algo;
> +				break;
> +			}
> +		}
> +	}
> =20
>  	/* get entry */
>  	e =3D qe->entry;
> @@ -233,8 +271,8 @@ static int ima_ascii_measurements_show(struct seq_fil=
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
> @@ -379,6 +417,71 @@ static const struct seq_operations ima_policy_seqops=
 =3D {
>  };
>  #endif
> =20
> +static void remove_measurements_list_files(struct dentry **files)
> +{
> +	int i;
> +
> +	if (files) {
> +		for (i =3D 0; i < ima_measurements_files_count; i++)
> +			securityfs_remove(files[i]);
> +
> +		kfree(files);
> +	}
> +}
> +
> +static int create_measurements_list_files(void)
> +{
> +	int i;
> +	u16 algo;
> +	char file_name[NAME_MAX+1];
> +	struct dentry *dfile;
> +	enum hash_algo sha1_algo_idx =3D -1;
> +
> +	ima_measurements_files_count =3D NR_BANKS(ima_tpm_chip);
> +
> +	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
> +		ima_measurements_files_count++;
> +
> +	ima_ascii_measurements_files =3D kcalloc(ima_measurements_files_count,
> +						sizeof(struct dentry *), GFP_KERNEL);

Second line not aligned?

Try scripts/checkpatch.pl --strict


It should tell about these issues.

> +	if (!ima_ascii_measurements_files)
> +		return -ENOMEM;
> +
> +	ima_binary_measurements_files =3D kcalloc(ima_measurements_files_count,
> +						sizeof(struct dentry *), GFP_KERNEL);
> +	if (!ima_binary_measurements_files)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < ima_measurements_files_count; i++) {
> +		algo =3D ima_algo_array[i].algo;
> +
> +		if (algo =3D=3D HASH_ALGO_SHA1)
> +			sha1_algo_idx =3D i;
> +
> +		sprintf(file_name, "ascii_runtime_measurements_%s",
> +					hash_algo_name[algo]);

Alignment.

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
> @@ -465,19 +568,21 @@ int __init ima_fs_init(void)
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
> +		"binary_runtime_measurements", ima_dir,
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
> @@ -515,6 +620,8 @@ int __init ima_fs_init(void)
>  	securityfs_remove(runtime_measurements_count);
>  	securityfs_remove(ascii_runtime_measurements);
>  	securityfs_remove(binary_runtime_measurements);
> +	remove_measurements_list_files(ima_ascii_measurements_files);
> +	remove_measurements_list_files(ima_binary_measurements_files);

Other than the issues above, looks good.

Did you try to dump non-SHA1 measurements after kexec?

Thanks

Roberto

>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
>=20
> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b=20


