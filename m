Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3162F458C
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 08:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAMHvD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 02:51:03 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58779 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbhAMHvD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 02:51:03 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A5B905C05B1;
        Wed, 13 Jan 2021 02:50:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 Jan 2021 02:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Q+gfiW21e+iUSVAjHLJaEmlTToT
        hRwbt8xbTZ2vNRhc=; b=ZAUmE899Zza5e8SJ6lVtE4r33o5cY+Eurllzi/ECQfn
        sI2xz0nki/g+5/XfNHpwNSMGU/zBMadV1dhkSmLXUFCjTbRdwDRBCevsWdij4+HE
        0XglqFc8B0OlFZ5qtg2nFTnD+dHMeeyyp8B87x7ZE9PvA/cF/PdfbtVn8omk91SL
        GAeeAgwfNa/FacVrwGLTiOpyrBPhpEyQ0OXpeaZotqXjhQaBMCA+DVMmWhXpJ1px
        QiEl/FhJxxPNprSUO0Gw3B4F2rwOu44r0ZGi0cB/AVIvl+IYZHD0Ks1tczFb4OfW
        5ikyxP4eqwbWFItLdc6TLa9Og0JrMpesA2TfnVFIllw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Q+gfiW
        21e+iUSVAjHLJaEmlTToThRwbt8xbTZ2vNRhc=; b=bJ8TAppSNi83ZmDanBgP4I
        p54aZMQNErX/2jCBxquozNZx2/4478QBqfR6Gz/OHJCU7kCBnkltejQ8lkWerlrZ
        edhX533RF69XQHGhlBmMJtR/qT8QDtZLgiclxipjlrR1Of69AGXwNBffncjOU8g1
        egaAWYBSO/NEATivu97YlRmpTaQfCCVi2cXM1Sb+BJfNyHo7h6vPfQVR6eXUd9sa
        kZx9Utr15CAyM2eC1fjymB19boHWx3rTlHK7JJjTwqzCDgZ26p+HQxM3depdVj76
        xAP2gpCpa1RXer5TW+9JBcQZuPSCEYu8BasANmChJG5NuHv/6wQGdAby5rrHHGvg
        ==
X-ME-Sender: <xms:Nqb-X8om1WB9Vf02OSAYBYqVgw9-W5mcCleBOfJMcFvaeqdi79Zy4g>
    <xme:Nqb-XyocyfHPKJ3E2HrMgAr8vEoUax5lKf45_nbyPum6W6psl29_jVbWY3zBcBLqV
    IdJLuLVm2mCaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:Nqb-XxMSB_zP6iNF-TxA49V05G5uEPNcZHUXyBwBTJ3tJ0SMeGQC2g>
    <xmx:Nqb-Xz4wpxHf0vvrGeH1SN5ys5M47lwGNAccZF-e8Tq1di-LSZfY5g>
    <xmx:Nqb-X74C8zLoyeUuyrvu2s7JI4L2igkyZMGRc0R3yK24c2_gwBM4Ag>
    <xmx:Nqb-X7FpSKSz2xJW6IwG24kgNqk9P3XAZvtjzOj9jtzONbj7LMPPWw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 218621080064;
        Wed, 13 Jan 2021 02:50:14 -0500 (EST)
Date:   Wed, 13 Jan 2021 08:50:11 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <X/6mM/egPLyXASM9@kroah.com>
References: <20210113015958.6685-1-James.Bottomley@HansenPartnership.com>
 <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113015958.6685-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 12, 2021 at 05:59:58PM -0800, James Bottomley wrote:
> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> ---
> 
> v2: fix TPM 1.2 legacy links failure
> v3: fix warn on and add note to tpm_algorithms
> v4: reword commit and add tested-by
> v5: algorithm spelling fix WARN->dev_err
> ---
>  drivers/char/tpm/tpm-sysfs.c | 179 +++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h          |   9 +-
>  2 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index e2ff0b273a0f..63f03cfb8e6a 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -337,11 +337,190 @@ static const struct attribute_group tpm2_dev_group = {
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

sysfs_emit()?




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

__ATTR_RO()?

>  void tpm_sysfs_add_device(struct tpm_chip *chip)
>  {
> +	int i;
> +
>  	WARN_ON(chip->groups_cnt != 0);
> +

How can that WARN_ON happen?

thanks,

greg k-h
