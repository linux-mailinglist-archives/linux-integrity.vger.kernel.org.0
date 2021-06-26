Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463693B4B78
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jun 2021 02:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFZAX7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 20:23:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:40914 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAX7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 20:23:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C32C372C8B4;
        Sat, 26 Jun 2021 03:21:36 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B17C14A46EC;
        Sat, 26 Jun 2021 03:21:36 +0300 (MSK)
Date:   Sat, 26 Jun 2021 03:21:36 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210626002136.bz2sn2chw4rddyev@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-4-vt@altlinux.org>
 <5a526d9dd5dcd227c4f85e8a3b9ae504ea97c438.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <5a526d9dd5dcd227c4f85e8a3b9ae504ea97c438.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Jun 25, 2021 at 08:22:15AM -0400, Mimi Zohar wrote:
> On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> > Allow to have certificate appended to the private key of `--key'
> > specified (PEM) file (for v2 signing) to facilitate reading of keyid
> > from the associated cert. This will allow users to have private and
> > public key as a single file. There is no check that public key form the
> > cert matches associated private key.
> 
> Is this a standard formats for storing the public and private key in
> the same file?

I am not aware of any standard to keep ASCII armored text x509 cert
together with the private key in the same file. But, it's common usage
for some web servers, such as NGINX. People commonly suggest doing
it in that context:

  https://stackoverflow.com/questions/991758/how-to-get-pem-file-from-key-and-crt-files
  "cat server.crt server.key > server.includesprivatekey.pem"
  "cat server.crt server.key > server.pem"

Thanks,


> 
> Mimi
