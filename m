Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88383CB814
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbhGPNx0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 09:53:26 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:35344 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbhGPNx0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 09:53:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6006C72C8B4;
        Fri, 16 Jul 2021 16:50:30 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 4AE8B4A46E9;
        Fri, 16 Jul 2021 16:50:30 +0300 (MSK)
Date:   Fri, 16 Jul 2021 16:50:30 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
Message-ID: <20210716135030.tc3fe3rmjmci2e4x@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
 <20210712054448.2471236-4-vt@altlinux.org>
 <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 14, 2021 at 12:16:57PM -0400, Mimi Zohar wrote:
> On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> > 
> > @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
> >  	basicConstraints=CA:TRUE
> >  	subjectKeyIdentifier=hash
> >  	authorityKeyIdentifier=keyid:always,issuer
> > +
> > +	[ skid ]
> > +	basicConstraints=CA:TRUE
> > +	subjectKeyIdentifier=12345678
> > +	authorityKeyIdentifier=keyid:always,issuer
> >  EOF
> >  fi
> 
> On my system:
> $ openssl version
> OpenSSL 1.1.1g FIPS  21 Apr 2020
> 
> Not sure this has anything to do with the reason that "skid" is not
> supported.   The resulting files are empty.
> 
> ls -lat *skid*
> -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
> -rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub
> 
> - openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
> - openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
> -extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
> rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
> Using configuration from test-ca.conf
> Error Loading extension section skid   <===

How `test-ca.conf' looked like? Maybe it's not updated?
Try to run ./gen-keys.sh clean (which is called from make distclean).

Thanks,

> 
> 
> Then the rest of the tests fail.  Probably should check not only if the
> file exists, but the size of the file as well.
> 
> - openssl pkey -in test-rsa1024_skid.key -out test-rsa1024_skid.pub
> -pubout
> Can't open test-rsa1024_skid.key for reading, No such file or directory
> 140493815547712:error:02001002:system library:fopen:No such file or
> directory:crypto/bio/bss_file.c:69:fopen('test-rsa1024_skid.key','r')
> 140493815547712:error:2006D080:BIO routines:BIO_new_file:no such
> file:crypto/bio/bss_file.c:76:
> unable to load key
> 
> 
> - openssl x509 -inform DER -in test-rsa1024_skid.cer
> Can't open test-rsa1024_skid.cer for reading, No such file or directory
> 139636313208640:error:02001002:system library:fopen:No such file or
> directory:crypto/bio/bss_file.c:69:fopen('test-rsa1024_skid.cer','rb')
> 139636313208640:error:2006D080:BIO routines:BIO_new_file:no such
> file:crypto/bio/bss_file.c:76:
> unable to load certificate
> 
> Mimi
