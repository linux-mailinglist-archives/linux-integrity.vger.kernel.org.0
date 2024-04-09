Return-Path: <linux-integrity+bounces-2033-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C0E89D95C
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Apr 2024 14:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A691C21F5C
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Apr 2024 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC2127B5A;
	Tue,  9 Apr 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cdpOBmID"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A912F39E
	for <linux-integrity@vger.kernel.org>; Tue,  9 Apr 2024 12:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666658; cv=none; b=Z6oLaRyPLWZzd/lQw97T2+hFvTdXlgtx2rBNyP2FoFsJB2Wu04ERdyuVnXE5MQ5omX/YDGxL7UYjY4p9roemr5K+t07WnSqYqnCPcCYxEnCVS0J8T9+oOMhzaHCgsSbFoyq4O1Q1gYy7/gKVIFV7g7LfSdvBCUAd8pi9aDJXZi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666658; c=relaxed/simple;
	bh=LknBjnTBh8437TgPnoA7mhEbcjC3YzUWOdi69NRGXps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=S8yPQRRqSodudFeSlp3Qm0mAdsuq5dYaTdkA4kd9FgJr/iGq0rm3Pmo1QPM9zVNguGIptJpdElraoKzN/WBxEGZq5QLQWHG7M8f041IFSYWlQPPs/+rxomOpjmqiAD/l14Pu9PPkBRMl1dbfbG7ij33RjgHRxQdClkbIR4DzCLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cdpOBmID; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439BLblC025261;
	Tue, 9 Apr 2024 12:43:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TlpddKh6DDe1WebG227ewNiMK6FuFwqvneR92fhcFDE=;
 b=cdpOBmIDJUmUfFoWFUrUDl/SfhYpDvxPLZ85mT9fanvhjffL7OgSGq8KvxloJ/mapOCR
 9xp2ioMSxHNma0EoG3zrkTzxInEm8euwCq42cwX570/NZJ7z8fJ0zwi0zc0Q4Kza24iu
 9DZUqRyTpxLU2e2psAKBVWRujI8FMQCxQlihqXG8DB/HJT1GA5jWmPBgQyeYgIj1c+LX
 VeKYsqpbZoSjoh2lCfish8GsuomrRoUNG3xwb7v3IpNiRmAdBOY9FY3syxzaDHDseM7d
 8+TI0ooVfdeaDNbMg5YhydcvgqkmLm+qa+QrjTc6lOFx2Mz9JEJnQpDqrkb7v3zt4JxW Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd2pxgcaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 12:43:59 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439ChwNM015135;
	Tue, 9 Apr 2024 12:43:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd2pxgcap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 12:43:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 439BVEh7019092;
	Tue, 9 Apr 2024 12:43:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbh406cya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 12:43:58 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 439ChtJ345416862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 12:43:57 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5260458052;
	Tue,  9 Apr 2024 12:43:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC1EB5806A;
	Tue,  9 Apr 2024 12:43:54 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.39.161])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 12:43:54 +0000 (GMT)
Message-ID: <74f8f5fa75629c41455f28544ab8c430ebd9006a.camel@linux.ibm.com>
Subject: Re: [PATCH v6] ima: add crypto agility support for template-hash
 algorithm
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
Cc: roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date: Tue, 09 Apr 2024 08:43:54 -0400
In-Reply-To: <20240408212810.1043272-1-enrico.bravi@polito.it>
References: <20240408212810.1043272-1-enrico.bravi@polito.it>
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
X-Proofpoint-GUID: EWCSCQgcuYOwNFCDGMPrDsiMlGLKNWhr
X-Proofpoint-ORIG-GUID: 1n34RGLN3Lu2AyVyAaAzNumDh30Dr8vm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404090082

Hi Enrico,

On Mon, 2024-04-08 at 23:28 +0200, Enrico Bravi wrote:
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
> the sha1 bank is not configured in the TPM.
> 
> As example, in the case a TPM chip is present and sha256 is the only
> configured PCR bank, the listing of the securityfs ima directory is the
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
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Much better. Just a few comments inline.

> 
> ---
> 
> v6:
>  - Fixed format error when applying the patch.
> 
> v5:
>  - Added lookup_algo_by_dentry() function to select the hash algo during
>    measurements dump. (suggested by Roberto)
>  - Renamed remove_measurements_list_files() to
>    remove_securityfs_measurement_lists() and create_measurements_list_files()
>    to create_securityfs_measurement_lists(), and marked both as __init.
>    (suggested by Mimi)
>  - Renamed ima_ascii_measurements_files to ascii_securityfs_measurement_lists,
>    ima_binary_measurements_files to binary_securityfs_measurement_lists and
>    ima_measurements_files_count to securityfs_measurement_list_count, and
>    marked them as __ro_after_init. (suggested by Mimi)
>  - Added missing NULL assignment for file.file in ima_dump_measurement_list()
>    during kexec.
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
>  security/integrity/ima/ima.h        |  10 +++
>  security/integrity/ima/ima_crypto.c |   7 +-
>  security/integrity/ima/ima_fs.c     | 131 +++++++++++++++++++++++++---
>  security/integrity/ima/ima_kexec.c  |   1 +
>  4 files changed, 131 insertions(+), 18 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 11d7c0332207..72ac73ebc83e 100644
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
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index f3738b2c8bcd..3606931fc525 100644
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

ima_algo_array should probably be defined as __ro_after_init, especially now
that the scope is changing.

>  
>  static int __init ima_init_ima_crypto(void)
>  {
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index cd1683dad3bf..7d9c2ef5b86c 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -116,9 +116,30 @@ void ima_putc(struct seq_file *m, void *data, int
> datalen)
>  		seq_putc(m, *(char *)data++);
>  }
>  
> +static struct dentry **ascii_securityfs_measurement_lists __ro_after_init;
> +static struct dentry **binary_securityfs_measurement_lists __ro_after_init;
> +static int securityfs_measurement_list_count __ro_after_init;
> +
> +static void lookup_algo_by_dentry(int *algo_idx, enum hash_algo *algo,
> +				  struct seq_file *m, struct dentry
> **dentry_list)

Please rename the function without "_by_dentry". Consider naming the function
lookup_measurement_list_algo().  Instead of dentry_list, consider naming the
variable measurement_lists or just lists.

> +{
> +	struct dentry *dentry;
> +	int i;
> +
> +	dentry = file_dentry(m->file);
> +
> +	for (i = 0; i < securityfs_measurement_list_count; i++) {
> +		if (dentry == dentry_list[i]) {
> +			*algo_idx = i;
> +			*algo = ima_algo_array[i].algo;
> +			break;
> +		}
> +	}
> +}
> +
>  /* print format:
>   *       32bit-le=pcr#
> - *       char[20]=template digest
> + *       char[n]=template digest
>   *       32bit-le=template name size
>   *       char[n]=template name
>   *       [eventdata length]
> @@ -132,7 +153,15 @@ int ima_measurements_show(struct seq_file *m, void *v)
>  	char *template_name;
>  	u32 pcr, namelen, template_data_len; /* temporary fields */
>  	bool is_ima_template = false;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;
> +
> +	algo_idx = ima_sha1_idx;
> +	algo = HASH_ALGO_SHA1;
> +
> +	if (m->file != NULL)
> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
> +				      binary_securityfs_measurement_lists);
>  
>  	/* get entry */
>  	e = qe->entry;
> @@ -151,7 +180,7 @@ int ima_measurements_show(struct seq_file *m, void *v)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
>  
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[algo_idx].digest, hash_digest_size[algo]);
>  
>  	/* 3rd: template name size */
>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
> @@ -220,7 +249,15 @@ static int ima_ascii_measurements_show(struct seq_file
> *m, void *v)
>  	struct ima_queue_entry *qe = v;
>  	struct ima_template_entry *e;
>  	char *template_name;
> -	int i;
> +	int i, algo_idx;
> +	enum hash_algo algo;

The preferred variable definition ordering is reverse fir tree.  Reverse the two
lines.

> +	algo_idx = ima_sha1_idx;
> +	algo = HASH_ALGO_SHA1;
> +
> +	if (m->file != NULL)
> +		lookup_algo_by_dentry(&algo_idx, &algo, m,
> +				      ascii_securityfs_measurement_lists);
>  
>  	/* get entry */
>  	e = qe->entry;
> @@ -233,8 +270,8 @@ static int ima_ascii_measurements_show(struct seq_file *m,
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
> @@ -379,6 +416,69 @@ static const struct seq_operations ima_policy_seqops = {
>  };
>  #endif
>  
> +static void __init remove_securityfs_measurement_lists(struct dentry
> **dentry_list)
> +{
> +	int i;
> +
> +	if (dentry_list) {
> +		for (i = 0; i < securityfs_measurement_list_count; i++)
> +			securityfs_remove(dentry_list[i]);
> +
> +		kfree(dentry_list);
> +	}
> +
> +	securityfs_measurement_list_count = 0;
> +}
> +
> +static int __init create_securityfs_measurement_lists(void)
> +{
> +	int i;
> +	u16 algo;
> +	char file_name[NAME_MAX + 1];
> +	struct dentry *dentry;
> +
> +	securityfs_measurement_list_count = NR_BANKS(ima_tpm_chip);
> +
> +	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
> +		securityfs_measurement_list_count++;
> +
> +	ascii_securityfs_measurement_lists =
> kcalloc(securityfs_measurement_list_count,
> +						     sizeof(struct dentry *),
> GFP_KERNEL);

Although lines > 80 characters are permitted, it isn't needed here.  Like the
original ascii_runtime_measurements initialization, split the line after the
ascii_securityfs_measurement_lists variable name.

> +	if (!ascii_securityfs_measurement_lists)
> +		return -ENOMEM;
> +
> +	binary_securityfs_measurement_lists =
> kcalloc(securityfs_measurement_list_count,
> +						      sizeof(struct dentry *),
> GFP_KERNEL);

Same here.


> +	if (!binary_securityfs_measurement_lists)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < securityfs_measurement_list_count; i++) {
> +		algo = ima_algo_array[i].algo;
> +
> +		sprintf(file_name, "ascii_runtime_measurements_%s",
> +			hash_algo_name[algo]);
> +		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +						ima_dir, NULL,
> +						&ima_ascii_measurements_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
> +
> +		ascii_securityfs_measurement_lists[i] = dentry;
> +
> +		sprintf(file_name, "binary_runtime_measurements_%s",
> +			hash_algo_name[algo]);
> +		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
> +						ima_dir, NULL,
> +						&ima_measurements_ops);
> +		if (IS_ERR(dentry))
> +			return PTR_ERR(dentry);
> +
> +		binary_securityfs_measurement_lists[i] = dentry;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * ima_open_policy: sequentialize access to the policy file
>   */
> @@ -454,6 +554,9 @@ int __init ima_fs_init(void)
>  {
>  	int ret;
>  
> +	ascii_securityfs_measurement_lists = NULL;
> +	binary_securityfs_measurement_lists = NULL;
> +
>  	ima_dir = securityfs_create_dir("ima", integrity_dir);
>  	if (IS_ERR(ima_dir))
>  		return PTR_ERR(ima_dir);
> @@ -465,19 +568,21 @@ int __init ima_fs_init(void)
>  		goto out;
>  	}
>  
> +	ret = create_securityfs_measurement_lists();
> +	if (ret != 0)
> +		goto out;
> +
>  	binary_runtime_measurements =
> -	    securityfs_create_file("binary_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_measurements_ops);
> +		securityfs_create_symlink("binary_runtime_measurements",
> ima_dir,
> +					  "binary_runtime_measurements_sha1",
> NULL);

> 80 characters here and in a few other places.

thanks,

Mimi

>  	if (IS_ERR(binary_runtime_measurements)) {
>  		ret = PTR_ERR(binary_runtime_measurements);
>  		goto out;
>  	}
>  
>  	ascii_runtime_measurements =
> -	    securityfs_create_file("ascii_runtime_measurements",
> -				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> -				   &ima_ascii_measurements_ops);
> +		securityfs_create_symlink("ascii_runtime_measurements", ima_dir,
> +					  "ascii_runtime_measurements_sha1",
> NULL);
>  	if (IS_ERR(ascii_runtime_measurements)) {
>  		ret = PTR_ERR(ascii_runtime_measurements);
>  		goto out;
> @@ -515,6 +620,8 @@ int __init ima_fs_init(void)
>  	securityfs_remove(runtime_measurements_count);
>  	securityfs_remove(ascii_runtime_measurements);
>  	securityfs_remove(binary_runtime_measurements);
> +	remove_securityfs_measurement_lists(ascii_securityfs_measurement_lists);
> +	remove_securityfs_measurement_lists(binary_securityfs_measurement_lists)
> ;
>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
>  
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index dadc1d138118..52e00332defe 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -30,6 +30,7 @@ static int ima_dump_measurement_list(unsigned long
> *buffer_size, void **buffer,
>  		goto out;
>  	}
>  
> +	file.file = NULL;
>  	file.size = segment_size;
>  	file.read_pos = 0;
>  	file.count = sizeof(khdr);	/* reserved space */
> 
> base-commit: 38aa3f5ac6d2de6b471ecb6e1cd878957ae7e8de


