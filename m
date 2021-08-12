Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0715C3EACC7
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhHLVqp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 17:46:45 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50018 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhHLVqo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 17:46:44 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EABB672C8FB;
        Fri, 13 Aug 2021 00:46:17 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D39394A46F1;
        Fri, 13 Aug 2021 00:46:17 +0300 (MSK)
Date:   Fri, 13 Aug 2021 00:46:17 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH ima-evm-utils] Improve memory handling for private keys
 and passwords
Message-ID: <20210812214617.og7eclvb53l3hqip@altlinux.org>
References: <20210812212143.2223183-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210812212143.2223183-1-vt@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Fri, Aug 13, 2021 at 12:21:43AM +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> secure heap. This facility is only available since OpenSSL_1_1_0-pre1
> and enabled for 'ima_sign', 'sign', 'sign_hash', and 'hmac'.

> setvbuf(3) _IONBF is used to hopefully avoid private key and password
> being stored inside of stdio buffers.

I should note that usefulness of this method (of avoiding buffering) is
not proven. I don't find other implementations doing it. So, I'm open to
suggestion of removing it.

Thanks,

> 
> Unfortunately, secure heap is not used for the passwords (`-p') due to
> absence of its support in the older OpenSSL where ima-evem-utils still
> should work, thus simple cleansing of password memory is used where
> possible to shorten its lifespan.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Perhaps, it will conflict with Bruno's patch, we should decide which
> one goes first if this will be accepted.
> 
>  src/evmctl.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++++---
>  src/libimaevm.c | 14 ++++++++-
>  2 files changed, 92 insertions(+), 5 deletions(-)
