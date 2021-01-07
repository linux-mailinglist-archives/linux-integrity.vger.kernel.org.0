Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696DD2ED075
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Jan 2021 14:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbhAGNQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Jan 2021 08:16:38 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:48708 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbhAGNQi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Jan 2021 08:16:38 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 2CEC372C8B0;
        Thu,  7 Jan 2021 16:15:56 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 118D14A473A;
        Thu,  7 Jan 2021 16:15:56 +0300 (MSK)
Date:   Thu, 7 Jan 2021 16:15:55 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Patrick Uiterwijk <patrick@puiterwijk.org>,
        linux-integrity@vger.kernel.org, pbrobinson@redhat.com
Subject: Re: [PATCH 1/2] Fix sign_hash not observing the hashalgo argument
Message-ID: <20210107131555.t7k4r2kytftj2nip@altlinux.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210106094335.3178261-2-patrick@puiterwijk.org>
 <ed6980130453e529d5bc8a089a0d0082d2f471cd.camel@linux.ibm.com>
 <20210107130816.wmzrcx5il4hdmah6@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210107130816.wmzrcx5il4hdmah6@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 07, 2021 at 04:08:16PM +0300, Vitaly Chikunov wrote:
> Patrick, Mimi,
> 
> On Thu, Jan 07, 2021 at 07:24:43AM -0500, Mimi Zohar wrote:
> > On Wed, 2021-01-06 at 10:43 +0100, Patrick Uiterwijk wrote:
> > > This fixes sign_hash not using the correct algorithm for creating the
> > > signature, by ensuring it uses the passed in variable value.
> > > 
> > > Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> > 
> > Thank you.  This is a regression first introduced in commit
> > 07e623b60848 ("ima-evm-utils: Convert sign_hash_v2 to EVP_PKEY API").
> 
> Ah, when sign_hash() is used not via evmctl, but as a library
> imaevm_params may be not set.

Thinking about imaevm_params -- it's still belong to a library and
extensively used in libimaevm.c, so I wonder if the fix is perfect.
Since, now there is hash_algo and algo duplication which one to prefer
and why?

Maybe, it should be [also] set like keypass in sign_hash?

  int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
  {
	  if (keypass)
		  imaevm_params.keypass = keypass;

+	  if (hashalgo)
+		  imaevm_params.hash_algo = hashalgo;

	  return imaevm_params.x509 ?
		  sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
		  sign_hash_v1(hashalgo, hash, size, keyfile, sig);
  }


