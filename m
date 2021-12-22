Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6547D448
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 16:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343722AbhLVPd7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 10:33:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42650 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbhLVPd6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 10:33:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F730B81D01
        for <linux-integrity@vger.kernel.org>; Wed, 22 Dec 2021 15:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6333C36AE8;
        Wed, 22 Dec 2021 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640187236;
        bh=PmIDdS4IybuygmCjt0en1LveCUWmmqBJ/vB3gTgpAB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gho7k+2tkTwtD4p/dGCpsSYKTTCRBF7WwqWi5PmmzPDyjR5/xLe83w4EuvC/n9dYt
         JdmQhGfR4042vEQcowtO8OedVZCsqaN1K0g5nXTzJ9flj2f2DymSIbOY3kLF7GDYoJ
         +YlnwWpvjfIP1Xgn1hL9oXd9H/zats9nDU8V1cJpukXEBHKBBd8UlKKKE49EPtx7V8
         XdnemwNqvU5rFCHepLUOJGU7HPUD7+eMQMBLjC0zv6sYBh1YqKuA0JCWW0HhHwxLnZ
         G67VPfDROMZJzIAXDsRleI9IWuQQbHdXXYbD+3JDa2MmNZkJ+KXSEszK/unpBlNx+T
         Ty5XUnpwZzmGQ==
Date:   Wed, 22 Dec 2021 09:33:53 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Yael Tiomkin <yaelt@google.com>
Cc:     ltp@lists.linux.it, zohar@linux.ibm.com, pvorel@suse.cz,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] syscalls/keyctl09: test encrypted keys.
Message-ID: <YcNFYd78LfV2FcSW@quark>
References: <20211221023721.129689-1-yaelt@google.com>
 <YcNA4w6mof+zKIak@quark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcNA4w6mof+zKIak@quark>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 22, 2021 at 09:14:43AM -0600, Eric Biggers wrote:
> On Mon, Dec 20, 2021 at 09:37:21PM -0500, Yael Tiomkin wrote:
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> > new file mode 100644
> > index 000000000..507cd5628
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021 Google, Inc.
> > + */
> > +
> > +/*\
> > + * [Description]
> > + * Test that encrypted keys can be instantiated using user-provided decrypted
> > + * data (plaintext), and separately, using kernel-generated key material.
> > + */
> > +
> 
> This test doesn't seem to work as intended.
> 
> First, it fails if CONFIG_ENCRYPTED_KEYS is unset (it should be skipped):
> 
> 	keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data
> 
> Second, I don't have your patch "Instantiate key with user-provided decrypted
> data" (https://lore.kernel.org/r/20211213192030.125091-1-yaelt@google.com) in my
> kernel, so instantiating a key using "user-provided decrypted data" is not
> implemented by the kernel.  However, the test still passes regardless:
> 
> 	keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read    
> 
> The test should detect when "user-provided decrypted data" is not supported by
> the kernel, and report that the test of that is being skipped in that case.
> 

And of course, if "user-provided decrypted data" *is* supported by the kernel,
the test should actually test it.

- Eric
