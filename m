Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE87320370
	for <lists+linux-integrity@lfdr.de>; Sat, 20 Feb 2021 04:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBTDKE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 22:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:45064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhBTDKD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 22:10:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B717064EE0;
        Sat, 20 Feb 2021 03:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613790563;
        bh=BKUd+jallq37FDOP7XZNlKIoHsBYEgg+risJ2luufz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2sQxU/R9X/6fZkIEcVkTVPkOug75dkQlMgvr2tDh/+49Rn3rP6Xe1/UPE2raBAdJ
         vwTG3NOpHrftST365HlCBYQy9WyZeUmhZd8sFnZrz6G3xt4Vxw6IMGFzYXM+VyRRoH
         DPCB+GmOfOlA1oAVNNoeEwWxZyvHX3UvF/2+YEEdvC1+xoKwbZrN+k2CAIZ+oYHvMq
         r94OWRrCDwG+C3kJFKachpZkSh3PrpCsozjuVgnrL7oAMk2o9vZfbe/WcNsT6WetAd
         xgZakwtUVC5GMfYJrUVPPXhxbeRFRdLpq/Cpa+Pz0aMKD5aKH9RNu1SCyjkdIPllxy
         ciQmefUC0pHgw==
Date:   Sat, 20 Feb 2021 05:09:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 5/9] security: keys: trusted: Allow storage of PCR values
 in creation data
Message-ID: <YDB9U2oyt0fmvLDF@kernel.org>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-6-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210220013255.1083202-6-matthewgarrett@google.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 01:32:51AM +0000, Matthew Garrett wrote:
> When TPMs generate keys, they can also generate some information
> describing the state of the PCRs at creation time. This data can then
> later be certified by the TPM, allowing verification of the PCR values.
> This allows us to determine the state of the system at the time a key
> was generated. Add an additional argument to the trusted key creation
> options, allowing the user to provide the set of PCRs that should have
> their values incorporated into the creation data.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>

LGTM too.

Something popped into mind: could we make PCR 23 reservation dynamic
instead of a config option.

E.g. if the user space uses it, then it's dirty and hibernate will
fail. I really dislike the static compilation time firewall on it.

/Jarkko
