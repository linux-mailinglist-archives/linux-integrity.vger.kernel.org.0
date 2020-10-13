Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6077B28D46D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Oct 2020 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbgJMTZ3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Oct 2020 15:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387795AbgJMTZ1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Oct 2020 15:25:27 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F152145D;
        Tue, 13 Oct 2020 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602617127;
        bh=mNHekrnoR+JyAIK8u8gM3jPB9pCDNXlZtnicar8KIcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/mFcueFktAomcAbbr+IF6D8MgmgVDMbxgeXvC1sNpq6GfEW8guNQeFb5LoNaU+sA
         ZLNaeBPLdho/5ck60GSiW1TfEG6TDXxnUeZOA0zAobBefIw63D3Dyxoh+N0bHex/ZO
         s9pfXqx1zRbOIjgxhYCHI6v3KnpzYNOuKZJy3bCs=
Date:   Tue, 13 Oct 2020 22:25:24 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: jarkko.sakkinen@linux.intel.com ->
 jarkko@kernel.org
Message-ID: <20201013192524.GA164334@kernel.org>
References: <20201013104705.140127-1-jarkko.sakkinen@linux.intel.com>
 <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce9442565fc3176ad770788bc1cf76b02080486.camel@perches.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 13, 2020 at 08:30:38AM -0700, Joe Perches wrote:
> On Tue, 2020-10-13 at 13:46 +0300, Jarkko Sakkinen wrote:
> > Use korg address as the main communications end point. Update the
> > corresponding M-entries.
> 
> Maybe add an equivalent entry to .mailmap?

Ugh, neither has @linux.intel.com. So, I'll insert these two lines:

Jarkko Sakkinen <jarkko@kernel.org>
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > -M:	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > +M:	Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

/Jarkko
