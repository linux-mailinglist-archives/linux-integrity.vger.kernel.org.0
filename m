Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D1A5A6EAD
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 22:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiH3Uw6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 16:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3Uw5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 16:52:57 -0400
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 676E26FA33
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 13:52:55 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 7E25F72C90B;
        Tue, 30 Aug 2022 23:52:54 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 58AD64A470D;
        Tue, 30 Aug 2022 23:52:54 +0300 (MSK)
Date:   Tue, 30 Aug 2022 23:52:54 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 08/11] Deprecate use of OpenSSL 3
 "engine" support
Message-ID: <20220830205254.w6cahikybwzmxwkx@altlinux.org>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-9-zohar@linux.ibm.com>
 <20220830030353.lwggzfsqmalpznoy@altlinux.org>
 <30cc0eab23501c33ab3d2a8e2a6548b92ce9a127.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <30cc0eab23501c33ab3d2a8e2a6548b92ce9a127.camel@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Aug 30, 2022 at 07:46:40AM -0400, Mimi Zohar wrote:
> On Tue, 2022-08-30 at 06:03 +0300, Vitaly Chikunov wrote:
> > Mimi,
> > 
> > On Mon, Aug 29, 2022 at 08:59:33PM -0400, Mimi Zohar wrote:
> > > OpenSSL 3 "engine" support is deprecated, which results in deprecated
> > > build warning messages.  In preparation for OpenSSL "engine" support
> > > to be removed, define a "--enable-engine" configuration option. If not
> > > specified, disable engine support on systems with OpenSSL v3.
> > 
> > This seems to change default behavior.
> > 
> > Many distributions (AFAIK) still contain openssl1, and some contain both
> > openssl1 and openssl3, including devel packages. So they will suddenly
> > drop --engine support on ima-evm-utils update, even though their OpenSSL
> > supports it.
> > 
> > Maybe --disable-engine should be added instead if user wants to avoid
> > compile time deprecation warnings?
> 
> No, engine support is not disabled for previous versions of OpenSSL. 
> It's only disabled for OpenSSL v3, with the --enable-engine option
> allowing it to be configured.  The "-Wno-deprecated-declarations"
> option could even be added.

IC, but many distributions switched to openssl3 - engine support will
suddenly disappear for them if they aren't attentive enough.

OpenSSL can be compiled w/o engine support, I think engine support in
evmctl should depend on that and not on ima-evm-utils configure option. If
distribution wants to disable engine support they will disable it in
OpenSSL and it will be disabled in ima-evm-utils as consequence.
Or at least this should be default behavior, and to deviate from it
additional --disable-engine option in ima-evm-utils.

> > 
> > (Also, engines aren't just deprecated, they are deprecated in favor of
> > providers.)
> 
> Right.  At some point, OpenSSL engine support will be removed.   This
> is a first step to removing it in ima-evm-utils.  I searched but didn't
> find any gost providers.   Feel free to add it.

gost-engine already compiles to a provider:
  https://github.com/gost-engine/engine#provider

> > > diff --git a/tests/functions.sh b/tests/functions.sh
> > > index 8f6f02dfcd95..ddc8fe9e5ea6 100755
> > > --- a/tests/functions.sh
> > > +++ b/tests/functions.sh
> > > @@ -312,4 +312,13 @@ _softhsm_teardown() {
> > >    rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
> > >    unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
> > >      EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
> > > -}
> > > \ No newline at end of file
> > > +}
> > > +
> > > +# OpenSSL 3 engine support still works, but is deprecated. In preparation
> > > +# for it being removed, a new ima-evm-utils configuration option
> > > +# "--enable-engine" is defined.`
> > > +_is_engine_supported() {
> > > +  cmd="evmctl --engine pkcs11"
> > 
> > I think pkcs11 engine is optional (and could be in additional package)
> > even if other engines are present.
> 
> We need to move away from OpenSSL engine support towards providers.

Perhaps they will remove engines (it's not certain) in openssl4,
but how many years will pass before that? I don't see why we should
hurry in that.

> 
> > 
> > Also engine could be loaded via openssl.cnf/OPENSSL_CONF, in that case
> > --engine option is not needed but engine is still there to use/test.
> 
> Thank you for reminding me that engine support based on the OpenSSL
> configuration also needs to be deprecated.

I'm curious - how would you deprecate that? As this should be
transparent to the libcrypto clients - new functionality and algorithms
just appear.

> 
> > 
> > 
> > > +  $cmd &>/dev/null
> > > +  ENGINE_SUPPORTED=$?
> > > +}
> > > diff --git a/tests/ima_hash.test b/tests/ima_hash.test
> > > index e88fd59cc359..0de9e6808af9 100755
> > > --- a/tests/ima_hash.test
> > > +++ b/tests/ima_hash.test
> > > @@ -71,6 +71,15 @@ expect_pass check  sha384     0x0405 38b060a751ac96384cd9327eb1b1e36a21fdb71114b
> > >  expect_pass check  sha512     0x0406 cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e
> > >  expect_pass check  rmd160     0x0403 9c1185a5c5e9fc54612808977ee8f548b2258d31
> > >  expect_pass check  sm3        0x0411 1ab21d8355cfa17f8e61194831e81a8f22bec8c728fefb747ed035eb5082aa2b
> > > +
> > > +# Remaining tests require engine support
> > > +_is_engine_supported
> > > +if [ $ENGINE_SUPPORTED -eq 77 ]; then
> > > +  __skip() { echo "Tests requiring engine support are skipped (not supported)"; return $SKIP; }
> > > +  expect_pass __skip
> > > +  exit 0
> > > +fi
> > 
> > GOST tests try to handle absence of algorithms (can work w/o --engine
> > option if configured via openssl config) and skip gracefully.
> > Perhaps this check should be moved below them just for pkcs11 tests
> > if they are so sensitive.
> 
> Does OpenSSL v3 differentiate how engines are configured?  I assume
> when engine support is removed, all of it will be removed.

Perhaps. But providers are configured similarly via config - there
config examples for some gost-engine Perl tests:
  as engine https://github.com/gost-engine/engine/blob/master/test/engine.cnf
  as provider https://github.com/gost-engine/engine/blob/master/test/provider.cnf

Thanks,
