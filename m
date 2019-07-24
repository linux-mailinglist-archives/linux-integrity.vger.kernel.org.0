Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11F487357B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 19:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfGXR2G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 13:28:06 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:56762 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbfGXR2D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 13:28:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ADD6172CCDA;
        Wed, 24 Jul 2019 20:28:01 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 93E814A4AE8;
        Wed, 24 Jul 2019 20:28:01 +0300 (MSK)
Date:   Wed, 24 Jul 2019 20:28:01 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Petr Vorel <pvorel@suse.cz>,
        "BrunoE.O.Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: ima-evm-utils:  library version
Message-ID: <20190724172801.y64bs2byyuqfsezf@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>,
        "BrunoE.O.Meneguele" <bmeneg@redhat.com>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <1563972698.4245.21.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1563972698.4245.21.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Jul 24, 2019 at 08:51:38AM -0400, Mimi Zohar wrote:
> 
> In preparing the ima-evm-utils v1.2 release, I noticed that the
> library version was never updated. šIt is still "0.0.0". šShould I set
> it to something? šIf so, what versioning scheme do you recommend -
> using the libtool current[:revision[:age]], prepending the release
> version on the .so, or suffixing the release version on the .so?

libtool rules should be followed:

  https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html

I think you should change 0.0.0 to 1.0.0 just before release. Since we are
changed ABI of calc_keyid_v2 (RSA *key -> EVP_PKEY *pkey). (There is also
changes to read_pub_pkey and get_filesize.)

> The other option is to leave the version as 0.0.0 and let the distro
> package maintainers deal with it.

I think you should update it properly.

> Posting a patch that sets the library version would be most welcome.

diff --git a/src/Makefile.am b/src/Makefile.am
index 9c037e2..b794c50 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -4,7 +4,7 @@ libimaevm_la_SOURCES = libimaevm.c
 libimaevm_la_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 # current[:revision[:age]]
 # result: [current-age].age.revision
-libimaevm_la_LDFLAGS = -version-info 0:0:0
+libimaevm_la_LDFLAGS = -version-info 1:0:0
 libimaevm_la_LIBADD =  $(LIBCRYPTO_LIBS)

Thanks,
