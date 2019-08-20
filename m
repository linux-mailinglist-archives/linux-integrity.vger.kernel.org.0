Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82669699D
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfHTTmi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 15:42:38 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34678 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTTmi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 15:42:38 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 68F5472CCD5;
        Tue, 20 Aug 2019 22:42:36 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4F50E4A4AF6;
        Tue, 20 Aug 2019 22:42:36 +0300 (MSK)
Date:   Tue, 20 Aug 2019 22:42:36 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Enable large-file support
Message-ID: <20190820194236.tgyhdlw5kgygcnsu@altlinux.org>
Mail-Followup-To: Bruno Meneguele <bmeneg@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190819202507.27735-1-vt@altlinux.org>
 <20190820151939.GC7410@rhlt>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190820151939.GC7410@rhlt>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bruno,

On Tue, Aug 20, 2019 at 12:19:39PM -0300, Bruno Meneguele wrote:
> On Mon, Aug 19, 2019 at 11:25:07PM +0300, Vitaly Chikunov wrote:
> > Some architectures require special measures to access large files (LFS).
> > Add `AC_SYS_LARGEFILE' to `configure.ac' to handle this.
> > 
> > It seems that ABI is not changed with this.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  configure.ac | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/configure.ac b/configure.ac
> > index 3f21ba4..02bd6f8 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -8,6 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
> >  
> >  AC_CANONICAL_HOST
> >  AC_USE_SYSTEM_EXTENSIONS
> > +AC_SYS_LARGEFILE
> >  
> 
> Should we also add AC_FUNC_FSEEKO?
> 
> I can't see any use of fseek or ftell in the code, but if we are
> enabling AC_SYS_LARGEFILE by default we also should check for
> AC_FUNC_FSEEKO in order to allow the use of fseeko/ftello whenever
> needed.

I thought about AC_FUNC_FSEEKO, but we don't use fseeko/ftello, so it
didn't look useful.

Thanks,


> 
> >  # Checks for programs.
> >  AC_PROG_CC
> > -- 
> > 2.11.0
> > 


