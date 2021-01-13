Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858DE2F4584
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 08:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbhAMHth (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Jan 2021 02:49:37 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59481 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbhAMHtg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Jan 2021 02:49:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id EBBD65C04F0;
        Wed, 13 Jan 2021 02:48:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 13 Jan 2021 02:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=uk4l3Ijiax/TJ1Nop/MMYDTynqh
        LEIqVVBQ3b7Ozw/Q=; b=BGtrnabDT3vxBa874N/NfJ/l/cVElYd78s+31R5W9jJ
        7XtoZxlzlCCwinqJYhXLZpoq/6VKTlJ32j8oJqY9XfvxAt8CviErF+AsyYSSqTNg
        epR85bZ6C1UBk/2VWqhNquhWkfzXIvVIEqv27B1Pl/JJjdyUXZtW4GX7hKCPqz1V
        P7V/t15vxE1N7zz9XwGboI10coCsPLnXn1SYF6ZTR6wORqvTomZX1ogkZDpfscjA
        M+Ht85Q3xvYR4HppT4R56Kn08FRb8ZKF1N2DvdS3boLKAtaGmJ1hRYJ9rDi1WXyQ
        4vmQ/CmR8LVrm/aY6xjXVAW5UePJ6FDKB5mcLflBrwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=uk4l3I
        jiax/TJ1Nop/MMYDTynqhLEIqVVBQ3b7Ozw/Q=; b=d1puOBM0WIHuJHoU6CPzMO
        MPvKQjfSaGNGG7Db41G5RC/TezpEajybeb2cQSUf7m2wiex7syMXhILMoo+wu75d
        zE3s4QVmyCJyigSnoSvwewYxBluLrHgBLxlggqAbakeena3U1QF5WKyd1QVu2w4I
        R4mx5y+LBgm/jA7FAdEUqyN6UBASLnWBw491DC3MVYzGExGiUAwDMzi+dbYFSwKG
        ZR5juaXjmZLkDY7540BQSqJy93K8VHnpYAkzt2tMGROzn2oIKexczN6RL7z90m0P
        GTo3i9hVpRfYU7mTEOl7lRoyWBr4uCTCkBxcAgxaDpPBpBTd7FipEJR5yIIRgMvA
        ==
X-ME-Sender: <xms:zqX-X5IrMO2A6TGOBl3ZMHhrA2lGj-s9A4_Ypc125priydNhO78aLg>
    <xme:zqX-X1LVNVOI3DCOsHH3Qa56DWeUVR0jVfWi7fHDsC5tT9E_JVdhpoHGfKvQLGrAc
    Qapxm-_Lkb3eQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:zqX-XxvYi4ZEHs_C6e7OPjieL5d82gK7uEra_wCQRQloe0vfHUabNQ>
    <xmx:zqX-X6axetUlKoGJ8t-p_XLoM46GWg7ywOimfWsMY_ziD9nrZ0uZUA>
    <xmx:zqX-XwaMJBZ0aRS8LEF7RmtAu78f75Qv-n4M3lG0v86jJyPCfV9X8Q>
    <xmx:zqX-X_nTVkFW-CdPOKoAYftY72x-KBlhSk74dKsercwvsLP_c9gL3A>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 007FA24005B;
        Wed, 13 Jan 2021 02:48:29 -0500 (EST)
Date:   Wed, 13 Jan 2021 08:48:26 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <X/6lyuhqQ8TSXOSa@kroah.com>
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

You add new sysfs files, but do not add Documentation/ABI/ entries
showing how they are used and what they contain :(

Please do that for the next version of this patch.

thanks,

greg k-h
