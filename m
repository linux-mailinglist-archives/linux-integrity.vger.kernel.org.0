Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4542E51B58
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 21:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfFXTXx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 15:23:53 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36506 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfFXTXw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 15:23:52 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B0DED72CC58;
        Mon, 24 Jun 2019 22:23:49 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 814614A4A29;
        Mon, 24 Jun 2019 22:23:49 +0300 (MSK)
Date:   Mon, 24 Jun 2019 22:23:49 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA
 to EVP_PKEY API
Message-ID: <20190624192349.gdp2xbe5c6etaw6v@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
 <1561387352.4340.20.camel@linux.ibm.com>
 <20190624161638.xz6ebfvxzilh2gew@altlinux.org>
 <1561403393.4340.58.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561403393.4340.58.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jun 24, 2019 at 03:09:53PM -0400, Mimi Zohar wrote:
> On Mon, 2019-06-24 at 19:16 +0300, Vitaly Chikunov wrote:
> > On Mon, Jun 24, 2019 at 10:42:32AM -0400, Mimi Zohar wrote:
> > > On Sun, 2019-06-23 at 12:00 +0300, Vitaly Chikunov wrote:
> > > > Convert sign v2 from RSA API (with manual formatting PKCS1) to more generic
> > > > EVP_PKEY API, allowing to generate more types of OpenSSL supported signatures.
> > > > This is done to enable EC-RDSA signatures, which are already supported in the
> > > > Kernel. With some small fixes.
> > > > 
> > > > All patches tested on x86_64 to not break anything.
> > > > 
> > > > Changes since v6:
> > > > - Remove "Make sure sig buffer is always MAX_SIGNATURE_SIZE" commit. Instead,
> > > >   change assumption of sign_hash_v2() about @sig size.
> > > 
> > > With and without this change, the sha family is working properly, but
> > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > (invalid digest)" for gost/streebog. šPreviously it worked.
> > 
> > Sounds strange. For me it's working good for streebog now and then.
> > 
> >   = Testing algo gost2012_256-A hash streebog256 =
> >   test.txt: verification is OK
> >   ...
> > 
> > Maybe somehow your test env is getting broken?
> > 
> > I test on Debian 9, manually compiled openssl and then gost-engine
> > from git. Env is like this:
> > 
> >   PATH=$HOME/src/openssl/apps:$HOME/src/ima-evm-utils/src/.libs:$PATH
> >   LD_LIBRARY_PATH=$HOME/src/openssl:$HOME/src/ima-evm-utils/src/.libs
> >   OPENSSL_CONF=$HOME/src/gost-engine/build/openssl.conf
> >   OPENSSL_ENGINES=$HOME/src/gost-engine/build/bin
> > 
> > ima-evm-utils is ./configure'd with
> > 
> >   export OPENSSL_LIBS="-L$HOME/src/openssl -lssl -lcrypto"
> > 
> > and then make'd without install, and test run.
> 
> Ok. šI'm using a version, which I built when you first sent the
> patches for the crypto engine support.

Did you mean you try to make RSA signature with Streebog hashes? This
shouldn't work, as intended. Streebog hash only should be used with
EC-RDSA signatures (or gost2012_{256,512} in terms of OpenSSL).

If it worked before this is strange. It should not. What patchset
version it was?

Vitaly,

