Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA72F7310
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 07:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbhAOG4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 01:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOG4n (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 01:56:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAF7B222BB;
        Fri, 15 Jan 2021 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610693763;
        bh=lrGUdHlmFF3vQTrV4Rd4F8pwidD+CS+Vnw7xWJ2KjVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIlDm/BvpCkKJyHcGkpTyaeYASW6Rmuyr/rRrx4j0etk2brCvWalbnb/oJrEqGYUV
         qr+NwVzvgaqZAkeE8gfHhr9xCfYANPyF3wrhw3xnb1q2pMdGlzSXloH6lqVmJz0oW1
         7NSr8IxdRM6ZJNUyLrRHCcEQ+flNF0NXx7iqJYzUTCE5kYMUoVQou97LtL7dKqz5li
         krLPCbuMbYT38YQED2BcgRHs5QyrrhRpC5GJNYWSu2vzlsdKN4ZFDE6mJD91uqLPgZ
         RmyK1ruYctwSrDXxfjmVnb2HIQn6BseAi/zMc8fj7NOfx0trJEuMWvPvbYzSdMLau/
         JF8p3nsYiJA6Q==
Date:   Fri, 15 Jan 2021 08:55:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Greg KH <greg@kroah.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <YAE8fjt/lfYmEZxc@kernel.org>
References: <20210113232634.23242-1-James.Bottomley@HansenPartnership.com>
 <20210113232634.23242-2-James.Bottomley@HansenPartnership.com>
 <X//55I26mxVQKKOE@kroah.com>
 <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce0ce0c5b3b66e2b1506ab9c4f10ffbbcfa648d8.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 14, 2021 at 04:21:08PM -0800, James Bottomley wrote:
> On Thu, 2021-01-14 at 08:59 +0100, Greg KH wrote:
> > On Wed, Jan 13, 2021 at 03:26:33PM -0800, James Bottomley wrote:
> > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > plugged in to a PCR read function which is TPM version agnostic, so
> > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > 
> > > Note: the macros used to create the hashes emit spurious checkpatch
> > > warnings.  Do not try to "fix" them as checkpatch recommends,
> > > otherwise
> > > they'll break.
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > 
> > > ---
> > > 
> > > v2: fix TPM 1.2 legacy links failure
> > > v3: fix warn on and add note to tpm_algorithms
> > > v4: reword commit and add tested-by
> > > v5: algorithm spelling fix WARN->dev_err
> > > ---
> > >  drivers/char/tpm/tpm-sysfs.c | 179
> > > +++++++++++++++++++++++++++++++++++
> > >  include/linux/tpm.h          |   9 +-
> > >  2 files changed, 187 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-
> > > sysfs.c
> > > index e2ff0b273a0f..63f03cfb8e6a 100644
> > > --- a/drivers/char/tpm/tpm-sysfs.c
> > > +++ b/drivers/char/tpm/tpm-sysfs.c
> > > @@ -337,11 +337,190 @@ static const struct attribute_group
> > > tpm2_dev_group = {
> > >  	.attrs = tpm2_dev_attrs,
> > >  };
> > >  
> > > +struct tpm_pcr_attr {
> > > +	int alg_id;
> > > +	int pcr;
> > > +	struct device_attribute attr;
> > > +};
> > > +
> > > +#define to_tpm_pcr_attr(a) container_of(a, struct tpm_pcr_attr,
> > > attr)
> > > +
> > > +static ssize_t pcr_value_show(struct device *dev,
> > > +			      struct device_attribute *attr,
> > > +			      char *buf)
> > > +{
> > > +	struct tpm_pcr_attr *ha = to_tpm_pcr_attr(attr);
> > > +	struct tpm_chip *chip = to_tpm_chip(dev);
> > > +	struct tpm_digest digest;
> > > +	int i;
> > > +	int digest_size = 0;
> > > +	int rc;
> > > +	char *str = buf;
> > > +
> > > +	for (i = 0; i < chip->nr_allocated_banks; i++)
> > > +		if (ha->alg_id == chip->allocated_banks[i].alg_id)
> > > +			digest_size = chip-
> > > >allocated_banks[i].digest_size;
> > > +	/* should never happen */
> > > +	if (!digest_size)
> > > +		return -EINVAL;
> > > +
> > > +	digest.alg_id = ha->alg_id;
> > > +	rc = tpm_pcr_read(chip, ha->pcr, &digest);
> > > +	if (rc)
> > > +		return rc;
> > > +	for (i = 0; i < digest_size; i++)
> > > +		str += sprintf(str, "%02X", digest.digest[i]);
> > > +	str += sprintf(str, "\n");
> > 
> > Please use sysfs_emit() and sysfs_emit_at() for new sysfs files.
> 
> Hey these interfaces were added after this patch began life.  But
> looking at sysfs_emit_at() I've got to say "aah ... don't you guys ever
> read rusty's guide to interfaces?" an interface which takes in an
> absolute page position but returns a relative offset to the position it
> took in is asking for people to get it wrong.  You should always be
> consistent about uses for inputs and outputs.  Basically the only way
> you can ever use sysfs_emit_at in a show routine is as
> 
> offset += sysfs_emit_at(buf, offset, ...);
> 
> because you always need to track the absolute offset.
> 
> It looks like we already have a couple of bugs in the kernel introduced
> by this confusion ...  return sysfs_emit() vs return sysfs_emit_at()
> being the most tricky ...

How is using sysfs_emit() different from using snprintf() for the
caller, ignoring the added safety measures? I'm new to this API.

> > > +/* ignore checkpatch warning about trailing ; in macro. */
> > > +#define PCR_ATTR(_alg, _hash, _pcr)				
> > >    \
> > > +	static struct tpm_pcr_attr dev_attr_pcr_##_hash##_##_pcr = {	
> > > \
> > > +		.alg_id = _alg,					   
> > > \
> > > +		.pcr = _pcr,					   
> > > \
> > > +		.attr = {					   \
> > > +			.attr = {				   \
> > > +				.name = __stringify(_pcr),	   \
> > > +				.mode = 0444			   
> > > \
> > > +			},					   \
> > > +			.show = pcr_value_show			   
> > > \
> > 
> > Can you use __ATTR_RO()?  "open" coding the sysfs mode is frowned
> > apon these days.
> 
> No because the .show function is the same for every attribute even
> though the name is different.  Somewhere way back at the beginning of
> this there was a thread about trying to use the ATTR macros, but the
> problem is there are multiple hash banks that each want files called
> "1" "2" and so on ... we just can't structure the show functions to be
> one per the entire attribute set without either including the hash in
> the name, which we don't want because it's in the directory, or
> creating clashes in the .show file.

One could introduce __ATTR_RO_SHOW(), like there is __ATTR_RO_MODE().
Not sure if this worth of trouble.

> James

/Jarkko
