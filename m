Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD722F5BEB
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 09:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbhANIAX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 03:00:23 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57493 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbhANIAW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 03:00:22 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 74652134E;
        Thu, 14 Jan 2021 02:59:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 14 Jan 2021 02:59:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yvYpFGO9MesyeqnSwFBmc3vHur3
        55sBthcHVnzFujXs=; b=UfePJs0eheOLSmd5xKMtscaPFoPwO3soCz47oYNjLXl
        71CGRQcThu/YdZgDlbUh5Wt7fqNkAONOSFV0XQkq9f94CEqZ8KFqPmMiEHrp9TXE
        5l1n9kD2XXV5EoqcKLMojhk64FvecngmOVv2MMAXy3pz+obSXaRNUylQm5fmSxPG
        YzDJm9Yb3oeQ72V9bAhXUw14OCO5NQDMdZ+BUDIHPc5JTn0mvieu02uOx0M1yVec
        tzOxjo5pUcyRoEJFSSFYa6WiG6GZUQ6pJ/PuKImtxo+/DQII1AR4Pfic/vqsXgBr
        M0JWHoYiKg54XimQAyX5T5RxsblicxHe7h39P2eFkiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yvYpFG
        O9MesyeqnSwFBmc3vHur355sBthcHVnzFujXs=; b=b0DzXf79QV02B981kHGL27
        t61bRrCD8rIkah/HR+mgFrMAfUKUOUBrCW5VrX1CYirL91FHTDY1XyMY5vhlhX4m
        ABRBEr0yWOfdqVZ0WtFsFFbSEO/x85S8DviLpMXaE7PzBxi6DxyCc/cdwMiynQlH
        sHFTz7hME7anvVP+dWKvqCHlHZzSSGX9YJfzkdrceup3Dp69MEJAwwmRcVp5htvj
        f7MbcgEPPdGI/MJN1pPRx7thi9tmsEk/IshyyMTYC5jdu5i7LBNoQFKjxXFoRlDh
        jMDPM12vTJndx6O/QV8lxexD0B+zhz4xVxs1DP50K01c0pj0bvDmiPBEWNS/GFpA
        ==
X-ME-Sender: <xms:5vn_X6jQsp1ymrE0683eFtxgmu9iWSOoBdE4gBhzuulzxQmAYoPlkg>
    <xme:5vn_X7Djbx-P3TPDh3tTLi4aMT51mouxr-05mJDVxjvA5fXyxDz2SW8xZgQW4v1cn
    rwH1kKT3ln_PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtdeggdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:5vn_XyFq1GZzIDHLTColKMJ2PwhOa7to0_mpVgVw1B0rjaRqedBzLw>
    <xmx:5vn_XzRCGlnTIp2qndWB0SajGzUOwhNd2FXLisvgL6Is92p30TwdWg>
    <xmx:5vn_X3ys3ONFF5xSaKoQH0npThWVKICCDObL4e2_cu2pjmL_b1dtvg>
    <xmx:5_n_Xy9NSh3wTmRxDUrNTUe26TvvK9CN83d14VIiO8RTnSCpqyBWKw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BF0324005A;
        Thu, 14 Jan 2021 02:59:34 -0500 (EST)
Date:   Thu, 14 Jan 2021 08:59:32 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <X//55I26mxVQKKOE@kroah.com>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
 <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 13, 2021 at 03:26:33PM -0800, James Bottomley wrote:
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

Please use sysfs_emit() and sysfs_emit_at() for new sysfs files.

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

Can you use __ATTR_RO()?  "open" coding the sysfs mode is frowned apon
these days.

thanks,

greg k-h
