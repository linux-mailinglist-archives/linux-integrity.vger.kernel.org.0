Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE811FE9E
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Dec 2019 07:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfLPGxd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Dec 2019 01:53:33 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49828 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfLPGxd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Dec 2019 01:53:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3E7D78EE163;
        Sun, 15 Dec 2019 22:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576479212;
        bh=Ub9QRo79yJlVnlr2oeZdZ301Q6v8WTDU9BOX4gLpaag=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Pj6hI+GqatQ04MmhUIj5idZNzTAYUcr0vIioF1HglrD4I3aK/E563yo3NwlnPl9jN
         +umghs3f0tWrH6vfulqjmBtERnVMd0OROGVlNyh4pAAGumW2KrFht267MVR0a5gWH3
         fttWODWrFMnpxdyoPPeKTwvF+AXk8BZ5Y8uNIJ+Y=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0dI3UALlt898; Sun, 15 Dec 2019 22:53:32 -0800 (PST)
Received: from [10.30.62.156] (unknown [103.5.140.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 014C38EE0E2;
        Sun, 15 Dec 2019 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576479211;
        bh=Ub9QRo79yJlVnlr2oeZdZ301Q6v8WTDU9BOX4gLpaag=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=sm2n9QN7+7rGuZJ4JiWOff5A6+cy2uc0c+kxLSutr4ywCpenJU3C1m9G3eeAsw7/c
         1LkilIWP+skklUmF+C3rMIiaEGcM+4HLZCWcBFHBODDDmJheRLW6VJ0NIlgMzDcv2S
         PWzHoFLlJeAkhcA1ZixJlDl8+0LrAhJurTtNXFbI=
Message-ID: <1576479187.3784.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Mon, 16 Dec 2019 15:53:07 +0900
In-Reply-To: <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2019-12-15 at 17:12 -0800, Lakshmi Ramasubramanian wrote:
> On 12/15/2019 7:22 AM, James Bottomley wrote:
> 
> Hi James,
> 
> > 
> > This is the problem:
> > 
> > if (!flag)
> >      pre()
> > .
> > .
> > .
> > if (!flag)
> >      post()
> > 
> > And your pre and post function either have to both run or neither
> > must.
> >   However, the flag is set asynchronously, so if it gets set while
> > another thread is running through the above code, it can change
> > after
> > pre is run but before post is.
> > 
> > James
> 
> The pre() and post() functions you have referenced above including
> the 
> check for the flag are executed with the mutex held.
> 
> Please see Mimi's response to the v3 email. I have copied it below:
> 
> ************************************
> Reading the flag IS lock protected, just spread across two functions.
> For performance, ima_post_key_create_or_update() checks
> ima_process_keys, before calling ima_queue_key(), which takes the
> mutex before checking ima_process_keys again.
> 
> As long as both the reader and writer, take the mutex before checking
> the flag, the locking is fine.  The additional check, before taking
> the mutex, is simply for performance.
> ************************************
> 
> The flag is checked with the mutex held in the "reader" - 
> ima_queue_key(). The key is queued with the mutex held only if the
> flag 
> is false.
> 
> The flag is protected in the "writer" also -
> ima_process_queued_keys(). 
> The flag is checked with the mutex held, set to true, and queued
> keys 
> (if any) are transferred to the temp list.
> 
> As Mimi has pointed out the additional check of the flag, before
> taking 
> the mutex in ima_post_key_create_or_update() and in 
> ima_process_queued_keys(), is for performance reason.
> 
> If the flag is true, there is no need to take the mutex to check it 
> again in those functions.

That doesn't matter ... the question is, is the input assumption that
both pre/post have to be called or neither must correct?  If so, the
code is wrong, if not, explain why.

James

