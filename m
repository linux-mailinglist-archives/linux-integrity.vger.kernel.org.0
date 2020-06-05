Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46211EFC33
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgFEPJv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 11:09:51 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51864 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbgFEPJv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 11:09:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EFC3E8EE17B;
        Fri,  5 Jun 2020 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591369791;
        bh=xi+z9qbPsTXllDBJ0WRM+/ndDAx9h8hfcyrkP6jQy6k=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=xNx4AC8ymt/OkeY3mRqTMEHnQndf/aBnclJfvQNWy7aveFecdWQ35qnK2BTj4tDk0
         G5zdkjg43mGiEaXACZbAdakKs5NyH9xBtLjgsw/hg81O93gLpIZNt1dPV0gMzUFC9W
         IxODd5GkCMt/vL9axFQoRSBPnCpWynjjUcD+9cX8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PJEsl4LlIseN; Fri,  5 Jun 2020 08:09:50 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5F2588EE0CE;
        Fri,  5 Jun 2020 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591369790;
        bh=xi+z9qbPsTXllDBJ0WRM+/ndDAx9h8hfcyrkP6jQy6k=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=SsuhanMxRd81tv09iysh1skSDTAVmdiFppZeBt8zMyAWejq3boqFwAwf+ovwt1fgJ
         wa8tlBOS2d3l8EhzY38Jhg077ePKPcMFGVvFPPcOQh1lXzB2ndfEuA7LwY5ZihCg1x
         nWR/l0VjoxYr+ZUGaNinORmtYn4VXP11y6PiLoN4=
Message-ID: <1591369788.4728.29.camel@HansenPartnership.com>
Subject: Re: TPM resource manager separation
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>, linux-integrity@vger.kernel.org
Date:   Fri, 05 Jun 2020 08:09:48 -0700
In-Reply-To: <6693966c-132e-c35a-af08-7513cab33fc3@linux.ibm.com>
References: <6693966c-132e-c35a-af08-7513cab33fc3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-05 at 10:45 -0400, Ken Goldman wrote:
> Low level question:
> 
> Does the RM keep track of which handle / object belongs to which
> process?

Sort of: it stores the mappings in a per open file private area.  One
process can have more than one file open to the resource manager,
meaning it could have multiple views of the resource managed TPM, but
by and large there's one open per process meaning you can regard it as
mapping per process.

> E.g., process A loads a key and gets handle 80ffffff.  Process B
> then tries to do an operation using handle 80ffffff.  Will the RM
> reject it?

No, in fact the way the current resource manager works, the first
volatile key loaded by any process using the RM will always appear at
80ffffff.

> High level question:
> 
> Does the RM have any design or capability documentation?  Is there a 
> place to get answers other than this mailing list.

Not really ... perhaps it is time to write a
Documentation/security/tpmrm guide.

James

