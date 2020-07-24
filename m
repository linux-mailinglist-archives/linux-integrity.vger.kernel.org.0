Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D7922BD78
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgGXF2m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 01:28:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:53472 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGXF2m (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 01:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A5257AB89;
        Fri, 24 Jul 2020 05:28:49 +0000 (UTC)
Date:   Fri, 24 Jul 2020 07:28:39 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200724052839.GA32086@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
 <20200722144510.l5qwn62dlanbuul4@altlinux.org>
 <20200722145047.GB18945@dell5510>
 <1595431869.5311.102.camel@linux.ibm.com>
 <1595503098.5211.85.camel@linux.ibm.com>
 <20200723115457.GA26679@dell5510>
 <1595506070.5211.103.camel@linux.ibm.com>
 <20200723122934.GA30011@dell5510>
 <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723140420.jwz6rjwq5j2ouzzt@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> > BTW could you also merge your .travis.yml from next-testing-travis to next (and
> > preferably also to master)? Even if you have no way to setup automatic mirror to
> > some travis account, it help to run it sometimes or at least before release.

> Also, it's useful to packagers to see that there is tests and how to run
> them.
+1

Kind regards,
Petr
