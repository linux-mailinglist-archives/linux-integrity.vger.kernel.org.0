Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0425522FCC1
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgG0XNU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 19:13:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0XNT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 19:13:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44C32AE02;
        Mon, 27 Jul 2020 23:13:29 +0000 (UTC)
Date:   Tue, 28 Jul 2020 01:13:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     ltp@lists.linux.it,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v5 4/4] IMA: Add test for kexec cmdline measurement
Message-ID: <20200727231317.GA21554@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
 <20200727223041.13110-5-pvorel@suse.cz>
 <1d18419e-413d-ecca-8d99-342aa4ad36f7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d18419e-413d-ecca-8d99-342aa4ad36f7@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lachlan,

> This patch removes the test of the `--reuse-cmdline` option of kexec.
> Go ahead and merge this, and then I'll post a patch that adds
> `--reuse-cmdline` back.
Thanks for the report, I'll send v6.

Kind regards,
Petr
