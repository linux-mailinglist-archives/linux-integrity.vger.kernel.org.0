Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0731CE21
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Feb 2021 17:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBPQfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Feb 2021 11:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhBPQfk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Feb 2021 11:35:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842BB64E09;
        Tue, 16 Feb 2021 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613493300;
        bh=ozjE98t3PZ9vMax3kmhOnPl92y2ymIw8L1N3IjQIiio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOTFtbiPe7sciAwL2NYe2uTTyekDCUyKMV6aEgTB+fOMSN1Nh5TcTEV6F+ctX9Uwo
         vlK4qxmrmxx4En7yu4ata7Dmef/oKcmiNdB3pV7jKwYjsRGKt4ppAF3M2MfF3J9xZ/
         pcv5TqOjwXClQxmzRdmAMGxsUyM/qky2cbIyaJgbXINJZ0K4u6T1fc+loiJBwzEMoe
         Riavu5QX3SbzBwOjzzBTujDoEmkwkM9NzTLLjPFiqeRUB78ms517mMk+7PQZrUrBMN
         SciQynNgJwbrhb3ZuzU5MmRC1NdWxs0XNaW0O0DypieH2jGWYMnA9YEKyMwKtRLXpw
         UWdjhdwazpZrg==
Date:   Tue, 16 Feb 2021 18:34:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <YCv0KFIdtmG8F1kT@kernel.org>
References: <20210216081750.191250-1-jarkko@kernel.org>
 <ccb8ff69-5223-c293-bdda-46f041b7b770@debian.org>
 <YCvv9wvj4jUIKpa7@kernel.org>
 <YCvyS6eVjZCKMAyJ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YCvyS6eVjZCKMAyJ@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 16, 2021 at 06:26:54PM +0200, Jarkko Sakkinen wrote:
> On Tue, Feb 16, 2021 at 06:16:58PM +0200, Jarkko Sakkinen wrote:
> > On Tue, Feb 16, 2021 at 12:02:24PM +0100, Laurent Bigonville wrote:
> > > Le 16/02/21 à 09:17, Jarkko Sakkinen a écrit :
> > > > From: Lukasz Majczak <lma@semihalf.com>
> > > > 
> > > > This is shown with Samsung Chromebook Pro (Caroline) with TPM 1.2
> > > > (SLB 9670):
> > > > 
> > > > [    4.324298] TPM returned invalid status
> > > > [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> > > > 
> > > > Background
> > > > ==========
> > > > 
> > > > TCG PC Client Platform TPM Profile (PTP) Specification, paragraph 6.1 FIFO
> > > > Interface Locality Usage per Register, Table 39 Register Behavior Based on
> > > > Locality Setting for FIFO - a read attempt to TPM_STS_x Registers returns
> > > > 0xFF in case of lack of locality. The described situation manifests itself
> > > > with the following warning trace:
> > > > 
> > > > The fix
> > > > =======
> > > > 
> > > > Add the proper decorations to tpm_tis_gen_interrupt() and
> > > > tpm_get_timeouts().
> > > 
> > > I tried that patch (alone on the top of the HEAD of Linus master) and I
> > > still get the same trace in dmesg
> > 
> > Can you give a shot to
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > 
> > It has couple of more fixes, and paste the log.
> 
> And if possible a full stack trace :-)

And apply this patch on top. Cannot apply it there before it's reviewed.

/Jarkko
