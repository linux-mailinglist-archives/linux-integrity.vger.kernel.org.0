Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DCC260A48
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Sep 2020 07:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgIHFqA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Sep 2020 01:46:00 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48483 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728654AbgIHFp6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Sep 2020 01:45:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0C862C36;
        Tue,  8 Sep 2020 01:45:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 08 Sep 2020 01:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=RzbxhO67ICGW54veN9IStE7J1Fe
        6Y49VyElbXUI/WAo=; b=oLovFA1ZNAEJpmSDjERuiGz6k6LPoHCMY320kjciCcz
        Mp6clqpgRaUo0+ET1nWFmZnnUuMpc+s3+c34BRcrsU4RgrFtzXTAqV+oVU+UamtH
        R0q3O6tEV9jY6hMjdG9PAWljUZl7B9cCQJTjcqay93apJ8el3cySN5Wxz5u4ub1g
        bsxWMzyHLNJPQno7uS+fCYHnF03qR4gOLb1Zz1ixWHd1nmB2Bo2WVz5FrAPBchAo
        oEsp2grqnpCnCCoT+ZW0a5WqoH5cNbsBFizLbq8IfXvtROaNsIAZFSQuULWD8SjC
        aCRKGKkcE6YdWtAismauwQ+eJrDZTdMm+QoDkhlrj8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RzbxhO
        67ICGW54veN9IStE7J1Fe6Y49VyElbXUI/WAo=; b=Sq9Cnzr+aam6wymjI/S9/O
        GPcj02LrX8poR8H4BXk0InXmJJb68h5rZO0eUSRjMEtqnJA5uWLz2LDp/MvyOtaK
        Cnrjdvy7ONqPb12Wad6/x2yqE7nYZNzuQUG+XzO5TJ7GkEYZ5OA2iej8i/dFvmTa
        VFSleyp1OJVHprV3XELuROh/Z3JmUIL32KAqErITKYc1GAjYOY+yL9D+aU4iUDGq
        V1DHHY5L0MM9LrzEbs0VK22DFzrcWfcRqc0I2GMLyUwg3n2//XCFLde87w2lZ0kW
        /xpmMkv5P3Kz5EX57jyBzERVappR/gm02g8gj7MJEliRKGAaqtPyLxx8fBr+hj1g
        ==
X-ME-Sender: <xms:lBpXX6aWSRXWZjx0L8X3ZVuCF_K3l1UNeLc9Tj42nY1-C8DOt_G6MQ>
    <xme:lBpXX9ZkrEoRD9cZ_xX6kDVuMAxdM6NgA7cfpHQZv6zJxmDrDlX-Rnx9beacCnrPE
    IhHFpD-SqnMSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:lBpXX0-Lpy7BlHDVMiSAMDXsestTtAZUV4_Qa7vVrdEPrzshiKGoIQ>
    <xmx:lBpXX8q2NpjYIlSvEHon8hcdpsZcQnEmZeiFk39ONgJX7nto7_mzQQ>
    <xmx:lBpXX1oUAeK_cM3izGi1f0rf8bds8nEV0PogwD2JM_tBbGprq3rKhw>
    <xmx:lBpXX82SlGGux2yC8_ALTS0uixQ7IFB9qFr89IcFZ1n6WaVi2cNYoQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB0493064610;
        Tue,  8 Sep 2020 01:45:55 -0400 (EDT)
Date:   Tue, 8 Sep 2020 07:45:52 +0200
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200908054552.GB303404@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
 <1599515528.4232.55.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599515528.4232.55.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
> On Mon, 2020-09-07 at 16:23 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 07, 2020 at 07:38:24AM +0200, Greg KH wrote:
> > > Please just use a binary blob format.  Binary sysfs files are
> > > exactly what this is for, you are just passing the data through the
> > > kernel from the hardware to userspace.
> > > 
> > > You can have 24 binary files if that makes it easier, but the
> > > existing format really is an abuse of sysfs.
> 
> There is no existing format for TPM 2.0 ... that's part of the problem
> since we certainly didn't want to carry over the TPM 1.2 format.

Ok, then no, if there is not already a binary format then you should not
use a binary sysfs file as you are then just sending a kernel structure
to userspace, not a hardware structure.

> I've got to say I think binary attributes are actively evil.  I can see
> they're a necessity when there's no good way to represent the data they
> contain, like the bios measurement log or firmware code or a raw
> interface like we do for the SMP frame code in libsas.  But when
> there's a well understood and easy to produce user friendly non-binary
> representation, I think dumping binary is inimical to being a good API.

Agreed.

thanks,

greg k-h
