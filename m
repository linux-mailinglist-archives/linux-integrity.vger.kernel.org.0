Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68D2F7D4A
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 14:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbhAONyw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 08:54:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51557 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727283AbhAONyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 08:54:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 13BB7F51;
        Fri, 15 Jan 2021 08:54:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 08:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=7f+HU+xaqvlOAL0uqE2wEBxglR5
        aL7cCj5gwXr3yJB4=; b=DaACQaau8RYGMDe02kPLPLM0J/sPAVuCWS/oesppV1w
        3WxufrQvr0SOoncSo4VgHHQlafS9tlm8/kzYksohu9ucG37qDXSVc3iDYC8E6Gzb
        n7eC7m1l1D1jkGCxL6F1COuF6ybkNjhAnPvtpl6rkwkJC9ZZsIk0S8cSElUGrQF5
        LQyf5fiRJteNWVp6Ab57NW395cVP218xpoEub0V+URHXvag0/5XBEUyz656mI5ro
        EzaHcppO5rAV5wU3Td3yRqbw/cefcy34fBYFzmYY/Nn1srhXnXohZbBTEN5E5k9y
        FafS2vOVDVAtzTOA5lIuljQ92uSXvQst1cdo+qCvCKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7f+HU+
        xaqvlOAL0uqE2wEBxglR5aL7cCj5gwXr3yJB4=; b=UxnVHjVgOR+z9fNGCs2wwb
        qsIpyt/kk2AGYM9hLa18cUurnbNXI7e4EKaT9PnUvay+GvPWI8Pv0aA/zPDevz1X
        h8Myr0bPkCAyTbXfcijQLthKzgDChelWwAG6/DLbCHbJiw9wnfJOvcmF4c/t66xh
        avtt1DCEaeu7Jm3snwykJw7aJ11Bz+cCVq2w0Jrn2lqOPJ62gi/3MaMEUndhtn2O
        gM2gmfPBi5ZuarwbqExtiPWySxTDMD1p4dZzYAMie91NRuA5et+n5unJrq3eGJr1
        +62b9WIFnfZZv7l1JToev0w3DIDoFDFSHyAQC8T2zFidmAdiK+jmCLAuUfqWOLNw
        ==
X-ME-Sender: <xms:fJ4BYLDbFXG9DPvlIJwO7wZD8dAekDZMoaw8t3f9xJ1YJmowlBMwbQ>
    <xme:fJ4BYBcrZFjGkN3YMIni9x5LbttxTX4cvpjqU4YdplQ5d8di-_xGt_udvcdnJZE8d
    F8G7HXpo5_WvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:fJ4BYDf4te0aoLB1fQwDB12JdaBqLHi38Bkd_rCqir9CJ_Y7zHMp_g>
    <xmx:fJ4BYFgG2_ncEfVPXUZvAv4GmletJaV8A7XmSdTk_odQZ7QwAx0GJQ>
    <xmx:fJ4BYPTME2Jglf1y4x-bczvq8ltECoN48-13THuS3rP2TpGR6RNYZg>
    <xmx:fZ4BYJujR07dBqlF3JNGSo6bdWOWPRfUBUtZ5eIjpDWczBpVzGgAwA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E778240069;
        Fri, 15 Jan 2021 08:54:04 -0500 (EST)
Date:   Fri, 15 Jan 2021 14:54:03 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/2] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <YAGeez8OZWDXugTW@kroah.com>
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

Well, you shouldn't be doing anything other than a "normal" single value
write, so the _at() function should be rare.

> It looks like we already have a couple of bugs in the kernel introduced
> by this confusion ...  return sysfs_emit() vs return sysfs_emit_at()
> being the most tricky ...

Hm, Joe, you did the conversion to these functions (and wrote the api),
care to review this?

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

Ah, missed that you were using the same show() function.  Ok, makes
sense, but it feels odd to have your own attribute type for something as
"simple" as a tiny driver like this.  But you are maintaining it, not me
:)

thanks,

greg k-h
