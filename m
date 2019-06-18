Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15C34A320
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jun 2019 15:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbfFRN7Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jun 2019 09:59:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:56716 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbfFRN7Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jun 2019 09:59:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC1E7AEAF;
        Tue, 18 Jun 2019 13:59:22 +0000 (UTC)
Date:   Tue, 18 Jun 2019 15:59:21 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Ignaz Forster <iforster@suse.de>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4 4/4] ima: Add overlay test + doc
Message-ID: <20190618135921.GA30776@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190613161414.29161-1-pvorel@suse.cz>
 <20190613161414.29161-5-pvorel@suse.cz>
 <55f6fec4-ef01-db2b-62c0-cbbbf79c6c12@suse.de>
 <20190614141449.GA24614@dell5510>
 <794ee977-463f-6670-fac6-3e27e25d64ab@suse.de>
 <20190614144611.GA869@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614144611.GA869@dell5510>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Ignaz,

> > > > This test requires "appraise_tcb" ("tcb" is not enough), as the errors only
> > > > occur during appraisal.
> > > Are you sure? This is a note for ima_measurements.sh test (not for evm_overlay.sh).
> > > I require ima_policy=tcb here, according to Mimi [1]

> > Oh, sorry, you are correct - "tcb" is correct in this case. I got confused
> > as the documentation is included in the overlayfs reproducer patch.
> Maybe I should put it into separate commit.
Whole patchset merged.

Thanks a lot both for your help!


Kind regards,
Petr
