Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03492477B4
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgHQTwr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 15:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:33910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgHQTwq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 15:52:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4DF2AAB0;
        Mon, 17 Aug 2020 19:53:10 +0000 (UTC)
Date:   Mon, 17 Aug 2020 21:52:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     ltp@lists.linux.it, Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 0/4] IMA: verify measurement of certificate imported
 into a keyring
Message-ID: <20200817195244.GA112397@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200817130916.27634-1-pvorel@suse.cz>
 <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc89bf8e0c40e6d66c86b42f55f9bf69ec7e335e.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Mon, 2020-08-17 at 15:09 +0200, Petr Vorel wrote:
> > Hi Mimi, Lakshmi,

> > changes v2->v3:
> > fixed regression in my third commit.
> > (please verify it on installed LTP, or at least run make install in
> > testcases/kernel/security/integrity/ima/datafiles/ima_keys/)

> I did, but nothing changed.  I probably need to set an environment
> variable.
You also need to set LTPROOT (prefix, e.g. /opt/ltp).

> After building and installing LTP, it's finding the file, but some of
> the issues still exist:

> ima_keys 1 TINFO: $TMPDIR is on tmpfs => run on loop device
> ima_keys 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
> ima_keys 1 TINFO: verify key measurement for keyrings and templates specified in IMA policy
> grep: Unmatched ( or \(
This should be fixed by v3 (fixed by for loop and sort -u)
https://patchwork.ozlabs.org/project/ltp/patch/20200817130916.27634-5-pvorel@suse.cz/
But I'll test it tomorrow with your IMA policy.

Thank you for testing!

Kind regards,
Petr

> ima_keys 1 TPASS: specified keyrings were measured correctly
> ima_keys 2 TINFO: verify measurement of certificate imported into a keyring
> keyctl_session_to_parent: Operation not permitted
> ima_keys 2 TPASS: logged certificate matches the original

> IMA policy:
> measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf 
> measure func=KEY_CHECK keyrings=key_import_test template=ima-buf 

> Mimi

