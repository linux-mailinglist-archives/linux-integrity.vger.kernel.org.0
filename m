Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C582331A7
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgG3MFz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 08:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgG3MFz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 08:05:55 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB9E2074B;
        Thu, 30 Jul 2020 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596110755;
        bh=NYWPTKukVI2HwxIT0he6+pqTjGLUhp8pm1CZzUigBFY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g+FARl7KpjxPZ6eI6TlqXclMnV3bfIihLKLNUDmSvMo4tqwq41Wm7w1moyvZaB3m4
         2LST5flx6aDyt8aoapZnAGy2HlMAQD6fNQqCsTzrsIvnTcr6qA79N+XEic1GyR3imp
         TOSeKWt5+OYZzz9EvuFiPXyexjHhVH7SrvgGc5pI=
Message-ID: <1596110753.25003.3.camel@kernel.org>
Subject: Re: Measure data again even when it has not changed
From:   Mimi Zohar <zohar@kernel.org>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>
Date:   Thu, 30 Jul 2020 08:05:53 -0400
In-Reply-To: <a83fdf87-d98e-b5cd-2557-2fae88b09a13@linux.microsoft.com>
References: <8bcf778d-8fa8-9985-43d7-c2b80d8d8445@linux.microsoft.com>
         <59f23e8953c0735695e5679fc7b7021252837874.camel@linux.ibm.com>
         <a83fdf87-d98e-b5cd-2557-2fae88b09a13@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-07-29 at 20:41 -0700, Lakshmi Ramasubramanian wrote:
> On 7/29/20 8:23 PM, Mimi Zohar wrote:
> 
> > On Wed, 2020-07-29 at 10:17 -0700, Lakshmi Ramasubramanian wrote:
> >> Hi Mimi,
> >>
> >> I have a query related to measuring data (by IMA subsystem) when that
> >> data has been already been measured.
> >>
> >> Consider the following sequence of events:
> >>
> >> => At time T0 IMA hook is called by another subsystem to measure data
> >> "foo". IMA measures it.
> >>
> >> => At time T1 data is "bar". IMA measures it.
> >>
> >> => At time T2 data is "foo" again. But IMA doesn't measure it since it
> >> is already in the measured list.
> >>
> >> But for the subsystem making the call to IMA, the state has changed and
> >> "foo" has to be measured again.
> >>
> >> One way to address the above is to use unique "event name" in each call
> >> so that IMA measures the given data every time.
> >>
> >> Is there a better way to address the above?
> > 
> > Most likely the file is being re-measured, but the new value already exists in
> > the hash table so it isn't being added to the IMA measurement list or extending
> > the TPM.  When IMA was upstreamed, there was concern about TPM performance and
> > the number of measurements being extended.  We've improved TPM performance quite
> > a bit.  If you're not concerned about TPM performance, I would define a new
> > template data field based on i_version.
> 
> In the use case I am considering the entity being measured is not a 
> file, but a memory buffer - it is for measuring an LSM's data 
> constructs. So i_version is not available in this case.
> 
> When LSM's data changes from A to B and then back to A, hash(A) already 
> exists in IMA's hash table. So A is not measured again.
> 
> Since LSM state change is not expected to be frequent, TPM performance 
> shouldn't be a concern.

Wouldn't a unique event name result in a new measurement every time?

Mimi
