Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB88932F434
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 20:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCETrS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 14:47:18 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:51486 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCETqm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 14:46:42 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5F25A72C8B8;
        Fri,  5 Mar 2021 22:46:40 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 490AE4A4737;
        Fri,  5 Mar 2021 22:46:40 +0300 (MSK)
Date:   Fri, 5 Mar 2021 22:46:40 +0300
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
Message-ID: <20210305194640.nnerhdadoczqyta3@altlinux.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-2-stefanb@linux.vnet.ibm.com>
 <YEJk44FXEl0+mEPr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YEJk44FXEl0+mEPr@kernel.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko,

On Fri, Mar 05, 2021 at 07:05:39PM +0200, Jarkko Sakkinen wrote:
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (c) 2021 IBM Corporation
> > + *
> > + * Redistribution and use in source and binary forms, with or without
> > + * modification, are permitted provided that the following conditions are
> > + * met:
> > + *  * Redistributions of source code must retain the above copyright
> > + *   notice, this list of conditions and the following disclaimer.
> > + *  * Redistributions in binary form must reproduce the above copyright
> > + *    notice, this list of conditions and the following disclaimer in the
> > + *    documentation and/or other materials provided with the distribution.
> > + *
> > + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> > + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> > + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> > + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> > + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> > + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> > + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> > + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> > + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> > + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> > + */
> 
> This license platter is redundant, given SPDX.

I think SPDX identifier supplements license plate and is machine readable
identifier, but it does not replace or making adding of license plate
redundant.

- Quoting https://spdx.dev/ids/

  "When a license defines a recommended notice to attach to files under
  that license (sometimes called a “standard header”), the SPDX project
  recommends that the standard header be included in the files, in
  addition to an SPDX ID.

  Additionally, when a file already contains a standard header or other
  license notice, the SPDX project recommends that those existing
  notices should not be removed. The SPDX ID is recommended to be used
  to supplement, not replace, existing notices in files."

- GPL license text have section on "How to Apply These Terms to Your New
  Programs" which says to add license boilerplate text and it does not
  say SPDX identifier is enough.

- Also, page https://www.kernel.org/doc/html/latest/process/license-rules.html
  does not forbid adding license plate text. (Even though it misguidedly
  says "alternative to boilerplate text" is the use of SPDX.)

- License text is a readable text and not just identifier.
  I think SPDX tag could be not legally binding in all jurisdictions.

By there reasons I believe you cannot request removing license platter
from the source and this should be author's decision.

Thanks,

