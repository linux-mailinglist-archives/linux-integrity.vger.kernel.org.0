Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86148375E7E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhEGBod (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 6 May 2021 21:44:33 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33858 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBod (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 6 May 2021 21:44:33 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E7C8372C8B4;
        Fri,  7 May 2021 04:43:32 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id AD88A4A46E8;
        Fri,  7 May 2021 04:43:32 +0300 (MSK)
Date:   Fri, 7 May 2021 04:43:32 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 0/3] ima-evm-utils: Add --keyid option
Message-ID: <20210507014332.qrgvzaana53yzp4g@altlinux.org>
References: <20210506034702.216842-1-vt@altlinux.org>
 <a187174e-9a57-9aad-790b-41eaca424e35@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <a187174e-9a57-9aad-790b-41eaca424e35@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Thu, May 06, 2021 at 04:10:25PM -0400, Stefan Berger wrote:
> On 5/5/21 11:46 PM, Vitaly Chikunov wrote:
> > Allow user to set signature's keyid using `--keyid' option. Keyid should
> > correspond to SKID in certificate. When keyid is calculated using SHA-1
> > in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> > certificate (the way public key is presented to the kernel), thus making
> > signatures not verifiable. This may happen when certificate is using non
> > SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> > As a last resort user may specify arbitrary keyid using the new option.
> > Certificate @filename could be used instead of the hex number. And,
> > third option is to read keyid from the cert appended to the key file.
> > 
> > These commits create backward incompatible ABI change for libimaevm,
> >   thus soname should be incremented on release.
> 
> I hope this will not be forgotten about. Maybe it should be part of this
> series here?

https://www.gnu.org/software/libtool/manual/html_node/Updating-version-info.html

  "Update the version information only immediately before a public
  release of your software."

I believe we should follow this.

Thanks,

