Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710C1FFB55
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgFRSxw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 14:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgFRSxu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:53:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ECE2CAC12;
        Thu, 18 Jun 2020 18:53:48 +0000 (UTC)
Date:   Thu, 18 Jun 2020 20:53:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [PATCH] ima_evm_utils: emit the per TPM PCR bank
 "boot_aggregate" values
Message-ID: <20200618185347.GA20597@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1592243919-29915-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592243919-29915-1-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Instead of emitting the per TPM PCR bank "boot_aggregate" values one
> at a time, store them in a buffer and emit them all at once.

Thanks for notifying me.

I see you already pushed this commit into next-testing
and I found few problems, thus posted patches to ML: segfault bug on system with
TPM 1.2 only [1], running tsspcrread on system without TPM [2] and logging
problem [3].

I'll move the discussion there.

Kind regards,
Petr

[1] https://patchwork.kernel.org/patch/11612893/
[2] https://patchwork.kernel.org/patch/11612911/
[3] https://patchwork.kernel.org/patch/11612913/
