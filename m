Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F376428D49
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Oct 2021 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbhJKMsZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Oct 2021 08:48:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbhJKMsY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Oct 2021 08:48:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 265801FEA4;
        Mon, 11 Oct 2021 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633956384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8aCM04Y5KKget2yGbE096ODHyYDPCyVX15tuLF1gmw=;
        b=SiSrBUhr7CcKxSsPBgknC52c3DOauZC9tW2h6EfYABhoUF66kYMnQ4g7Je0eGGJzXyeT/K
        EInMlXK5NPXnbdMhZLZ0erQhqdsk52vgy4sN7w9wIerE4ndlLJRi+cDp3BEWrzgLCLTgoH
        A4IprkRFSJuHZLOH++ORAXB22S5ygBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633956384;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8aCM04Y5KKget2yGbE096ODHyYDPCyVX15tuLF1gmw=;
        b=rOEHUMOHgsh6dCj9nw45/O6TMDNDfVmcfDVp2sgvqWi8FrV9lpBy2gXCSvXxpYctKpq3Cw
        HXxpOOkLs4RPg0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB96413C72;
        Mon, 11 Oct 2021 12:46:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gT1jNx8yZGGYAQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 11 Oct 2021 12:46:23 +0000
Date:   Mon, 11 Oct 2021 14:46:22 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com
Subject: Re: [PATCH v6 0/2] IMA checkpatch fixes
Message-ID: <YWQyHjqJshY1b//w@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211008091430.22392-1-pvorel@suse.cz>
 <685eb07ebb22de45a0b15c82fe7b8d56431269ce.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685eb07ebb22de45a0b15c82fe7b8d56431269ce.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr, Alex,

> On Fri, 2021-10-08 at 11:14 +0200, Petr Vorel wrote:
> > Hi,

> > very minor checkpatch fixes based on [v3,2/2] ima: add gid support patchset [1].

> These and the original gid patch set are now queued in next-integrity-
> testing.
Thanks!

Kind regards,
Petr

> thanks,

> Mimi

