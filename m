Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9DD17225B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 16:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgB0Pi7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 10:38:59 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57938 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbgB0Pi7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 10:38:59 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F302F72CCF1;
        Thu, 27 Feb 2020 18:38:39 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D2BCB4A4A16;
        Thu, 27 Feb 2020 18:38:31 +0300 (MSK)
Date:   Thu, 27 Feb 2020 18:38:31 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Fix compatibility with LibreSSL
Message-ID: <20200227153825.ywas4clc3qa76rhc@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>,
        linux-integrity@vger.kernel.org
References: <63ba8482-0085-f2d3-dbb9-70bb81990f07@rosalinux.ru>
 <1582638298.10443.196.camel@linux.ibm.com>
 <fac0bebb-22ce-77f9-bac9-7ca5f76d1ca1@rosalinux.ru>
 <1582777694.10443.286.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1582777694.10443.286.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Feb 26, 2020 at 11:28:14PM -0500, Mimi Zohar wrote:
> On Wed, 2020-02-26 at 12:51 +0300, Mikhail Novosyolov wrote:
> > Hello Mimi, thanks for feedback.
> > 25.02.2020 16:44, Mimi Zohar ÐÉÛÅÔ:
> > > On Sun, 2020-02-16 at 14:10 +0300, Mikhail Novosyolov wrote:
> > >> LibreSSL in most cases can be used as a drop-in replacement of OpenSSL.
> > >> Commit 07d799cb6c37 "ima-evm-utils: Preload OpenSSL engine via '--engine' option"
> > >> added OpenSSL-specific functions: "engines" were removed from LibreSSL long ago.
> > >> Instead of requiring to attach GOST support via an external library ("engine"),
> > >> LibreSSL has build-in implementation of GOST.
> > >
> > > OpenSSL had a builtin support for GOST, which was dropped.š From the
> > > OpenSSL news "Changes between 1.0.2h and 1.1.0":
> > >
> > >šššš The GOST engine was out of date and therefore it has been removed. An up
> > >šššš to date GOST engine is now being maintained in an external repository.
> > >šššš See:šššš https://wiki.openssl.org/index.php/Binariesššš .š Libssl still retains
> > >šššš support for GOST ciphersuites (these are only activated if a GOST engine
> > >šššš is present).
> > >
> > > Please update the patch description to reflect the reason for OpenSSL
> > > dropping GOST builtin support, while LibreSSL continues to build it
> > > in.
> 
> > The reasons why OpenSSL decided to do it are out of my scope, I can
> > just write that OpenSSL had GOST, then dropped it, then gost-engine
> > appeared as an OpenSSL plugin and that LibreSSL has GOST built in
> > and dropped engines API after forking from OpenSSL. Will it be OK?
> 
> The question is whether LibreSSL is using the back level version of
> GOST that OpenSSL dropped or has it been updated? šThe patch
> description should be updated accordingly.

AFAIK, LibreSSL is using independent implementation of Streebog. It
wasn't exist in OpenSSL before split and different from what is in
gost-engine (also having different authors).

I don't really understand reason to know implementation history, if,
as library users, we should be enough to know they have compatible APIs.

Thanks,

