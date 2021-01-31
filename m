Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBDE309D86
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhAaPYy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 10:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbhAaOO5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 09:14:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD16CC06174A
        for <linux-integrity@vger.kernel.org>; Sun, 31 Jan 2021 06:14:15 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6DUK-0003wo-6u; Sun, 31 Jan 2021 15:14:04 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6DUJ-0004cG-5y; Sun, 31 Jan 2021 15:14:03 +0100
Message-ID: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Sun, 31 Jan 2021 15:14:02 +0100
In-Reply-To: <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: jlu@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > Hello,
> > > 
> > > I've been looking into how a migration to using trusted/encrypted keys
> > > would look like (particularly with dm-crypt).
> > > 
> > > Currently, it seems the the only way is to re-encrypt the partitions
> > > because trusted/encrypted keys always generate their payloads from
> > > RNG.
> > > 
> > > If instead there was a key command to initialize a new trusted/encrypted
> > > key with a user provided value, users could use whatever mechanism they
> > > used beforehand to get a plaintext key and use that to initialize a new
> > > trusted/encrypted key. From there on, the key will be like any other
> > > trusted/encrypted key and not be disclosed again to userspace.
> > > 
> > > What are your thoughts on this? Would an API like
> > > 
> > >   keyctl add trusted dmcrypt-key 'set <content>' # user-supplied content
> > > 
> > > be acceptable?
> > 
> > Maybe it's the lack of knowledge with dm-crypt, but why this would be
> > useful? Just want to understand the bottleneck, that's all.

Our goal in this case is to move away from having the dm-crypt key material
accessible to user-space on embedded devices. For an existing dm-crypt volume,
this key is fixed. A key can be loaded into user key type and used by dm-crypt
(cryptsetup can already do it this way). But at this point, you can still do
'keyctl read' on that key, exposing the key material to user space.

Currently, with both encrypted and trusted keys, you can only generate new
random keys, not import existing key material. 

James Bottomley mentioned in the other reply that the key format will become
compatible with the openssl_tpm2_engine, which would provide a workaround. This
wouldn't work with OP-TEE-based trusted keys (see Sumit Garg's series), though.

> We upstreamed "trusted" & "encrypted" keys together in order to address
> this sort of problem.   Instead of directly using a "trusted" key for
> persistent file signatures being stored as xattrs, the "encrypted" key
> provides one level of indirection.   The "encrypted" key may be
> encrypted/decrypted with either a TPM based "trusted" key or with a
> "user" type symmetric key[1].
> 
> Instead of modifying "trusted" keys, use a "user" type "encrypted" key.

I don't see how this would help. When using dm-crypt with an encrypted key, I
can't use my existing key material.

Except for the migration aspect, trusted keys seem ideal. Only a single exported
blob needs to be stored and can only be loaded/used again on the same (trusted)
system. Userspace cannot extract the key material. 

To get to this point on systems in the field without re-encryption of the whole
storage, only the initial trusted/encrypted key creation would need to allow
passing in existing key material.

> Mimi
> 
> [1] The ima-evm-utils README contains EVM examples of "trusted" and
> "user" based "encrypted" keys.

I assume you refer to
https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/README#l143
"Generate EVM encrypted keys" and "Generate EVM trusted keys (TPM based)"?

In both cases, the key used by EVM is a *newly generated* random key. The only
difference is whether it's encrypted to a user key or a (random) trusted key.

Best regards
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

