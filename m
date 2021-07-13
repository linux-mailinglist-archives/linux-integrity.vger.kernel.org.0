Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8979E3C69E7
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jul 2021 07:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGMFt7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jul 2021 01:49:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46578 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhGMFt7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jul 2021 01:49:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7E5CB72C8B4;
        Tue, 13 Jul 2021 08:47:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 29F9E4A46E9;
        Tue, 13 Jul 2021 08:47:07 +0300 (MSK)
Date:   Tue, 13 Jul 2021 08:47:06 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v8 0/3] ima-evm-utils: Add --keyid option
Message-ID: <20210713054706.u3b7god6cxbm4tpg@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
 <b2dab0c5a7f67f337257ddf63dc58134c36ca4f9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <b2dab0c5a7f67f337257ddf63dc58134c36ca4f9.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jul 12, 2021 at 04:04:29PM -0400, Mimi Zohar wrote:
> On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > Allow user to set signature's keyid using `--keyid' option. Keyid should
> > correspond to SKID in certificate. When keyid is calculated using SHA-1
> > in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> > certificate (the way public key is presented to the kernel), thus making
> > signatures not verifiable. This may happen when certificate is using non
> > SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> > As a last resort user may specify arbitrary keyid using the new option.
> > Certificate filename could be used instead of the hex number with
> > `--keyid-from-cert' option. And, third option is to read keyid from the
> > cert appended to the key file.
> > 
> > These commits create backward incompatible ABI change for libimaevm,
> > thus soname should be incremented on release.
> 
> I can't seem to apply either of your patch sets using "git am", only
> manually using "patch -p0 <  <mbox>".    This hasn't been a problem in
> the past.  Did you do something differently?

Ah. I sent from the different box where git configured with:

  [diff]
          noprefix = true

Sorry. Will resend later.


> 
> thanks,
> 
> Mimi
