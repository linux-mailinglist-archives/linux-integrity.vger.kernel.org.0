Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43FB1CFCCB
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 20:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgELSF7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgELSF7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 14:05:59 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8AFD20673;
        Tue, 12 May 2020 18:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306758;
        bh=ez20Q+vbHatmoUrQcLugh4B8uaSdEsJghLxVdqu1yKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfnlaLpi8iGkdyKXHCoxYcGLnQAXHWsHurzFCPMp/79mAMkJzJekdMYpqj8X//u2b
         bxZ3YPRlvn3oXc8QyUMlmVKLx0JPIwDVzOoeZZAC8fAxHu5J3mhBByNviAL52XqZSp
         JIkFfyKrszv5BHbOkEsGfaT8eWEFgbcZvEb3B56Q=
Date:   Tue, 12 May 2020 13:10:32 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <20200512181032.GG4897@embeddedor>
References: <20200508163826.GA768@embeddedor>
 <202005112224.9EFD07F5@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005112224.9EFD07F5@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 11, 2020 at 10:24:10PM -0700, Kees Cook wrote:
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
> 

Thanks, Kees.

--
Gustavo
