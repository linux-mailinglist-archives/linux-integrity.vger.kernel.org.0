Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB15E9F1DA
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2019 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbfH0RtB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Aug 2019 13:49:01 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:38406 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfH0Rs6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Aug 2019 13:48:58 -0400
X-Greylist: delayed 2265 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 13:48:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lLYloM0Ywjig+ulU3rxirWB2hunInBTjYfHlRq1yag0=; b=i4yWR/AGXeNk0efti4p+I0xxR
        He1mnoWyZPL4x55cesht2sxmTyNiXHwOuyL7xB8q7GvUg6p1hZTfzm6vrlxwxsP1almCB6XTL6qQX
        mNAr7uZ6CkFnOz2D9Rv+/voSIbzTRnLqlT1cD7Ggd9yTJu/17YA07WnjiesVVv023Nins=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1i2ezq-00079w-HA; Tue, 27 Aug 2019 18:11:06 +0100
Date:   Tue, 27 Aug 2019 18:11:06 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
Message-ID: <20190827171106.owkvt6slwwg5ypyl@srcf.ucam.org>
References: <20190826081752.57258-1-kkamagui@gmail.com>
 <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
 <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
 <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjaAcSpU0eW5PLsEpxTkycwi+wNS67xeizb6_BMM_-qUZYAmg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 01:36:30AM +0900, Seunghun Han wrote:

> I got your point. Is there any problem if some regions which don't
> need to be handled in NVS area are saved and restored? If there is a
> problem, how about adding code for ignoring the regions in NVS area to
> the nvs.c file like Jarkko said? If we add the code, we can save and
> restore NVS area without driver's interaction.

The only thing that knows which regions should be skipped by the NVS 
driver is the hardware specific driver, so the TPM driver needs to ask 
the NVS driver to ignore that region and grant control to the TPM 
driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
