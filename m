Return-Path: <linux-integrity+bounces-2027-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F589BE32
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 13:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C25284697
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Apr 2024 11:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F4657C4;
	Mon,  8 Apr 2024 11:35:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99145940
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576141; cv=none; b=MlI6XrIWIy3lucwVdNRbHlW4YaBtx5Q/40laVjnEdxs5tDPdDEgvMYP7PBTN/lzkMtJ8Q5T4bUyv6HlXaaZHBYV144DjKzgqcybqMqPzT5HDOleV890oraVCHKexgpaejeNBBF3nWED5+clVs1yw20wr+/mAv8+wGXtRgZ8zvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576141; c=relaxed/simple;
	bh=yj+eiesEXIZTs+0fiJvZEaOJlgIZqBE6uIkTibx4JMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NV5NruSpEkiHnzNiBqlBjRs3tUhuYQ+Bo+qUdmloCUsATwqhasHrezZ8vW/b4a8pGsl2DmvfR6MJRPDZzfqp1BpgvqitHYHJGqILJVI9uIOipWojmiHCZAUtA/Ksjr6vd1zicoZO1yxfVGpSIonBimrq9nT+XtATHuS36y0ouyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4VCmhS2pVTz9xFr8
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 19:14:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2400A140713
	for <linux-integrity@vger.kernel.org>; Mon,  8 Apr 2024 19:35:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBXSxR21hNmkQvYBQ--.48372S2;
	Mon, 08 Apr 2024 12:35:25 +0100 (CET)
Message-ID: <b82cceaa6505f75acd7c1702dfc4a70406a0a9d7.camel@huaweicloud.com>
Subject: Re: [PATCH v5] ima: add crypto agility support for template-hash
 algorithm
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Mon, 08 Apr 2024 13:35:14 +0200
In-Reply-To: <20240408111727.404486-1-enrico.bravi@polito.it>
References: <20240408111727.404486-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBXSxR21hNmkQvYBQ--.48372S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJF15Kw48AFy8JF48Kr18AFb_yoW8Jw48Jo
	Za9rW3CF4UKrn3Cr4jkFsFkrWxua95W347ArW0qrWDt3ZFqFy5Ka1SqF4UGa1Fq34rX347
	Gwn7Aw1kZFnFqwn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5Q7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3w
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5g64QAAsz

On Mon, 2024-04-08 at 13:17 +0200, Enrico Bravi wrote:
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
> the sha1 bank is not configured in the TPM.
>=20
> As example, in the case a TPM chip is present and sha256 is the only
> configured PCR bank, the listing of the securityfs ima directory is the
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

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
>=20
> v5:
>  - Added lookup_algo_by_dentry() function to select the hash algo during
>    measurements dump. (suggested by Roberto)
>  - Renamed remove_measurements_list_files() to
>    remove_securityfs_measurement_lists() and create_measurements_list_fil=
es()
>    to create_securityfs_measurement_lists(), and marked both as __init.
>    (suggested by Mimi)
>  - Renamed ima_ascii_measurements_files to ascii_securityfs_measurement_l=
ists,
>    ima_binary_measurements_files to binary_securityfs_measurement_lists a=
nd
>    ima_measurements_files_count to securityfs_measurement_list_count, and
>    marked them as __ro_after_init. (suggested by Mimi)
>  - Added missing NULL assignment for file.file in ima_dump_measurement_li=
st()
>    during kexec.
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
> ---
>  security/integrity/ima/ima.h        |  10 +++
>  security/integrity/ima/ima_crypto.c |   7 +-
>  security/integrity/ima/ima_fs.c     | 129 +++++++++++++++++++++++++---
>  security/integrity/ima/ima_kexec.c  |   1 +
>  4 files changed, 129 insertions(+), 18 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..e5e45cce4d0e 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -54,6 +54,16 @@ extern int ima_hash_algo __ro_after_init;
>  extern int ima_sha1_idx __ro_after_init;
>  extern int ima_hash_algo_idx __ro_after_init;
>  extern int ima_extra_slots __ro_after_init;
> +
> +/* IMA hash algorithm description */
> +struct ima_algo_desc {
> +	struct crypto_shash *tfm;
> +	enum hash_algo algo;
> +};
> +
> +/* hash algorithms configured in IMA */
> +extern struct ima_algo_desc *ima_algo_array;
> +
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
>  extern const char boot_aggregate_name[];
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index f3738b2c8bcd..3606931fc525 100644
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
> index cd1683dad3bf..d0c8f7daa2e2 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -116,9 +116,30 @@ void ima_putc(struct seq_file *m, void *data, int da=
talen)
>  		seq_putc(m, *(char *)data++);
>  }
> =20
> +static struct dentry **ascii_securityfs_measurement_lists __ro_after_ini=
t;
> +static struct dentry **binary_securityfs_measurement_lists __ro_after_in=
it;
> +static int securityfs_measurement_list_count __ro_after_init;
> +
> +static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
> +				  struct seq_file *m, struct dentry **dentry_list)
> +{
> +	struct dentry *dentry;
> +	int i;
> +
> +	dentry =3D file_dentry(m->file);
> +
> +	for (i =3D 0; i < securityfs_measurement_list_count; i++) {
> +		if (dentry =3D=3D dentry_list[i]) {
> +			*algo_idx =3D i;
> +			*algo =3D ima_algo_array[i].algo;
> +			break;
> +		}
> +	}
> +}
> +
>  /* print format:
>   *       32bit-le=3Dpcr#
> - *       char[20]=3Dtemplate digest
> + *       char[n]=3Dtemplate digest
>   *       32bit-le=3Dtemplate name size
>   *       char[n]=3Dtemplate name
>   *       [eventdata length]
> @@ -132,7 +153,14 @@ int ima_measurements_show(struct seq_file *m, void *=
v)
>  	char *template_name;
>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>  	bool is_ima_template =3D false;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (m->file !=3D NULL)
> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
> +				      binary_securityfs_measurement_lists);
> =20
>  	/* get entry */
>  	e =3D qe->entry;
> @@ -151,7 +179,7 @@ int ima_measurements_show(struct seq_file *m, void *v=
)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
> =20
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
> =20
>  	/* 3rd: template name size */
>  	namelen =3D !ima_canonical_fmt ? strlen(template_name) :
> @@ -220,7 +248,14 @@ static int ima_ascii_measurements_show(struct seq_fi=
le *m, void *v)
>  	struct ima_queue_entry *qe =3D v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx =3D ima_sha1_idx;
> +	algo =3D HASH_ALGO_SHA1;
> +
> +	if (m->file !=3D NULL)
> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
> +				      ascii_securityfs_measurement_lists);
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
> @@ -379,6 +414,69 @@ static const struct seq_operations ima_policy_seqops=
 =3D {
>  };
>  #endif
> =20
> +static void __init remove_securityfs_measurement_lists(struct dentry **d=
entry_list)
> +{
> +	int i;
> +
> +	if (dentry_list) {
> +		for (i =3D 0; i < securityfs_measurement_list_count; i++)
> +			securityfs_remove(dentry_list[i]);
> +
> +		kfree(dentry_list);
> +	}
> +
> +	securityfs_measurement_list_count =3D 0;
> +}
> +
> +static int __init create_securityfs_measurement_lists(void)
> +{
> +	int i;
> +	u16 algo;
> +	char file_name[NAME_MAX + 1];
> +	struct dentry *dentry;
> +
> +	securityfs_measurement_list_count =3D NR_BANKS(ima_tpm_chip);
> +
> +	if (ima_sha1_idx >=3D NR_BANKS(ima_tpm_chip))
> +		securityfs_measurement_list_count++;
> +
> +	ascii_securityfs_measurement_lists =3D kcalloc(securityfs_measurement_l=
ist_count,
> +						     sizeof(struct dentry *), GFP_KERNEL);
> +	if (!ascii_securityfs_measurement_lists)
> +		return -ENOMEM;
> +
> +	binary_securityfs_measurement_lists =3D kcalloc(securityfs_measurement_=
list_count,
> +						      sizeof(struct dentry *), GFP_KERNEL);
> +	if (!binary_securityfs_measurement_lists)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < securityfs_measurement_list_count; i++) {
> +		algo =3D ima_algo_array[i].algo;
> +
> +		sprintf(file_name, "ascii_runtime_measurements_%s",
> +			hash_algo_name[algo]);
> +		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +						ima_dir, NULL,
> +						&ima_ascii_measurements_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
> +
> +		ascii_securityfs_measurement_lists[i] =3D dentry;
> +
> +		sprintf(file_name, "binary_runtime_measurements_%s",
> +			hash_algo_name[algo]);
> +		dentry =3D securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +						ima_dir, NULL,
> +						&ima_measurements_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
> +
> +		binary_securityfs_measurement_lists[i] =3D dentry;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * ima_open_policy: sequentialize access to the policy file
>   */
> @@ -454,6 +552,9 @@ int __init ima_fs_init(void)
>  {
>  	int ret;
> =20
> +	ascii_securityfs_measurement_lists =3D NULL;
> +	binary_securityfs_measurement_lists =3D NULL;
> +
>  	ima_dir =3D securityfs_create_dir("ima", integrity_dir);
>  	if (IS_ERR(ima_dir))
>  		return PTR_ERR(ima_dir);
> @@ -465,19 +566,21 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
> =20
> +	ret =3D create_securityfs_measurement_lists();
> +	if (ret !=3D 0)
> +		goto out;
> +
>  	binary_runtime_measurements =3D
> -	    securityfs_create_file("binary_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_measurements_ops);
> +		securityfs_create_symlink("binary_runtime_measurements", ima_dir,
> +					  "binary_runtime_measurements_sha1", NULL);
>  	if (IS_ERR(binary_runtime_measurements)) {
>  		ret =3D PTR_ERR(binary_runtime_measurements);
>  		goto out;
>  	}
> =20
>  	ascii_runtime_measurements =3D
> -	    securityfs_create_file("ascii_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_ascii_measurements_ops);
> +		securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
> +					  "ascii_runtime_measurements_sha1", NULL);
>  	if (IS_ERR(ascii_runtime_measurements)) {
>  		ret =3D PTR_ERR(ascii_runtime_measurements);
>  		goto out;
> @@ -515,6 +618,8 @@ int __init ima_fs_init(void)
>  	securityfs_remove(runtime_measurements_count);
>  	securityfs_remove(ascii_runtime_measurements);
>  	securityfs_remove(binary_runtime_measurements);
> +	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists)=
;
> +	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists=
);
>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
> =20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index dadc1d138118..52e00332defe 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -30,6 +30,7 @@ static int ima_dump_measurement_list(unsigned long *buf=
fer_size, void **buffer,
>  		goto out;
>  	}
> =20
> +	file.file =3D NULL;
>  	file.size =3D segment_size;
>  	file.read_pos =3D 0;
>  	file.count =3D sizeof(khdr);	/* reserved space */
>=20
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba


