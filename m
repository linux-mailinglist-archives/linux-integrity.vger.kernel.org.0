Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137C414D7DD
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jan 2020 09:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgA3Ilr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jan 2020 03:41:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:52024 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgA3Ilr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jan 2020 03:41:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9A1C7AEC4;
        Thu, 30 Jan 2020 08:41:45 +0000 (UTC)
Date:   Thu, 30 Jan 2020 09:41:43 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 1/2] ima: use the IMA configured hash algo to calculate
 the boot aggregate
Message-ID: <20200130084143.GA31906@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
 <20200127204941.2ewman4y5nzvkjqe@cantor>
 <1580160699.5088.64.camel@linux.ibm.com>
 <20200129083034.GA387@dell5510>
 <1580338276.4790.8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1580338276.4790.8.camel@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> > > The original LTP ima_boot_aggregate.c test needed to be updated to
> > > support TPM 2.0 before this change.  For TPM 2.0, the PCRs are not
> > > exported.  With this change, the kernel could be reading PCRs from a
> > > TPM bank other than SHA1 and calculating the boot_aggregate based on a
> > > different hash algorithm as well.  I'm not sure how a remote verifier
> > > would know which TPM bank was read, when calculating the boot-
> > > aggregate.
> > Mimi, do you plan to do update LTP test?

> In order to test Roberto's patches that calculates and extends the
> different TPM banks with the appropriate hashes, we'll need some test
> to verify that it is working properly.  As to whether this will be in
> LTP or ima-evm-utils, I'm not sure.
Sure, it's up to you where you place the test (if you plan to write it).

BTW I see evmtest [1] haven't been merged yet into ima-evm-utils.
What's blocking to merge them? (My objections to require bash shouldn't be the
reason for not being merged.)
I'd like to package them separately for developers to run them on SUT
(unless they're meant to be running only during building package).

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/linux-integrity/list/?series=95303
