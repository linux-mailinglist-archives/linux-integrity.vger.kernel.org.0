Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A3B6298F0
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Nov 2022 13:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKOMch (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 07:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKOMcg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 07:32:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B9A1CB0D
        for <linux-integrity@vger.kernel.org>; Tue, 15 Nov 2022 04:32:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8BA41F8B4;
        Tue, 15 Nov 2022 12:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668515552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1HMjDHx+jtn2OlJLOTd3lTk4+o+SNofvggm9DUXbQY=;
        b=m0KnrcTh0d9MhSws5aZysjXlLSURmaydA3Hm7dgy+LGxeDGsWnXN/n6BEevEyEwWSLLF/U
        sW4fcekuXyty21J6qeWxjfmx32OlQF24RWznJpovBQ2KmsVY74OCKFMEwUwu4nU7JZZCat
        tKCSw7/wPYhOnwfNQrtSr3fJhsHC5VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668515552;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H1HMjDHx+jtn2OlJLOTd3lTk4+o+SNofvggm9DUXbQY=;
        b=J/oU2GqZBWX+/f0ShdkQ6kiWbNXJfV+QLC9dwkl1t9oWtBEuRyOvzSMu97qD8vMDZ7+wOw
        SYBMElMVWQSEo6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9648813A91;
        Tue, 15 Nov 2022 12:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id emuDIuCGc2NwQwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 15 Nov 2022 12:32:32 +0000
Date:   Tue, 15 Nov 2022 13:32:30 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH ima-evm-utils] Save ima-evm-utils sourceforge wiki
Message-ID: <Y3OG3vzaPYCWntCa@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221114222451.832058-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114222451.832058-1-zohar@linux.ibm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, all,

> The sourceforge wiki info is dated and requires a major overhaul.  Some
> of the information already exists in the linux kernel documentation.
> For now, save it with the referenced html files.
May I ask why you in the end reverted this from next-testing?
fdd58fa ("Revert "Save ima-evm-utils sourceforge wiki"") has no explanation.
Maybe I missed some email.

I like moving docs to git repository.

Kind regards,
Petr
