Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECA4B722DC
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 01:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfGWXNS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 19:13:18 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42980 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfGWXNS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 19:13:18 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5447D72CCDF;
        Wed, 24 Jul 2019 02:13:16 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4290F4A4AE8;
        Wed, 24 Jul 2019 02:13:16 +0300 (MSK)
Date:   Wed, 24 Jul 2019 02:13:16 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ima-evm-utils: log unknown keyid's as errors
Message-ID: <20190723231316.rnngionrm4lrtyct@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
References: <1563460194-21569-1-git-send-email-zohar@linux.ibm.com>
 <1563460194-21569-2-git-send-email-zohar@linux.ibm.com>
 <20190723221801.ycvdj5eajlrozxf6@altlinux.org>
 <1563922756.4294.16.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563922756.4294.16.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 23, 2019 at 06:59:16PM -0400, Mimi Zohar wrote:
> On Wed, 2019-07-24 at 01:18 +0300, Vitaly Chikunov wrote:
> > On Thu, Jul 18, 2019 at 10:29:54AM -0400, Mimi Zohar wrote:
> > > Each tima a new unknown key is encountered, emit a message of the format
> > > "key #: <keyid> unknown".  The individual files using unknown keys are
> > > then only logged in verbose mode.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  src/libimaevm.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index 43eb4ef2412c..d2194a6ca0f8 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -402,13 +402,26 @@ static struct public_key_entry *public_keys = NULL;
> > >  
> > >  static EVP_PKEY *find_keyid(uint32_t keyid)
> > >  {
> > > -	struct public_key_entry *entry;
> > > +	struct public_key_entry *entry, *tail = public_keys;
> > 
> > If user specified in `-k` filename that does not exist no key is added
> > into public_keys and it remains NULL.
> 
> Right, just the keyid is added and an error message is emitted.
> 
> > 
> > > +	int i = 1;
> > >  
> > >  	for (entry = public_keys; entry != NULL; entry = entry->next) {
> > >  		if (entry->keyid == keyid)
> > >  			return entry->key;
> > > +		i++;
> > > +		tail = entry;
> > >  	}
> > > -	return NULL;
> > > +
> > > +	/* add unknown keys to list */
> > > +	entry = calloc(1, sizeof(struct public_key_entry));
> > > +	if (!entry) {
> > > +		perror("calloc");
> > > +		return 0;
> > > +	}
> > > +	entry->keyid = keyid;
> > > +	tail->next = entry;
> > 
> > In that case here is SIGSEGV when user try to ima_verify.
> 
> find_keyid() returns NULL, which is checked before being used.
> šThere's only one caller of this function.

find_keyid does not return since tail is NULL, thus there is null
dereference in `tail->next`.

> Do you have a test case to reproduce this bug?

  ima-evm-utils/tests ((31b5f50...))$ rm sha1.txt
  ima-evm-utils/tests ((31b5f50...))$ touch sha1.txt
  ima-evm-utils/tests ((31b5f50...))$ evmctl ima_sign -k test-rsa1024.key -a sha1 --xattr-user sha1.txt
  ima-evm-utils/tests ((31b5f50...))$ evmctl ima_verify -k /absent --xattr-user sha1.txt
  Failed to open keyfile: /absent
  Segmentation fault

31b5f50 is head of your git next branch.

I temporary fixed like this:

-       tail->next = entry;
+       if (tail)
+               tail->next = entry;
+       else
+               public_keys = entry;

