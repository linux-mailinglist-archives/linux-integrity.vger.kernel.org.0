Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEADB449D25
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Nov 2021 21:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237694AbhKHUnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Nov 2021 15:43:15 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43902 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbhKHUnN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Nov 2021 15:43:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 230FA21B07;
        Mon,  8 Nov 2021 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636404028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ymatp5Gk3YOSs1BDVSXLWCXXfxR+Ri/cCIYGCpv4Lgw=;
        b=Rd4U6XujiCmjj0+NKtEotDKJBXaPcOz6EPLBVc3UUreh9oZWDJEea26sltIdQJYbtcuQKr
        bfC7g48k637Nn9Hblyn29viyWP6/tRPttZ6hKdnmzIjJEHQiihkNXhrWjV0BcALIYpdmfw
        X7VNrO+iGh7l2kjvU8B86jhVUmtdPvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636404028;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ymatp5Gk3YOSs1BDVSXLWCXXfxR+Ri/cCIYGCpv4Lgw=;
        b=AJxiGVI6wbNBFikliI3j0usmFBqghyOTbU9vluJjwN6Kyz9yqoMoUrLd3nMrTcQm5kjU/t
        lTtqaXOgPODKgQBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD9B113C20;
        Mon,  8 Nov 2021 20:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MTfPMjuLiWF1TgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 08 Nov 2021 20:40:27 +0000
Date:   Mon, 8 Nov 2021 21:40:26 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.4 released
Message-ID: <YYmLOoa6E78G3ii2@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
 <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> On Fri, 2021-11-05 at 09:21 -0700, Lakshmi Ramasubramanian wrote:
> > On 11/5/2021 1:15 AM, Petr Vorel wrote:
> > > Hi Mimi,

> > >> Please refer to the NEWS file for the short summary and the git history
> > >> for details of the ima-evm-utils v1.4 release.

> > Thanks for the info Mimi.

> > I checked both "master" and "next-testing" branches in the following, 
> > and I still see 1.3.2 version only.

> > 	https://github.com/pevik/ima-evm-utils

> > Is there a different github url for the latest ima-evm-utils source?

> The original sf git repo https://sourceforge.net/projects/linux-ima/
> and the new github https://github.com/mimizohar/ima-evm-utils.

Github repository is marked as primary. How about moving releases also to
GitHub?

Kind regards,
Petr

> Mimi

