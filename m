Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549EC7AC69
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jul 2019 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfG3P2d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jul 2019 11:28:33 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40320 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731021AbfG3P2c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jul 2019 11:28:32 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D4B0872CCD5;
        Tue, 30 Jul 2019 18:28:30 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B008A4A4AE7;
        Tue, 30 Jul 2019 18:28:30 +0300 (MSK)
Date:   Tue, 30 Jul 2019 18:28:30 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
Subject: Re: ima-evm-utils: git tagging for release
Message-ID: <20190730152829.y3nf54dq6md2pafy@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@kernel.org>,
        linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Petr Vorel <pvorel@suse.cz>
References: <20190729101252.iirdsz2j5bjk267f@altlinux.org>
 <20190730062625.gpy2p4nff3vnm7sd@altlinux.org>
 <1564486237.4189.28.camel@kernel.org>
 <1564497374.4189.84.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564497374.4189.84.camel@kernel.org>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 30, 2019 at 10:36:14AM -0400, Mimi Zohar wrote:
> 
> I've also pushed out some of the bug fixes to next and ima-evm-utils-
> 1.2.y. šWhich of your remaining patches are bug fixes and should be
> applied to both branches?

"ima-evm-utils: Do not load keys from x509 certs if user pass --rsa"
- This allows user to not see the confusing error message for v1 signatures
  if user knows to pass --rsa. This error message is not affecting
  behavior, though.

All others are applied, I think.

Thanks,

