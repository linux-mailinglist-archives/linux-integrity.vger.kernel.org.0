Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DED3D0167
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhGTRfC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 13:35:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53218 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhGTRem (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 13:34:42 -0400
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6FD6920B7178;
        Tue, 20 Jul 2021 11:15:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FD6920B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626804920;
        bh=N8E8gzfYQmpi/I0Lx5dmpzYIfyAFRTN+dtv5BQwgb34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ms7GNU9PDybjj1dg92xSh9JYqZMLzqLrtMV2nhcCV+OgoVw9tIYBpIP0mL2LIUZxJ
         B/Y+lbeuikXcycF7HJm6zFKTqrkQJj+7uIcnCx8n9FtMgyk/jLdzPkXLc46KENg+Gs
         VSC4cj+wSVDMWtc4QOca9A5T+I9lNGIoB86O3ewk=
Date:   Tue, 20 Jul 2021 13:15:17 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 8/8] firmware: tee_bnxt: Release TEE shm, session, and
 context during kexec
Message-ID: <20210720181517.GF3232@sequoia>
References: <20210716022332.GC3232@sequoia>
 <CAHLZf_t5U1bh1H8sULbJz7xrZ-r3Dcmxuw9MMmG2fehS3C72uQ@mail.gmail.com>
 <CAHUa44EetPuA_5+UQLW-c=-_OApiRoiq+YjeFs6TRPj6=AJfHw@mail.gmail.com>
 <903824a6-7a2b-1514-5b71-a2db634e9abf@gmail.com>
 <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3f4bdd-b833-d58c-f7d7-6670bcbd8ef8@gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-07-20 10:57:18, Florian Fainelli wrote:
> 
> 
> On 7/19/2021 7:32 PM, Florian Fainelli wrote:
> > 
> > 
> > On 7/19/2021 3:49 AM, Jens Wiklander wrote:
> > > Hi,
> > > 
> > > On Fri, Jul 16, 2021 at 4:48 AM Vikas Gupta
> > > <vikas.gupta@broadcom.com> wrote:
> > > > 
> > > > Hi Allen/Tyler,
> > > >   The patch looks good to me.
> > > 
> > > Thanks.
> > > 
> > > Rafal, is it OK if I include this patch together with the rest of the
> > > patches in this patch set in a pull request to arm-soc?
> > 
> > I can take those patches through the Broadcom ARM SoC pull request,
> > Rafal would that work for you? We seem to have a bit of a maintainer
> > coverage blind spot for that directory.
> 
> Applied to drivers/fixes: https://github.com/Broadcom/stblinux/commit/4ecd797b7e16eb7f1b86fbfd7e4a7887b192535b

Thanks, Florian, but note that you won't be able to build that branch
since the commit uses a new function (tee_shm_alloc_kernel_buf()) that's
added earlier in the full series. It seems like it is going to be easier
for this to all go through Jens.

Tyler

> -- 
> Florian
> 
