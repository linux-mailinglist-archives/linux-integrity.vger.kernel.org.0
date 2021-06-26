Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED13B4B82
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jun 2021 02:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFZA36 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 20:29:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44140 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbhFZA34 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 20:29:56 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 421C872C8B4;
        Sat, 26 Jun 2021 03:27:34 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 2E8674A46EC;
        Sat, 26 Jun 2021 03:27:34 +0300 (MSK)
Date:   Sat, 26 Jun 2021 03:27:34 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ima-evm-utils: Allow manual setting keyid from a
 cert file
Message-ID: <20210626002734.ojk57twxcnfnpzxw@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-3-vt@altlinux.org>
 <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <ffac9c53bacfc5a0d16ae457289d7c224c8ef924.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 25, 2021 at 08:22:06AM -0400, Mimi Zohar wrote:
> On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> > 
> > +/**
> > + * imaevm_read_keyid() - Read 32-bit keyid from the cert file.
> > + * @certfile:	File possibly containing certificate in DER/PEM format.
> > + *
> > + * Try to read keyid from Subject Key Identifier (SKID) of certificate.
> > + * Autodetect if cert is in PEM or DER encoding.
> > + *
> > + * Return: 0 on error;
> > + *         32-bit keyid as unsigned integer in host order.
> > + */
> > +uint32_t imaevm_read_keyid(const char *certfile)
> > +{
> > +	uint32_t keyid_raw = 0;
> > +
> > +	__read_keyid(&keyid_raw, certfile, KEYID_FILE_UNK_CERT);
> > +	return ntohl(keyid_raw);
> 
> On error, __read_keyid() returns < 0, but the return value isn't
> checked before calling ntohl.

It does not need to be checked, because it also does not change value
pointed by `&keyid_raw' (which is 0 by default). Yes, this is not
mentioned in the `__read_keyid' description. But, otherwise (to change
pointed value on error) would be a bug.

> In either case, is imaevm_params.keyid
> suppose to be big endian byte order? 

No, it's in native order. This looked reasonable, since it could be
presented to the user as a hex number.

Thanks,

> If so, the call to htonl in
> sign_hash_v2() would be unnecessary.
> 
> thanks,
> 
> Mimi
