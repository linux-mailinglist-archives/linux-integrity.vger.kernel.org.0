Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676653B7911
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhF2UI7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 16:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhF2UI7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 16:08:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 864E761D9A;
        Tue, 29 Jun 2021 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624997191;
        bh=9QBx072z+54cgVdFt//hyA0DiNwP5mfGm1V1m8vlvOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JltrPfdsb6sf7blyz6jL3rJz/wdE25QZNIfWYMbdumqomtXC9QHoFj1zTSp2fcxBo
         fCiMeO8Yr1j6XKhmr6qAriFtoqUaT6CHOmJ9cxmQCOSkXtL/DGTn71od9AUP8IJRdx
         WWCDu/2tUe7YaJLHXV+FfD/PjMqoB1+KIWhzk3Y3Akj/jADvVX40p2cnxfW5w5vat8
         oSOau+4RI7c6+iwZhgmICMjDw/OycDVrv3drEBT7vTMjNl+mO0koiFmsL8D8x2O32b
         uwbTj4ynelPsgoE8AhLks/8KWnMjuF95SR+fai+6asD8b3BcP+51cnOqRp0frsjme8
         OU4VbAQrTHL0g==
Date:   Tue, 29 Jun 2021 23:06:28 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
Message-ID: <20210629200628.slv7fnjxsmnvv2cf@kernel.org>
References: <20210620231809.21101-1-hao.wu@rubrik.com>
 <20210623133518.5vykitqsdwtfqzd6@kernel.org>
 <51DCB704-8E9D-40DD-9E81-F1D16EB28BD5@rubrik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51DCB704-8E9D-40DD-9E81-F1D16EB28BD5@rubrik.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jun 23, 2021 at 10:49:27PM -0700, Hao Wu wrote:
> > On Jun 23, 2021, at 6:35 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Sun, Jun 20, 2021 at 04:18:09PM -0700, Hao Wu wrote:
> >> This is a fix for the ATMEL TPM crash bug reported in
> >> https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.109645-1-hao.wu@rubrik.com/
> >> 
> >> According to the discussions in the original thread,
> >> we don't want to revert the timeout of wait_for_tpm_stat
> >> for non-ATMEL chips, which brings back the performance cost.
> >> For investigation and analysis of why wait_for_tpm_stat
> >> caused the issue, and how the regression was introduced,
> >> please read the original thread above.
> >> 
> >> Thus the proposed fix here is to only revert the timeout
> >> for ATMEL chips by checking the vendor ID.
> >> 
> >> Test Plan:
> >> - Run fixed kernel with ATMEL TPM chips and see crash
> >>  has been fixed.
> >> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> >>  the timeout has not been changed.
> > 
> > Please move test plan right before diffstat if you wan to include such,
> > so that it does not go into the commit log.
> Hi Jarkko, not sure I understood your suggestion or not. I removed
> the test plan from the commit message in a updated commit
> https://patchwork.kernel.org/project/linux-integrity/patch/20210624053321.861-1-hao.wu@rubrik.com/
> 
> Let me know if I misunderstood this. I am fine to not include test plan,
> If this is not something expected by linux community.
> I personally think it is helpful to understand the confidence of the commit.
> 
> > 
> >> ---

You can add it right here. Then it won't be included to the actual
commit log but is still available in the patch.

/Jarkko 
