Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB30E3C98E5
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 08:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhGOGtx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Jul 2021 02:49:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41672 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhGOGtv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Jul 2021 02:49:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 161A7227C7;
        Thu, 15 Jul 2021 06:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626331618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5hchbb+Vatmq37V114hvlK1u549Ub0cIxRjupH99jE=;
        b=QYfLs8ig0wZu4aiQR8ZgEcNyEU6Usm+uo0OfiajxDHbTFBdshFscheOiz2IU3z0v0shzTC
        7HPJsOqOYMqAb8uUlW3ImPE6Lten/VHjzdki7YWdD5IheX+TyEzZAYqwcL0re3Q74V8WNM
        XdT8piDyTyKGxj7DNVqQ/nxek39Cj8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626331618;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5hchbb+Vatmq37V114hvlK1u549Ub0cIxRjupH99jE=;
        b=G5l082ZN4GrYN9azj2KB5JuJ1qGhizB6C6KACrWGwDPRKKhtM22t5EbRtBid/YaV4GIOB2
        qd37WA7HWcnMS3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA3E013C27;
        Thu, 15 Jul 2021 06:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jXhxI+HZ72D4WAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 15 Jul 2021 06:46:57 +0000
Date:   Thu, 15 Jul 2021 08:46:55 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v4] ima-evm-utils: Support SM2 algorithm
 for sign and verify
Message-ID: <YO/Z3+MVV4oPKRe1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210714130152.25751-1-tianjia.zhang@linux.alibaba.com>
 <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422b37b533ed6e24d783f323f7d4e22736f0e4bd.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

There are several failures
https://github.com/pevik/ima-evm-utils/actions/runs/1032906509

Alpine, Ubuntu Xenial, Centos7, Centos:latest:
./boot_aggregate.test: line 34: ./tsstpmcmd: No such file or directory

and Fedora:
dgst: Unrecognized flag md_gost12_256

Kind regards,
Petr
