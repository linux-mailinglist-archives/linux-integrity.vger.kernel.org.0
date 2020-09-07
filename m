Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83D3260233
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Sep 2020 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgIGNrr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Sep 2020 09:47:47 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:52233 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729666AbgIGNrh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:37 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2BF3160C;
        Mon,  7 Sep 2020 09:36:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Sep 2020 09:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=dK41NMPYg6hwFg/2puosTJfcGSF
        TVcf3K/ccUSnYXxY=; b=nyBopx3J9A/4Yia7oSzLKfpL7eCaylJmj1PNC3r6qsj
        gyKycyHIA3S0ZBScPLhPjbNsS8BQrlBOAyUqGizCZ3kCU6OyYxy2nOytZeOWK6Ut
        bBgQYMGSV9nWyLRI1iesQHm3HlyFbmXiDfvw+bKFc8VJ1lC9RNzyQEPW+RBSco6J
        KAMFcFUG+HRPVdmMj7ymyK1/NhcWc6yjRnvN8SUeyVl03rvqd1OWCbEStUvnlv/t
        eR6CMabTLfOMB7An9L3UGbFtQU1i46thSaHK5Cnv7zYf30Sn7VY2wqkCJ6KXr2iz
        MF1Eql4foXDZDL9W0UAaOn7NZqR4WjZ8yYC4tEuqS0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dK41NM
        PYg6hwFg/2puosTJfcGSFTVcf3K/ccUSnYXxY=; b=PDf0mhD646jHV6yFjnsRIl
        WzDygkPnUoUbmaDj7SMc26NztPA0CNLGHWjBEYJ1Hhkx/aPEATCFOdExcmFRQR3u
        ucT7LMl+3XDpuZ01xJNNVmhDiT6Sw4dSGGZkLqv1XNF8/Z0d5wB4Ij8gk+1QAmlX
        9B1QvmNp7/QDr04E9QV7A45MiPpg2tZPdpnep/6VYH3YSfNzXBcKNkEf/PwvltwT
        ChQYe/WoBarmm8gmUI7gq4qOHCdigK8BPCuF4i9kemo/CerG71zY4maM+ZxTkiKA
        LB4myuE13r1ggI0aKPcrTMb4ANN+bYVLpsQ2mED3z16W1P03h/Lwxu3/00fazyig
        ==
X-ME-Sender: <xms:YjdWX4yQixl0PbVG-bErTnFnGr6jlmZS5myfzC2Eb3sY8yrOi5wAAg>
    <xme:YjdWX8RvUDX2amk7i3hC7rJiVbYI-HhovfsA7oiGyFUEOzaMFQTTXyugb5_hlAbZZ
    gKQ6Q16ZWVSzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:YjdWX6UGuu-iujTDIQlcS9jkiN7OQqTMBEdh_oF-IIXC4cax3y0ciQ>
    <xmx:YjdWX2h-LK8ROdICENh-H9z9x4cLcGzec264kOwCQ3tuMW0p8_ySRw>
    <xmx:YjdWX6AGp4M1p582cDyLASM1FqkkbPXLa2GAmBh0Oa85LJMOq7wvEw>
    <xmx:YjdWX9NHkMdpwEy_OAD-hRckyQk5MYTVkbvaHM90zuXRylgQm64GYA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id E50473064674;
        Mon,  7 Sep 2020 09:36:33 -0400 (EDT)
Date:   Mon, 7 Sep 2020 15:36:46 +0200
From:   Greg KH <greg@kroah.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200907133646.GA2779642@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907132322.GB106839@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 07, 2020 at 04:23:22PM +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 07, 2020 at 07:38:24AM +0200, Greg KH wrote:
> > Please just use a binary blob format.  Binary sysfs files are exactly
> > what this is for, you are just passing the data through the kernel from
> > the hardware to userspace.
> > 
> > You can have 24 binary files if that makes it easier, but the existing
> > format really is an abuse of sysfs.
> > 
> > Or use securityfs, that's fine too, but as you say, you have to write
> > more code for that.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I suggested this in previous round: to have a single 'pcrs' binary file
> with <TPM Alg ID, blob> pairs contained.

That's fine with me!
