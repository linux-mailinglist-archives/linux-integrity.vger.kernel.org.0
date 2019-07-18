Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD26D73C
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 01:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfGRX0V (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 19:26:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53738 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGRX0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 19:26:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 12BDB72CA65;
        Fri, 19 Jul 2019 02:26:19 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D3EF64A4A29;
        Fri, 19 Jul 2019 02:26:18 +0300 (MSK)
Date:   Fri, 19 Jul 2019 02:26:18 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/3] ima-evm-utils: Remove not needed argument from
 verify_hash_v2
Message-ID: <20190718232617.buo6pcvtncntcdxg@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190718213510.10829-1-vt@altlinux.org>
 <20190718213510.10829-2-vt@altlinux.org>
 <1563492201.4539.339.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563492201.4539.339.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Jul 18, 2019 at 07:23:21PM -0400, Mimi Zohar wrote:
> On Fri, 2019-07-19 at 00:35 +0300, Vitaly Chikunov wrote:
> > Since we now always call verify_hash_v2() with NULL keyfile (assuming
> > all keys are already loaded into public_keys list), remove keyfile
> > argument and its handling from verify_hash_v2().
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Thanks!
> 
> > ---
> >  src/libimaevm.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 97b7167..b153f1b 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -453,7 +453,7 @@ void init_public_keys(const char *keyfiles)
> >   * Return: 0 verification good, 1 verification bad, -1 error.
> >   */
> >  int verify_hash_v2(const char *file, const unsigned char *hash, int size,
> > -		   unsigned char *sig, int siglen, const char *keyfile)
> > +		   unsigned char *sig, int siglen)
> >  {
> 
> While making this change, could we also make both this and
> verify_hash_v1() functions static?

Yes, I wonder why they wasn't static in the first place.

> Should I make the change?

OK!

Thanks,

