Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A381D5758
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Oct 2019 20:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfJMSel (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Oct 2019 14:34:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39076 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfJMSei (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Oct 2019 14:34:38 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9DIWBpj040064;
        Sun, 13 Oct 2019 14:34:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vkut6etkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 14:34:36 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x9DIYa3v043282;
        Sun, 13 Oct 2019 14:34:36 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vkut6etk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 14:34:35 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9DIPIv5016665;
        Sun, 13 Oct 2019 18:34:35 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 2vk6f87gr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Oct 2019 18:34:35 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9DIYYLW54526218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 18:34:34 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 298B6AC059;
        Sun, 13 Oct 2019 18:34:34 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01EB0AC05F;
        Sun, 13 Oct 2019 18:34:32 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.201.65])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 13 Oct 2019 18:34:32 +0000 (GMT)
Subject: Re: [PATCH v0 1/2] KEYS: Measure keys added to builtin or secondary
 trusted keys keyring
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
 <20191011173547.3200-2-nramas@linux.microsoft.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <9f015e69-ba6c-8631-d3b4-e60501dd97d8@linux.vnet.ibm.com>
Date:   Sun, 13 Oct 2019 14:34:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191011173547.3200-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910130185
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,


On 10/11/2019 01:35 PM, Lakshmi Ramasubramanian wrote:
> IMA hook TRUSTED_KEYS to measure keys added to builtin or secondary
> trusted keys keyring. This can be enabled through IMA policy.
>
> The key data is queued up if IMA is not yet initialized and measured
> when IMA is initialized. If IMA is initialized then the key is
> measured immediately.
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>   Documentation/ABI/testing/ima_policy |   1 +
>   include/linux/ima.h                  |  10 ++
>   security/integrity/ima/ima.h         |  14 ++
>   security/integrity/ima/ima_api.c     |   2 +-
>   security/integrity/ima/ima_init.c    |  11 +-
>   security/integrity/ima/ima_main.c    | 230 ++++++++++++++++++++++-----
>   security/integrity/ima/ima_policy.c  |   4 +-
>   7 files changed, 226 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
> index fc376a323908..cc25c0f41d6e 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -29,6 +29,7 @@ Description:
>   				[FIRMWARE_CHECK]
>   				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
>   				[KEXEC_CMDLINE]
> +				[TRUSTED_KEYS]
>   			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
>   			       [[^]MAY_EXEC]
>   			fsmagic:= hex value
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index a20ad398d260..eb95743ada7d 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -25,6 +25,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   extern void ima_post_path_mknod(struct dentry *dentry);
>   extern void ima_kexec_cmdline(const void *buf, int size);
>
> +extern int ima_post_key_create_or_update(struct key *keyring,
> +					 struct key *key,
> +					 bool builtin_or_secondary);
>   #ifdef CONFIG_IMA_KEXEC
>   extern void ima_add_kexec_buffer(struct kimage *image);
>   #endif
> @@ -91,6 +94,13 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>   }
>
>   static inline void ima_kexec_cmdline(const void *buf, int size) {}
> +
> +static inline int ima_post_key_create_or_update(struct key *keyring,
> +						struct key *key,
> +						bool builtin_or_secondary)
> +{
> +	return 0;
> +}
>   #endif /* CONFIG_IMA */
>
>   #ifndef CONFIG_IMA_KEXEC
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 011b91c79351..f0c1801da890 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -21,6 +21,7 @@
>   #include <linux/tpm.h>
>   #include <linux/audit.h>
>   #include <crypto/hash_info.h>
> +#include <keys/asymmetric-type.h>
>
>   #include "../integrity.h"
>
> @@ -52,6 +53,7 @@ extern int ima_policy_flag;
>   extern int ima_hash_algo;
>   extern int ima_appraise;
>   extern struct tpm_chip *ima_tpm_chip;
> +extern bool ima_initialized;
>
>   /* IMA event related data */
>   struct ima_event_data {
> @@ -104,6 +106,16 @@ struct ima_queue_entry {
>   };
>   extern struct list_head ima_measurements;	/* list of all measurements */
>
> +/*
> + * To track trusted keys that need to be measured when IMA is initialized.
> + */
> +struct ima_trusted_key_entry {
> +	struct list_head list;
> +	void *public_key;
> +	u32  public_key_len;
> +	char *key_description;
> +};
> +
>   /* Some details preceding the binary serialized measurement list */
>   struct ima_kexec_hdr {
>   	u16 version;
> @@ -158,6 +170,7 @@ void ima_init_template_list(void);
>   int __init ima_init_digests(void);
>   int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
>   			  void *lsm_data);
> +void ima_measure_queued_trusted_keys(void);
>
>   /*
>    * used to protect h_table and sha_table
> @@ -189,6 +202,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
>   	hook(KEXEC_INITRAMFS_CHECK)	\
>   	hook(POLICY_CHECK)		\
>   	hook(KEXEC_CMDLINE)		\
> +	hook(TRUSTED_KEYS)		\
>   	hook(MAX_CHECK)
>   #define __ima_hook_enumify(ENUM)	ENUM,
>
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index f614e22bf39f..704a048ff925 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -174,7 +174,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>    *		subj=, obj=, type=, func=, mask=, fsmagic=
>    *	subj,obj, and type: are LSM specific.
>    *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
> - *	| KEXEC_CMDLINE
> + *	| KEXEC_CMDLINE | TRUSTED_KEYS
>    *	mask: contains the permission mask
>    *	fsmagic: hex value
>    *
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 5d55ade5f3b9..32b9147fe410 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -23,6 +23,7 @@
>   /* name for boot aggregate entry */
>   static const char boot_aggregate_name[] = "boot_aggregate";
>   struct tpm_chip *ima_tpm_chip;
> +bool ima_initialized;
>
>   /* Add the boot aggregate to the IMA measurement list and extend
>    * the PCR register.
> @@ -131,5 +132,13 @@ int __init ima_init(void)
>
>   	ima_init_policy();
>
> -	return ima_fs_init();
> +	rc = ima_fs_init();
> +	if (rc != 0)
> +		return rc;
> +
> +	ima_initialized = true;
> +
> +	ima_measure_queued_trusted_keys();
> +
> +	return 0;
>   }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 584019728660..b0ee5c82207a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -27,6 +27,7 @@
>   #include <linux/ima.h>
>   #include <linux/iversion.h>
>   #include <linux/fs.h>
> +#include <crypto/public_key.h>
>
>   #include "ima.h"
>
> @@ -43,6 +44,13 @@ static struct notifier_block ima_lsm_policy_notifier = {
>   	.notifier_call = ima_lsm_policy_change,
>   };
>
> +/*
> + * Used to synchronize access to the list of trusted keys (ima_trusted_keys)
> + * that need to be measured when IMA is initialized.
> + */
> +static DEFINE_MUTEX(ima_trusted_keys_mutex);
> +static LIST_HEAD(ima_trusted_keys);
> +
>   static int __init hash_setup(char *str)
>   {
>   	struct ima_template_desc *template_desc = ima_template_desc_current();
> @@ -351,6 +359,65 @@ static int process_measurement(struct file *file, const struct cred *cred,
>   	return 0;
>   }
>
> +
> +/*
> + * process_buffer_measurement - Measure the buffer to ima log.
> + * @buf: pointer to the buffer that needs to be added to the log.
> + * @size: size of buffer(in bytes).
> + * @eventname: event name to be used for the buffer entry.
> + * @func: IMA Hook function
> + * @cred: a pointer to a credentials structure for user validation.
> + * @secid: the secid of the task to be validated.
> + *
> + * Based on policy, the buffer is measured into the ima log.
> + */
> +static void process_buffer_measurement(const void *buf, u32 size,
> +				       const char *eventname,
> +				       enum ima_hooks func,
> +				       const struct cred *cred, u32 secid)
> +{
> +	int ret = 0;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache iint = {};
> +	struct ima_event_data event_data = {.iint = &iint,
> +					    .filename = eventname,
> +					    .buf = buf,
> +					    .buf_len = size};
> +	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash = {};
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	int action = 0;
> +
> +	action = ima_get_action(NULL, cred, secid, 0, func, &pcr,
> +				&template_desc);
> +	if (!(action & IMA_MEASURE))
> +		return;
> +
> +	iint.ima_hash = &hash.hdr;
> +	iint.ima_hash->algo = ima_hash_algo;
> +	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ima_store_template(entry, violation, NULL, buf, pcr);
> +
> +	if (ret < 0)
> +		ima_free_template_entry(entry);
> +
> +out:
> +	return;
> +}
> +

I am wondering that even though there is just one argument change in the 
process_buffer_measurement() function, a full new function is defined. 
This makes reviewing the function more difficult than it should be. Can 
you please check on how the patch is getting formatted ?

Moreover, I am already modifying this function as part of the blacklist 
patchset, but in a different way. Please refer to the Patch [5/8] in the 
patchset titled "powerpc: Enabling IMA arch specific secure boot 
policies". It was posted on 8th October.

I will modify the process_buffer_measurement() function in a way that 
can work for both of our requirements and will post a new version soon.

Thanks & Regards,
      - Nayna


