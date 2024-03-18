Return-Path: <linux-integrity+bounces-1780-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE8987E9D0
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 14:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB391F22302
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Mar 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F638DCC;
	Mon, 18 Mar 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d3VGwTyd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CDC3839E
	for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2024 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767147; cv=none; b=NrH4KMqA7NZSSnxc67IEGx4L6S6CmK53BjXzRwOzJTtTsrh/FzjvaijXnfU5f+aQ+qyya89EHO59U7yj92JXkxcPN6O3XA4ArIX0I6rwchcw6dV1c/P1Fa57NgFNGwrYSs3FDt5B7X5Fb3iYz9AEzRxayu9zM0Snrq5UbfiENLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767147; c=relaxed/simple;
	bh=SDFkXdX7fh1B6JtbqljO2VCMl3FEKCsauhRZpBRzae0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=KDkyMLqgNEJRRfxS0bTKtx09xKEufoAbbLtqJ5EYbz1A4dzrfNY82DoZBGaAcTrkGkCLRolEcZAJGBX7wJSqhroUgC0b8hz4IqAyBrTorMb6LqJtPaMMztBKgD5Aw5N/kYw3maBfmsbkG5ljVM0nSv5ZDHcmeSgweevySq91C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d3VGwTyd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ID0afI006409;
	Mon, 18 Mar 2024 13:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jyU18eQb1wRRtxzVBOTYpNZh4aLPf6jR+O0Miv5T/Qk=;
 b=d3VGwTyd5l0cH0q88BywK6iwitOxlQ4H7GwRDDn5kXNrUhxubKMqmY1PkFl2J+eV5ZrO
 JBoBNGVtJFbKET6840SDTYoKwqe05aaAVRZiCOyvE5UVKzPUB/GlafZJbSLwl5VN6Lw4
 o4wUyZlE9sv8Qmc8Pcpl3X4rnClW4fdD5L0BBnPEpXb44GqJ0xXwVeXdaG7Xbu0nPPbP
 Yn4CopNbfrQD2Y8fezMpqB9WOfc8Nu6A6/iyEBBoCFEJgxChR2sBl78AJawhInD8mT7n
 K3VtSeHy7edzWn+b8DXvEB8wPNP80nYF2HHwrkHD14h80TxB0VJZaQeZiwRYJTiXcV6N Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxkvfhcud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 13:05:35 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42ID27A6010403;
	Mon, 18 Mar 2024 13:05:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxkvfhcu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 13:05:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42ICtA0N011606;
	Mon, 18 Mar 2024 13:05:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwq8kruv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 13:05:33 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42ID5Vnl40567146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 13:05:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0328558065;
	Mon, 18 Mar 2024 13:05:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC185806B;
	Mon, 18 Mar 2024 13:05:30 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.93.67])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 Mar 2024 13:05:30 +0000 (GMT)
Message-ID: <18e212c7d947e8a39297fd84e1765d2bc0e82140.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Mon, 18 Mar 2024 09:05:29 -0400
In-Reply-To: <20240308104953.743847-1-enrico.bravi@polito.it>
References: <20240308104953.743847-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UPKZmCckh4U01ytVkX8Zq9ZrDaWxSpqj
X-Proofpoint-ORIG-GUID: Uu_V5tczCyqyXUQaVDhB-WF1SxdWS_39
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_04,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403180097

On Fri, 2024-03-08 at 11:49 +0100, Enrico Bravi wrote:
> The template hash showed by the ascii_runtime_measurements and
> binary_runtime_measurements is the one calculated using sha1 and there is
> no possibility to change this value, despite the fact that the template
> hash is calculated using the hash algorithms corresponding to all the PCR
> banks configured in the TPM.
> 
> Add the support to retrieve the ima log with the template data hash
> calculated with a specific hash algorithm.
> Add a new file in the securityfs ima directory for each hash algo
> configured in a PCR bank of the TPM. Each new file has the name with
> the following structure:
> 
>         {binary, ascii}_runtime_measurements_<hash_algo_name>
> 
> Legacy files are kept, to avoid breaking existing applications, but as
> symbolic links which point to {binary, ascii}_runtime_measurements_sha1
> files. These two files are created even if a TPM chip is not detected or
> the sha1 bank is not configure in the TPM.
> 
> As example, in the case a TPM chip is present and sha256 is the only
> configured PCR bank, the listing of the security/ima directory is the
> following:
> 
> lr--r--r-- [...] ascii_runtime_measurements -> ascii_runtime_measurements_sha1
> -r--r----- [...] ascii_runtime_measurements_sha1
> -r--r----- [...] ascii_runtime_measurements_sha256
> lr--r--r-- [...] binary_runtime_measurements ->
> binary_runtime_measurements_sha1
> -r--r----- [...] binary_runtime_measurements_sha1
> -r--r----- [...] binary_runtime_measurements_sha256
> --w------- [...] policy
> -r--r----- [...] runtime_measurements_count
> -r--r----- [...] violations
> 
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> Signed-off-by: Silvia Sisinni <silvia.sisinni@polito.it>
> 
> ---
> 
> v4:
>  - Added NULL check on m->file for measurements list dump called by
>    ima_dump_measurement_list() on kexec.
>  - Exported ima_algo_array and struct ima_algo_desc declaration from
>    ima_crypto.c to access this information in ima_fs.c.
>  - Added ima_measurements_files_count global variable to avoid extra
>    logic each time the number of measurements file is needed.
> 
> v3:
>  - Added create_measurements_list_files function for measurements files
> creation.
>  - Parameterized the remove_measurements_list_files function and add NULL
>    check before freeing files' list.
>  - Removed algorithm selection based on file name during ima_measurements_show
>    and ima_ascii_measurements_show, and selecting it comparing dentry address.
>  - Allocate also sha1 file following the schema
>    {binary, ascii}_runtime_measurements_<hash_algo_name> and keep legacy
>    files as symbolic links to those files.
>  - Allocate measurements files lists even if a TPM chip is not detected,
>    adding only sha1 files.
> 
> v2:
>  - Changed the behavior of configuring at boot time the template data hash
>    algorithm.
>  - Removed template data hash algo name prefix.
>  - Removed ima_template_hash command line option.
>  - Introducing a new file in the securityfs ima subdir for each PCR banks
>    algorithm configured in the TPM.
>    (suggested by Roberto)
> 
> 
>  security/integrity/ima/ima.h        |   9 ++
>  security/integrity/ima/ima_crypto.c |   7 +-
>  security/integrity/ima/ima_fs.c     | 135 +++++++++++++++++++++++++---
>  3 files changed, 131 insertions(+), 20 deletions(-)
> 
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
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 51ad29940f05..d42ea0d350a1 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -57,11 +57,6 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum ahash buffer
> size");
>  static struct crypto_shash *ima_shash_tfm;
>  static struct crypto_ahash *ima_ahash_tfm;
>  
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
>  
> -static struct ima_algo_desc *ima_algo_array;
> +struct ima_algo_desc *ima_algo_array;
>  
>  static int __init ima_init_ima_crypto(void)
>  {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index cd1683dad3bf..475ab368e32f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -116,9 +116,13 @@ void ima_putc(struct seq_file *m, void *data, int
> datalen)
>  		seq_putc(m, *(char *)data++);
>  }
>  
> +static struct dentry **ima_ascii_measurements_files;
> +static struct dentry **ima_binary_measurements_files;

The variable naming isn't quite right.  It's defined as a 'struct dentry', but
the name is '*_files'.  Why not just name the variables 'ima_{ascii, binary}
_measurements'?

Variables that shouldn't change after '__init' should be annotated as
__ro_after_init;

> +static int ima_measurements_files_count;

Removing '_files', in this case, from the variable name could be confused with
the number of measurements.  Perhaps rename the variable to
ima_measurement_list_count or ima_securityfs_measurement_list_count.

> +
>  /* print format:
>   *       32bit-le=pcr#
> - *       char[20]=template digest
> + *       char[n]=template digest
>   *       32bit-le=template name size
>   *       char[n]=template name
>   *       [eventdata length]
> @@ -130,9 +134,26 @@ int ima_measurements_show(struct seq_file *m, void *v)
>  	struct ima_queue_entry *qe = v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> +	struct dentry *dentry;
>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>  	bool is_ima_template = false;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx = ima_sha1_idx;
> +	algo = HASH_ALGO_SHA1;
> +
> +	if (m->file != NULL) {
> +		dentry = file_dentry(m->file);
> +
> +		for (i = 0; i < ima_measurements_files_count; i++) {
> +			if (dentry == ima_binary_measurements_files[i]) {
> +				algo_idx = i;
> +				algo = ima_algo_array[i].algo;
> +				break;
> +			}
> +		}
> +	}
>  
>  	/* get entry */
>  	e = qe->entry;
> @@ -151,7 +172,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
>  
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>  
>  	/* 3rd: template name size */
>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
> @@ -220,7 +241,24 @@ static int ima_ascii_measurements_show(struct seq_file
> *m, void *v)
>  	struct ima_queue_entry *qe = v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> -	int i;
> +	struct dentry *dentry;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx = ima_sha1_idx;
> +	algo = HASH_ALGO_SHA1;
> +
> +	if (m->file != NULL) {
> +		dentry = file_dentry(m->file);
> +
> +		for (i = 0; i < ima_measurements_files_count; i++) {
> +			if (dentry == ima_ascii_measurements_files[i]) {
> +				algo_idx = i;
> +				algo = ima_algo_array[i].algo;
> +				break;
> +			}
> +		}
> +	}
>  
>  	/* get entry */
>  	e = qe->entry;
> @@ -233,8 +271,8 @@ static int ima_ascii_measurements_show(struct seq_file *m,
> void *v)
>  	/* 1st: PCR used (config option) */
>  	seq_printf(m, "%2d ", e->pcr);
>  
> -	/* 2nd: SHA1 template hash */
> -	ima_print_digest(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	/* 2nd: template hash */
> +	ima_print_digest(m, e->digests[algo_idx].digest,
> hash_digest_size[algo]);
>  
>  	/* 3th:  template name */
>  	seq_printf(m, " %s", template_name);
> @@ -379,6 +417,71 @@ static const struct seq_operations ima_policy_seqops = {
>  };
>  #endif
>  
> +static void remove_measurements_list_files(struct dentry **files)

And remove '_files' from the function name.  Perhaps rename it
remove_measurement_lists or remove_securityfs_measurement_lists.

> +{
> +	int i;
> +
> +	if (files) {
> +		for (i = 0; i < ima_measurements_files_count; i++)
> +			securityfs_remove(files[i]);
> +
> +		kfree(files);
> +	}
> +}
> +
> +static int create_measurements_list_files(void)

And remove '_files' from the function name.  Perhaps rename it to
create_measurement_lists or create_securityfs_measurement_lists.

> +{
> +	int i;
> +	u16 algo;
> +	char file_name[NAME_MAX+1];
> +	struct dentry *dfile;

Use 'dentry', if needed.

> +	enum hash_algo sha1_algo_idx = -1;
> +
> +	ima_measurements_files_count = NR_BANKS(ima_tpm_chip);
> +
> +	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
> +		ima_measurements_files_count++;
> +
> +	ima_ascii_measurements_files = kcalloc(ima_measurements_files_count,
> +						sizeof(struct dentry *),
> GFP_KERNEL);
> +	if (!ima_ascii_measurements_files)
> +		return -ENOMEM;
> +
> +	ima_binary_measurements_files = kcalloc(ima_measurements_files_count,
> +						sizeof(struct dentry *),
> GFP_KERNEL);
> +	if (!ima_binary_measurements_files)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ima_measurements_files_count; i++) {
> +		algo = ima_algo_array[i].algo;
> +
> +		if (algo == HASH_ALGO_SHA1)
> +			sha1_algo_idx = i;
> +
> +		sprintf(file_name, "ascii_runtime_measurements_%s",
> +					hash_algo_name[algo]);
> +		dfile = securityfs_create_file(file_name,
> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
> +					&ima_ascii_measurements_ops);
> +		if (IS_ERR(dfile))
> +			return PTR_ERR(dfile);
> +
> +		ima_ascii_measurements_files[i] = dfile;
> +
> +		sprintf(file_name, "binary_runtime_measurements_%s",
> +					hash_algo_name[algo]);
> +		dfile = securityfs_create_file(file_name,
> +					S_IRUSR | S_IRGRP, ima_dir, NULL,
> +					&ima_measurements_ops);
> +		if (IS_ERR(dfile))
> +			return PTR_ERR(dfile);
> +
> +		ima_binary_measurements_files[i] = dfile;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * ima_open_policy: sequentialize access to the policy file
>   */
> @@ -465,19 +568,21 @@ int __init ima_fs_init(void)

The new functions should be annotated with '__init'  as well.

>  		goto out;
>  	}
>  
> -	binary_runtime_measurements =
> -	    securityfs_create_file("binary_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_measurements_ops);
> +	ret = create_measurements_list_files();
> +	if (ret != 0)
> +		goto out;
> +
> +	binary_runtime_measurements = securityfs_create_symlink(
> +		"binary_runtime_measurements", ima_dir,
> +		"binary_runtime_measurements_sha1", NULL);

Please use scripts/checkpatch.pl to check formatting.

>  	if (IS_ERR(binary_runtime_measurements)) {
>  		ret = PTR_ERR(binary_runtime_measurements);
>  		goto out;
>  	}
>  
> -	ascii_runtime_measurements =
> -	    securityfs_create_file("ascii_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_ascii_measurements_ops);
> +	ascii_runtime_measurements = securityfs_create_symlink(

And here ...

thanks,

Mimi

> +		"ascii_runtime_measurements", ima_dir,
> +		"ascii_runtime_measurements_sha1", NULL);
>  	if (IS_ERR(ascii_runtime_measurements)) {
>  		ret = PTR_ERR(ascii_runtime_measurements);
>  		goto out;
> @@ -515,6 +620,8 @@ int __init ima_fs_init(void)
>  	securityfs_remove(runtime_measurements_count);
>  	securityfs_remove(ascii_runtime_measurements);
>  	securityfs_remove(binary_runtime_measurements);
> +	remove_measurements_list_files(ima_ascii_measurements_files);
> +	remove_measurements_list_files(ima_binary_measurements_files);
>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
> 
> base-commit: 88035e5694a86a7167d490bb95e9df97a9bb162b 


