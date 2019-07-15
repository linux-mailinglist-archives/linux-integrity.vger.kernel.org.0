Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3BA69C4F
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jul 2019 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfGOUFN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jul 2019 16:05:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57674 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbfGOUFN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jul 2019 16:05:13 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3218C72CA65;
        Mon, 15 Jul 2019 23:05:11 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 218314A4A29;
        Mon, 15 Jul 2019 23:05:11 +0300 (MSK)
Date:   Mon, 15 Jul 2019 23:05:11 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v1 2/5] ima-evm-utils: Fix possible strcpy overflow
Message-ID: <20190715200510.gbebcml3uzmfdf7i@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190712212833.29280-1-vt@altlinux.org>
 <20190712212833.29280-2-vt@altlinux.org>
 <1563217735.4539.145.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563217735.4539.145.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 15, 2019 at 03:08:55PM -0400, Mimi Zohar wrote:
> On Sat, 2019-07-13 at 00:28 +0300, Vitaly Chikunov wrote:
> > caps_str is passed from command line but copied into fixed-size buffer.
> > CID 229895.
> > ---
> >  src/evmctl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 39bc3d9..e07cff4 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -409,8 +409,9 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> >  		} else if (!strcmp(*xattrname, XATTR_NAME_CAPS) && (hmac_flags & HMAC_FLAG_CAPS_SET)) {
> >  			if (!caps_str)
> >  				continue;
> > -			strcpy(xattr_value, caps_str);
> >  			err = strlen(caps_str);
> > +			assert(err < sizeof(xattr_value));
> 
> "calc_evm_hash" can be called while walking and labeling, or
> verifying, a file system. šWe probably don't want to abruptly end it.
> šMaybe emit an error message and return and error?

Ok. I will also add similar checks for selinux_str and ima_str.

Thanks,

> 
> 
> > +			strcpy(xattr_value, caps_str);
> >  		} else {
> >  			err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
> >  			if (err < 0) {
