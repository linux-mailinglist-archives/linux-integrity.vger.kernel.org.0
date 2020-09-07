Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4408D25F2A1
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 07:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgIGFia (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 01:38:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40835 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgIGFi3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 01:38:29 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 690CB5C00B0;
        Mon,  7 Sep 2020 01:38:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 07 Sep 2020 01:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=9zHDtxhfMmyni7ofUq7PIlCJh1Z
        r6HL/OVKjXckwPNw=; b=OB1LkMmAmJ0SdeVJ1MS4OETf7+7GIZHl+UFLYUClkrz
        53W8Re9qQOweYuB52fIankDbxeTwvXfEDferT0kyYQGtFXkOKeqak6Zu5Im2JUDT
        zVj4BojfLmbW8waVJnyshQjEsRciaBLxNfYqxwBK1l3JFDb6NeUNbSCotM3o5Nqu
        3+UgSOeDUffSgfDkyOYveMfCmqhzM+Wj9DwAUuCFN1XQhD+ByRnRc8iKHB1O0uUJ
        rcdRYSQZF+CXQU4pDQC3/s20lvcrKxiVXIrUPOeL980v3FZ07CFQ95RdrwTcNum+
        GJrtiBXn7HSDxh3j46oX0SWudSX1U504pAZ5X3g1yRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9zHDtx
        hfMmyni7ofUq7PIlCJh1Zr6HL/OVKjXckwPNw=; b=YEwxDXoBmAI3YGdKpFoCMi
        XpFhFTE9PN22blaMaA7szoDnfPYV+cT6ds/9Y6ogsVtaVzxnqGDXeB8dpO8xjPiu
        KQU9nG/Bz3RdDSNQ8JDhIAspko65BO8MFIF7fOm4t6xLY/gNQjeKV8tGjqxci33i
        RnJsXxFmNrZ6AOACVBBpv1M5j5axpsP4GiEm1zeM9vKllO5p7INsVjDX45XdTe5P
        o0UNqBFBp79nhfrVU20NC6frK+RsUfpexB60KAzYwwnQgcxm4XEMLvenyJhWwYpj
        mCBYnnycJwV99t8CyZkeCRCjW6pIT9zvVsShKu8sKQeC0h39lgWNTaPetpWCCvvw
        ==
X-ME-Sender: <xms:UsdVX9-AX-HSVxa6kPvOxV5p09UcV1j_VAPIUiLwH01Uk0Ds1w-jFA>
    <xme:UsdVXxtV_DqEmtRY2PVGqcMeK7kgsF5bfXGX5PXG4hodNZ4uVT7oZdzX2enY_4dkV
    0M_JrZ0AdgSpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegledggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:UsdVX7DWKqgqwUsvfaxOUZke_i9apDon_CjBFl3493e9xHJ0E_cCRQ>
    <xmx:UsdVXxf1Qubm-s1aY2ltNfSuKTDnZohCW8gf8CrqFkeki1pgmAI3bw>
    <xmx:UsdVXyPJLFKSsl-S1POAtPvFMc6cnr_nAYmPn_Vvyu656wVgerHIKw>
    <xmx:U8dVX7a3jPQIMASxINhGXlBf6woWRlwONffc4kzaMCvwL6gEvggWGw>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 470EC328005E;
        Mon,  7 Sep 2020 01:38:26 -0400 (EDT)
Date:   Mon, 7 Sep 2020 07:38:24 +0200
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200907053824.GA279469@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Sep 06, 2020 at 01:32:44PM -0700, James Bottomley wrote:
> Cc to linux-api to get an opinion on two issues.  First the background:
> 
> We've had a fairly extensive discussion over on linux-integrity and
> iterated to the conclusion that the kernel does need to export TPM 2.0
> PCR values for use by a variety of userspace integrity programmes
> including early boot.  The principle clinching argument seems to be
> that these values are required by non-root systems, but in a default
> Linux set up the packet marshalled communication device: /dev/tpmrm0,
> is by default only usable by root.  Historically, TPM 1.2 exported
> these values via sysfs in a single file containing all 24 values:
> 
>   /sys/class/tpm/tpm0/pcrs
> 
> with the format
> 
>   PCR-00: 7D 29 CB 08 0C 0F C4 16 7A 0E 9A F7 C6 D3 97 CD C1 21 A7 69 
>   PCR-01: 9C B6 79 4C E4 4B 62 97 4C AB 55 13 1A 2F 7E AE 09 B3 30 BE 
>   ...

Ick, that's not "one value per file" :(

> TPM 2.0 adds more complexity: because of it's "agile" format, each TPM
> 2.0 is required to support a set of hashes (of which at least sha1 and
> sha256 are required but quite a few TPM 2.0s have at least two or
> three more) and maintain 24 PCR registers for each supported hash.
> The current patch exports each PCR bank under the directory
> 
>   /sys/class/tpm/tpm0/pcr-<hash>/<bank>
> 
> So the sha256 bank value of PCR 7 can be obtained as
> 
>   cat /sys/class/tpm/tpm0/pcr-sha256/7
>   2ED93F199692DC6788EFA6A1FE74514AB9760B2A6CEEAEF6C808C13E4ABB0D42
> 
> And the output is a single non-space separated ascii hex value of the
> hash.
> 
> The issues we'd like input on are:
> 
>  1. Should this be in sysfs or securityfs?
> 
>   2. Should we export the values as one value per file (current patch)
>      or as a binary blob of all 24?

Please just use a binary blob format.  Binary sysfs files are exactly
what this is for, you are just passing the data through the kernel from
the hardware to userspace.

You can have 24 binary files if that makes it easier, but the existing
format really is an abuse of sysfs.

Or use securityfs, that's fine too, but as you say, you have to write
more code for that.

thanks,

greg k-h
