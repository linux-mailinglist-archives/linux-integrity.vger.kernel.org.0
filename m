Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF26283F45
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Oct 2020 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgJETFK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Oct 2020 15:05:10 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50024 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgJETFK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Oct 2020 15:05:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3FDAF8EE1C8;
        Mon,  5 Oct 2020 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601924710;
        bh=Bdj8u52riTI/9aOgCAaYrUAjy0sQDsszmDp4XBmy3Pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FGKbcRj75fUqlxvt0z/Ok7CQ6T+bZ2sCHgcVNyxrztQH9d+dZvHz/MXdP0QT9IgXH
         9w5WH7+6yRMSN+T6H0UE1G3+jmsl+PEQWxFY1aD1yPoxf4FoBQPu8FPPAw/4j9A7aE
         K2XG/tGhO/NUOQDuG/WGn2KZqjxc47Lp1IFgP+K0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s7JQg5c99TR1; Mon,  5 Oct 2020 12:05:09 -0700 (PDT)
Received: from jarvis (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3B0C18EE173;
        Mon,  5 Oct 2020 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601924709;
        bh=Bdj8u52riTI/9aOgCAaYrUAjy0sQDsszmDp4XBmy3Pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=O660zQm4lAikHQLFwPWN1Ah3dKu3kLyg2Rqxf0Lu81lT9gGkeHBQvzhUFzhgYhgx0
         Xmdhzg8hcJ2lTSo7Edf+rZVl0e59my73N2TxiirLsQ+IcYsRk2GhrWBZsrcIAWeEvg
         kBCxXRkxwuXwZLoO5xhGQ1VWXvnWDU3g/Zgb9Dtw=
Message-ID: <aa9bf3f821ab8f3ed8dc663112c67ca0f8e96c81.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/5] tpm_tis: Clean up locality release
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>
Date:   Mon, 05 Oct 2020 12:05:07 -0700
In-Reply-To: <20201005170219.GC6232@linux.intel.com>
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
         <20201001180925.13808-3-James.Bottomley@HansenPartnership.com>
         <20201005170219.GC6232@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-10-05 at 20:02 +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 01, 2020 at 11:09:22AM -0700, James Bottomley wrote:
> > The current release locality code seems to be based on the
> > misunderstanding that the TPM interrupts when a locality is
> > released: it doesn't, only when the locality is acquired.
> > 
> > Furthermore, there seems to be no point in waiting for the locality
> > to be released.  All it does is penalize the last TPM
> > user.  However, if there's no next TPM user, this is a pointless
> > wait and if there is a next TPM user, they'll pay the penalty
> > waiting for the new locality (or possibly not if it's the same as
> > the old locality).
> > 
> > Fix the code by making release_locality as simple write to release
> > with no waiting for completion.
> > 
> > Fixes: 33bafe90824b ("tpm_tis: verify locality released before
> > returning from release_locality")
> > Signed-off-by: James Bottomley <
> > James.Bottomley@HansenPartnership.com>
> 
> So, if I got it right this is dependent on 1/5 to address Jerry's
> issue? I.e. if this has a fixes tag and previous does not, it will
> not fully fix the situation when backporting?

Yes, exactly.  Technically 1/5 isn't really fixing anything at all,
it's changing from the current fix where we wait for the locality to be
released at the back end of a TIS TPM operation to a new fix where we
correctly check the conditions in the locality acquisition.  After the
new fix is done, we can eliminate all the wait code in locality
release.

James


