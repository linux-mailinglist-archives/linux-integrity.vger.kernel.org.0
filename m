Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A31321185
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 08:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBVHnV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 02:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhBVHnS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 02:43:18 -0500
Received: from cavan.codon.org.uk (cavan.codon.org.uk [IPv6:2a00:1098:84:22e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860FC061786;
        Sun, 21 Feb 2021 23:42:17 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
        id 90F3C40A2F; Mon, 22 Feb 2021 07:41:10 +0000 (UTC)
Date:   Mon, 22 Feb 2021 07:41:10 +0000
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-pm@vger.kernel.org, keyrings@vger.kernel.org,
        zohar@linux.ibm.com, jejb@linux.ibm.com, corbet@lwn.net,
        rjw@rjwysocki.net, Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH 5/9] security: keys: trusted: Allow storage of PCR values
 in creation data
Message-ID: <20210222074110.GC30403@codon.org.uk>
References: <20210220013255.1083202-1-matthewgarrett@google.com>
 <20210220013255.1083202-6-matthewgarrett@google.com>
 <YDB9U2oyt0fmvLDF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDB9U2oyt0fmvLDF@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Feb 20, 2021 at 05:09:07AM +0200, Jarkko Sakkinen wrote:

> Something popped into mind: could we make PCR 23 reservation dynamic
> instead of a config option.
>
> E.g. if the user space uses it, then it's dirty and hibernate will
> fail. I really dislike the static compilation time firewall on it.

We can fail hibernation if userland hasn't flagged things, but the
concern is that if you hibernate with PCR 23 blocking enabled and then
reboot with the blocking disabled, userland can obtain the blob from the
hibernation image, extend PCR 23, modify the image and use the key
they've recovered to make it look legitimate, enable PCR 23 blocking
again and then resume into their own code.
