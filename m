Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAC23ED4B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgHGM10 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 08:27:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:58096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHGM10 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 08:27:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A46FAAC5E;
        Fri,  7 Aug 2020 12:27:43 +0000 (UTC)
Date:   Fri, 7 Aug 2020 14:27:23 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: Re: [PATCH 2/3] IMA: Refactor datafiles directory
Message-ID: <20200807122723.GB11014@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200803184726.2416-1-t-josne@linux.microsoft.com>
 <20200803184726.2416-3-t-josne@linux.microsoft.com>
 <20200807071754.GA9748@dell5510>
 <20200807090147.GB21400@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807090147.GB21400@dell5510>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> > > The IMA datafiles directory is structured so that it cannot be directly
> > > expanded to include datafiles for tests other than `ima_policy.sh`.

> > > Move the contents of the IMA datafiles directory into an IMA
> > > datafiles/policy directory.

> > Why it's required? Can't you use glob for inclusion?

> > *.policy for valid policies
> > *.policy-invalid for invalid policies
> > *.policy* for all policies

> > BTW I plan to use policies for other tests than just ima_policy.sh

> > I don't refuse this patch, I just simply don't understand why it's required.

> OK, I got that. Looking into $TST_DATAROOT is self explanatory.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> And I plan to use IMA policy as well for more tests will require some trick,
> but that's another story.

Thinking about it twice, keycheck.policy and kexec.policy should not be in
/opt/ltp/testcases/data/ima_policy/ as they belong to the their tests
(ima_keys.sh resp. ima_kexec.sh). I forget where are installed due "policy"
(the name of the directory).

I'll send v2 (altogether with fixes for the test) to speedup the things.

Kind regards,
Petr
