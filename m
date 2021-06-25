Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB23B3C87
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jun 2021 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhFYGPS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 02:15:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54314 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhFYGPR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 02:15:17 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7BCAB21BB4;
        Fri, 25 Jun 2021 06:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624601576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJ6f8gqDaV4JAqhjhALrNNyJBU1UH8z5EvvhIWOsPU=;
        b=0Wn20p4Lc1W9/u2HaOvhZULHdQ5dy4PASPZBXNihsi7T9eFt6/VHrcC87RMwAwBOXKMix1
        fKhhALAr/zmkpI7hWmXB8JC6np+r6DQyF8sRtrJNLS5/YZuEFxa9yKdS3WLzlosd1n1Ggh
        2OnGRPn4Epw01M0ixpWR0obZxIExNms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624601576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJ6f8gqDaV4JAqhjhALrNNyJBU1UH8z5EvvhIWOsPU=;
        b=3iEUfMM/9R2HiW+NhBaO7oNckWbe8NpRaYDsfEvqs5IRati6K0kq8loyUdl7yGj+fq9UYw
        N3OD54ts0cN61/Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 443EB11A97;
        Fri, 25 Jun 2021 06:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624601576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJ6f8gqDaV4JAqhjhALrNNyJBU1UH8z5EvvhIWOsPU=;
        b=0Wn20p4Lc1W9/u2HaOvhZULHdQ5dy4PASPZBXNihsi7T9eFt6/VHrcC87RMwAwBOXKMix1
        fKhhALAr/zmkpI7hWmXB8JC6np+r6DQyF8sRtrJNLS5/YZuEFxa9yKdS3WLzlosd1n1Ggh
        2OnGRPn4Epw01M0ixpWR0obZxIExNms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624601576;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dRJ6f8gqDaV4JAqhjhALrNNyJBU1UH8z5EvvhIWOsPU=;
        b=3iEUfMM/9R2HiW+NhBaO7oNckWbe8NpRaYDsfEvqs5IRati6K0kq8loyUdl7yGj+fq9UYw
        N3OD54ts0cN61/Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id c0RnDuhz1WAREQAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Fri, 25 Jun 2021 06:12:56 +0000
Date:   Fri, 25 Jun 2021 08:12:54 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Add GitHub Actions support
Message-ID: <YNVz5s36fsRZGEUc@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
 <c88c3a1e20242d4f42eea275a174f4b375e203bb.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88c3a1e20242d4f42eea275a174f4b375e203bb.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Tue, 2021-06-22 at 16:12 +0200, Petr Vorel wrote:
> > Hi Mimi,

> > Travis is unreliable due "pull rate limit" issue, workaround does not
> > work any more. Also GitHub Actions is a recommended way for projects
> > hosted on GitHub.

> > Nice bonus is that manual podman activation for distros using glibc >=
> > 2.33 (e.g. openSUSE Tumbleweed, Fedora) it's not needed in GitHub.

> > Unlike LTP, where I removed Travis CI support, I kept it for
> > ima-evm-utils, because you use it.

> Thanks, Petr.  I appreciate your not removing Travis CI.

> I've pushed out the changes to next-testing.
Thanks!

Kind regards,
Petr

> Mimi

