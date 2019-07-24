Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2A572387
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 02:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfGXAus (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 20:50:48 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48836 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfGXAus (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 20:50:48 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 025FC72CCDF;
        Wed, 24 Jul 2019 03:50:46 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id E1C2A4A4AE8;
        Wed, 24 Jul 2019 03:50:45 +0300 (MSK)
Date:   Wed, 24 Jul 2019 03:50:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ima-evm-utils: log unknown keyid's as errors
Message-ID: <20190724005044.2t3mlpyh7goxah6s@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563460194-21569-1-git-send-email-zohar@linux.ibm.com>
 <1563460194-21569-2-git-send-email-zohar@linux.ibm.com>
 <20190723221801.ycvdj5eajlrozxf6@altlinux.org>
 <1563922756.4294.16.camel@linux.ibm.com>
 <20190723231316.rnngionrm4lrtyct@altlinux.org>
 <1563927586.4294.20.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563927586.4294.20.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 23, 2019 at 08:19:46PM -0400, Mimi Zohar wrote:
> On Wed, 2019-07-24 at 02:13 +0300, Vitaly Chikunov wrote:
> > > > > +	tail->next = entry;
> > > > 
> > > > In that case here is SIGSEGV when user try to ima_verify.
> > > 
> > > find_keyid() returns NULL, which is checked before being used.
> > > šThere's only one caller of this function.
> > 
> > find_keyid does not return since tail is NULL, thus there is null
> > dereference in `tail->next`.
> > 
> > > Do you have a test case to reproduce this bug?
> > 
> >   ima-evm-utils/tests ((31b5f50...))$ rm sha1.txt
> >   ima-evm-utils/tests ((31b5f50...))$ touch sha1.txt
> >   ima-evm-utils/tests ((31b5f50...))$ evmctl ima_sign -k test-rsa1024.key -a sha1 --xattr-user sha1.txt
> >   ima-evm-utils/tests ((31b5f50...))$ evmctl ima_verify -k /absent --xattr-user sha1.txt
> >   Failed to open keyfile: /absent
> >   Segmentation fault
> > 
> > 31b5f50 is head of your git next branch.
> > 
> > I temporary fixed like this:
> > 
> > -       tail->next = entry;
> > +       if (tail)
> > +               tail->next = entry;
> > +       else
> > +               public_keys = entry;
> 
> I see.  If you don't object, I'll fold this into the original patch. 

Of course.

Thanks,

