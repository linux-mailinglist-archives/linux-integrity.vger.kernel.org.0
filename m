Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092B932DD0E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 23:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhCDWbk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 17:31:40 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:36660 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhCDWbj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 17:31:39 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHwV8-0007Yu-3l; Fri, 05 Mar 2021 09:31:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Mar 2021 09:31:21 +1100
Date:   Fri, 5 Mar 2021 09:31:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH v9 6/9] crypto: Add NIST P384 curve parameters
Message-ID: <20210304223121.GA19322@gondor.apana.org.au>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-7-stefanb@linux.vnet.ibm.com>
 <20210304052809.GB25972@gondor.apana.org.au>
 <37e5c232-11e8-0533-ab3e-676829091d19@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e5c232-11e8-0533-ab3e-676829091d19@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 08:59:36AM -0500, Stefan Berger wrote:
>
> Are you going to take the other patches as well, except for maybe 9/9, which
> depends on Nayan's patch series. Mimi suggested to me to ask you whether you
> could create a topic branch where we can apply other patches to, such as
> Nayna's?

Yes I can do a topic branch.  Please let me know which patches
I should take when you resubmit.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
