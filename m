Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6727B6E6
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgI1VPg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 17:15:36 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:36096 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgI1VPf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 17:15:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7011B8EE17F;
        Mon, 28 Sep 2020 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601327735;
        bh=cd9UlN+XhmBbNgrcBt64nxLtOQ+3Su4wIg8oMd1CwVU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qCCxQPy7VuyP/c11Fq/mC21TRQPIRMnt/Pb46D8A03BUPxH/cIkrgn0KVjkei47Cf
         aFBPuahpNRwVpBfbuDp9ojUbMImGl8Qr5f1XDYuLbNd2TFqbdr7gLuTVx71noPIANd
         sAmjBP8zrEF9/84z9Na8EMTay5LC0D4sEhdtZxQY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YT76NM0OnY9S; Mon, 28 Sep 2020 14:15:35 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DA94D8EE0F5;
        Mon, 28 Sep 2020 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601327735;
        bh=cd9UlN+XhmBbNgrcBt64nxLtOQ+3Su4wIg8oMd1CwVU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qCCxQPy7VuyP/c11Fq/mC21TRQPIRMnt/Pb46D8A03BUPxH/cIkrgn0KVjkei47Cf
         aFBPuahpNRwVpBfbuDp9ojUbMImGl8Qr5f1XDYuLbNd2TFqbdr7gLuTVx71noPIANd
         sAmjBP8zrEF9/84z9Na8EMTay5LC0D4sEhdtZxQY=
Message-ID: <f0dcade667d226e982db89389fd0d86368c67ba9.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm_tis: Add a check for invalid status
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Mon, 28 Sep 2020 14:15:33 -0700
In-Reply-To: <20200928183351.GA587339@ziepe.ca>
References: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
         <20200928183351.GA587339@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-09-28 at 15:33 -0300, Jason Gunthorpe wrote:
> On Mon, Sep 28, 2020 at 11:00:12AM -0700, James Bottomley wrote:
> > Some TIS based TPMs can return 0xff to status reads if the locality
> > hasn't been properly requested.  Detect this condition by checking
> > the bits that the TIS spec specifies must return zero are clear and
> > return zero in that case.  Also drop a warning so the problem can
> > be identified in the calling path and fixed (usually a missing
> > try_get_ops()).
> > 
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> > 
> > This is the patch I've been using to catch and kill all the points
> > in the stack where we're not properly using get/put ops on the tpm
> > chip.
> 
> If this is a problem add a lockdep on ops_sem in various places too?

It's not really possible because of the init issue with checking the
interrupt.  That originally had no locking at all (it doesn't need any
because the TPM device isn't publicly exposed at the point the check is
done).  If the patch to add get/put around the tpm2_get_tpm_pt is
acceptable, then perhaps we could because I think that's the last
unguarded use of tpm_tis_status.

James


