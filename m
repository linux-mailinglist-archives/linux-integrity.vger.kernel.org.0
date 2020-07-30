Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B09C23396C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 21:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgG3T6y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 15:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730599AbgG3T6x (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 15:58:53 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B6C20656;
        Thu, 30 Jul 2020 19:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596139133;
        bh=x5Z5Lcy+lf5VlE+mnhIdU70vykDcR9T41o85m5TGRC4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d5K8FZnF+X3fFCVHtPjw/TcDLxsBZkNTAvWve/b1YLOaZrm/SKsWT3wYbzTuJT/91
         a9V+SS+PhWAoqFWD0OW9AJ82V+nZFUGksmmtGAezpAQoRLQvuM8czrXGeo7UM8TXZd
         BILb2kAJd5dwdCvsLiIpDCoZuDTrwQFnFhQugC7E=
Message-ID: <1596139131.25003.14.camel@kernel.org>
Subject: Re: [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:58:51 -0400
In-Reply-To: <20200728001301.31121-1-pvorel@suse.cz>
References: <20200728001301.31121-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-28 at 02:13 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> [ pvorel: improved setup, various LTP API cleanup ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, really nice.

Missing is a short comment explaining the reason for the multiple
tests.

> +test()
> +{
> +	case $1 in
> +	1) kexec_test '--reuse-cmdline';;
> +	2) kexec_test '--append' 'foo';;
> +	3) kexec_test '--command-line' 'bar';;
> +	esac
> +}
> +
> +tst_run

