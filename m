Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F241C153561
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2020 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBEQjb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Feb 2020 11:39:31 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2381 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbgBEQjb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Feb 2020 11:39:31 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 84D2DB3D3C420410F7A4;
        Wed,  5 Feb 2020 16:39:28 +0000 (GMT)
Received: from fraeml705-chm.china.huawei.com (10.206.15.54) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Feb 2020 16:39:28 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 5 Feb 2020 17:39:27 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Wed, 5 Feb 2020 17:39:27 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
 template digests
Thread-Topic: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
 template digests
Thread-Index: AQHV3A/+rAKtbF80BkqxEfHd/18hO6gMzSIw
Date:   Wed, 5 Feb 2020 16:39:27 +0000
Message-ID: <bb9aa70e33e6449dacb1732342420297@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
 <20200205103317.29356-6-roberto.sassu@huawei.com>
In-Reply-To: <20200205103317.29356-6-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Roberto Sassu
> Sent: Wednesday, February 5, 2020 11:33 AM
> To: zohar@linux.ibm.com; James.Bottomley@HansenPartnership.com;
> jarkko.sakkinen@linux.intel.com
> Cc: linux-integrity@vger.kernel.org; linux-security-module@vger.kernel.org;
> linux-kernel@vger.kernel.org; Silviu Vlasceanu
> <Silviu.Vlasceanu@huawei.com>; Roberto Sassu
> <roberto.sassu@huawei.com>
> Subject: [PATCH v2 5/8] ima: Switch to dynamically allocated buffer for
> template digests
> 
> This patch dynamically allocates the array of tpm_digest structures in
> ima_alloc_init_template() and ima_restore_template_data(). The size of
> the
> array, stored in ima_num_template_digests, is initially equal to 1 (SHA1)
> and will be determined in the upcoming patches depending on the allocated
> PCR banks and the chosen default IMA algorithm.
> 
> Calculating the SHA1 digest is mandatory, as SHA1 still remains the default
> hash algorithm for the measurement list. When IMA will support the Crypto
> Agile format, remaining digests will be also provided.
> 
> The position in the array of the SHA1 digest is stored in the ima_sha1_idx
> global variable and it is determined at IMA initialization time.
> 
> Changelog
> 
> v1:
> - move ima_sha1_idx to ima_crypto.c
> - introduce ima_num_template_digests (suggested by Mimi)
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h          |  4 +++-
>  security/integrity/ima/ima_api.c      |  8 ++++++++
>  security/integrity/ima/ima_crypto.c   |  6 +++++-
>  security/integrity/ima/ima_fs.c       |  4 ++--
>  security/integrity/ima/ima_queue.c    | 10 ++++++----
>  security/integrity/ima/ima_template.c | 12 ++++++++++--
>  6 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2f380fb92a7a..4843077dc9e8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -50,6 +50,8 @@ extern int ima_policy_flag;
> 
>  /* set during initialization */
>  extern int ima_hash_algo;
> +extern int ima_sha1_idx;
> +extern int ima_num_template_digests;
>  extern int ima_appraise;
>  extern struct tpm_chip *ima_tpm_chip;
> 
> @@ -92,7 +94,7 @@ struct ima_template_desc {
> 
>  struct ima_template_entry {
>  	int pcr;
> -	u8 digest[TPM_DIGEST_SIZE];	/* sha1 or md5 measurement hash
> */
> +	struct tpm_digest *digests;
>  	struct ima_template_desc *template_desc; /* template descriptor
> */
>  	u32 template_data_len;
>  	struct ima_field_data template_data[0];	/* template related
> data */
> diff --git a/security/integrity/ima/ima_api.c
> b/security/integrity/ima/ima_api.c
> index 51f562111864..2ced5975c16f 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -27,6 +27,7 @@ void ima_free_template_entry(struct
> ima_template_entry *entry)
>  	for (i = 0; i < entry->template_desc->num_fields; i++)
>  		kfree(entry->template_data[i].data);
> 
> +	kfree(entry->digests);
>  	kfree(entry);
>  }
> 
> @@ -50,6 +51,13 @@ int ima_alloc_init_template(struct ima_event_data
> *event_data,
>  	if (!*entry)
>  		return -ENOMEM;
> 
> +	(*entry)->digests = kcalloc(ima_num_template_digests,
> +				    sizeof(*(*entry)->digests), GFP_NOFS);
> +	if (!(*entry)->digests) {
> +		result = -ENOMEM;
> +		goto out;
> +	}
> +
>  	(*entry)->template_desc = template_desc;
>  	for (i = 0; i < template_desc->num_fields; i++) {
>  		const struct ima_template_field *field =
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 2d356ae8e823..31f2497a3ab8 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -59,6 +59,9 @@ MODULE_PARM_DESC(ahash_bufsize, "Maximum
> ahash buffer size");
>  static struct crypto_shash *ima_shash_tfm;
>  static struct crypto_ahash *ima_ahash_tfm;
> 
> +int ima_sha1_idx;
> +int ima_num_template_digests = 1;

I forgot to add __ro_after_init.

Will do in the next version.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

>  int __init ima_init_crypto(void)
>  {
>  	long rc;
> @@ -502,7 +505,8 @@ static int ima_calc_field_array_hash_tfm(struct
> ima_field_data *field_data,
>  	}
> 
>  	if (!rc)
> -		rc = crypto_shash_final(shash, entry->digest);
> +		rc = crypto_shash_final(shash,
> +					entry-
> >digests[ima_sha1_idx].digest);
> 
>  	return rc;
>  }
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 2000e8df0301..2b79581d0e25 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -152,7 +152,7 @@ int ima_measurements_show(struct seq_file *m,
> void *v)
>  	ima_putc(m, &pcr, sizeof(e->pcr));
> 
>  	/* 2nd: template digest */
> -	ima_putc(m, e->digest, TPM_DIGEST_SIZE);
> +	ima_putc(m, e->digests[ima_sha1_idx].digest, TPM_DIGEST_SIZE);
> 
>  	/* 3rd: template name size */
>  	namelen = !ima_canonical_fmt ? strlen(template_name) :
> @@ -235,7 +235,7 @@ static int ima_ascii_measurements_show(struct
> seq_file *m, void *v)
>  	seq_printf(m, "%2d ", e->pcr);
> 
>  	/* 2nd: SHA1 template hash */
> -	ima_print_digest(m, e->digest, TPM_DIGEST_SIZE);
> +	ima_print_digest(m, e->digests[ima_sha1_idx].digest,
> TPM_DIGEST_SIZE);
> 
>  	/* 3th:  template name */
>  	seq_printf(m, " %s", template_name);
> diff --git a/security/integrity/ima/ima_queue.c
> b/security/integrity/ima/ima_queue.c
> index 1ce8b1701566..bcd99db9722c 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -57,7 +57,8 @@ static struct ima_queue_entry
> *ima_lookup_digest_entry(u8 *digest_value,
>  	key = ima_hash_key(digest_value);
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(qe, &ima_htable.queue[key], hnext) {
> -		rc = memcmp(qe->entry->digest, digest_value,
> TPM_DIGEST_SIZE);
> +		rc = memcmp(qe->entry->digests[ima_sha1_idx].digest,
> +			    digest_value, TPM_DIGEST_SIZE);
>  		if ((rc == 0) && (qe->entry->pcr == pcr)) {
>  			ret = qe;
>  			break;
> @@ -77,7 +78,7 @@ static int get_binary_runtime_size(struct
> ima_template_entry *entry)
>  	int size = 0;
> 
>  	size += sizeof(u32);	/* pcr */
> -	size += sizeof(entry->digest);
> +	size += TPM_DIGEST_SIZE;
>  	size += sizeof(int);	/* template name size field */
>  	size += strlen(entry->template_desc->name);
>  	size += sizeof(entry->template_data_len);
> @@ -109,7 +110,7 @@ static int ima_add_digest_entry(struct
> ima_template_entry *entry,
> 
>  	atomic_long_inc(&ima_htable.len);
>  	if (update_htable) {
> -		key = ima_hash_key(entry->digest);
> +		key = ima_hash_key(entry->digests[ima_sha1_idx].digest);
>  		hlist_add_head_rcu(&qe->hnext,
> &ima_htable.queue[key]);
>  	}
> 
> @@ -173,7 +174,8 @@ int ima_add_template_entry(struct
> ima_template_entry *entry, int violation,
> 
>  	mutex_lock(&ima_extend_list_mutex);
>  	if (!violation) {
> -		memcpy(digest, entry->digest, sizeof(digest));
> +		memcpy(digest, entry->digests[ima_sha1_idx].digest,
> +		       sizeof(digest));
>  		if (ima_lookup_digest_entry(digest, entry->pcr)) {
>  			audit_cause = "hash_exists";
>  			result = -EEXIST;
> diff --git a/security/integrity/ima/ima_template.c
> b/security/integrity/ima/ima_template.c
> index 6aa6408603e3..751f101ae927 100644
> --- a/security/integrity/ima/ima_template.c
> +++ b/security/integrity/ima/ima_template.c
> @@ -311,11 +311,19 @@ static int ima_restore_template_data(struct
> ima_template_desc *template_desc,
>  	if (!*entry)
>  		return -ENOMEM;
> 
> +	(*entry)->digests = kcalloc(ima_num_template_digests,
> +				    sizeof(*(*entry)->digests), GFP_NOFS);
> +	if (!(*entry)->digests) {
> +		kfree(*entry);
> +		return -ENOMEM;
> +	}
> +
>  	ret = ima_parse_buf(template_data, template_data +
> template_data_size,
>  			    NULL, template_desc->num_fields,
>  			    (*entry)->template_data, NULL, NULL,
>  			    ENFORCE_FIELDS | ENFORCE_BUFEND, "template
> data");
>  	if (ret < 0) {
> +		kfree((*entry)->digests);
>  		kfree(*entry);
>  		return ret;
>  	}
> @@ -447,8 +455,8 @@ int ima_restore_measurement_list(loff_t size, void
> *buf)
>  		if (ret < 0)
>  			break;
> 
> -		memcpy(entry->digest, hdr[HDR_DIGEST].data,
> -		       hdr[HDR_DIGEST].len);
> +		memcpy(entry->digests[ima_sha1_idx].digest,
> +		       hdr[HDR_DIGEST].data, hdr[HDR_DIGEST].len);
>  		entry->pcr = !ima_canonical_fmt ? *(hdr[HDR_PCR].data) :
>  			     le32_to_cpu(*(hdr[HDR_PCR].data));
>  		ret = ima_restore_measurement_entry(entry);
> --
> 2.17.1

