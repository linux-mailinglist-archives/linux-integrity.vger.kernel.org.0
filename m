Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD944762A
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Nov 2021 23:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbhKGWF3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 7 Nov 2021 17:05:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37924 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbhKGWF2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 7 Nov 2021 17:05:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E363212C2;
        Sun,  7 Nov 2021 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636322564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuwAcJ4HaM7MbmUxUL/7LP4ABH9efUxTbsQvUNRJ0zg=;
        b=VZBBh2SY0CW1WNPjAVzilyUHUPwlc2zgUyVcxC9cxGA76vyOP1SEWBYSkb6Ra2X5dNq1Nr
        /1JnH5KACfy7ULQoRZwYcD5Vum2bhxeb2QxJhandi0XCCi6xtyR9AgTgXFQ343NOHZjxfc
        ldSuz59w6s7stzACNWX8SFjhmhCeZP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636322564;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AuwAcJ4HaM7MbmUxUL/7LP4ABH9efUxTbsQvUNRJ0zg=;
        b=OI/z3YQKDSYd9PYkKNzJY7eQeku2WBAC4toeoN9VqTbmm9UAiyKPZ1hFEPiDuulRsBBxXi
        hEbv/BER/L+wd+Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 228C513517;
        Sun,  7 Nov 2021 22:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jGjdAwRNiGFzKgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sun, 07 Nov 2021 22:02:44 +0000
Date:   Sun, 7 Nov 2021 23:02:42 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.4 released
Message-ID: <YYhNAojmg/OTgSRt@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi, all,

> On 11/5/2021 1:15 AM, Petr Vorel wrote:
> > Hi Mimi,

> > > Please refer to the NEWS file for the short summary and the git history
> > > for details of the ima-evm-utils v1.4 release.

> Thanks for the info Mimi.

> I checked both "master" and "next-testing" branches in the following, and I
> still see 1.3.2 version only.

> 	https://github.com/pevik/ima-evm-utils
FYI this is my unofficial fork which I used for Travis testing, now used for
GitHub actions testing. I stated it's unofficial since it's creation in About
section.

Kind regards,
Petr

> Is there a different github url for the latest ima-evm-utils source?

> I am seeing the following errors when trying to validate IMA measurement
> using the util. I'd like to try the latest (v1.4).

> sudo ./evmctl ima_measurement
> /sys/kernel/security/ima/binary_runtime_measurements  -vv

> Error messages for the above command
> ------------------------------------
> Using tsspcrread to read PCRs.

> tpm2_pcr_supported:67 Found 'tsspcrread' in $PATHread_tpm_banks:1923
> Failed to read sha1 PCRs: (TSS_Socket_Open: Error on connect to
> localhost:2321)

> read_tpm_banks:1923 Failed to read sha256 PCRs: (TSS_Socket_Open: Error
> on connect to localhost:2321)

> Failed to read any TPM PCRs

> thanks,
>  -lakshmi


