Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B713A19FDB3
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Apr 2020 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDFS7L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Apr 2020 14:59:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45324 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFS7L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Apr 2020 14:59:11 -0400
Received: by linux.microsoft.com (Postfix, from userid 1033)
        id 6557920B4737; Mon,  6 Apr 2020 11:59:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6557920B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586199550;
        bh=8+4SIzp738pVoCmLOrnJS6Dy5LRKKuCLugqMPy7T3Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfKpfQ9fwJ1xCtYp8NAdRxpIpqyibbHR1Kp08SvxFwdnqAw6SUs56COIi4ZhVUaQN
         cuXFI4b7+jZJbQa34jLIoOkB+hI+fF8zerq00JVspwHX54nvky3Xr+4ZoA4HwZSxKJ
         qXA9lqXQSbwiUROHMO2R/qEvx3xOnzVvdfmJYL9o=
Date:   Mon, 6 Apr 2020 11:59:10 -0700
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     Jann Horn <jannh@google.com>
Cc:     agk@redhat.com, Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200406185910.GA77950@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
 <CAG48ez3JV-tzjRLdcys6Fz9LKYaB1h-1GaeAzkUYtY1RgxsB6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3JV-tzjRLdcys6Fz9LKYaB1h-1GaeAzkUYtY1RgxsB6g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 06, 2020 at 08:50:46PM +0200, Jann Horn wrote:
> On Mon, Apr 6, 2020 at 8:10 PM <deven.desai@linux.microsoft.com> wrote:
> > Overview:
> > ------------------------------------
> > IPE is a Linux Security Module, which allows for a configurable
> > policy to enforce integrity requirements on the whole system. It
> > attempts to solve the issue of Code Integrity: that any code being
> > executed (or files being read), are identical to the version that
> > was built by a trusted source.
> 
> Where's patch 02/11? lore at
> https://lore.kernel.org/linux-security-module/20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net/T/#t
> has everything other than that patch.

It looks like it's over majordomo's character limit by 7489 characters.
I'll have to repost with this patch broken up. Apologies.

- Deven
