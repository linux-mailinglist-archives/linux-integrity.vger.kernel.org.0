Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81356412FA4
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Sep 2021 09:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhIUHra (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Sep 2021 03:47:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55338 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhIUHra (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Sep 2021 03:47:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64C331FEA7;
        Tue, 21 Sep 2021 07:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632210361;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbaVPv4vSSElBKs3pswuaVlQJR+eOjyDCJovMxOgnqk=;
        b=dGm4CkiIXYfobIWE/thguVkW5zmNYSu/u0z5fPbFab4djtg6bi3oHTA74TWScP5fqzD/sU
        jSc49jZuB0T40nCP2lUlngCNFC+OndZm9D0ev6uqp5XMKI2NdOlSquZp03MzbE91sX+OHz
        Vo1+8OdvY0XnpIdAItoCzR78If2LYhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632210361;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbaVPv4vSSElBKs3pswuaVlQJR+eOjyDCJovMxOgnqk=;
        b=9fNKcD1Xtg0NULcFj1a/CPLcpYQU6J996R/3UTJIEGnfrGJkBa4NV3QnaJztsQBAl0cHJ5
        Y9AgtJ/az/V0g3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 306D513B0A;
        Tue, 21 Sep 2021 07:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id txCyCbmNSWFnDwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 21 Sep 2021 07:46:01 +0000
Date:   Tue, 21 Sep 2021 09:45:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v4 3/3] IMA: Add tests for uid, gid, fowner, and
 fgroup options
Message-ID: <YUmNt06CD97u0Drs@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210921004140.15041-1-alexh@vpitech.com>
 <20210921004140.15041-3-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921004140.15041-3-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh
> @@ -0,0 +1,57 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2021 VPI Technology
> +# Author: Alex Henrie <alexh@vpitech.com>
> +#
> +# Verify that conditional rules work.
> +
> +TST_NEEDS_CMDS="awk chgrp chown cut sg sudo"
awk, cut are not used. Or is that a dependency from some helpers in
ima_setup.sh? (these should check the dependency themselves via tst_require_cmds).

The rest LGTM, I just need to retest it.

Kind regards,
Petr
