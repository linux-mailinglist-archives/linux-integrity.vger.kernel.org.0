Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0E25F2A3
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgIGFjk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 01:39:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44735 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgIGFjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 01:39:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 25E245C0116;
        Mon,  7 Sep 2020 01:39:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Sep 2020 01:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lxZukiqLUitRS8sYygW+E+4Mh4B
        6q/Q6RDBcrfTxIuM=; b=TcXNl0jQm7GuYZvCAoLf6iQPbQb1YF5TgkoKuoHcUBh
        1CwKiT2wazPzIjmrSwnsfqTPngcSYMvNw2kytxi9Bh3W4ipRykpPIRUWZqt7Zw1h
        IS+jvDrIjGmmLkNpnDvaBD2Vp96hI0eeUhF6rmgUSfBba6myWIKqQaf2giCwYIgt
        c1R92/pqA/NQTL3cjZqVZDAiz+7fR7NMeNQuDWJPS6qhus63ibZ7vbVS2JNruyQl
        ZNStg2Skh/t1RItDZ1uVV4WdVVkiWKXYCAogMrpL1y+art4NIenYwIk5HoWOfb5m
        bol4NhlOatbFZ085j7o/0uXsZOXqpTV0f+QcgdKd4Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lxZuki
        qLUitRS8sYygW+E+4Mh4B6q/Q6RDBcrfTxIuM=; b=XC4T04xg1TP8rnWu3ztICK
        q0wXRg8dAdf/xr0uoMqgyiFCrhuZkHx18H8tafL2yVIzPEb0jT+YjdhCYmPQnz6g
        CX3Sc/p/IJGSZUnjqHNoUzZzKS9qic02IfdlpYavxkKb0JAB/NmCfqmHKKl/GLxS
        cNmlLDyI3pvRVr2zzhnBKrjMRADE3Ng1x7/Y3Ta0SwpPGV+YJ8fff0+DX5otDxJK
        QDA5U5c2ouldjtvXaSTxzBrJV5uDSuwazFOa9bQl5RdVIQenT28XDMRjq9BdIDrc
        17A4M9eZtg4rO6+x3T4mJDSXyB1Rkyexceq4UrTzr5jH+hirOoVPNSFd+PFyBakA
        ==
X-ME-Sender: <xms:m8dVX79l_ACf1QJvkk4Jcgxyz4h_UZqcd6ON0mN0PT9ibX6pBohxvQ>
    <xme:m8dVX3sI6-S-If2Wypqri3C4Y83mCyobZ6DPzBTTGI-2l4341iTNl4sBkd1S-JdWa
    _xf7Okh1Kw7mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegledggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:m8dVX5B2dRSPAmqaoFKvOMMiBODyRWtugcaWSzKnqFAUHwMO2OvKPA>
    <xmx:m8dVX3dHLLCH4Q-Fs17Z5V7RJ6AxVKo8mMttpoeijqORhQpXFSNxmQ>
    <xmx:m8dVXwMcBxu_WLsecumy7Vk3At3V2hZT1A7eQBVWAbDVCK3_CwAt4A>
    <xmx:m8dVX5aGioyLeD-K4XaHeGdHqv03DMLI11FArcsGcrsk1zb1mvUuGA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id A26D23064605;
        Mon,  7 Sep 2020 01:39:38 -0400 (EDT)
Date:   Mon, 7 Sep 2020 07:39:35 +0200
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <20200907053935.GB279469@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906203245.18429-2-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 06, 2020 at 01:32:45PM -0700, James Bottomley wrote:
> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.

Oh you are just ensuring yourself a world of hurt for drive-by patches
that everyone submits.  Don't do this if you can help it at all.


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
> ---
>  drivers/char/tpm/tpm-sysfs.c | 178 +++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h          |   9 +-
>  2 files changed, 186 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index d52bf4df0bca..81a02200b207 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -348,11 +348,189 @@ static const struct attribute_group tpm2_dev_group = {
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

Like I said before, just use a binary sysfs file, that should make this
function simpler.

thanks,

greg k-h
