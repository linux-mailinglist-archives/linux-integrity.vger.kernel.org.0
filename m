Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E570D3F0D35
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Aug 2021 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhHRVR6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 17:17:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45038 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHRVR6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 17:17:58 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4EC9372C8F8;
        Thu, 19 Aug 2021 00:17:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 35A914A46F1;
        Thu, 19 Aug 2021 00:17:20 +0300 (MSK)
Date:   Thu, 19 Aug 2021 00:17:20 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils] Improve memory handling for private keys
 and passwords
Message-ID: <20210818211720.5mnlrbc5njtt776n@altlinux.org>
References: <20210812212143.2223183-1-vt@altlinux.org>
 <20210812214617.og7eclvb53l3hqip@altlinux.org>
 <3e870d0e5c5cbecce5d9fe1c0d613118ddb1bae3.camel@linux.ibm.com>
 <0f85d155b154c7358eaf4bb2c65f391587e3809d.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <0f85d155b154c7358eaf4bb2c65f391587e3809d.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Aug 18, 2021 at 05:07:20PM -0400, Mimi Zohar wrote:
> On Fri, 2021-08-13 at 17:31 -0400, Mimi Zohar wrote:
> > On Fri, 2021-08-13 at 00:46 +0300, Vitaly Chikunov wrote:
> > > On Fri, Aug 13, 2021 at 12:21:43AM +0300, Vitaly Chikunov wrote:
> > > > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1
> > > > and enabled for 'ima_sign', 'sign', 'sign_hash', and 'hmac'.
> > 
> > From the manpage:
> > CRYPTO_secure_malloc_init() returns 0 on failure, 1 if successful, and
> > 2 if successful but the heap could not be protected by memory mapping.
> > 
> > Not sure what we would do on failure ( 0, 2), but we should at least
> > check the return code.
> > > 
> > > > setvbuf(3) _IONBF is used to hopefully avoid private key and password
> > > > being stored inside of stdio buffers.
> > > 
> > > I should note that usefulness of this method (of avoiding buffering) is
> > > not proven. I don't find other implementations doing it. So, I'm open to
> > > suggestion of removing it.
> > > 
> > Probably would be better to split the patch.
> 
> According to the man page "OPENSSL_secure_malloc() allocates num bytes
> from the heap.  If CRYPTO_secure_malloc_init() is not called, this is
> equivalent to calling OPENSSL_malloc()".   OPENSSL_malloc() is
> supported in the older openssl versions.
> 
> Does it make sense to replace allocating memory for the password via
> malloc() with OPENSSL_secure_malloc()?  For older openssl versions,
> define OPENSSL_secure_malloc() and OPENSSL_secure_free() as
> OPENSSL_malloc() and OPENSSL_free().

It makes sense to use OPENSSL_secure_malloc for passwords, but it will
look strange to define OPENSSL_secure_malloc as OPENSSL_malloc for older
versions.

Maybe we could add a #warning in that case.

Thanks,

> 
> This doesn't solve the memory handling for private keys and passwords
> for older openssl versions, but it is a path forward.
> 
> thanks,
> 
> Mimi
