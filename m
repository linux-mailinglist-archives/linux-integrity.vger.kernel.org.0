Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B92206AF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 10:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgGOIDr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 04:03:47 -0400
Received: from [195.135.220.15] ([195.135.220.15]:42170 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgGOIDr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 04:03:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E375AF31;
        Wed, 15 Jul 2020 08:03:49 +0000 (UTC)
Date:   Wed, 15 Jul 2020 10:03:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
Message-ID: <20200715080344.GA10916@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
 <1594774692.12900.220.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1594774692.12900.220.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Thu, 2020-07-02 at 11:35 -0400, Lachlan Sneff wrote:
> > Add a testcase that verifies that kexec correctly logs the
> > kernel command line to the IMA buffer and that the command
> > line is then correctly measured.

> > This test must be run standalone, since it runs kexec
> > multiple times (and therefore reboots several times).

> Verifying the kexec boot command line doesn't require rebooting.  Just
> loading the kexec kernel image should be enough (kexec -s -l).
>  Verifying that the measurement list, including the kexec boot command
> line, is carried across kexec could be a separate test.
Mimi, thanks for a confirmation.
Lachlan, so is it possible to turn it as a normal LTP test? And the test looks
like IMA specific now, thus I'd move it into IMA tests.

I'll post some comments to the test itself.

Kind regards,
Petr
