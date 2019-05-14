Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A81C841
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2019 14:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENMMQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 08:12:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:33778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfENMMQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 08:12:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02EBBAF32;
        Tue, 14 May 2019 12:12:15 +0000 (UTC)
Date:   Tue, 14 May 2019 14:12:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>
Cc:     Fabian Vogt <FVogt@suse.com>, Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH v2 0/3] LTP reproducer on broken IMA on overlayfs
Message-ID: <20190514121213.GA28655@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405165225.27216-1-pvorel@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Ignaz,

Mimi, could you please have a second look on this [4] patchset? We've had a
discussion about second patch [5], I can drop it if you don't like it, but
that's not a main concern about this test. More important is whether the
testcase looks valid for you. It's about overlayfs broken in IMA+EVM,
which is currently broken on mainline.
There is different reproducer (C code) for a slightly different scenario,
but I'm not going to port it before this got merged.

Ignaz, could you please test this patchset? Could you, please, share your setup?
ima_policy=appraise_tcb kernel parameter and loading IMA and EVM keys over
dracut-ima scripts? (IMA appraisal and EVM using digital signatures? I guess
using hashes for IMA appraisal would work as well).

Kind regards,
Petr

> this is a second version of patch demonstrating a bug on overlayfs when
> combining IMA with EVM. There is ongoing work made by Ignaz Forster and
> Fabian Vogt [1] [2], IMA only behavior was already fixed [3].

> Main patch is the last one (previous are just a cleanup and not changed).

> [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
> [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
> [3] https://patchwork.kernel.org/patch/10776231/

[4] https://patchwork.ozlabs.org/project/ltp/list/?series=101213&state=*
[5] https://patchwork.ozlabs.org/patch/1078553/
