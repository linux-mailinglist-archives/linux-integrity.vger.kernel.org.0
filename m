Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68365228C95
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgGUXQl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 19:16:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39025 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726148AbgGUXQl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 19:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595373399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URZ74O3o/GaJTr8ONqu5MzMSgY0nPijplZEmXWfIv5k=;
        b=Gt2L51k+pH5pybXcn+nXDqsxC32G331aRilB7IU7GRkcIR5CHnWgpCF8zIaIgeCq4/TyEk
        fyyyNmCGtG6h3JaATfqnn+ATWbFZYE2giFirDeXdgrnxLCIuKoh6XtZzJ9Ii07pCT7v6Ay
        4C6dGH8koLfQWA61qAZC/vmpItYsan4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-RtILhlGhOR6rfrGlD2Lr8Q-1; Tue, 21 Jul 2020 19:16:34 -0400
X-MC-Unique: RtILhlGhOR6rfrGlD2Lr8Q-1
Received: by mail-qk1-f199.google.com with SMTP id 1so145219qkm.19
        for <linux-integrity@vger.kernel.org>; Tue, 21 Jul 2020 16:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=URZ74O3o/GaJTr8ONqu5MzMSgY0nPijplZEmXWfIv5k=;
        b=n4p+G2mt4OkMowaLyonN8ufKCTY7ug2L7gPMA29YNgFgsX2r1CQx/jHuNYHR8mrt2m
         hR58C78rVNau6DObcFyzGx9zHWPg8l2xKEGWawT3Hwmmp4MRco22VjMCZy99tjdZhB2h
         kusxOAPb4otntPDuZ9ow2O7k0MU6oTmH+oX+FxgnE0S1hDpKlbJ15cEklFKYMsFX5loV
         SltYBNaZTepjMypEQ5Qz1XeaQ8NFCbAzi2iIAcetYR+/qcWX6FR8HzMpO6tbYdUC9v6y
         eBKKR4eBd6rcVjNJvdVINZbaHrNPbU0H9r25DfnAxE2UeIof0/gURxTXHu5De1IJtbTD
         2o8g==
X-Gm-Message-State: AOAM531gl7kl7sLW06YQlrri+EZgfOkiwI5YLhp3OeT1ItGcVhNdypcW
        Xngqynmc3qzkV31DQcEYEDTWCH//wA8Jj0v7uCWaU/zDIBd61+WeTMV5WYj6iVWPda+Pr/LpRLe
        FAEji7dHfQdUR7js9RkOA13UefuHU
X-Received: by 2002:ac8:2f67:: with SMTP id k36mr31198850qta.345.1595373393868;
        Tue, 21 Jul 2020 16:16:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywB50mdS3PWVgENzPp0A4K3I6YRlWOluA1Hjr9Ly7j/sZV9rAMmWyoDIYzq7P2hQkaf4/o9Q==
X-Received: by 2002:ac8:2f67:: with SMTP id k36mr31198816qta.345.1595373393531;
        Tue, 21 Jul 2020 16:16:33 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l66sm219698qkc.42.2020.07.21.16.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 16:16:32 -0700 (PDT)
References: <20200721155615.12625-1-James.Bottomley@HansenPartnership.com> <20200721155615.12625-2-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v2 1/1] tpm: add sysfs exports for all banks of PCR registers
In-reply-to: <20200721155615.12625-2-James.Bottomley@HansenPartnership.com>
Date:   Tue, 21 Jul 2020 16:16:30 -0700
Message-ID: <87a6zslar5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-07-21 08:56 MST:

> use macro magic to create sysfs per hash groups with 24 PCR files in
> them one for each possible agile hash of the TPM.  The files are
> plugged in to a read function which is TPM version agnostic, so this
> works also for TPM 1.2 although the hash is only sha1 in that case.
> For every hash the TPM supports, a group named pcr-<hash> is created
> and each of the PCR read files placed under it.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: fix TPM 1.2 legacy links failure
> ---
>  drivers/char/tpm/tpm-sysfs.c | 180 +++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h          |   8 +-
>  2 files changed, 187 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index d52bf4df0bca..6c4e984d6c8d 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -348,11 +348,191 @@ static const struct attribute_group tpm2_dev_group = {
>  	.attrs = tpm2_dev_attrs,
>  };
>  
> +struct tpm_pcr_attr {
> +	int alg_id;
> +	int pcr;
> +	struct device_attribute attr;
> +};
> +
> +#define to_tpm_pcr_attr(a) container_of(a, struct tpm_pcr_attr, attr)
> +
> +static ssize_t pcr_value_show(struct device *dev,
> +			      struct device_attribute *attr,
> +			      char *buf)
> +{
> +	struct tpm_pcr_attr *ha = to_tpm_pcr_attr(attr);
> +	struct tpm_chip *chip = to_tpm_chip(dev);
> +	struct tpm_digest digest;
> +	int i;
> +	int digest_size = 0;
> +	int rc;
> +	char *str = buf;
> +
> +	for (i = 0; i < chip->nr_allocated_banks; i++)
> +		if (ha->alg_id == chip->allocated_banks[i].alg_id)
> +			digest_size = chip->allocated_banks[i].digest_size;
> +	/* should never happen */
> +	if (!digest_size)
> +		return -EINVAL;
> +
> +	digest.alg_id = ha->alg_id;
> +	rc = tpm_pcr_read(chip, ha->pcr, &digest);
> +	if (rc)
> +		return rc;
> +	for (i = 0; i < digest_size; i++)
> +		str += sprintf(str, "%02X", digest.digest[i]);
> +	str += sprintf(str, "\n");
> +
> +	return str - buf;
> +}
> +
> +/*
> + * The following set of defines represents all the magic to build
> + * the per hash attribute groups for displaying each bank of PCRs.
> + * The only slight problem with this approach is that every PCR is
> + * hard coded to be present, so you don't know if an PCR is missing
> + * until a cat of the file returns -EINVAL
> + *
> + * Also note you must ignore checkpatch warnings in this macro
> + * code. This is deep macro magic that checkpatch.pl doesn't
> + * understand.
> + */
> +
> +/* Note, this must match TPM2_PLATFORM_PCR which is fixed at 24. */
> +#define _TPM_HELPER(_alg, _hash, F) \
> +	F(_alg, _hash, 0)	    \
> +	F(_alg, _hash, 1)	    \
> +	F(_alg, _hash, 2)	    \
> +	F(_alg, _hash, 3)	    \
> +	F(_alg, _hash, 4)	    \
> +	F(_alg, _hash, 5)	    \
> +	F(_alg, _hash, 6)	    \
> +	F(_alg, _hash, 7)	    \
> +	F(_alg, _hash, 8)	    \
> +	F(_alg, _hash, 9)	    \
> +	F(_alg, _hash, 10)	    \
> +	F(_alg, _hash, 11)	    \
> +	F(_alg, _hash, 12)	    \
> +	F(_alg, _hash, 13)	    \
> +	F(_alg, _hash, 14)	    \
> +	F(_alg, _hash, 15)	    \
> +	F(_alg, _hash, 16)	    \
> +	F(_alg, _hash, 17)	    \
> +	F(_alg, _hash, 18)	    \
> +	F(_alg, _hash, 19)	    \
> +	F(_alg, _hash, 20)	    \
> +	F(_alg, _hash, 21)	    \
> +	F(_alg, _hash, 22)	    \
> +	F(_alg, _hash, 23)
> +
> +/* ignore checkpatch warning about trailing ; in macro. */
> +#define PCR_ATTR(_alg, _hash, _pcr)				   \
> +	static struct tpm_pcr_attr dev_attr_pcr_##_hash##_##_pcr = {	\
> +		.alg_id = _alg,					   \
> +		.pcr = _pcr,					   \
> +		.attr = {					   \
> +			.attr = {				   \
> +				.name = __stringify(_pcr),	   \
> +				.mode = 0444			   \
> +			},					   \
> +			.show = pcr_value_show			   \
> +		}						   \
> +	};
> +
> +#define PCR_ATTRS(_alg, _hash)			\
> +	_TPM_HELPER(_alg, _hash, PCR_ATTR)
> +
> +/* ignore checkpatch warning about trailing , in macro. */
> +#define PCR_ATTR_VAL(_alg, _hash, _pcr)		\
> +	&dev_attr_pcr_##_hash##_##_pcr.attr.attr,
> +
> +#define PCR_ATTR_GROUP_ARRAY(_alg, _hash)		       \
> +	static struct attribute *pcr_group_attrs_##_hash[] = { \
> +		_TPM_HELPER(_alg, _hash, PCR_ATTR_VAL)	       \
> +		NULL					       \
> +	}
> +
> +#define PCR_ATTR_GROUP(_alg, _hash)			    \
> +	static struct attribute_group pcr_group_##_hash = { \
> +		.name = "pcr-" __stringify(_hash),	    \
> +		.attrs = pcr_group_attrs_##_hash	    \
> +	}
> +
> +#define PCR_ATTR_BUILD(_alg, _hash)	   \
> +	PCR_ATTRS(_alg, _hash)		   \
> +	PCR_ATTR_GROUP_ARRAY(_alg, _hash); \
> +	PCR_ATTR_GROUP(_alg, _hash)
> +/*
> + * End of macro structure to build an attribute group containing 24
> + * PCR value files for each supported hash algorithm
> + */
> +
> +/*
> + * The next set of macros implements the cleverness for each hash to
> + * build a static attribute group called pcr_group_<hash> which can be
> + * added to chip->groups[].
> + *
> + * The first argument is the TPM algorithm id and the second is the
> + * hash used as both the suffix and the group name.  Note: the group
> + * name is a directory in the top level tpm class with the name
> + * pcr-<hash>, so it must not clash with any other names already
> + * in the sysfs directory.
> + */
> +PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
> +PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
> +PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
> +PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
> +PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);
> +
> +
>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>  {
> +	int i;
> +
>  	WARN_ON(chip->groups_cnt != 0);
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		chip->groups[chip->groups_cnt++] = &tpm2_dev_group;
>  	else
>  		chip->groups[chip->groups_cnt++] = &tpm1_dev_group;
> +
> +	/* add one group for each bank hash */
> +	for (i = 0; i < chip->nr_allocated_banks; i++) {
> +		switch (chip->allocated_banks[i].alg_id) {
> +		case TPM_ALG_SHA1:
> +			chip->groups[chip->groups_cnt++] = &pcr_group_sha1;
> +			break;
> +		case TPM_ALG_SHA256:
> +			chip->groups[chip->groups_cnt++] = &pcr_group_sha256;
> +			break;
> +		case TPM_ALG_SHA384:
> +			chip->groups[chip->groups_cnt++] = &pcr_group_sha384;
> +			break;
> +		case TPM_ALG_SHA512:
> +			chip->groups[chip->groups_cnt++] = &pcr_group_sha512;
> +			break;
> +		case TPM_ALG_SM3_256:
> +			chip->groups[chip->groups_cnt++] = &pcr_group_sm3;
> +			break;
> +		default:
> +			/*
> +			 * If this warning triggers, send a patch to
> +			 * add both a PCR_ATTR_BUILD() macro above for
> +			 * the missing algorithm as well as an
> +			 * additional case in this switch statement.
> +			 */
> +			WARN(1, "TPM with unsupported bank algorthm 0x%04x",
> +			     chip->allocated_banks[i].alg_id);
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * This will only trigger if someone has added an additional
> +	 * hash to the tpm_algorithms enum without incrementing
> +	 * TPM_MAX_HASHES.  This has to be a BUG_ON because under this
> +	 * condition, the chip->groups array will overflow corrupting
> +	 * the chips structure.
> +	 */
> +	BUG_ON(chip->groups_cnt > TPM_MAX_HASHES);

Should this check be 3 + TPM_MAX_HASHES like below?

>  }
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 5026a06977e1..f73dc4f9fbf4 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -42,6 +42,12 @@ enum tpm_algorithms {
>  	TPM_ALG_SM3_256		= 0x0012,
>  };
>  
> +/*
> + * maximum number of hashing algorithms a TPM can have.  This is
> + * basically a count of every hash in tpm_algorithms above
> + */
> +#define TPM_MAX_HASHES	5
> +
>  struct tpm_digest {
>  	u16 alg_id;
>  	u8 digest[TPM_MAX_DIGEST_SIZE];
> @@ -145,7 +151,7 @@ struct tpm_chip {
>  
>  	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>  
> -	const struct attribute_group *groups[3];
> +	const struct attribute_group *groups[3 + TPM_MAX_HASHES];
>  	unsigned int groups_cnt;
>  
>  	u32 nr_allocated_banks;

