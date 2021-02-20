Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979C4320366
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 04:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBTDGd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 22:06:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:44752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229796AbhBTDGc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 22:06:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18166024A;
        Sat, 20 Feb 2021 03:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613790352;
        bh=zePbphJrLY4ddzfW42yCYDuewrITnlUUsWSc+yLxycs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3ftLHb9B3+P3Ji78zM8wayXAlyi/kVD1a79M5s36h/sbLbkrQk/mOOLSoNzyw2n+
         QS2tYsl/5DYchkwVQwDaoNxGRfm1gkgmaKVWzWeAm5zz6ZSmiLcfoEVFHMu4gKyEll
         t/v1rSPqf0aZubbizu+2I/woUZ+ECimePDY0ZLynyvdvFOSnCuoomJIRcuyHqruTS3
         Gm/4fp5axtQCffm2fa6bAQfcF2oTnV5ZBbbt1H8TdilSbLAY2rcrKSxVmq665s8hYd
         d4hppr/KR1TNPtJ+Oq4vFSpch4JAcZXeYT9fN87tinM0WLD1nlmfDbfFcDrNVK7wcP
         BsftYdLx65Q9A==
Date:   Sat, 20 Feb 2021 05:05:36 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 3/9] security: keys: trusted: Parse out individual
 components of the key blob
Message-ID: <YDB8gM6Z9OOKujQu@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-4-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-4-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:49AM +0000, Matthew Garrett wrote:
> Performing any sort of state validation of a sealed TPM blob requires
> being able to access the individual members in the response. Parse the
> blob sufficiently to be able to stash pointers to each member, along
> with the length.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

I'll just say LGTM for now. Did not see anything obviously wrong in
the code change (and does make sense to nitpick minor things just
yet).

Need to understand the whole use case just a little bit better.

/Jarkko
