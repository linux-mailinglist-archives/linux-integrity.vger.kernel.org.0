Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A36D574300
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 03:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfGYBxb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 21:53:31 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52638 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388469AbfGYBxb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 21:53:31 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D2BEE72CC6C;
        Thu, 25 Jul 2019 04:53:29 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id BF4AF4A4AE8;
        Thu, 25 Jul 2019 04:53:29 +0300 (MSK)
Date:   Thu, 25 Jul 2019 04:53:29 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Namespace some too generic function names
Message-ID: <20190725015329.q6cu7vxtzjpfve4m@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190724204204.25383-1-vt@altlinux.org>
 <1564010660.4245.76.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564010660.4245.76.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 24, 2019 at 07:24:20PM -0400, Mimi Zohar wrote:
> On Wed, 2019-07-24 at 23:42 +0300, Vitaly Chikunov wrote:
> > Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
> > with other global symbols.
> 
> The package is named ima-evm-utils, the tool is named evmctl, and now
> we're prefixing the global symbols with "ima". šSome of the functions,
> like dump(), are used by both "ima" and "evm". šAiming for some sort
> of consistency, maybe it should be prefixed with "ima_evm", not just
> "ima_"?š

Just ima_ is OK with me. EVM could be thought as IMA extension.
Or we can use evm_ like in evmctl. Or imaevm_ (without underscore, like
in libimaevm or imaevm.h).

> dump() should never have been named just "dump". šIt should have at
> least been named "hexdump".
> š
> > `params' is prefixed with a #define trick to avoid change in half
> > hundred places.
> 
> Perhaps separate this change from the other change?

I agree to Bruno E. O. Meneguele it's better to actually rename `params'
like other functions instead of redefining. Then all renames can go in
one commit?

Thanks,

