Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3F147CEDA
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 10:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhLVJKb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 04:10:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:55532 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhLVJKb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 04:10:31 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FEB9210F6;
        Wed, 22 Dec 2021 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640164230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsLHxbYaydSzdgFM3yIoRgE2DfHG6G1yyZn0m/XXz3Q=;
        b=FSHKRqru3nWWsatD3DA05l4BnoLap6HOU/g84iz0bkoDHpiDvOaCZpnqgL/WPWZ8Y/bejr
        Rez3lh9QLSJJgYLK5P7Q2H148NIwTbblYJx0wUWxHi3LmmYr/paIO4F/li2+st0vRc7YSA
        HjAn7DwzZ6rmFtpjDxKmJI70R6g0knM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640164230;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EsLHxbYaydSzdgFM3yIoRgE2DfHG6G1yyZn0m/XXz3Q=;
        b=ePKObNGFEHjMarsnxuUL0udXQ+fPTz1PK0sTeStk7rIF35rNzSoIOnCD+wFEAfqbQY1j73
        mCJBt39x1IAPxDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DCFF13CE7;
        Wed, 22 Dec 2021 09:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id d7FMDYbrwmGSVAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 09:10:30 +0000
Date:   Wed, 22 Dec 2021 10:10:28 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Nageswara Sastry <rnsastry@linux.ibm.com>
Cc:     Yael Tiomkin <yaelt@google.com>, ltp@lists.linux.it,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] syscalls/keyctl09: test encrypted keys.
Message-ID: <YcLrhP62jewzFgqn@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211221023721.129689-1-yaelt@google.com>
 <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
 <YcGw5Lyo+hBEnlFD@pevik>
 <8c785afa-4564-d7ca-0bb8-34d5b5ca89bd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c785afa-4564-d7ca-0bb8-34d5b5ca89bd@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> On 21/12/21 4:18 pm, Petr Vorel wrote:
> > Hi Nageswara,

> > > On 21/12/21 8:07 am, Yael Tiomkin wrote:
> > > > Test that encrypted keys can be instantiated using
> > > > both user-provided decrypted data
> > > > (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> > > > or kernel-generated numbers.

> > > > Signed-off-by: Yael Tiomkin <yaelt@google.com>

> > > Tested on ppc64le platform

> > I suppose it also fails on ppc64le when run more iterations.


> Tried with -i500, -i5000 and -i50000 also ... no failures were seen on
> ppc64le architecture.

> Summary:
> passed   500
> failed   0

> Summary:
> passed   5000
> failed   0

> Summary:
> passed   50000
> failed   0

Interesting, thx for info. It's either arch specific or specific to openSUSE
kernel on my laptop (~ 5.16.0-rc5) where I tested it. Testing on
various VM it works well (including openSUSE with latest kernel stable). It also
works on RPI 4 with openSUSE kernel.

Also it fails on 2 VMs with fips enabled: Debian testing (immediately) and SLES
15-SP4 (after 63 iterations - the same number as 5.16.0-rc5 on my laptop):
keyctl09.c:33: TBROK: Failed to instantiate encrypted key using payload decrypted data

but on my laptop I don't use fips.

Kind regards,
Petr
