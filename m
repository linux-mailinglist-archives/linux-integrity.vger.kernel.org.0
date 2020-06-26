Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511CC20B3AA
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgFZOgf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 10:36:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51438 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgFZOgf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 10:36:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B3E678EE25D;
        Fri, 26 Jun 2020 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593182193;
        bh=NNjSYoJa2E2i2KfOg27iengig6S5FbChi0NfMaOraSU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pz4gvXViKqgsBhUOpwcoswSq9g2Wy155Sl/4/GJYyxLPgoNX3WPtS59KK6lfx6kW5
         X7hAN9psYUkRi19Jr6M+imH1uh08NoR9TfiqMWzhZgtEAcKtSZuKOUAZ54BQNMKNyl
         bBBj87WHJfEbfnIXcTl3CetdmtqqmLOeD3FbkLGc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dGrBzAFreGIx; Fri, 26 Jun 2020 07:36:33 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C863D8EE051;
        Fri, 26 Jun 2020 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1593182193;
        bh=NNjSYoJa2E2i2KfOg27iengig6S5FbChi0NfMaOraSU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pz4gvXViKqgsBhUOpwcoswSq9g2Wy155Sl/4/GJYyxLPgoNX3WPtS59KK6lfx6kW5
         X7hAN9psYUkRi19Jr6M+imH1uh08NoR9TfiqMWzhZgtEAcKtSZuKOUAZ54BQNMKNyl
         bBBj87WHJfEbfnIXcTl3CetdmtqqmLOeD3FbkLGc=
Message-ID: <1593182191.7381.11.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Jun 2020 07:36:31 -0700
In-Reply-To: <20200626131523.GB7853@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
         <20200625062150.idm6j3vm2neyt4sh@cantor>
         <20200625210202.GA20341@linux.intel.com>
         <20200625211923.2jirvix6zbrbgj6e@cantor>
         <1593120239.3332.17.camel@HansenPartnership.com>
         <20200626131523.GB7853@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-26 at 16:15 +0300, Jarkko Sakkinen wrote:
> I have an obstacle with that.
> 
> I lost my previous PGP key a year ago and created a new one, which is
> not trusted yet by anyone [*]. I've backed this up now and have it
> stored inside Nitrokey Pro 2 in order to prevent this happening
> again.

I wouldn't do that.  If the nitro key gets lost or breaks, you'll be in
the same position.  Best practice is to have your key offline somewhere
in a secure vault (like an encrypted USB key in a bank vault) so you
can restore in case of loss and then present inside a token (so I use
the TPM2 for mine).

> Now the problem is that in order to get a kernel.org account, I need
> to be in the web of trust of the kernel maintainers.
> 
> I can request an accunt only after I see face to face another kernel
> maintainers, so that I can proof that I am I.
> 
> [*] http://keys.gnupg.net/pks/lookup?op=get&search=0x3AB05486C7752FE1

Well, I would sign this and send it back to you, except I can't.  The
verification procedures require an encrypted email and you don't have a
working encryption key:

gpg --export -a 3AB05486C7752FE1 | gpg --encrypt -r 3AB05486C7752FE1 -a --output 3AB05486C7752FE1.gpg 
gpg: 3AB05486C7752FE1: skipped: Unusable public key
gpg: [stdin]: encryption failed: Unusable public key

The reason is your main key is certification only (as is should be):

pub  rsa4096/3AB05486C7752FE1
     created: 2019-06-24  expires: 2023-06-24  usage: C   
     trust: unknown       validity: full

but your only encryption subkey is revoked:

sub  rsa2048/3A4EC6E56FDD3158
     created: 2019-06-25  revoked: 2019-10-22  usage: E   

You seem to have only one unrevoked, unexpired subkey which is an
authentication one, so you wouldn't even be able to sign with that key:

sub  rsa2048/962F0565523E5DC5
     created: 2019-06-26  expires: 2021-06-25  usage: A   

James

