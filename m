Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F23A7EA1
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 15:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhFONHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 09:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFONHL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 09:07:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC38B61001;
        Tue, 15 Jun 2021 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623762307;
        bh=aGEKMIS0PUOJ/1fjleH9M9mgh0PdhlRGN7kd+G3Hjn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rt6yV4rsIBq+vFZL/WT3d87b3ZpHqar7FYyuZyzWmzguq4QfJNHOs2SproeQ1wkyp
         ZRlKQrJKpH0BIgx/+A45LTmp2KU8BFiz73xjtzL3PUDdQ0C5GmBN8Z9Y2PV4SfwzzN
         HF4U1V7AoIVsUEEYGkh1xXzo8pjy842YZTws+xyVNLZDCmYRfz/KLcm6RczPB6m7WF
         6Ft5DzhvjopxvbTpw4oUorTWHeEqRM4efJ4BDLqv50cul+C27tI93CPFiNCHiZY+wv
         SNzT4EAHQoTuzoWg7E9MfUMzJP1uRYslNjakaC8N+gYZjS0cfjDUTYVdV07ox1PQgG
         qWyqVCjdSUhYw==
Date:   Tue, 15 Jun 2021 16:05:04 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] Add support for ECDSA-signed kernel modules
Message-ID: <20210615130504.ngizto6nv33qqirf@kernel.org>
References: <20210610125623.1553792-1-stefanb@linux.ibm.com>
 <20210614191948.io4waff5aisah36q@kernel.org>
 <95fac042-d348-91d9-f6d0-6a1ec21cebe4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95fac042-d348-91d9-f6d0-6a1ec21cebe4@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 14, 2021 at 03:20:43PM -0400, Stefan Berger wrote:
> 
> On 6/14/21 3:19 PM, Jarkko Sakkinen wrote:
> > On Thu, Jun 10, 2021 at 08:56:19AM -0400, Stefan Berger wrote:
> > > This series adds support for ECDSA-signed kernel modules. It also
> > > attempts to address a kbuild issue where a developer created an ECDSA
> > > key for signing kernel modules and then builds an older version of the
> > > kernel, when bisecting the kernel for example, that does not support
> > > ECDSA keys.
> > > 
> > > The first patch addresses the kbuild issue of needing to delete that
> > > ECDSA key if it is in certs/signing_key.pem and trigger the creation
> > > of an RSA key. However, for this to work this patch would have to be
> > > backported to previous versions of the kernel but would also only work
> > > for the developer if he/she used a stable version of the kernel to which
> > > this patch was applied. So whether this patch actually achieves the
> > > wanted effect is not always guaranteed.
> > > 
> > > The 2nd patch adds the support for the ECSDA-signed kernel modules.
> > > 
> > > This patch depends on the ECDSA support series currently queued here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git/log/?h=ecc
> > > 
> > >    Stefan
> > > 
> > > v6:
> > >    - Patch 2/4 is fixing V4's 1/2 and 4/4 is fixing V4's 2/2. Both fixup
> > >      patches to be squashed.
> > > 
> > > v5:
> > >    - do not touch the key files if openssl is not installed; likely
> > >      addresses an issue pointed out by kernel test robot
> > > 
> > > v4:
> > >    - extending 'depends on' with MODULES to (IMA_APPRAISE_MODSIG && MODULES)
> > > v3: - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
> > >    - added recommendation to use string hash to Kconfig help text
> > > 
> > > v2:
> > >    - Adjustment to ECDSA key detector string in 2/2
> > >    - Rephrased cover letter and patch descriptions with Mimi
> > > 
> > > 
> > > Stefan Berger (4):
> > >    certs: Trigger creation of RSA module signing key if it's not an RSA
> > >      key
> > >    certs: Check whether openssl tool is available
> > >    certs: Add support for using elliptic curve keys for signing modules
> > >    certs: Adjustment due to 'Check whether openssl tool is available'
> > > 
> > >   certs/Kconfig                         | 26 ++++++++++++++++++++++++++
> > >   certs/Makefile                        | 21 +++++++++++++++++++++
> > >   crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
> > >   3 files changed, 55 insertions(+)
> > > 
> > > -- 
> > > 2.29.2
> > > 
> > > 
> > Since you know the commit ID's in
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > 
> > you could just use fixes-tags and send exactly two patch series. Works
> > better with various tools (e.g. https://pypi.org/project/b4/)
> > 
> > /Jarkko
> 
> 
> So you are not taking v6's 2/4 and 4/4 ?

I applied the fixes and squashed them to appriopriate commits.

/Jarkko
