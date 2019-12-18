Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB5D0123DDB
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 04:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfLRDYu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Dec 2019 22:24:50 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39370 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbfLRDYu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Dec 2019 22:24:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 32E2B8EE18E;
        Tue, 17 Dec 2019 19:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576639487;
        bh=cxJCl8qV7Xg1j7Y2wOi2Z+uGDbdR6QY84n+AaSV4kUo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=E2BkXk4VA/Jn14EJ7skkcnkgIY3T79JaUlajPQIRdOWlwgtCLYIo0bGOmlZrOuu2s
         dU537hLdFfLTrgXI4DkV8+5ibdpxrbzBnfxtwOmZNsqfjtsdearjWsbSqiHa/QsxKq
         /6NKPQpa6sif5/lRgyNGigWCfh6PNNlDXyO01bDo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id laTiIJbTyWvm; Tue, 17 Dec 2019 19:24:46 -0800 (PST)
Received: from [172.20.1.149] (s138.GtokyoFL8.vectant.ne.jp [222.228.122.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 740538EE0DF;
        Tue, 17 Dec 2019 19:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576639486;
        bh=cxJCl8qV7Xg1j7Y2wOi2Z+uGDbdR6QY84n+AaSV4kUo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XebAmp5r09vXGb9a1Y1MgLtnzFnKanoVwRRKSx0pkqZHMOFQBAV+vY++ZJeZ2XrDi
         QMijlyB3y9Cuqhv5ka3gUkQ32SzzzoFoZ64BEl3tzpjuiCXxxprM/Oi5Wdv732HrF0
         sJm/yeMYr2RV879Om2B33b0792TU0d4/oc0BRZjo=
Message-ID: <1576639480.14900.13.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Wed, 18 Dec 2019 12:24:40 +0900
In-Reply-To: <95606a84-ea7d-dda2-5ced-7418fe802ecf@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
         <1576479187.3784.1.camel@HansenPartnership.com>
         <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
         <1576531022.3365.6.camel@HansenPartnership.com>
         <35a6c241-9a46-2657-51d1-0c04d32a9fae@linux.microsoft.com>
         <f25b7299-1530-2e43-cdf4-2208c82fc768@linux.microsoft.com>
         <152580f3-2a1f-fa33-cc25-f25747a470a5@linux.microsoft.com>
         <1576634499.14900.10.camel@HansenPartnership.com>
         <edda07dc-c615-58f1-5689-4692c3fb3315@linux.microsoft.com>
         <95606a84-ea7d-dda2-5ced-7418fe802ecf@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-12-17 at 19:00 -0800, Lakshmi Ramasubramanian wrote:
> On 12/17/2019 6:44 PM, Lakshmi Ramasubramanian wrote:
> 
> > > 
> > > The direct implication of the comment and the lock dance with the
> > > temporary list and the processed flag is that stuff can be added
> > > to the ima_keys list after you drop the mutex.  Your explanation
> > > in the prior couple of emails says that nothing can be added
> > > because the ima_process_keys flag setting prevents it.  If the
> > > latter is true, you can simply drop the lock after setting the
> > > flag and rely on ima_keys not changing to run it through
> > > process_buffer_measurement without needing any of the
> > > intermediate list or the processed flag.  If the latter isn't
> > > true then any key added to ima_keys after the mutex
> > > is dropped is never processed.
> > > 
> > > James
> 
> One more scenario needs to be taken care - that still doesn't require
> a temp list, but will need a local flag.
> 
> Say, two threads race to call ima_process_queued_keys().
> Both find ima_process_keys flag is false.
> They now race to take to the lock.
> Only the 1st one setting the flag to true should process queued keys.

Kernel developers are systems people ... this is what we do with bit
test and set ... but the API is definitely less friendly than boolean
flags.

James

