Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285003349EF
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 22:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCJVlp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 16:41:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhCJVlh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 16:41:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77CDE64FC4;
        Wed, 10 Mar 2021 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615412497;
        bh=7L66YLf+ed4bmAJ64a+z2Rfb2jejvrDUJlt5flDQSzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WeHJlZUUXjhMzB0/88zdlqbvsiS1W0n+3Ir0GWVoZi3fNsOyyoW1K3k/zkXzce+2B
         kupH6bNM25jf4p0/6AONLd4Tb60fLXSIGH33Vu77s5EbxeT2gKCEAln9hjc+ckfsCI
         EF1Tzwn+e/C5pQ3AF/jHVKyi6+lO2sGXakUAZ1LYm1Q96gRIJcKo6IY/xtNOTaiGb1
         VGTre1rlahv2JZ25OXfgztv0cnsflZLbrpm0pCjPgOWdAMddR4+lNMBxZaQXfsGE2Z
         AoSAT0O1ZMxAC9jtlOQ0QSs+QMDopV7VanzXKNotQ+W7ezAKH+528KIWoQR4cIEZC3
         R7xW0yDIFDmBQ==
Date:   Wed, 10 Mar 2021 23:41:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v11 01/10] oid_registry: Add OIDs for ECDSA with
 sha224/256/384/512
Message-ID: <YEk8+OwwVJbXIb9+@kernel.org>
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
 <20210305205956.3594375-2-stefanb@linux.vnet.ibm.com>
 <YEjnPZOVit+U9YcG@kernel.org>
 <b2672c92-ddf5-51ba-bb4c-f3aadee26daf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2672c92-ddf5-51ba-bb4c-f3aadee26daf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 10, 2021 at 01:38:12PM -0500, Stefan Berger wrote:
> 
> On 3/10/21 10:35 AM, Jarkko Sakkinen wrote:
> > On Fri, Mar 05, 2021 at 03:59:47PM -0500, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > > 
> > > Add OIDs for ECDSA with sha224/256/384/512.
> > Nit: SHA224/256/384/512 (sorry cannot help myself with these, have been
> > doing this way too much, consider me as a bot :-) )
> > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Jarrko,
> 
>   I applied the nit and the 4 Acked-by's.
> 
> Thank you!
> 
> 
>    Stefan

Cool, thank you :-)

/Jarkko
