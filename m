Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4513339DA5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Mar 2021 11:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbhCMKpV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Mar 2021 05:45:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhCMKpV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Mar 2021 05:45:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B10564F1B;
        Sat, 13 Mar 2021 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615632320;
        bh=Uhy5dEacUbBiUn386NQTz78v2sd2V04Ad12yd4wbvEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ay6p0+ZYtwNhEep6crBrqspBKNqkh0R9ePYUUtSgJ0efW6xUMKbuV8OacPEQsDkri
         BGLK8OMxihBxTZcsRZTgoyIxB/6v0oWjK+wiSsZ3hL0BJMnGnR6azUP9rZYSwv9L4m
         Ho6volvT38PYrLAFj+mqc0ODICyuKXo+zSadMS04F0CRUB8XBnkO5vboCLB2i00hCp
         RtuTx2Ppus8u7VYor+EGBOC9svjuC9KZKxcsMi0xRKQofkVtMwKoeqPOVNinDVnnCp
         pXzTVWazbBSKI4L6rf6ZR9GVd34/f0dZVSjcloa6uB7cD81woJ/17telQJjEU/atF7
         bAgIGf8ISYd4Q==
Date:   Sat, 13 Mar 2021 12:44:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <jejb@linux.ibm.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
Message-ID: <YEyXpwilJq8DR7vI@kernel.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
 <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
 <YEEANW+khw3nJtcQ@kernel.org>
 <CAFA6WYOxsYin8wBB_yU=S-bnqM-g5TFnTU_KXxc3wSBfx_N_6A@mail.gmail.com>
 <YEkkXbWrYBTcGXEd@kernel.org>
 <9aa3173ab46b0aa7edb8146ffd3df05c1f74207e.camel@linux.ibm.com>
 <YEuWTet0wr5DuDy/@kernel.org>
 <5dfe8f6b5f25cc38c8410b849aaef2c3dbed7f65.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dfe8f6b5f25cc38c8410b849aaef2c3dbed7f65.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 12, 2021 at 08:30:36AM -0800, James Bottomley wrote:
> On Fri, 2021-03-12 at 18:26 +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 10, 2021 at 02:26:27PM -0800, James Bottomley wrote:
> > > On Wed, 2021-03-10 at 21:56 +0200, Jarkko Sakkinen wrote:
> > > [...]
> > > > I also need to apply 
> > > > 
> > > > https://lore.kernel.org/linux-integrity/20210127190617.17564-1-James.Bottomley@HansenPartnership.com/
> > > > 
> > > > and I would like to do both while I'm at it.
> > > > 
> > > > James, there was one patch that needed fixing but I cannot find
> > > > lore.kernel.org link. Can you point me to that so that we
> > > > can proceed?
> > > 
> > > I think you mean this one observing a missing space in the commit
> > > message:
> > > 
> > > https://lore.kernel.org/keyrings/1327393.1612972717@warthog.procyon.org.uk/
> > > 
> > > James
> > 
> > Makefile needed fixing (separate lines), and spaces where missing
> > between
> > commas in one file (checkpatch complained).
> > 
> > I digged a version from my reflog but as I noted privately it's
> > missing one
> > file.
> > 
> > Either provide that file or send a new version of the full patch set.
> 
> This is the file that got lost
> 
> James
> 

> ---
> --- ASN.1 for TPM 2.0 keys
> ---
> 
> TPMKey ::= SEQUENCE {
> 	type		OBJECT IDENTIFIER ({tpm2_key_type}),
> 	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> 	parent		INTEGER ({tpm2_key_parent}),
> 	pubkey		OCTET STRING ({tpm2_key_pub}),
> 	privkey		OCTET STRING ({tpm2_key_priv})
> 	}

Thanks, NP, I amended the commit.

/Jarkko


/Jarkko
