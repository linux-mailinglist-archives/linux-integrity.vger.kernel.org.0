Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57D3CB86D
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbhGPOKl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 10:10:41 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51238 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbhGPOKj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 10:10:39 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B7BEA72C8B4;
        Fri, 16 Jul 2021 17:07:43 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 1D8604A46E9;
        Fri, 16 Jul 2021 17:07:43 +0300 (MSK)
Date:   Fri, 16 Jul 2021 17:07:43 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
Message-ID: <20210716140743.ct3sxyi5luhqechz@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
 <20210712054448.2471236-4-vt@altlinux.org>
 <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
 <20210716135030.tc3fe3rmjmci2e4x@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210716135030.tc3fe3rmjmci2e4x@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 16, 2021 at 04:50:30PM +0300, Vitaly Chikunov wrote:
> Mimi,
> 
> On Wed, Jul 14, 2021 at 12:16:57PM -0400, Mimi Zohar wrote:
> > On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > > 
> > > @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
> > >  	basicConstraints=CA:TRUE
> > >  	subjectKeyIdentifier=hash
> > >  	authorityKeyIdentifier=keyid:always,issuer
> > > +
> > > +	[ skid ]
> > > +	basicConstraints=CA:TRUE
> > > +	subjectKeyIdentifier=12345678
> > > +	authorityKeyIdentifier=keyid:always,issuer
> > >  EOF
> > >  fi
> > 
> > On my system:
> > $ openssl version
> > OpenSSL 1.1.1g FIPS  21 Apr 2020
> > 
> > Not sure this has anything to do with the reason that "skid" is not
> > supported.   The resulting files are empty.
> > 
> > ls -lat *skid*
> > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
> > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub
> > 
> > - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> > - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> > -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> > rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> > Using configuration from test-ca.conf
> > Error Loading extension section skid   <===
> 
> How `test-ca.conf' looked like? Maybe it's not updated?
> Try to run ./gen-keys.sh clean (which is called from make distclean).

Perhaps, this is the case. I will add `test -nt' check in
gen-keys.sh, so that test-ca.conf and keys are regenerated when
gen-keys.sh is updated. This should solve that problem for users.

diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index d604c96..d2c2f80 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -26,7 +26,8 @@ log() {
 
 if [ "$1" = clean ]; then
   rm -f test-ca.conf
-elif [ "$1" = force ] || [ ! -e test-ca.conf ]; then
+elif [ "$1" = force ] || [ ! -e test-ca.conf ] \
+       || [ gen-keys.sh -nt test-ca.conf ]; then
 cat > test-ca.conf <<- EOF
        [ req ]
        distinguished_name = req_distinguished_name
@@ -54,7 +55,8 @@ fi
 # RSA
 # Second key will be used for wrong key tests.
 for m in 1024 1024_skid 2048; do
-  if [ "$1" = clean ] || [ "$1" = force ]; then
+  if [ "$1" = clean ] || [ "$1" = force ] \
+         || [ gen-keys.sh -nt test-rsa$m.key ]; then
     rm -f test-rsa$m.cer test-rsa$m.key test-rsa$m.pub
   fi
   if [ "$1" = clean ]; then

Thanks,


