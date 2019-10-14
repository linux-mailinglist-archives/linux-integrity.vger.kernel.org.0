Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35438D6A37
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Oct 2019 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfJNTfm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Oct 2019 15:35:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45548 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730288AbfJNTfm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Oct 2019 15:35:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 23C5E8EE0F8;
        Mon, 14 Oct 2019 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1571081742;
        bh=AeRuRcgM6jscchlt/EXJEwv9Uv2Dq7fTNJi3DQhxtxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tdwb3VA4RFihblvfgH6wj+gJHfLvE95a2w5DUQQ3O4PvaBZS0aX4Chqn5r2mod4ZK
         DpLucBC2smnnVeboQBjJapGpZhdokOImzlN9uwtUPpMhQs/YaiB39+Mm5AowPMOOKY
         DY3rN3U6t+d3h3gRaGzfemXbXcoA88ojaS9vmoO8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t2U2D3im5XpM; Mon, 14 Oct 2019 12:35:41 -0700 (PDT)
Received: from [172.16.1.194] (unknown [63.64.162.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AACDD8EE0F5;
        Mon, 14 Oct 2019 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1571081741;
        bh=AeRuRcgM6jscchlt/EXJEwv9Uv2Dq7fTNJi3DQhxtxw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KKv6+fAG3nOUpTYC+dp5azBBF2qZEopErYDj496XRdjscaajHPterWrmN9iupLYB6
         N0h6xyDHIuqWo31ROLiPDlDenF3y2K++wriPTrtm8wQoN5EYPvCqg3EiDOJPzqA6wq
         5hPuXM1y+sP+l2GYhl0NQ3W9DzahKWji7gtNdC3E=
Message-ID: <1571081740.3728.12.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: use GFP kernel for tpm_buf allocations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Date:   Mon, 14 Oct 2019 12:35:40 -0700
In-Reply-To: <20191014193224.GF15552@linux.intel.com>
References: <1570809779.24157.1.camel@HansenPartnership.com>
         <20191014193224.GF15552@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-10-14 at 22:32 +0300, Jarkko Sakkinen wrote:
> On Fri, Oct 11, 2019 at 09:02:59AM -0700, James Bottomley wrote:
> > The current code uses GFP_HIGHMEM, which is wrong because
> > GFP_HIGHMEM
> > (on 32 bit systems) is memory ordinarily inaccessible to the kernel
> > and should only be used for allocations affecting userspace.  In
> > order
> > to make highmem visible to the kernel on 32 bit it has to be
> > kmapped,
> > which consumes valuable entries in the kmap region.  Since the
> > tpm_buf
> > is only ever used in the kernel, switch to using a GFP_KERNEL
> > allocation so as not to waste kmap space on 32 bits.
> > 
> > Fixes: a74f8b36352e (tpm: introduce tpm_buf)
> > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> I'll apply this without a fixes tag as there is no failing system.
> Agree that it was not the best design decision to use GFP_HIGHMEM.

I don't really mind either way.  The function of the fixes tag isn't to
say there was a fatal bug it's to say if you think you're fixing
something where was the origin of the problem, however minor the
problem is.

I do agree that Sasha's autosel stuff does seem to be triggering off
Fixes and we don't want to see hundreds of autosel patches trying to
apply this to older trees, so removing the fixes tag to avoid this is
fine with me.

James

