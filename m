Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3215D11F86B
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Dec 2019 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfLOPWh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Dec 2019 10:22:37 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38764 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfLOPWh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Dec 2019 10:22:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F2E238EE163;
        Sun, 15 Dec 2019 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576423356;
        bh=kvuqPPhoUhuej+greuJFdVimHdta1pVopykZYNvvk88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bae0QB32kC9fsngp2gNoYx4TAeRJ5+X4z/u5ftK5bYoCuUCFyRnw6y0UNyNRFz7FC
         AzrCZyFAyDeDtReiJs2xq9KyzSDpVDl+wSXrO0UTsBt7KLUlnorTM9CpKjTvL78OPN
         gttRi3oYH6FjSB9Z+sBauGI+gJA07WwzoyTKx7a0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I8ldxVfxBjL5; Sun, 15 Dec 2019 07:22:35 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B40BF8EE0E2;
        Sun, 15 Dec 2019 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576423355;
        bh=kvuqPPhoUhuej+greuJFdVimHdta1pVopykZYNvvk88=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nOf164TKANgBuxswIn2wJAvvRPXcx99Pf6Xel6lvyD9HDorh9ylJ4k9/rI0YCExFn
         tT786CGvGB6FaQMaLA6Oex2jUa8EBWg0xi8u+kyLZ7sYYg5L43QMTzVmNbdrRIoYIA
         aFt5quqpd0NJsgQ69gRmzzHcXly5AWR9TKksw3EQ=
Message-ID: <1576423353.3343.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Sun, 15 Dec 2019 07:22:33 -0800
In-Reply-To: <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-12-13 at 09:31 -0800, Lakshmi Ramasubramanian wrote:
> On 12/13/19 9:25 AM, James Bottomley wrote:
> 
> Hi James,
> 
> > 
> > There's no locking around the ima_process_keys flag.  If you get
> > two policy updates in quick succession can't this flag change as
> > you're processing the second update meaning you lose it because the
> > flag was false when you decided to build it for the queue but
> > becomes true before you check above whether you need to queue it?
> > 
> > Note you don't need locking to fix this, you just need to ensure
> > that you use the same copy of the flag value for both tests.
> > 
> > James
> > 
> 
> Same flag (ima_process_keys) is used for making the queuing decision.
> 
> Taking a lock to access ima_process_keys is required only if the flag
> is false. That is handled in ima_queue_key() and
> ima_process_queued_keys() functions.
> 
> Queued keys are processed when the first policy update occurs. 
> Subsequently, the keys are processed immediately (not queued).
> 
> Could you please review those functions in this patch and let me know
> if you see a problem?

This is the problem:

if (!flag)
    pre()
.
.
.
if (!flag)
    post()

And your pre and post function either have to both run or neither must.
 However, the flag is set asynchronously, so if it gets set while
another thread is running through the above code, it can change after
pre is run but before post is.

James



