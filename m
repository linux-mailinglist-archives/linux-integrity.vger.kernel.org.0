Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7632440F69E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 13:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243977AbhIQLSF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 07:18:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhIQLSB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 07:18:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AFA0A20274;
        Fri, 17 Sep 2021 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631877397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrucSyRNV+iSRIWXvYS4We+plHhQlXfFlzMWWLD/cVc=;
        b=aZBufhiykmFpUNRnDp01cRh2h0YxooLWtYtIvM2JtAUQ9DggVxS4DBQYAkuC78aRbBq2+4
        cYhrSOq+Fcw0cZWanmZFMV6WCD7F5c8YHS9X2RC8UDvUH0fKvZIptaGW7FG+rsmiZI/o9K
        YltUuaF/dv9A5v9jXtsuVrVhCtpSq9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631877397;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrucSyRNV+iSRIWXvYS4We+plHhQlXfFlzMWWLD/cVc=;
        b=bQTAqY7JWqZzIqOS5JEEkvckCkFCyfQYhxihJRRpFtsvhBsxOptBLFFLYcScRfDFlGY6jz
        PBmAGpHZeGv7XfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ED1414063;
        Fri, 17 Sep 2021 11:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3CsZGRV5RGF4HQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 11:16:37 +0000
Date:   Fri, 17 Sep 2021 13:16:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v3 1/2] IMA: Move check_policy_writable to
 ima_setup.sh and rename it
Message-ID: <YUR5E6eFMxieUbWA@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210914161503.97495-1-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914161503.97495-1-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

...
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh

As it's now a generally used function I'll add a comment:

# Because we don't grep kernel config for CONFIG_IMA_WRITE_POLICY, we just try
# to write empty string (invalid), thus policy must be repeatedly checked.
# Because after first write to policy policy will be removed on systems without
# CONFIG_IMA_WRITE_POLICY.
> +require_policy_writable()
> +{
> +	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> +	# CONFIG_IMA_READ_POLICY
> +	echo "" 2> log > $IMA_POLICY
> +	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> +}
> +

Kind regards,
Petr
