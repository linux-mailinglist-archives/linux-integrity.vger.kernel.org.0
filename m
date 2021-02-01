Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3230AC14
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbhBAPyU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:54:20 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38301 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhBAPx6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 10:53:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6bTf-0008E3-O0; Mon, 01 Feb 2021 16:50:59 +0100
Received: from localhost ([127.0.0.1])
        by ptx.hi.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <jlu@pengutronix.de>)
        id 1l6bTe-0007Gf-Md; Mon, 01 Feb 2021 16:50:58 +0100
Message-ID: <6b362abd95b116e26c65809a3a1525c7951ed0bd.camel@pengutronix.de>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 01 Feb 2021 16:50:58 +0100
In-Reply-To: <4153718.1612179361@warthog.procyon.org.uk>
References: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <4153718.1612179361@warthog.procyon.org.uk>
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

On Mon, 2021-02-01 at 11:36 +0000, David Howells wrote:
> Jan Lübbe <jlu@pengutronix.de> wrote:
> 
> > ... But at this point, you can still do 'keyctl read' on that key, exposing
> > the key material to user space.
> 
> I wonder if it would help to provide a keyctl function to mark a key as being
> permanently unreadable - so that it overrides the READ permission bit.
> 
> Alternatively, you can disable READ and SETATTR permission - but that then
> prevents you from removing other perms if you want to :-/

That would mean using user type keys, right? Then we'd still have the core
problem how a master key can be protected against simply reading it from
flash/disk, as it would be unencrypted in this scenario.


Maybe a bit of background:

We're looking at the trusted/encrypted keys because we want to store the key
material in an encrypted format, only loadable into the same system where they
were generated and only if that's in a trusted state (to solve the master key
problem above).

This binding can be done with trusted keys via a TPM (and soon with Sumit's OP-
TEE backend, or later based on SoC-specific hardware like NXP's CAAM). In the
OP-TEE/CAAM case, the bootloader would ensure that the backend can only be used
when booting a correctly authenticated kernel.

Of course, that's not as flexible as TPMs with a custom policy, but much simpler
and a good fit for many embedded use-cases.

Best regards,
Jan Lübbe
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

