Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2A696ED0
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Feb 2023 22:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjBNVBs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Feb 2023 16:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjBNVBr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Feb 2023 16:01:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC528D13
        for <linux-integrity@vger.kernel.org>; Tue, 14 Feb 2023 13:01:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 65EB821A0C;
        Tue, 14 Feb 2023 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676408501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8YtHo5t1D2A3phLSJQpngIab2/UVnrQKg5vB0C96+k=;
        b=CF10oCLsQ/DbfiffG8JlpbfQujzU2CHSBOWCchTd/fgbDY94KaftePIuE2NhVRfDK5uPv2
        HBMlZUZSqB4JR3UFBvov7S/HqbfbXc73MstfRPAvhLpwj7qHk6w+60ciPE+eIEtUj4udYC
        84vCPBlHIlik2x+23Faqbj4JUQT1AWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676408501;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8YtHo5t1D2A3phLSJQpngIab2/UVnrQKg5vB0C96+k=;
        b=9/iCDNvUKiBs+k6OdjAv+DsQWVFAP2AuVvx0g3Zi3HL/lQcLO/q3k4ku9yYkPGfnx5uiVf
        G4ElPvxMhhyAQECA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17A0A13A21;
        Tue, 14 Feb 2023 21:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vpKKA7X262PyeAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 14 Feb 2023 21:01:41 +0000
Date:   Tue, 14 Feb 2023 22:01:39 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com, vt@altlinux.org, stefanb@linux.ibm.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] CI: Tumbleweed openSSL fix
Message-ID: <Y+v2synszNf1MRn/@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230214210035.585395-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214210035.585395-1-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Tested:
> https://github.com/pevik/ima-evm-utils/actions/runs/4177976359/jobs/7236222413

NOTE: I cannot test this on Travis.

Kind regards,
Petr

> Petr Vorel (3):
>   tests/install-swtpm.sh: Update ibmswtpm2 to 1682
>   github: travis: Remove COMPILE_SSL from tumbleweed
>   github: Put openSSL build into own section

>  .github/workflows/ci.yml | 8 ++++++--
>  .travis.yml              | 2 +-
>  tests/install-swtpm.sh   | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
