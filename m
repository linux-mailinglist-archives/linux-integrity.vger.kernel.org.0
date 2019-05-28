Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2A2D1AD
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2019 00:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE1WrB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 18:47:01 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38960 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1WrB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 18:47:01 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5DD9C72CC64;
        Wed, 29 May 2019 01:46:59 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 438B74A4A14;
        Wed, 29 May 2019 01:46:59 +0300 (MSK)
Date:   Wed, 29 May 2019 01:46:58 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] ima-evm-utils: Convert sign v2 from RSA to EVP_PKEY
 API
Message-ID: <20190528224657.r6muelxxhjdgcyji@altlinux.org>
References: <20190323025633.26541-1-vt@altlinux.org>
 <1559069833.4139.25.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1559069833.4139.25.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, May 28, 2019 at 02:57:13PM -0400, Mimi Zohar wrote:
> On Sat, 2019-03-23 at 05:56 +0300, Vitaly Chikunov wrote:
> > Convert sign_v2 and related to using EVP_PKEY API instead of RSA API.
> > This enables more signatures to work out of the box.
> > 
> > Remove RSA_ASN1_templates[] as it does not needed anymore. OpenSSL sign
> > is doing proper PKCS1 padding automatically (tested to be compatible
> > with previous version, except for MD4). This also fixes bug with MD4
> > which produced wrong signature because of absence of the appropriate
> > RSA_ASN1_template.
> 
> Is there any way of breaking this patch up to simplify review?

Hm. The main change is to replace key type from RSA with more abstract
EVP_PKEY. All other changes are a consequence of it.

And because keys are now EVP_PKEY the templates are removed too, now
that we are not dealing with keys on the too low level anymore.

I already tried to leave RSA handling as is for v1 signatures, because
they are RSA specific anyway.

Also, I tried to leave most (external) API the same, except
calc_keyid_v2 which now gets EVP_PKEY instead of RSA. Internally,
find_keyid now returns EVP_PKEY too.

read_pub_key now extracts RSA from EVP_PKEY from read_pub_pkey.

And calc_keyid_v2 now works internally slightly differently (and
generally) to handle all possible key types.

Also, I run some tests with ASan.

Thanks,


> 
> Mimi
