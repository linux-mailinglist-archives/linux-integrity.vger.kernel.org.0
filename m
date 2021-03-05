Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493D132F205
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCER7E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:59:04 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49704 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCER6i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:58:38 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C411A72C8B8;
        Fri,  5 Mar 2021 20:58:35 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A16FB4A4737;
        Fri,  5 Mar 2021 20:58:35 +0300 (MSK)
Date:   Fri, 5 Mar 2021 20:58:35 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 1/9] crypto: Add support for ECDSA signature
 verification
Message-ID: <20210305175835.armhwbivd4g6w273@altlinux.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-2-stefanb@linux.vnet.ibm.com>
 <YEJk44FXEl0+mEPr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <YEJk44FXEl0+mEPr@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko,

On Fri, Mar 05, 2021 at 07:05:39PM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 04, 2021 at 07:51:55PM -0500, Stefan Berger wrote:
> > +module_exit(ecdsa_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
> 
> Remove MODULE_AUTHOR(). It's redundant because of Git.

When it's decided that MODULE_AUTHOR is redundant because of git?
I don't see MODULE_AUTHOR define expanding to nothing in module.h.
Also, this info is shown for end user in modinfo. And kernel is still
distributed as a tarball on kernel.org.

Thanks,

