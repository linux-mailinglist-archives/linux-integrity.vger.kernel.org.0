Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04A116B1E
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 11:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLIKeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 05:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfLIKeh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 05:34:37 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD7B2077B;
        Mon,  9 Dec 2019 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575887676;
        bh=J+F+a3mv9evZz/xMVs7tWTVa5ygDM4L/pYf6W5zxScI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6OjGbvd5UndR5pdeV8AyJbhe2sMngS6qmECGpWC5XD3b7hnQaGnElOEXo/4w+1nO
         n7cbbH1Mdno3rxiEtsD5vlTDN0+rgTIVFVD4yEHLXLgepQK9FGUEYFl8p1PMkIVw+S
         TH3oUBrtbr8AWct+gZFynCsmyBciAWz3/Gp+ac+U=
Date:   Mon, 9 Dec 2019 10:34:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Subject: Re: [PROBLEM]:  WARNING: lock held when returning to user space!
 (5.4.1 #16 Tainted: G )
Message-ID: <20191209103432.GC3306@willie-the-truck>
References: <20191207173420.GA5280@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191207173420.GA5280@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

[expanding cc list]

On Sat, Dec 07, 2019 at 11:04:20PM +0530, Jeffrin Jose wrote:
> i got the following  output related from typical dmesg output from 5.4.1 kernel

Was this during boot or during some other operation?

> ================================================
> WARNING: lock held when returning to user space!
> 5.4.1 #16 Tainted: G            E    
> ------------------------------------------------
> tpm2-abrmd/691 is leaving the kernel with locks still held!
> 2 locks held by tpm2-abrmd/691:
>  #0: ffff8881ee784ba8 (&chip->ops_sem){.+.+}, at: tpm_try_get_ops+0x2b/0xc0 [tpm]
>  #1: ffff8881ee784d88 (&chip->tpm_mutex){+.+.}, at: tpm_try_get_ops+0x57/0xc0 [tpm]

Can you reproduce this failure on v5.5-rc1?

Thanks,

Will
