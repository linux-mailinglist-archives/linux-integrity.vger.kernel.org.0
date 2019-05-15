Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93FF1EF52
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbfEOLce (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 May 2019 07:32:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41618 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733024AbfEOLcc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 07:32:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7F9FAAF68;
        Wed, 15 May 2019 11:32:31 +0000 (UTC)
Date:   Wed, 15 May 2019 13:32:29 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ima: Add overlay test
Message-ID: <20190515113229.GA22920@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-4-pvorel@suse.cz>
 <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810d4df7-1e5e-dd24-8b87-e0fa3edbd25f@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ignaz,

> thanks a lot for your continued work on the IMA / EVM tests and sorry for
> missing feedback - the mail got lost in my stack of TODO items.
Not a big deal and thanks a lot for a feedback and info.

> Am 05.04.19 um 18:52 Uhr schrieb Petr Vorel:
> > Should I check EVM enabled?

> As these tests require an appropriately prepared machine anyway: How about
> printing a message whether only IMA or both IMA and EVM are enabled. These
> tests make sense in both cases, so I wouldn't block them on either setup.

> > /sys/kernel/security/evm should be 1?

> Yes, that should be enough to detect whether EVM is enabled.

> > +test1()
> > +{
> > +	local file="foo1.txt"
> > +
> > +	tst_res TINFO "overwrite file in overlay"
> > +	ROD echo lower \> $lower/$file
> > +	EXPECT_PASS echo overlay \> $merged/$file

> It seems the redirection / escaping is wrong here: the string "overlay"
> never ends up in the target file.
I'm pretty sure that '>' should be escaped for both ROD and EXPECT_PASS.
EXPECT_PASS should fail (something like "evm_overlay 1 TFAIL: echo overlay ...
failed unexpectedly") if "overlay" string didn't get into $merged/$file file.
Can you sent whole output?

Kind regards,
Petr
