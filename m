Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385292F4007
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Jan 2021 01:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhALXNo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 18:13:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:36428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbhALXNn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 18:13:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EC26AB7A;
        Tue, 12 Jan 2021 23:13:02 +0000 (UTC)
Date:   Wed, 13 Jan 2021 00:13:00 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        ltp@lists.linux.it
Subject: Re: [PATCH v2 2/2] IMA: Add test for dm-crypt measurement
Message-ID: <X/4s/AhZ6+eTcYnv@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
 <20200928035605.22701-3-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928035605.22701-3-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
> @@ -0,0 +1,60 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> +#
> +# Verify that DM target dm-crypt are measured correctly based on policy.
> +
> +TST_NEEDS_CMDS="dmsetup"
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +
> +. ima_setup.sh
> +
> +FUNC_CRIT_DATA='func=CRITICAL_DATA'
> +TEMPLATE_BUF='template=ima-buf'
> +REQUIRED_POLICY="^measure.*($FUNC_CRIT_DATA.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_CRIT_DATA)"
> +
> +setup()
> +{
> +	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
> +}
> +
> +cleanup()
> +{
> +	ROD "dmsetup remove test-crypt"
FYI: there should be check that dmsetup create was run.
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#a-word-about-the-cleanup-callback

i.e. here:

[ "$dmsetup_run" ] || return
ROD "dmsetup remove test-crypt"

+ see below.

> +}
> +
> +test1()
> +{
> +	local input_digest="039d8ff71918608d585adca3e5aab2e3f41f84d6"
> +	local pattern='data_sources=[^[:space:]]+'
> +	local tmp_file="$TST_TMPDIR/dm_crypt_tmp.txt"
> +	local policy="data_sources"
> +	local arg key res
> +
> +	tst_res TINFO "verifying dm target - dmcrypt gets measured correctly"
> +
> +	check_policy_pattern "$pattern" $FUNC_CRIT_DATA $TEMPLATE_BUF > $tmp_file || return
> +
> +	tgt="crypt"
> +	key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
> +
> +	arg="'0 1953125 crypt aes-xts-plain64 "
> +	arg="$arg $key 0 "
> +	arg="$arg /dev/loop0 0 1 allow_discards'"
> +
> +	ROD "dmsetup create test-crypt --table $arg"
adding 
dmsetup_run=1

Kind regards,
Petr
