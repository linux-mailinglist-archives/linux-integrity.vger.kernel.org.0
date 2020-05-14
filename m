Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB21D2376
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 02:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbgENAJF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 20:09:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:17408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732871AbgENAJE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 20:09:04 -0400
IronPort-SDR: Fgv6nAJTFr8zbTKSuaLdqotHV1ZSnv+zkNC8ClukKbJQyDXOV01A6HGGr/z4ybuarxL9uy7u7B
 W5JY3Pk/6lPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 17:09:03 -0700
IronPort-SDR: lhPIPIrnmkX4X+jhi9tu23//ARu70HzakZKd175bTckQmCEPEicCbnJ82WLVhs8UhtedOO2ZQ4
 PpMtIYGNj7YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="251434238"
Received: from gliber-mobl1.ger.corp.intel.com ([10.249.38.41])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2020 17:08:59 -0700
Message-ID: <2a77f3bc9e7ed88343bbd206eaf25f10a697de90.camel@linux.intel.com>
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 14 May 2020 03:08:58 +0300
In-Reply-To: <202005112224.9EFD07F5@keescook>
References: <20200508163826.GA768@embeddedor>
         <202005112224.9EFD07F5@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-05-11 at 22:24 -0700, Kees Cook wrote:
> On Fri, May 08, 2020 at 11:38:26AM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on.
> > 
> > Also, notice that, dynamic memory allocations won't be affected by
> > this change:
> > 
> > "Flexible array members have incomplete type, and so the sizeof operator
> > may not be applied. As a quirk of the original implementation of
> > zero-length arrays, sizeof evaluates to zero."[1]
> > 
> > sizeof(flexible-array-member) triggers a warning because flexible array
> > members have incomplete type[1]. There are some instances of code in
> > which the sizeof operator is being incorrectly/erroneously applied to
> > zero-length arrays and the result is zero. Such instances may be hiding
> > some bugs. So, this work (flexible-array member conversions) will also
> > help to get completely rid of those sorts of issues.
> > 
> > Also, the following issue shows up due to the flexible-array member
> > having incomplete type[4]:
> > 
> > drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_start’:
> > drivers/char/tpm/eventlog/tpm2.c:54:46: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
> >    54 |  size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
> >       |                                              ^
> > drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_bios_measurements_next’:
> > drivers/char/tpm/eventlog/tpm2.c:102:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
> >   102 |    sizeof(event_header->event) + event_header->event_size;
> >       |          ^
> > drivers/char/tpm/eventlog/tpm2.c: In function ‘tpm2_binary_bios_measurements_show’:
> > drivers/char/tpm/eventlog/tpm2.c:140:10: error: invalid application of ‘sizeof’ to incomplete type ‘u8[]’ {aka ‘unsigned char[]’}
> >   140 |    sizeof(event_header->event) + event_header->event_size;
> >       |          ^
> > scripts/Makefile.build:266: recipe for target 'drivers/char/tpm/eventlog/tpm2.o' failed
> > make[3]: *** [drivers/char/tpm/eventlog/tpm2.o] Error 1
> > 
> > As mentioned above: "Flexible array members have incomplete type, and
> > so the sizeof operator may not be applied. As a quirk of the original
> > implementation of zero-length arrays, sizeof evaluates to zero."[1] As
> > in "sizeof(event_header->event) always evaluated to 0, so removing it
> > has no effect".
> > 
> > Lastly, make use of the struct_size() helper to deal with the
> > flexible array member and its host structure.
> > 
> > This issue was found with the help of Coccinelle.
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> > [4] https://github.com/KSPP/linux/issues/43
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you.

I applied this patch, will include it to the next PR.

/Jarkko

