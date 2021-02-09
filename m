Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D523431495B
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 08:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBIHR2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 02:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBIHRW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 02:17:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A7C061788
        for <linux-integrity@vger.kernel.org>; Mon,  8 Feb 2021 23:16:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l9NGC-0006mV-H4; Tue, 09 Feb 2021 08:16:32 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l9NGB-0000sq-8K; Tue, 09 Feb 2021 08:16:31 +0100
Message-ID: <e8f149cddce55a4e4615396108e4c900cbec75a8.camel@pengutronix.de>
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
Date:   Tue, 09 Feb 2021 08:16:30 +0100
In-Reply-To: <9bd1eaab236f095f1dbdc01752c3c6f487f33525.camel@linux.ibm.com>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
         <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
         <bd3246ebb4eae526c84efe2d27c6fadff662b0c8.camel@linux.ibm.com>
         <0be34899c9686b95cd22aa016f466523579cbeed.camel@pengutronix.de>
         <e9e7814c35d9ce5a6351a960081bf3c6b90bdca7.camel@linux.ibm.com>
         <b6ee219924e7195070062b6453931595faa640af.camel@pengutronix.de>
         <9bd1eaab236f095f1dbdc01752c3c6f487f33525.camel@linux.ibm.com>
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

On Mon, 2021-02-08 at 16:50 -0500, Mimi Zohar wrote:
> On Mon, 2021-02-08 at 15:38 +0100, Jan Lübbe wrote:
> 
> > As it seems that this feature would not be appropriate for all use-cases and
> > threat models, I wonder if making it optional would be acceptable. Something
> > like:
> > 
> > config TRUSTED_KEYS_IMPORT
> 
> To me "IMPORT" implies from a trusted source, which this is not. 
> Perhaps "UNSAFE_IMPORT", "DEBUGGING_IMPORT, "DEVELOPMENT_IMPORT", ...
> 
> Defining a Kconfig with any of these names and the other changes below,
> makes it very clear using predefined key data is not recommended.  My
> concern with extending trusted keys to new trust sources is the
> implication that the security/integrity is equivalent to the existing
> discrete TPM.
> 
> >         bool "Allow creating TRUSTED KEYS from existing key material"
> >         depends on TRUSTED_KEYS
> 
> Missing "default n"

According to Documentation/kbuild/kconfig-language.rst: "The default value
deliberately defaults to 'n' in order to avoid bloating the build.". So an
explicit "default n" should not be needed. I'll add it though, for now.

> >         help
> >           This option adds support for creating new trusted keys from
> > existing 
> >           key material supplied by userspace, instead of using random
> > numbers.
> >           As with random trusted keys, userspace cannot extract the plain-
> > text 
> 
> Once defined, as with random trusted keys, userspace cannot ...
> 
> >           key material again and will only ever see encrypted blobs.
> >           
> > 
> >           This option should *only* be enabled for use in a trusted
> >           environment (such as during debugging/development or in a secured
> >           factory). Also, consider using 'keyctl padd' instead of 'keyctl
> > add' 
> 
> Even the "secured factory" is not a good idea.  Please limit the usage
> to debugging/development.
> 
> >           to avoid exposing the plain-text key on the process command line.
> > 
> >           If you are unsure as to whether this is required, answer N.
> 
> The above would be fine.

OK, that would result in:

config TRUSTED_KEYS_DEVELOPMENT_IMPORT
        bool "Allow creating TRUSTED KEYS from existing key material for development"
        depends on TRUSTED_KEYS
        default n
        help
          This option adds support for creating new trusted keys from
          existing key material supplied by userspace, instead of using
          random numbers. Once defined,  as with random trusted keys,
          userspace cannot extract the plain-text key material again
          and will only ever see encrypted blobs.
          
          This option should *only* be enabled for debugging/development.
          Also, consider using 'keyctl padd' instead of 'keyctl add' to
          avoid exposing the plain-text key on the process command line.

          If you are unsure as to whether this is required, answer N.

Thanks,
Jan
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

