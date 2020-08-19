Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CE24A2A0
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 17:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgHSPRS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 11:17:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41398 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728664AbgHSPRO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 11:17:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9DCEB8EE1F3;
        Wed, 19 Aug 2020 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597850233;
        bh=u8eA+UrKm7Oa+OhwxVTGmaX8Rvfjzz/S18lGSJoKESA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wvtm21nX4yRbrL5AM/oZ9DiDQrZ2Pb5uA4Do2S2Qa6/B1c20JzBNIGtEy52/xRyuF
         lSaV3e23b7FDRBE1oOZd3qHg6wPp+rYyj6cl74pJoRONr6Gktix4mqmOAFb3737Lve
         5T9B0NJpbfXwMc6qN3mau/8S68JSpqdcGJz3PR88=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id js-7jB_ASmDR; Wed, 19 Aug 2020 08:17:13 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 11A818EE0E9;
        Wed, 19 Aug 2020 08:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1597850233;
        bh=u8eA+UrKm7Oa+OhwxVTGmaX8Rvfjzz/S18lGSJoKESA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Wvtm21nX4yRbrL5AM/oZ9DiDQrZ2Pb5uA4Do2S2Qa6/B1c20JzBNIGtEy52/xRyuF
         lSaV3e23b7FDRBE1oOZd3qHg6wPp+rYyj6cl74pJoRONr6Gktix4mqmOAFb3737Lve
         5T9B0NJpbfXwMc6qN3mau/8S68JSpqdcGJz3PR88=
Message-ID: <1597850231.3875.13.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@nvidia.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 19 Aug 2020 08:17:11 -0700
In-Reply-To: <20200819120238.GD1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
         <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
         <20200818161207.GC137138@linux.intel.com>
         <20200818161955.GD137138@linux.intel.com>
         <20200818162630.GE137138@linux.intel.com>
         <20200818164602.GZ1152540@nvidia.com>
         <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
         <20200818183603.GC1152540@nvidia.com>
         <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
         <20200819120238.GD1152540@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> 
> > The problem is that there isn't just one single userspace library
> > or application for reading PCRs.  So now not only is there the
> > kernel "boot_aggregate" regression testing, but regression testing
> > of the tool itself to support multiple methods of reading the PCRs.
> 
> I was thinking just open code 
>   open("/dev/tpm")
>   write(read_pcrs_cmd)

That's rather an over simplification.  The command takes a
TPML_PCR_SELECTION structure which is, in turn, a packed array of
TPMS_PCR_SELECTION which is a hash type and big endian packed bitmap.

>   read(read_pcrs_cmd)

And the return is a TPML_PCR_SELECTION, in case the system couldn't
provide something you asked for followed by TPML_DIGEST structure which
is a counted array of TPM2B packed digests.

This is a marshal/unmarshal nightmare for the uninitiated.  It is *not*
simple or even straightforward.

> It isn't particularly hard to retrive the PCRs, don't really need to
> depend on a library.

Well, having a PhD in Theoretical Physics, I find quantum field theory
remarkably easy to understand.  My friends tell me this is just me and
they'd rather I not talk about it at parties ...

James

