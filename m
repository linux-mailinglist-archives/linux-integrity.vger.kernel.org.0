Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C76663A5
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jul 2019 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfGLCFU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 22:05:20 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:59292 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfGLCFU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 22:05:20 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id DFB9872CC58;
        Fri, 12 Jul 2019 05:05:17 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4F9424A4AE8;
        Fri, 12 Jul 2019 05:05:17 +0300 (MSK)
Date:   Fri, 12 Jul 2019 05:05:16 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] ima-evm-utils: link to libcrypto instead of OpenSSL
Message-ID: <20190712020516.tpinh2xk43b6xufj@altlinux.org>
Mail-Followup-To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190523122623.25684-1-dbaryshkov@gmail.com>
 <20190711150732.7xrx42cnlsef6lit@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190711150732.7xrx42cnlsef6lit@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dmitry,

On Thu, Jul 11, 2019 at 06:07:32PM +0300, Vitaly Chikunov wrote:
> On Thu, May 23, 2019 at 03:26:20PM +0300, Dmitry Eremin-Solenikov wrote:
> > There is no need to link to full libssl. evmctl uses functions from
> > libcrypto, so let's link only against that library.
> 
> Btw, this breaks my tests in my set up with gost-engine, making evmctl
> crash on OPENSSL_init_crypto (in bind_gost). Did not investigate real
> cause yet. I test with latest version of gost-engine (e372739) and
> openssl 0fc4d00a00.

Sorry, this was my set up failure. Previously I was defining
`OPENSSL_LIBS="-L$HOME/src/openssl -lssl -lcrypto"` to link with custom
OpenSSL build. Now I should just define
`LIBCRYPTO_LIBS="-L$HOME/src/openssl -lcrypto"` instead.

So there is no error in these commits.

Thanks,
