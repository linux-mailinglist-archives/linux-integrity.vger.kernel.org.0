Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616A32206E9
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 10:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgGOITA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 04:19:00 -0400
Received: from [195.135.220.15] ([195.135.220.15]:50670 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729751AbgGOITA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 04:19:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 38EA1B023;
        Wed, 15 Jul 2020 08:19:02 +0000 (UTC)
Date:   Wed, 15 Jul 2020 10:18:57 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, ltp@lists.linux.it,
        nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] IMA: Verify that the kernel cmdline is passed and
 measured correctly through the kexec barrier.
Message-ID: <20200715081857.GB10916@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200702153545.3126-1-t-josne@linux.microsoft.com>
 <20200702153545.3126-2-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702153545.3126-2-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Add a testcase that verifies that kexec correctly logs the
> kernel command line to the IMA buffer and that the command
> line is then correctly measured.

> This test must be run standalone, since it runs kexec
> multiple times (and therefore reboots several times).

> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
...
> +++ b/testcases/kexec/utils.sh
> @@ -0,0 +1,47 @@
> +#!/bin/sh
> +
> +install() {
> +    local arg="$1"
> +
> +    if [ ! -d "/etc/init.d" ]; then
> +        mkdir /etc/init.d
> +    fi
I'm not sure if tests like this are suitable for LTP.
Ideal LTP test is a normal test, which is able to run with runltp, cleanup after
itself and use LTP C or/and shell API. LTP is full of tests which needs special
handling and thus not being run, not sure if it's a good idea to introduce yet
another one.

Also test shouldn't not significantly modify SUT to make it unbootable, which
I'm not sure in this case. This is a big difference to kselftests which are
meant to help during kernel development which somehow expects some system
modifications (as you install your custom build kernel).

I wonder if using QEMU would help to implement this test while not touching SUT
(thus be able to run this test with runltp). If you miss something in LTP API
just let us know.

Kind regards,
Petr
