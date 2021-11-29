Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47358461467
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 12:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhK2MAl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 07:00:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51962 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbhK2L6k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 06:58:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77896212C0;
        Mon, 29 Nov 2021 11:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638186922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2WP4yyTZioCVA6UB0hpZeLP+/OtR0YizA47Q/oZN2Q=;
        b=bm073j3isu9TlEYVE9RhqwgeG0ymNwpg1gUb8VT7xyL5zD5SJNs95R6wKlhQg3CNfn2Tqg
        B5cFn6jzyeJowbVkfkGaiElc1UQfrfDjg4eFdF3BqXP/aeG/G5ZGyTlMbG3FA3WnTBbbyC
        RbLlQG4p/rg2dbfPETdbj8vMyJ+UOmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638186922;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2WP4yyTZioCVA6UB0hpZeLP+/OtR0YizA47Q/oZN2Q=;
        b=vtk5i4j1xuNc90PMPblLppaZw+Z+2D2gibKJSzRpsaYLEZ7HkpRKNiHAZzy7KosRbtKM/Y
        cTWgSA/4rc1wDrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C80213A86;
        Mon, 29 Nov 2021 11:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pdmIDKq/pGGUIQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 29 Nov 2021 11:55:22 +0000
Date:   Mon, 29 Nov 2021 12:55:20 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.4 released
Message-ID: <YaS/qI1QF5iYUtuy@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
 <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
 <YYmLOoa6E78G3ii2@pevik>
 <ca8a4b45b3d7449b41b244217dddc9c91335780c.camel@linux.ibm.com>
 <YZN9pJeU6rDfEzVr@pevik>
 <68b1000251c5c45909f85f9229412a4688cc4500.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68b1000251c5c45909f85f9229412a4688cc4500.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Tue, 2021-11-16 at 10:45 +0100, Petr Vorel wrote:
> > Hi Mimi,

> > Great, thank you! Also, when you have time, could you please put there
> > checksums? (ideally sha256/sha512) or even signed checksum file).

> The github documentation is lacking as to where to put the release
> checksums or signed checksum file.  All I've found is that it isn't
> supported.  Here are the hashes:

> sha256:fcf85b31d6292051b3679e5f17ffa7f89b6898957aad0f59aa4e9878884b27d1

> sha512:2fdf41470d88608162a084c4877ba17d531941b744bcb44dd4913e48ab2c2d13
> 1e0af3e3ead74c18748a5d46aced51213ebd7c13a5ee19050c28d54a26c011a3

You can just generate files and checksum and upload them to the release, like
Cyril does for LTP [1]. iputils just creates checksums file and upload it's sign
[2] (having also signed is obviously better).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/releases/tag/20210927
[2] https://github.com/iputils/iputils/releases/tag/20210722

> thanks,

> Mimi

