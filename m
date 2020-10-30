Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9394F2A0A45
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Oct 2020 16:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJ3Pt3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Oct 2020 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgJ3Pt3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Oct 2020 11:49:29 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02790C0613CF
        for <linux-integrity@vger.kernel.org>; Fri, 30 Oct 2020 08:49:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id BE9FC12803D3;
        Fri, 30 Oct 2020 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604072968;
        bh=eTT+CgK3U0fdlTfv948/eSIweR6CywUvIbiVBRDVxx0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=UXv6mm/pgjFy4ggHIOu8plHTizHYBnrIU+GgO7DQaSsZbEfEqYS67hA+dc3DAQ5+H
         9yzAMVQms9JgTidtv9nja79TNtCn1XGJNRPuUP0pRtj/1fX7Gap1DBve71EZweoy2d
         l3PpRBDGLpwEMBBFCjn4f20uyhxN74pX95lnZAgc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a4Ff7WMRKgTQ; Fri, 30 Oct 2020 08:49:28 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::c447])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 49CF2128032B;
        Fri, 30 Oct 2020 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1604072968;
        bh=eTT+CgK3U0fdlTfv948/eSIweR6CywUvIbiVBRDVxx0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=UXv6mm/pgjFy4ggHIOu8plHTizHYBnrIU+GgO7DQaSsZbEfEqYS67hA+dc3DAQ5+H
         9yzAMVQms9JgTidtv9nja79TNtCn1XGJNRPuUP0pRtj/1fX7Gap1DBve71EZweoy2d
         l3PpRBDGLpwEMBBFCjn4f20uyhxN74pX95lnZAgc=
Message-ID: <837dbe43b7507a765553260289de5fd8eee397c4.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 4/5] tpm_tis: fix IRQ probing
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Fri, 30 Oct 2020 08:49:27 -0700
In-Reply-To: <20201030124335.GD522355@kernel.org>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-5-James.Bottomley@HansenPartnership.com>
         <87zh4hg4wg.fsf@redhat.com> <20201024121718.GC32960@kernel.org>
         <20201030124335.GD522355@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-10-30 at 14:43 +0200, Jarkko Sakkinen wrote:
[...]
> I tested this with:
> 
> - 
> https://ark.intel.com/content/www/us/en/ark/products/84861/intel-nuc-kit-nuc5i5myhe.html
>   dTPM 1.2
> - 
> https://ark.intel.com/content/www/us/en/ark/products/74483/intel-nuc-kit-dc53427hye.html
>   dTPM 2.0
> 
> I did not get "TPM interrupt not working, polling instead" to klog.
> But I neither see tpm0 in /proc/interrupts. What I'm doing wrong?

That's usually what you get when ACPI specifies the interrupt isn't
connected (we don't try to probe it).

James


