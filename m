Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D42627FF
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Sep 2020 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIIHHX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Sep 2020 03:07:23 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:34915 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725863AbgIIHHX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Sep 2020 03:07:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DF22C9C4;
        Wed,  9 Sep 2020 03:07:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Sep 2020 03:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=D+K42dGY4mJ+XfwGsoIiELdV9Ku
        H2LhoUP8m42K12q0=; b=E+bYY3r6QX+yb9I01hy8EHSqQsNxxNurRCRw2pF+Pn7
        1goELCV6t8+ZnQtaXd3c6c/7Ho1pO8GQAS8Bcq8HkAccnujEcZLlNxEIftJThy1e
        L5akYi5QqWCq6evphzDHMcGEhNNohWmMo5qHO3z3IpJK1q7KzPjICoBgTjEmoRrE
        xX/8ZDo4sLANTekydSjMpYosptkHiHYENo8hM7SXs+/AbwJq7/zI3hp4KPcf2XMO
        X/SOenUaS0m/iHWGV73jdKNNdEGhZ0BuoTEx3M74TS75j474gVboW0OvOUkm0bEm
        r9+WJFJbMIctFt1eMPIo8f6z3JhVN84xTeYj1mZGQ8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=D+K42d
        GY4mJ+XfwGsoIiELdV9KuH2LhoUP8m42K12q0=; b=q9zKpoqqCkKO+6vrfnhXxn
        tMvRal581RPBIGTMqKsGBdugxmIxt6DOkxhr0MYr9S7P0/o2yrDfQxqYK4GWIvU8
        FCK2f/vXuv/ip3mEQEy4qvMiz3g98cv5LtTk9Exp9yWP94dwwPIlmjv8fUKXHhRi
        yyDB0WHyuqSgkTiWGQ4o8hsefnO9fM0lff0N0B1g2OZzfllb+0BX/B6WXRn6KE3A
        OvYJ7D87UdzXlFE4+EalFBlY4q6uzweMYyMI8UHg3x4f72PmoQenhDnLlQfiaM/R
        OmBA0mrx0RrDLFaCRu3mMlUMjKS9L7k8qNU0wxEzat4BA/Uc0vS5rdajEPoCFZ1A
        ==
X-ME-Sender: <xms:KX9YX2MYaH64L6_I46jAJxPXHP2OctzHsMRr1KiRwIXB-7GnkJ8FBw>
    <xme:KX9YX09wdfXwrwM1GDmnurhdtQ10C4pXpe_5kNSqB910SDdQt4b2WQnG5Ur9ZqvrP
    4X9LsJM0bd5Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:KX9YX9QjHAjx0DU5nqo7p4KJTMNwETZS2JioMrpqPd6y6t_A4HkyzA>
    <xmx:KX9YX2slf-DzUYQJkBXxmSp17zsJw4hSj_rxw1edVTHqMWFTChSmuw>
    <xmx:KX9YX-fUqFa4vlajHOY0H8qXu1L2VpCf7ZHSsbVD6Tm6yTl886tjiQ>
    <xmx:KX9YX_r3LAM9pJSjhyQhnNPCZqXLyDua7q4RooYZhenSRWAYrgHlXQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE40F3064882;
        Wed,  9 Sep 2020 03:07:20 -0400 (EDT)
Date:   Wed, 9 Sep 2020 09:07:29 +0200
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 0/1] add sysfs exports for TPM 2 PCR registers
Message-ID: <20200909070729.GD311356@kroah.com>
References: <20200906203245.18429-1-James.Bottomley@HansenPartnership.com>
 <20200907053824.GA279469@kroah.com>
 <20200907132322.GB106839@linux.intel.com>
 <1599515528.4232.55.camel@HansenPartnership.com>
 <20200908054552.GB303404@kroah.com>
 <20200908180513.GB5390@linux.intel.com>
 <1599588851.10803.29.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599588851.10803.29.camel@HansenPartnership.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 08, 2020 at 11:14:11AM -0700, James Bottomley wrote:
> On Tue, 2020-09-08 at 21:05 +0300, Jarkko Sakkinen wrote:
> > On Tue, Sep 08, 2020 at 07:45:52AM +0200, Greg KH wrote:
> > > On Mon, Sep 07, 2020 at 02:52:08PM -0700, James Bottomley wrote:
> [...]
> > > > I've got to say I think binary attributes are actively evil.  I
> > > > can see
> > > > they're a necessity when there's no good way to represent the
> > > > data they
> > > > contain, like the bios measurement log or firmware code or a raw
> > > > interface like we do for the SMP frame code in libsas.  But when
> > > > there's a well understood and easy to produce user friendly non-
> > > > binary
> > > > representation, I think dumping binary is inimical to being a
> > > > good API.
> > > 
> > > Agreed.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Looking at the patch, something like <device>/pcrs/<hash>/<index>
> > would be a bit cleaner representation than the current <device>/pcrs-
> > <hash>/<index>.
> 
> That's actually a technical limitation of using the current attribute
> groups API: It's designed to support single level directories in sysfs
> (or no directory at all).  That's not to say we can't do multi-level
> ones, but if we do we have to roll our own machinery for managing the
> files rather than relying on the groups API.

Agreed, do NOT do multi-level attribute groups please, userspace tools
will not handle them well, if at all.

> Given that the current groups API does all the nasty lifetime
> management that I'd otherwise have to do in the patch, I have a strong
> incentive for keeping it, which is why the single <device>/pcrs-
> <hash>/<index> format.

Agreed.

thanks,

greg k-h
