Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2381A8342
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 17:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440529AbgDNPiZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 11:38:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:46198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440553AbgDNPiP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 11:38:15 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 27DD977D;
        Tue, 14 Apr 2020 15:38:10 +0000 (UTC)
Date:   Tue, 14 Apr 2020 09:38:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, tyhicks@linux.microsoft.com,
        pasha.tatashin@soleen.com, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 11/12] documentation: Add IPE Documentation
Message-ID: <20200414093809.2c6ef93b@lwn.net>
In-Reply-To: <20200406221439.1469862-12-deven.desai@linux.microsoft.com>
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com>
        <20200406221439.1469862-12-deven.desai@linux.microsoft.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon,  6 Apr 2020 15:14:38 -0700
deven.desai@linux.microsoft.com wrote:

> From: Deven Bowers <deven.desai@linux.microsoft.com>
> 
> Add IPE's documentation to the kernel tree.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>

Thanks for including this nice documentation from the outset!  I have a
couple of tiny nits to pick, but nothing really substantive to complain
about, so:

  Acked-by: Jonathan Corbet <corbet@lwn.net>

[...]

> +IPE is a Linux Security Module, which allows for a configurable policy

I'd drop the comma (I told you these were nits!)

[...]

> +IPE Policy
> +~~~~~~~~~~
> +
> +IPE policy is designed to be both forward compatible and backwards
> +compatible. There is one required line, at the top of the policy,
> +indicating the policy name, and the policy version, for instance:
> +
> +::
> +
> +   policy_name="Ex Policy" policy_version=0.0.0

This pattern can be compressed a bit by just putting the "::" at the end of
the last line of text:

	indicating the policy name, and the policy version, for instance::

	   policy_name="Ex Policy" policy_version=0.0.0

The result is a bit more readable in the plain-text format, IMO, and
renders exactly the same in Sphinx.

Thanks,

jon
