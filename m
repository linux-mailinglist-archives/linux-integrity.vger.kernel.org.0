Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D743DD212
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Aug 2021 10:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhHBIfl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Aug 2021 04:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232428AbhHBIfl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Aug 2021 04:35:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88C0761057;
        Mon,  2 Aug 2021 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627893332;
        bh=PS8OqBJDBxjaQi+snp59d5+ckpWtNZ6D8Vin4bKMsik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TunhCp3a96gik8QdNgRL27GGU/13kOdl9cXB+C3ytpwFLzI6jVrs1lyoDDvOBTM6j
         it0CMqG6Oi01Aljxd91t7IASlMoifiE7qTkC4gQ6gHki7eS/Ud1ru4MoP9tqD67NL4
         pzsEo+eDQCcG6pGOkc3KPFO8c5wA52lT5FEqscQZwXe1lI0ovFrnojpKQMuI940roJ
         /H1holKg4U0zKDux8I6v11F31JvHiLCw0lCgbI4eLT0xZnsLzLBHek0lwhs2QRSZQd
         Zk6oxqTsR0pV9gRc81qWBPwjpI/Rjdh8fxVsypUtJKk/ksyy2swC0S4FMoHQsErCmz
         XYnq5J+Vps7rQ==
Date:   Mon, 2 Aug 2021 11:35:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>
Cc:     Borys Movchan <Borys.Movchan@axis.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, kernel <kernel@axis.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Add Upgrade/Reduced mode support for TPM2 modules
Message-ID: <20210802083528.yayuwm6mlkowrsh2@kernel.org>
References: <20210728105730.10170-1-borysmn@axis.com>
 <20210728215819.vsdwh2fbct7wxwsu@kernel.org>
 <b12dad90-c9ed-2331-7e96-78ca5c3994e8@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b12dad90-c9ed-2331-7e96-78ca5c3994e8@axis.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 30, 2021 at 04:24:01PM +0200, Borys Movchan wrote:
> On 7/28/21 11:58 PM, Jarkko Sakkinen wrote:
> > On Wed, Jul 28, 2021 at 12:57:30PM +0200, Borys Movchan wrote:
> > > If something went wrong during the TPM firmware upgrade,
> > > like power failure or the firmware image file get corrupted,
> > > the TPM might end up in Upgrade or Failure mode upon the
> > > next start. The state is persistent between the TPM power
> > > cycle/restart.
> > >
> > > According to TPM specification:
> > >  * If the TPM is in Upgrade mode, it will answer with
> > >    TPM2_RC_UPGRADE to all commands except Field Upgrade
> > >    related ones.
> > >  * If the TPM is in Failure mode, it will allow performing
> > >    TPM initialization but will not provide any crypto
> > >    operations. Will happily respond to Field Upgrade calls.
> > >
> > > The fix adds the possibility to detect an active state of
> > > the TPM and gives the user-space a chance to finish the
> > > firmware upgrade/recover the TPM.
> >
> > This is different than telling what the patch does. It's just
> > describing a goal, but does not describe how the driver is
> > changed, and reasons for doing that.
> >
> > For instance, you check 'limited_mode' flag in a few sites.
> > How can I know that those are exactly the locations where this
> > needs to be done?
> >
> 
> Seems like I got what you are looking for. Let me try to explain the
> reasoning
> and doubts regarding what I meant under my change.

Please try to nail this in the commit message instead, and I'll
then review that.

/Jarkko
