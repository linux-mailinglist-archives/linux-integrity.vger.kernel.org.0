Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8EFBC655
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2019 13:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395127AbfIXLMn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Sep 2019 07:12:43 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35492 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388764AbfIXLMn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 07:12:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0164A8EE175;
        Tue, 24 Sep 2019 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569323563;
        bh=7Ai2qtIntMWNVtxwe6qQsuPbjf6XjGDzBQonHyILHuw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d8vGZgqMBZ+hp7FMGmptBoxa8NuFaKkrg/uzwOKm4OZx0cNPSP663Txtd6GSPLDw7
         x8DW4Y8HwWJx3JcmQ2uYIo34hrrmgWgs86kHzw7Utkfxfr1VFXp5U9zqjdwEvSx6eU
         12TEraBTRT3/PXU0i0hzasp4Q2jq9yf//aMYIPl8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eNmijRz7YiHK; Tue, 24 Sep 2019 04:12:42 -0700 (PDT)
Received: from [192.168.101.242] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 414818EE12C;
        Tue, 24 Sep 2019 04:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569323562;
        bh=7Ai2qtIntMWNVtxwe6qQsuPbjf6XjGDzBQonHyILHuw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gvkj3Ct1bv3ybOgiYNYVi1SsR3Fw32GIY4wFNu7MKT+1NsUscSTrhidl5RXHvHNRs
         co00JrvFBOZ45m/8k/8O7UE33+tRCU0Kf40Xq1JtjmlrL13kwCi1OTMO8vEhoxSVpZ
         qacEs5VJTkGzU9iTxYMJUcNCrn0i7dS82RNtkbsk=
Message-ID: <1569323560.24519.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v6 02/12] tpm-buf: add handling for TPM2B types
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 24 Sep 2019 07:12:40 -0400
In-Reply-To: <20190920141826.GC9578@linux.intel.com>
References: <1568031408.6613.29.camel@HansenPartnership.com>
         <1568031515.6613.31.camel@HansenPartnership.com>
         <20190920141826.GC9578@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-09-20 at 17:18 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 09, 2019 at 01:18:35PM +0100, James Bottomley wrote:
> > Most complex TPM commands require appending TPM2B buffers to the
> > command body.  Since TPM2B types are essentially variable size
> > arrays,it makes it impossible to represent these complex command
> > arguments as structures and we simply have to build them up using
> > append primitives like these.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> I think a better idea would be to have headerless TPM buffers

I thought about that.  The main problem is that most of the
construct/append functions use the header, and these are the functions
most useful to the TPM2B operation.

The other thing that argues against this is that the TPM2B case would
save nothing if we eliminated the header, because we allocate a page
for all the data regardless.

>  and also it makes sense to have a separate length field in the
> struct to keep the code sane given that sometimes the buffer does not
> store the length.

I'm really not sure about that one.  The header length has to be filled
in for the non-TPM2B case but right at the moment we have no finish
function for the buf where it could be, so we'd end up having to
maintain two lengths in every update operation on non-TPM2B buffers. 
That seems inefficient and the only slight efficiency we get in the
TPM2B case is not having to do the big endian conversion from the
header which doesn't seem to be worth the added complexity.

James

> E.g.
> 
> enum tpm_buf_flags {
> 	TPM_BUF_OVERFLOW	= BIT(0),
> 	TPM_BUF_HEADERLESS	= BIT(1),
> };
> 
> struct tpm_buf {
> 	unsigned int length;
> 	struct page *data_page;
> 	unsigned int flags;
> 	u8 *data;
> };
> 
> /Jarkko
> 

