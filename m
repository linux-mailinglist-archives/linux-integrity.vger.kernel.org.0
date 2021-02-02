Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9567030BE56
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhBBMhi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 07:37:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50761 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhBBMhd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 07:37:33 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6ust-0007Jm-15; Tue, 02 Feb 2021 13:34:19 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6usr-0001nH-QE; Tue, 02 Feb 2021 13:34:17 +0100
Message-ID: <2012751fd653c284679aa2c6ac9a56a5edbf1410.camel@pengutronix.de>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>, kernel@pengutronix.de
Date:   Tue, 02 Feb 2021 13:34:17 +0100
In-Reply-To: <CAFA6WYMn519aF=uodjnSUZ+kKaRzdoh6Enu0OsRMge=21iBNBA@mail.gmail.com>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
         <CAFA6WYMn519aF=uodjnSUZ+kKaRzdoh6Enu0OsRMge=21iBNBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-02-02 at 17:45 +0530, Sumit Garg wrote:
> Hi Jan,
> 
> On Sun, 31 Jan 2021 at 23:40, James Bottomley <jejb@linux.ibm.com> wrote:
> > 
> > On Sun, 2021-01-31 at 15:14 +0100, Jan Lübbe wrote:
> > > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > > > On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > > > > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > I've been looking into how a migration to using
> > > > > > trusted/encrypted keys would look like (particularly with dm-
> > > > > > crypt).
> > > > > > 
> > > > > > Currently, it seems the the only way is to re-encrypt the
> > > > > > partitions because trusted/encrypted keys always generate their
> > > > > > payloads from RNG.
> > > > > > 
> > > > > > If instead there was a key command to initialize a new
> > > > > > trusted/encrypted key with a user provided value, users could
> > > > > > use whatever mechanism they used beforehand to get a plaintext
> > > > > > key and use that to initialize a new trusted/encrypted key.
> > > > > > From there on, the key will be like any other trusted/encrypted
> > > > > > key and not be disclosed again to userspace.
> > > > > > 
> > > > > > What are your thoughts on this? Would an API like
> > > > > > 
> > > > > >   keyctl add trusted dmcrypt-key 'set <content>' # user-
> > > > > > supplied content
> > > > > > 
> > > > > > be acceptable?
> > > > > 
> > > > > Maybe it's the lack of knowledge with dm-crypt, but why this
> > > > > would be useful? Just want to understand the bottleneck, that's
> > > > > all.
> > > 
> > > Our goal in this case is to move away from having the dm-crypt key
> > > material accessible to user-space on embedded devices. For an
> > > existing dm-crypt volume, this key is fixed. A key can be loaded into
> > > user key type and used by dm-crypt (cryptsetup can already do it this
> > > way). But at this point, you can still do 'keyctl read' on that key,
> > > exposing the key material to user space.
> > > 
> > > Currently, with both encrypted and trusted keys, you can only
> > > generate new random keys, not import existing key material.
> > > 
> > > James Bottomley mentioned in the other reply that the key format will
> > > become compatible with the openssl_tpm2_engine, which would provide a
> > > workaround. This wouldn't work with OP-TEE-based trusted keys (see
> > > Sumit Garg's series), though.
> > 
> > Assuming OP-TEE has the same use model as the TPM, someone will
> > eventually realise the need for interoperable key formats between key
> > consumers and then it will work in the same way once the kernel gets
> > updated to speak whatever format they come up with.
> 
> IIUC, James re-work for TPM trusted keys is to allow loading of sealed
> trusted keys directly via user-space (with proper authorization) into
> the kernel keyring.
> 
> I think similar should be achievable with OP-TEE (via extending pseudo
> TA [1]) as well to allow restricted user-space access (with proper
> authorization) to generate sealed trusted key blob that should be
> interoperable with the kernel. Currently OP-TEE exposes trusted key
> interfaces for kernel users only.

What is the security benefit of having the key blob creation in user-space
instead of in the kernel? Key import is a standard operation in HSMs or PKCS#11
tokens.

I mainly see the downside of having to add another API to access the underlying
functionality (be it trusted key TA or the NXP CAAM HW *) and requiring
platform-specific userspace code.

This CAAM specific API (in out-of-tree patches) was exactly the part I was
trying to get rid of. ;)

Regards,
Jan

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

