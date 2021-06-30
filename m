Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBCD3B8945
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 21:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhF3TrW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 15:47:22 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44756 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3TrV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 15:47:21 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 706A972C8B4;
        Wed, 30 Jun 2021 22:44:51 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 5155F4A46ED;
        Wed, 30 Jun 2021 22:44:51 +0300 (MSK)
Date:   Wed, 30 Jun 2021 22:44:51 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
Message-ID: <20210630194451.laico5ziqy3fw4eh@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-2-vt@altlinux.org>
 <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
 <20210626004241.wkkjsbbesakszfkj@altlinux.org>
 <f2355538832153c82c866d1e779b128a9612b6cc.camel@linux.ibm.com>
 <20210629013201.xelhje2hmiuqybrt@altlinux.org>
 <2f494e1d5c2c99a4b7c0912faa4c3be3de682afc.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2f494e1d5c2c99a4b7c0912faa4c3be3de682afc.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jun 30, 2021 at 12:39:02PM -0400, Mimi Zohar wrote:
> On Tue, 2021-06-29 at 04:32 +0300, Vitaly Chikunov wrote:
> > On Mon, Jun 28, 2021 at 04:50:42PM -0400, Mimi Zohar wrote:
> > > 
> > > Thank you for the detailed explanation.
> > > 
> > > On Sat, 2021-06-26 at 03:42 +0300, Vitaly Chikunov wrote:
> > > 
> > > > > Requiring the optarg value to be prefixed with "0x" would
> > > > > simplify the strlen test.
> > > > > (The subsequent patch wouldn't need a contrived prefix.)
> > > > 
> > > > (I do not understand this remark at the moment.)
> > > > 
> > > > Base 16 will let user pass keyid just as a string, copy-pasting from
> > > > somewhere else.
> > > 
> > > strtoul() supports prefixing the ascii-hex string with "0x".  To
> > > differentiate between a keyid and pathname, why not require the keyid
> > > be prefixed with "0x", as opposed to requiring the pathname to be
> > > prefixed with '@', like "--keyid @/path/to/cert.pem".
> > 
> > I wanted to avoid (filename vs keyid) ambiguity of the argument to
> > `--keyid' - if user have file named "0x00112233" they would have hard
> > time passing it to `--keyid'. But, it's impossible to have keyid string
> > starting with "@". So, "@" perfectly distinguish type of `--keyid'
> > argument but "0x" isn't.
> > 
> > Also, in some software (zip, rar) "@" is common prefix meaning value
> > should be taken from the specified file. But, yes, "@" is not common
> > in Unix environments. Do you want me to create separate option like
> > `--keyid-from-file'?
> 
> It's highly unlikely that both the filename and pathname would be
> prefixed with "0x".  Defining a new option might be a good idea. 
> Possibly naming it --extract-cert-keyid,  ---cert-keyid, or --keyid-
> from-cert.  

It's not unlikely, because people may want to keep cert files named or
symlinked by keyid. (For example, local cert database keep cert files
symlinked like `f30dd6ad.0'.)

I will add an option, most understandable, perhaps, is `--keyid-from-cert'.

Also, I will remove base 16 from --keyid argument.

Thanks,

> 
> thanks,
> 
> Mimi
