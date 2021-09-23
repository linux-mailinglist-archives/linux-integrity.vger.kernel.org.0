Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C413415AA8
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Sep 2021 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbhIWJQV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Sep 2021 05:16:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38068 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbhIWJQV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Sep 2021 05:16:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A1D4C1FD77;
        Thu, 23 Sep 2021 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632388489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjEblAiuGNbLAlz7cWIUzWMmxgmFSh7dc4Xmm8c/hlc=;
        b=II5LAtdmSFIfgYb7p+C9dc9GpELTacSqcNWCM9Dw7UqydrQIR0cglyKiQSZrJNZr3NZcOm
        CdLM9+PSuhrQ8fpgMZW03ynWaIjmHf+CZhOHBOsLF6EIl+mUC3aSoZLrW8imteoFYbDKr1
        vdMM2ZQHweOz5GZyd/nUmylNojFagQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632388489;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hjEblAiuGNbLAlz7cWIUzWMmxgmFSh7dc4Xmm8c/hlc=;
        b=wO07WqoB8a+0KayhCvAg0lnof9fBZRs39RYBwkc/NrwBmdoa2zJdxbWM6pXeyLpYYCTBPj
        afEpYkvmGkET8WCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59E3913DCA;
        Thu, 23 Sep 2021 09:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gBEDE4lFTGHBNgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 23 Sep 2021 09:14:49 +0000
Date:   Thu, 23 Sep 2021 11:14:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     ltp@lists.linux.it, alexhenrie24@gmail.com,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 3/3] IMA: Add tests for uid, gid, fowner, and fgroup
 options
Message-ID: <YUxFh1Gp231NftEY@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210922115310.5927-1-pvorel@suse.cz>
 <20210922115310.5927-4-pvorel@suse.cz>
 <20210922110620.cf7530d5120d2f0173ed2f05@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922110620.cf7530d5120d2f0173ed2f05@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Wed, 22 Sep 2021 13:53:10 +0200
> Petr Vorel <pvorel@suse.cz> wrote:

> > From: Alex Henrie <alexh@vpitech.com>

> > Requires "ima: add gid support".

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Alex Henrie <alexh@vpitech.com>
> > [ pvorel: add test_file parameter to ima_check(), add
> > verify_measurement() (DRY) ]
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Thanks Petr for taking over and making the changes you want directly,
> that makes my life much easier.
yw. FYI I'll merge v7 after it's merged into mainline, I expect it'll be in v5.16-rc1.
Could you please notify me if I forget?

I'll try to have look into kernel patch itself.

Kind regards,
Petr

> -Alex
