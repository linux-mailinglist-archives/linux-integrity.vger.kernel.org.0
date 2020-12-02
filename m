Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA072CC2A2
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 17:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgLBQpF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Dec 2020 11:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgLBQpF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Dec 2020 11:45:05 -0500
Date:   Wed, 2 Dec 2020 18:44:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606927464;
        bh=jyurRGL89zzdslzCJsMEO78yjlUO+ENETbmWC5gauAc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fk8es+TSPwGkya5e2AaTkaSRdMxTZ/9U3Pdp7qR/WPLqbNG/7UUvszEQLuBBh6d09
         sQxfzKmjOn7GDzmHsHKEIrI6vH+NcBCXVZdNoja1Nu1DZLbBJr9v8hYT8OXGWXkdjJ
         QXjcmV/kBBJoUFnjq/wRlvq5WsN94bImYkr++tPE=
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Morris <jmorris@namei.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 0/9] Enable root to update the blacklist keyring
Message-ID: <20201202164417.GA91162@kernel.org>
References: <20201120180426.922572-1-mic@digikod.net>
 <20201130024011.GA24870@kernel.org>
 <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80fb0eae-8321-5ae2-8d50-eabbe86981da@digikod.net>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 30, 2020 at 09:23:59AM +0100, Mickaël Salaün wrote:
> 
> On 30/11/2020 03:40, Jarkko Sakkinen wrote:
> > On Fri, Nov 20, 2020 at 07:04:17PM +0100, Mickaël Salaün wrote:
> >> Hi,
> >>
> >> This patch series mainly add a new configuration option to enable the
> >> root user to load signed keys in the blacklist keyring.  This keyring is
> >> useful to "untrust" certificates or files.  Enabling to safely update
> >> this keyring without recompiling the kernel makes it more usable.
> > 
> > I apologize for latency. This cycle has been difficult because of
> > final cuts with the huge SGX patch set.
> > 
> > I did skim through this and did not see anything striking (but it
> > was a quick look).
> > 
> > What would be easiest way to smoke test the changes?
> 
> An easy way to test it is to enable the second trusted keyring to
> dynamically load certificates in the kernel. Then we can create a hash
> of a valid certificate (but not loaded yet) and sign it as explained in
> tools/certs/print-cert-tbs-hash.sh (patch 9/9). Once this hash is loaded
> in the kernel, loading the blacklisted certificate will be denied. We
> can also test it with a PKCS#7 signature chain, either with the
> blacklist keyring itself, or with a signed dm-verity image.

Thanks, looking into this once 5.11-rc1 is out.

/Jarkko
