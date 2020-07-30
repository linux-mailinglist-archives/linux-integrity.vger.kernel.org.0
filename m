Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0F233974
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgG3UDl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 16:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgG3UDk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 16:03:40 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009D52074B;
        Thu, 30 Jul 2020 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596139420;
        bh=Nb6NoNnz9vaD/ACyuYzBpeQTihylPtRPWzrvjEv46Pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aWxm3EzQyI3R5yKTmhjwCH73q2hIy90aLytGjpQLXawdE3p/szijJ+xH6qwRk7ES7
         Nnk+IPXe5wOV9+EEdVS4KVpr9DtcCidDFDJgbH8+Dq2neTBHQ++PLo/MW0GhXdXVwC
         UEjwkTCm/kwaNVH6IV45GrL1Vn0jWJldvUVEemMs=
Message-ID: <1596139419.25003.16.camel@kernel.org>
Subject: Re: [PATCH v5 0/4] IMA: kexec cmdline measurement
From:   Mimi Zohar <zohar@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Thu, 30 Jul 2020 16:03:39 -0400
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-28 at 00:30 +0200, Petr Vorel wrote:
> Hi all,
> 
> sending hopefully the last version. In the end I did quite few changes,
> thus sending patchset instead of merging without review.

Nice! Thank you.

Mimi
