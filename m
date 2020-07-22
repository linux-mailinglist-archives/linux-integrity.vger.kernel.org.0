Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683A229A94
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgGVOuu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 10:50:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgGVOuu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 10:50:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 631B4AE44;
        Wed, 22 Jul 2020 14:50:56 +0000 (UTC)
Date:   Wed, 22 Jul 2020 16:50:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Drop empty NEWS file
Message-ID: <20200722145047.GB18945@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200722114729.4210-1-pvorel@suse.cz>
 <1595428021.5311.93.camel@linux.ibm.com>
 <20200722144510.l5qwn62dlanbuul4@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722144510.l5qwn62dlanbuul4@altlinux.org>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

...
> > Really annoying having to include an empty file, but without it,
> > autoconf fails with:

> > Makefile.am: error: required file './NEWS' not found
> > src/Makefile.am: installing './depcomp'
> > autoreconf: automake failed with exit status: 1

> Maybe current ChangeLog should be renamed to NEWS?

> git log is better changelog, and ChangeLog is really condensed and
> suitable to be NEWS.
+1, good idea.

Kind regards,
Petr
