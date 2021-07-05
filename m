Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A570F3BC390
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 23:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGEVSY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 17:18:24 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:47730 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGEVSY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 17:18:24 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A936672C8B4;
        Tue,  6 Jul 2021 00:15:45 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 515654A46ED;
        Tue,  6 Jul 2021 00:15:45 +0300 (MSK)
Date:   Tue, 6 Jul 2021 00:15:45 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210705211545.s2hzroeulcw7bfbm@altlinux.org>
References: <20210701011323.2377251-1-vt@altlinux.org>
 <20210701011323.2377251-4-vt@altlinux.org>
 <f304a136df93bd74e06a68737f9512e003e329ab.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <f304a136df93bd74e06a68737f9512e003e329ab.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 05, 2021 at 04:04:52PM -0400, Mimi Zohar wrote:
> On Thu, 2021-07-01 at 04:13 +0300, Vitaly Chikunov wrote:
> > 
> > +/**
> > + * read_keyid_from_key() - Read 32-bit keyid from the key file
> > + * @keyid_be:   Pointer to 32-bit value in network order (BE, unaligned).
> > + * @keyfile:    PEM file with private key with optionally appended x509 cert.
> > + * Return:      0 on success and keyid_be is written;
> > + *              -1 on error, logged error message, and keyid_be isn't written.
> > + */
> > +static int read_keyid_from_key(uint32_t *keyid_be, const char *keyfile)
> 
> (With  the new option "--keyid-from-cert" is this patch really still
> needed?)

Yes. Key+cert is a nice option and should be handy for users. Key is
stored together with the cert which will verify them. Otherwise key
format doesn't store keyid which is error prone.

> The function name is a bit off.  Both imaevm_read_keyid() and this
> function are getting the keyid from a cert.  There's also quite a bit
> of code duplication between them.  Refactoring the code might help. 
> For example, perhaps imaevm_read_keyid() could be a wrapper for
> read_keyid_from_cert().

They have important difference too. Thus, its hard to refactor them
into nested function that looked good and simple. This is third attempt.
And it's like solving a unsolvable puzzle.

imaevm_read_keyid() reads from cert-only file where cert could be PEM or
DER encoded. It's failure if there is no cert, because user intended to
read a cert.

imaevm_read_keyid() reads from private key optionally combined with a
cert (both are PEM-only). It's not failure if there is no cert.

We want to save "duplicated" call to PEM_read_X509() but really it
causes more convoluted internal logic.

I tried to de-duplicate them as much as possible while remaining
understandability.

> Otherwise renaming this function to read_keyid_from_keyfile(),
> read_appended_keyid() or read_appended_keyid_from_cert(), which is
> really wordy, would be better.

Ok. read_keyid_from_keyfile looks good.

> 
> thanks,
> 
> Mimi
