Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142694C6E7B
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Feb 2022 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiB1NpO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Feb 2022 08:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiB1NpM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Feb 2022 08:45:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1059041988;
        Mon, 28 Feb 2022 05:44:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 830BE1F899;
        Mon, 28 Feb 2022 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646055872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S71zosWP0qbc18ePiTgFDhbq1Yuo06MT71tp5Uj+ZSI=;
        b=HKttq5PL6FFWYPNiyBYQw2eN+tuG84zd2ERBQhKnMPTa6r0JG54oqy4yRZ6Bg6IrpW06Ug
        fgCgIePKVgdSz5XyaLu9J2TQhrkQqVAam9Zf+QfHPsMPd/21WYt5wIHIhgtVSDRbh9kSWU
        H0ss4eUwxk6fgUP25HfTtU6xRyeskCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646055872;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S71zosWP0qbc18ePiTgFDhbq1Yuo06MT71tp5Uj+ZSI=;
        b=RaQpsLoyWuJO9TZFCeG+kbUosmvLSIDB+MessTX5ffBvbR+rgiCW5W2szdOS13PtdwnE/4
        nJDojKLZ4JyETuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1977813ADA;
        Mon, 28 Feb 2022 13:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4Fp5A8DRHGIFSwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 28 Feb 2022 13:44:32 +0000
Date:   Mon, 28 Feb 2022 14:44:30 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, dvyukov@google.com,
        ebiggers@kernel.org, jmorris@namei.org, keescook@chromium.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Message-ID: <YhzRvhsOPxrKHzq9@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
 <20220224142025.2587-1-pvorel@suse.cz>
 <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
 <YhfDhYQYZTU0clAf@pevik>
 <9405bcfc-78bd-8e7f-41d4-b919221f73e4@schaufler-ca.com>
 <c4842493db13fd6f05eda54c1ef4c94e9d687850.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4842493db13fd6f05eda54c1ef4c94e9d687850.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, all,

> Hi Petr, Casey,

> On Thu, 2022-02-24 at 10:51 -0800, Casey Schaufler wrote:
> > On 2/24/2022 9:42 AM, Petr Vorel wrote:

> > It was always my expectation, which appears to have been poorly
> > communicated, that "making integrity an LSM" meant using the LSM
> > hook infrastructure. Just adding "integrity" to lsm= doesn't make
> > it an LSM to my mind.

> Agreed.  The actual commit that introduced the change was 3d6e5f6dcf65
> ("LSM: Convert security_initcall() into DEFINE_LSM()").
I wonder whether we can improve things now.

Kind regards,
Petr
