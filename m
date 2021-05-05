Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10D5373496
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 07:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEEFQw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 01:16:52 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46688 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEEFQw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 01:16:52 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2FEB172C8B5;
        Wed,  5 May 2021 08:15:55 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 19A314A46E8;
        Wed,  5 May 2021 08:15:55 +0300 (MSK)
Date:   Wed, 5 May 2021 08:15:54 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210505051554.tg5mqzaq6n34o3jx@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-4-vt@altlinux.org>
 <1b5d6c49-c080-76e9-66e1-2db19bfee2c9@linux.ibm.com>
 <20210504222723.wirqlwsz2xtnfqz7@altlinux.org>
 <fbe258e3-5cd4-5d67-7622-431a6434d64f@linux.ibm.com>
 <20210505011501.vdgfkrparxwop6xc@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210505011501.vdgfkrparxwop6xc@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Wed, May 05, 2021 at 04:15:02AM +0300, Vitaly Chikunov wrote:
> On Tue, May 04, 2021 at 09:04:44PM -0400, Stefan Berger wrote:
> > On 5/4/21 6:27 PM, Vitaly Chikunov wrote:
> > > On Tue, May 04, 2021 at 09:38:06AM -0400, Stefan Berger wrote:
> > > > On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> > > > I suppose if there's an
> > > > appended X509 in the private key file as well then only one function should
> > > > be necessary to extract the x509 cert from the files. That function should
> > > > be able to handle PEM and DER format at the same time. Have you tried
> > > > extracting the x509 cert from the private key file using that other function
> > > > in 2/3 yet?
> > > Excuse me, I don't understand what you talking about in this note.
> > > 2/3 does not read private keys. Where and why should be one function?
> > > And what other function?
> > 
> > It should be possible to combine yourš functions extract_keyid (2/3) and
> > read_keyid (3/3) into a single function that can handle PEM files containing
> > X509 certs as well as DER files. It's two times very similar code and the
> > function that can handle DER and PEM should be able to handle PEM files with
> > private keys + X509 certs.
> 
> I see. There should be very generic function that can read fd, FILE,
> bio, and memory region, also can parse DER, PEM, and combined PEMs.

Implemented in [PATCH v3 2/3], but now there are some problems.

ima_read_keyid() is called with different intentions from evmctl and
from libimaevm. Call from evmctl is explicit user intention (to read
cert) and should produce error messages for failures. Call from
calc_keyid_v2() is best effort (and can be thought as a side effect)
and should be as quiet as possible. Also, in the second case it shall not
try to load DER certificate.

Vitaly,

