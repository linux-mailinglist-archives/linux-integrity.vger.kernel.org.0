Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703F1D5CBB
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2020 01:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgEOXXM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 19:23:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55706 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgEOXXM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 19:23:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8BA9C8EE2CA;
        Fri, 15 May 2020 16:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589584991;
        bh=ymkONZXFvhdNnpPtY8Q0bGiYA4GZZsgJujtY6WG/iM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ua90IXccRPjdyWtWuPrTnTGBZSrdXEXTzOZQKTMES3saTNghba2ihkHxW7e1tOM/z
         0ip+DGhvx3PdZN98a0vF56oMR8TRrhTxA2I4lvxR6mf5RMEYqlPLv5jPs/0bd0qijG
         zhgtTS/rnBYMSw/ZGX9eLJBWgEXSR/k+z6Jfijxc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vQ3AgkwYdWPD; Fri, 15 May 2020 16:23:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DACB98EE25D;
        Fri, 15 May 2020 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589584991;
        bh=ymkONZXFvhdNnpPtY8Q0bGiYA4GZZsgJujtY6WG/iM8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ua90IXccRPjdyWtWuPrTnTGBZSrdXEXTzOZQKTMES3saTNghba2ihkHxW7e1tOM/z
         0ip+DGhvx3PdZN98a0vF56oMR8TRrhTxA2I4lvxR6mf5RMEYqlPLv5jPs/0bd0qijG
         zhgtTS/rnBYMSw/ZGX9eLJBWgEXSR/k+z6Jfijxc=
Message-ID: <1589584989.30847.20.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Fri, 15 May 2020 16:23:09 -0700
In-Reply-To: <1589581169.30847.5.camel@HansenPartnership.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
         <1589514263.5759.25.camel@HansenPartnership.com>
         <20200515084702.GA3404@linux.intel.com>
         <20200515191758.ieojyk5xhsx2hzzd@cantor>
         <1589571278.3653.22.camel@HansenPartnership.com>
         <1589573417.3653.28.camel@HansenPartnership.com>
         <56688CD4-A4A5-4D98-8724-6CBA10C7E1CE@unh.edu>
         <1589581169.30847.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 15:19 -0700, James Bottomley wrote:
> On Fri, 2020-05-15 at 21:03 +0000, Kayaalp, Mehmet wrote:
> > > On May 15, 2020, at 4:10 PM, James Bottomley <James.Bottomley@han
> > > se
> > > npartnership.com> wrote:
> > > 
> > > I think that means the solution is not to run the smoke test
> > > under sudo but to do sudo -s and then run it.
> > > 
> > > James
> > 
> > How about "sudo -i":
> > 
> > https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-
> > bin-bash-when-does-it-matter-which-is-used
> 
> Actually, no that doesn't work either:
> 
> jejb@testdeb> sudo -i keyctl list @s
> 1 key in keyring:
> 1041514063: ---lswrv  1000 65534 keyring: _uid.1000
> 
> I suspect this might be a very subtle bug to do with when you get a
> new session keyring.

It turns out to be incredibly subtle, but I'm not sure if it's a bug or
not.  the util-linux sudo like commands have special pam profiles

/etc/pam.d/su-l 
/etc/pam.d/runuser-l

These special profiles call pam_keyinit.so with flags to install a new
session keyring.  sudo doesn't have this, so it never, on its own, even
when called with -i or -s, installs a new session keyring. This does
strike me as a bizarre oversight which leads directly to this weird
keyctl pipe behaviour.

I'm also not sure the keyctl pipe behaviour is correct: why should
keyctl pipe deny access to root to read a key just because it's in a
different session keyring?  It defintely seems intentional, because if
I create a key as a non root user and try to print it by id as root I
get EPERM.

The weirdest behaviour, though seems to be keyctl:  keyctl add ... @u
will add to the session keyrings of the actual uid regardless of what
session keyring the creator actually has, which is why keyctl add ...
@u works under sudo but you get EPERM back trying to pipe it by id.
 
James

