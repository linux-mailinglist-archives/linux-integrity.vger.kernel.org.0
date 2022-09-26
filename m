Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D075E9E5C
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Sep 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiIZJxF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Sep 2022 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiIZJxE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Sep 2022 05:53:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AFCB47
        for <linux-integrity@vger.kernel.org>; Mon, 26 Sep 2022 02:53:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E61D2220FD;
        Mon, 26 Sep 2022 09:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664185981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8x+ytHZbtagrUB583NioKF/B94WLDFiCktQtB6qaWA=;
        b=wiAcYwAEbKdhVWLT1PseBXkQIBCncDOpUuinjBvpUFy4CUOTkALZKwvdW8302Jc7zkvQ8T
        6B7gLtbYH1d5o1vz3PSilA54KJKJLosgmkWeESuYmJnOIROBIn+yNs5JoHaCEPFfHnt+OG
        bZYnqylpsIGUJ91GmpnRMg3zXozWV8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664185981;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8x+ytHZbtagrUB583NioKF/B94WLDFiCktQtB6qaWA=;
        b=1KLwjFT46vspqXwhU+cHiz0r3fmxktAjUW9aX7GHQOh2On9MLQWSzOXd9iDS2lFaJm0bxh
        /ZwywmmcDeJmj4DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94532139BD;
        Mon, 26 Sep 2022 09:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v0M5In12MWP5BAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 26 Sep 2022 09:53:01 +0000
Date:   Mon, 26 Sep 2022 11:52:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.ibm.com>,
        Li Wang <liwang@redhat.com>, Martin Doucha <mdoucha@suse.cz>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/3] ima_setup.sh: Use tst_supported_fs instead of df
Message-ID: <YzF2exld6LqWrxi8@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220923105554.28942-1-pvorel@suse.cz>
 <20220923105554.28942-4-pvorel@suse.cz>
 <Yy2k448Z6mweD+TS@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2k448Z6mweD+TS@yuki>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

[ Cc linux-integrity ML ]

Cyril, thanks a lot for your review, patchset merged.

@linux-integrity Last 7 fixes made IMA working on my setup, if anything broken
please speak up, so that we can fix it before LTP release (git freeze is going
to be very soon, likely this week).

Kind regards,
Petr
