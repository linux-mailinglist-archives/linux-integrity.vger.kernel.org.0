Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6B313560
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhBHOjy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 09:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbhBHOjg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 09:39:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CF1C06178A
        for <linux-integrity@vger.kernel.org>; Mon,  8 Feb 2021 06:38:46 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l97gU-0008Bl-Bs; Mon, 08 Feb 2021 15:38:38 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l97gT-0007SL-Cu; Mon, 08 Feb 2021 15:38:37 +0100
Message-ID: <b6ee219924e7195070062b6453931595faa640af.camel@pengutronix.de>
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
Date:   Mon, 08 Feb 2021 15:38:36 +0100
In-Reply-To: <e9e7814c35d9ce5a6351a960081bf3c6b90bdca7.camel@linux.ibm.com>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
         <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
         <bd3246ebb4eae526c84efe2d27c6fadff662b0c8.camel@linux.ibm.com>
         <0be34899c9686b95cd22aa016f466523579cbeed.camel@pengutronix.de>
         <e9e7814c35d9ce5a6351a960081bf3c6b90bdca7.camel@linux.ibm.com>
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

On Mon, 2021-02-01 at 14:46 -0500, Mimi Zohar wrote:
> On Mon, 2021-02-01 at 17:38 +0100, Jan Lübbe wrote:
> > On Mon, 2021-02-01 at 11:11 -0500, Mimi Zohar wrote:
> > > On Mon, 2021-02-01 at 16:31 +0100, Jan Lübbe wrote:
> > > > On Sun, 2021-01-31 at 09:29 -0500, Mimi Zohar wrote:
> > <snip>
> > > > > Usage::
> > > > > 
> > > > >     keyctl add encrypted name "new [format] key-type:master-key-name keylen"
> > > > >         ring
> > > > >     keyctl add encrypted name "load hex_blob" ring
> > > > 
> > > > 'load' (as I understand the code) only accepts an encrypted blob.
> > > > 
> > > > So the only way I see to have an encrypted key with a non-random key data would
> > > > be:
> > > > - create a random temporary master key and load a copy as a user key
> > > > - encrypt the chosen key data with the temporary master key (using a new
> > > > userspace reimplementation of the kernel encrypted key blob format)
> > > > - use keyctl add encrypted dmcrypt "load <encrypted blob>" <keyring>
> > > > - create new trusted master key (OP-TEE or CAAM in our case) as 
> > > > - use keyctl update to switch to the new trusted master key
> > > > - use keyctl pipe on the trusted and encrypted keys and store both for loading
> > > > on later boots
> > > > 
> > > > If we'd support importing a pre-existing key into a trusted or encrypted key,
> > > > we'd do instead:
> > > > - use keyctl add trusted dmcrypt "import <unencrypted key data>"
> > > > - use keyctl pipe on the trusted key and store it for loading on later boots
> > > > 
> > > > This way, users wouldn't need to care which backend is used by trusted keys
> > > > (TPM/OP-TEE/CAAM/...). That would make use-cases where a random key is not
> > > > suitable as straight-forward as the those where a random key is OK.
> > > 
> > > As I said above, the "encrypted" key update doesn't change the key data
> > > used for encrypting/decrypting storage in the dm-crypt case, it just
> > > updates the key under which it is encrypted/signed.
> > 
> > Yes, that's clear. I only used it to demonstrate how a workaround for importing
> > key material into an encrypted key could look like.
> > 
> > > Yes, the reason for using an encrypted "trusted" key, as opposed to an
> > > encrypted "user" key, is that the "trusted" key is encrypted/decrypted
> > > by the TPM and never exposed to userspace in the clear.
> > 
> > Yes, and that's the main reason I'd like to use trusted keys with dm-crypt: a
> > much lower chance of exposing this key somewhere it could be extracted.
> > 
> > > It doesn't sound like you're wanting to update the storage key in the
> > > field, just the key used to encrypt/decrypt that key.  So I'm still not
> > > clear as to why you would want an initial non-random encrypted key. 
> > > Providing that key on the command line certaining isn't a good idea.
> > 
> > Some of our customers have systems in the field which use non-mainline patches
> > for access to the CAAM [1], which also have the downside of exposing the
> > decrypted key material directly to userspace. In that thread you suggested to
> > use trusted keys instead. With Sumit's work that rework is finally within reach.
> > :)
> > 
> > 
> > In those systems, we have data that's encrypted with a pre-existing dm-crypt or
> > ecryptfs key. As we update those systems in the field to newer kernels, we want
> > to get rid of those custom patches, but can't reencrypt everything.
> > 
> > So the approach would be to perform a one-time migration when updating a device:
> > - use our old interface to decrypt the key and 'import' it into a trusted key
> > - use keyctl pipe and save the re-encrypted key to disk
> > - destroy the old encrypted key
> > After this migration, the key material is no longer available to userspace (only
> > to dm-crypt).
> > 
> > 
> > Another use-case for supporting key import that we want to support is  analysis
> > of broken devices returned from the field:
> > - generate an encryption key per device in the factory
> > - encrypt it to a private key in escrow and archive it for later use
> > - import it into a trusted key on the device
> > - keyctl pipe it to a file on the device for use on boot
> > 
> > Later, when you need to do an analysis, you can get the key from escrow even if
> > the device cannot boot any longer.
> 
> The first use case doesn't sound like a valid reason for upstreaming
> such support.  It's a one time update to migrate everyone to a newer
> kernel.  That you can carry independently of upstream.  In terms of the
> second use case, do you really want the ability and the resulting
> responsibility of being able to decrypt user's data?   Please think
> this through carefully, before you decide you really want/need this
> feature.

As it seems that this feature would not be appropriate for all use-cases and
threat models, I wonder if making it optional would be acceptable. Something
like:

config TRUSTED_KEYS_IMPORT
        bool "Allow creating TRUSTED KEYS from existing key material"
        depends on TRUSTED_KEYS
        help
          This option adds support for creating new trusted keys from existing 
          key material supplied by userspace, instead of using random numbers.
          As with random trusted keys, userspace cannot extract the plain-text 
          key material again and will only ever see encrypted blobs.
          
          This option should *only* be enabled for use in a trusted
          environment (such as during debugging/development or in a secured
          factory). Also, consider using 'keyctl padd' instead of 'keyctl add' 
          to avoid exposing the plain-text key on the process command line.

          If you are unsure as to whether this is required, answer N.

Best regards,
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

