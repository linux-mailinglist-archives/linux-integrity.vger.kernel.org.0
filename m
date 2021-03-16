Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB9233DD3E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhCPTSc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 15:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236567AbhCPTS2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 15:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE9F66507D;
        Tue, 16 Mar 2021 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615922308;
        bh=ooYQMkFoVvHvnTFUcEjo25lP505q1slZTAneNKYMA0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XRqVtm2tDQKcvW+oVzph4R90TqOhivv8TpkE8ZQamjBNrLPZK/tee3RcEQbcMiz/S
         3qWGs0EsNpb5lhdV6/+9/FvVoRtrBRNx0Xg+j8QqRVE3fMl6DxFWTBPAAYKYMHcIqw
         HbiQMTAefFKv4PeR75m3NHi8o5sKqZRHqGbNmJ7hqqY0U/abK7Wtk6bn+gsCCYsCQ+
         YkfZc8+pI+kpc8l3/bCSLcu5ZcQsYuJujndDXk3Eq5jX259zCMR9HUYgr1QQkA8m0e
         YjPOw2hnoNZrdaHBo61+1M1r7vGv34S3MWSx14ES/xwR0egpOFVox2g0mtIR20qRfN
         vaFfAY+NnnTNg==
Date:   Tue, 16 Mar 2021 21:18:02 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: Recent tpm_tis IRQ handling changes are causing kernel backtraces
Message-ID: <YFEEas6kH3FUoKJe@kernel.org>
References: <34442b17-c8e6-9d33-831f-fcbf3a38552b@redhat.com>
 <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4afc566-0114-c5a3-ebda-a775132e999d@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 16, 2021 at 04:34:01PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/11/21 2:09 PM, Hans de Goede wrote:
> > Hi Jerry,
> > 
> > It looks like there still is an issue with the recent changes to the tpm_tis IRQ
> > handling. At least I think those are the cause I did not dive any deeper,
> > I just noticed that we (Fedora) have been receiving an aweful lot of
> > kernel tpm_tis_send_data backtraces with most starting with tpm_tis_probe_irq_...
> > 
> > See for example:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1912167
> > https://bugzilla.redhat.com/show_bug.cgi?id=1927610
> > 
> > Those are just the 3 which landed in my inbox today, for much more see:
> > https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
> > (this shows 18 bugs atm).
> > 
> > These were reported through the Fedora ABRT tools which automatically
> > collects backtraces, the bugs have links to the ABRT reports, e.g. :
> > https://retrace.fedoraproject.org/faf/reports/28155/
> > https://retrace.fedoraproject.org/faf/reports/37107/
> > 
> > The 28155 report says that so far there have been 308,412 (ouch) automatic
> > uploads of that particular variant of these backtraces
> > 
> > Note the second (37107) retrace report is about this happening
> > on resume, rather then on probe/tpm_tis_probe_irq_... time.
> > 
> > Did your work on this work land in 5.10 ? Or could it be that the
> > issue is an incomplete backport to the 5.10.y stable series ?
> 
> Ping ?
> 
> It is raining bug-reports about this:
> 
> https://bugzilla.redhat.com/buglist.cgi?quicksearch=tpm_tis_send_data
> 
> Currently lists 25 bugs and that is excluding bugs which have already
> been marked as a duplicate.
> 
> Can someone involved in the patch-series which is causing this regression
> please take a look at these kernel backtraces ?
> 
> Regards,
> 
> Hans

I incorporated two fixes to this issue to my last PR, which were taken
to the mainline. What is the situation with the mainline?

/Jarkko
