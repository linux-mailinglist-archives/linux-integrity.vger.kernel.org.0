Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0926767C08B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 00:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbjAYXAv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 18:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAYXAv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 18:00:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B3E13DE5
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 15:00:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E080721D06;
        Wed, 25 Jan 2023 23:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674687647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqX3ijIXOkM4mYOwv+g8QMys5vkFFpCcCAdMion2J3w=;
        b=0f2NH+4pCdUugxE47Yc8ENSNrT5YEHlwBW3psSuY1bw4G5zmP7V7MU1EkflKRoerZIbmvQ
        tjSGMBOlDeH32qmwDZr0Syi+xzjy0ABmiws7mAZbWJtcY1qD7kYhq5rDJivqHA+Zpmpeog
        ihoT38phPlaOhRTogW44e/S+RefX5Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674687647;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kqX3ijIXOkM4mYOwv+g8QMys5vkFFpCcCAdMion2J3w=;
        b=4bCtaW3/+15wPAMqRRyHi5ZdijlyUj6OGUsHYFtKUG1xYxr7xJ7m/ZKKIsfwX9zPwnA3wm
        BaX7MM9xCBW2bSCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A62CA1339E;
        Wed, 25 Jan 2023 23:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fNb5Jp+00WMDRQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 23:00:47 +0000
Date:   Thu, 26 Jan 2023 00:00:46 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] ci: cleanup build.sh test log output
Message-ID: <Y9G0nhYZmqsW2PUd@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230125221311.395032-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221311.395032-1-zohar@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Unlike the original ima-evm-utils ima_hash.test and sign_verify.test
> selftests, kernel tests may fail for any number of reasons (e.g. kernel
> config, permissions, missing applications, test infrastructure).  For
> these tests, the full test log is needed to analyze the failure.

> Create a phony target in tests/Makefile.am named "check-logs". Based on
> test name, output different amounts of the test log.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
