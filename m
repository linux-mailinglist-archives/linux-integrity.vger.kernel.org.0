Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA457A8CB
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfG3Mjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 08:39:41 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37288 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfG3Mjl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 08:39:41 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 13D2672CCD5;
        Tue, 30 Jul 2019 15:39:39 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 041C54A4AE7;
        Tue, 30 Jul 2019 15:39:39 +0300 (MSK)
Date:   Tue, 30 Jul 2019 15:39:38 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] ima-evm-utils: Never exit with -1 code
Message-ID: <20190730123938.l3wrcf57pw7swt2k@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@kernel.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190727031900.7140-1-vt@altlinux.org>
 <20190727031900.7140-2-vt@altlinux.org>
 <1564487830.4189.39.camel@kernel.org>
 <20190730122939.52jrwkl2xtdgh3os@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20190730122939.52jrwkl2xtdgh3os@altlinux.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jul 30, 2019 at 03:29:39PM +0300, Vitaly Chikunov wrote:
> On Tue, Jul 30, 2019 at 07:57:10AM -0400, Mimi Zohar wrote:
> > On Sat, 2019-07-27 at 06:19 +0300, Vitaly Chikunov wrote:
> > > +		if (err < 0)
> > > +			err = 125;
> > >  	}
> > >  
> > >  	if (eng) {
> > 
> > Agreed we need to return better errors, but instead of always
> > returning 125, would it be better to return the first errno, if err is
> > -1?
> 
> 125 will be not always but only to avoid returning -1 (or any negative).
> 
> There is no practice to exit with errno, AFAIK. Plus, errno we have at
> the end (and which is reported to user) frequently is bogus and that
> should be fixed. (I may do this later maybe, don't know how much work
> that would require).
> 
> We also wish to reserve some exit code as hard error for tests.

I meant 'we also may wish'... This needs to be thought over.

