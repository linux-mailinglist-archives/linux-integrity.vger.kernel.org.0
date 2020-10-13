Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0CF28D041
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388692AbgJMObw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 10:31:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33458 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgJMObu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 10:31:50 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AD9320B4905;
        Tue, 13 Oct 2020 07:31:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AD9320B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1602599509;
        bh=qJXh+57+9TzB1CrROf86VFJLVGLi7eRc1KhHpcNMGas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0en6LF+5k0tk23ICRKWKqwz2HLlzl+tCBaeY49/dCPVnYZ+AgHzzFqKjXozcod+u
         rmvtdNn2Pbz3Xvj+oJDtCnJwufIrWum85l+EPVxKlnAYu8Tk2S8n49m/JrDWJEcpp2
         8fYfBrALywgoH26onkezASyihEEyojCfkjgg1wNk=
Date:   Tue, 13 Oct 2020 09:31:39 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] "tpm: Require that all digests are present in
 TCG_PCR_EVENT2 structures" causes null pointer dereference
Message-ID: <20201013143139.GA12418@sequoia>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20200928140623.GA69515@linux.intel.com>
 <BB63B86E-CA44-4EB7-A5D1-21B0E9EB2850@canonical.com>
 <846fe4da67d05f57fba33e38c9a6e394e657adc3.camel@linux.ibm.com>
 <20200930022040.GG808399@linux.intel.com>
 <A983BE2B-02A7-450B-9FD0-77B1470EF233@canonical.com>
 <20201009160654.GA26881@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009160654.GA26881@linux.intel.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Sorry for coming in so late, I've been on an extended vacation with
little connectivity.

On 2020-10-09 19:06:54, Jarkko Sakkinen wrote:
> On Thu, Oct 08, 2020 at 05:09:06PM +0800, Kai-Heng Feng wrote:
> > > I do not have yet any reasonable answer to this and my v5.10 PR is
> > > running late. Does everyone agree that I should revert the patch?
> > 
> > Given that there are multiple users confirmed reverting the commit
> > helps, can you please revert it and Cc: linux-stable?
> 
> I already sent the PR, but I schedule the revert to my rc2 PR.

I'll try to better understand what's going on. I, too, am confused about
how the change would introduce the reported regression. I've only
skimmed the thread so far but it feels like there's possibly a latent
issue that the change may be uncovering on certain systems.

FWIW, we've had this patch applied to our internal kernel for a month
and haven't seen any issues.

Tyler

> 
> > Thanks!
> > 
> > Kai-Heng
> 
> /Jarkko
> 
