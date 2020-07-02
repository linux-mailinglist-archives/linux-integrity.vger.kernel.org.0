Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCC921302D
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2020 01:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgGBXiE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 19:38:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:33560 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGBXiD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 19:38:03 -0400
IronPort-SDR: S0AIupqzL8nxKzYPY53Dn0t/m4wCQbhPHJQxaAqB5F341RMT7JuDZ4oaqR5njDA3FpSgGUTCQ8
 JRQ+KMP5EQjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="135335469"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="135335469"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 16:38:02 -0700
IronPort-SDR: LJWYTOoaVrb5gF3AIH7M0RIJACBJ6Vee08zUmwwPnv7riK830nwZ8pmisBU7tYKDDjHu0Bhh5i
 a1q3MozBsM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; 
   d="scan'208";a="267205219"
Received: from chadjitt-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.41.125])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jul 2020 16:37:58 -0700
Date:   Fri, 3 Jul 2020 02:37:57 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        "Ferry Toth :" <ferry.toth@elsinga.info>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@osdl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm_tis: Remove the HID IFX0102
Message-ID: <20200702233757.GG31291@linux.intel.com>
References: <20200625023111.270458-1-jarkko.sakkinen@linux.intel.com>
 <20200625062150.idm6j3vm2neyt4sh@cantor>
 <20200625210202.GA20341@linux.intel.com>
 <20200625211923.2jirvix6zbrbgj6e@cantor>
 <1593120239.3332.17.camel@HansenPartnership.com>
 <20200626131523.GB7853@linux.intel.com>
 <1593182191.7381.11.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593182191.7381.11.camel@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 26, 2020 at 07:36:31AM -0700, James Bottomley wrote:
> On Fri, 2020-06-26 at 16:15 +0300, Jarkko Sakkinen wrote:
> > I have an obstacle with that.
> > 
> > I lost my previous PGP key a year ago and created a new one, which is
> > not trusted yet by anyone [*]. I've backed this up now and have it
> > stored inside Nitrokey Pro 2 in order to prevent this happening
> > again.
> 
> I wouldn't do that.  If the nitro key gets lost or breaks, you'll be in
> the same position.  Best practice is to have your key offline somewhere
> in a secure vault (like an encrypted USB key in a bank vault) so you
> can restore in case of loss and then present inside a token (so I use
> the TPM2 for mine).

I have a backup too.

> 
> > Now the problem is that in order to get a kernel.org account, I need
> > to be in the web of trust of the kernel maintainers.
> > 
> > I can request an accunt only after I see face to face another kernel
> > maintainers, so that I can proof that I am I.
> > 
> > [*] http://keys.gnupg.net/pks/lookup?op=get&search=0x3AB05486C7752FE1
> 
> Well, I would sign this and send it back to you, except I can't.  The
> verification procedures require an encrypted email and you don't have a
> working encryption key:
> 
> gpg --export -a 3AB05486C7752FE1 | gpg --encrypt -r 3AB05486C7752FE1 -a --output 3AB05486C7752FE1.gpg 
> gpg: 3AB05486C7752FE1: skipped: Unusable public key
> gpg: [stdin]: encryption failed: Unusable public key
> 
> The reason is your main key is certification only (as is should be):
> 
> pub  rsa4096/3AB05486C7752FE1
>      created: 2019-06-24  expires: 2023-06-24  usage: C   
>      trust: unknown       validity: full
> 
> but your only encryption subkey is revoked:
> 
> sub  rsa2048/3A4EC6E56FDD3158
>      created: 2019-06-25  revoked: 2019-10-22  usage: E   
> 
> You seem to have only one unrevoked, unexpired subkey which is an
> authentication one, so you wouldn't even be able to sign with that key:
> 
> sub  rsa2048/962F0565523E5DC5
>      created: 2019-06-26  expires: 2021-06-25  usage: A   
> 
> James
> 

pub   rsa4096 2019-06-24 [C] [expires: 2023-06-24]
      5107E66D34788A93E3227C903AB05486C7752FE1
      uid           [ultimate] Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
      uid           [ultimate] Jarkko Sakkinen
      <jarkko.sakkinen@linux.intel.com>
      sub   ed25519 2019-06-25 [S] [expires: 2021-06-24]
      sub   rsa2048 2019-06-26 [A] [expires: 2021-06-25]

There's also a signing key.

/Jarkko
