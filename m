Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAB43CB7D6
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 15:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhGPN2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 09:28:19 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:41440 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhGPN2S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 09:28:18 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EA99772C8B4;
        Fri, 16 Jul 2021 16:25:21 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id BBD0B4A46E9;
        Fri, 16 Jul 2021 16:25:21 +0300 (MSK)
Date:   Fri, 16 Jul 2021 16:25:21 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
Message-ID: <20210716132521.2rot6q5ubux3trfl@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
 <20210712054448.2471236-4-vt@altlinux.org>
 <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
 <20210714181348.yjvfk5p5uxqarl2q@altlinux.org>
 <46cba7f404f09c13a5a80606ee934b185660e567.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <46cba7f404f09c13a5a80606ee934b185660e567.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 14, 2021 at 03:20:50PM -0400, Mimi Zohar wrote:
> On Wed, 2021-07-14 at 21:13 +0300, Vitaly Chikunov wrote:
> > On Wed, Jul 14, 2021 at 12:16:57PM -0400, Mimi Zohar wrote:
> > > On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > > > 
> > > > @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
> > > >  	basicConstraints=CA:TRUE
> > > >  	subjectKeyIdentifier=hash
> > > >  	authorityKeyIdentifier=keyid:always,issuer
> > > > +
> > > > +	[ skid ]
> > > > +	basicConstraints=CA:TRUE
> > > > +	subjectKeyIdentifier=12345678
> > > > +	authorityKeyIdentifier=keyid:always,issuer
> > > >  EOF
> > > >  fi
> > > 
> > > On my system:
> > > $ openssl version
> > > OpenSSL 1.1.1g FIPS  21 Apr 2020
> > > 
> > > Not sure this has anything to do with the reason that "skid" is not
> > > supported.   The resulting files are empty.
> > > 
> > > ls -lat *skid*
> > > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
> > > -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub
> > > 
> > > - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> > > - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> > > -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> > > rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> > > Using configuration from test-ca.conf
> > > Error Loading extension section skid   <===
> > 
> > Is it reproducible? Since multiple-distributions CI passed, I wonder
> > what distro it is.
> 
> I'm running the tests locally on RHEL 8.4 and Fedora 34 rawhide
> systems.  When generating the keys, the output is redirected to
> /dev/null.   The end result is that the test is simply skipped.

Cannot reproduce this in Docker on centos:8 and fedora:34 with this
Dockerfile (for fedora):

  FROM fedora:34
  RUN dnf install -y \
	  asciidoc \
	  attr \
	  autoconf \
	  automake \
	  diffutils \
	  docbook-xsl \
	  git \
	  gzip \
	  keyutils-libs-devel \
	  libattr-devel \
	  libtool \
	  libxslt \
	  make \
	  openssl \
	  openssl-devel \
	  pkg-config \
	  procps \
	  sudo \
	  vim-common \
	  wget \
	  which
  WORKDIR /src
  COPY . .
  RUN git clean -dxf \
	  && autoreconf -fisv
  RUN ./configure
  RUN make
  RUN make check

Log:

  - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
  - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
  Using configuration from test-ca.conf
  Generating a RSA private key
  ..............+++++
  ..............+++++
  writing new private key to 'test-rsa1024_skid.key'
  ...

  [root@45a7d2cfe41e tests]# find -ls |grep skid
   26608693      4 -rw-r--r--   1 root     root          272 Jul 16 13:19 ./test-rsa1024_skid.pub
   26608692      4 -rw-r--r--   1 root     root          615 Jul 16 13:19 ./test-rsa1024_skid.cer
   26608691      4 -rw-------   1 root     root         1803 Jul 16 13:19 ./test-rsa1024_skid.key


> 
> sign_verify.test:
> ./gen-keys.sh >/dev/null 2>&1
> 
> [On Fedora:
> $ openssl version
> OpenSSL 1.1.1k  FIPS 25 Mar 2021]
> 
> Mimi
