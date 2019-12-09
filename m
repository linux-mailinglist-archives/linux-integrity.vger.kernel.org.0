Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC51177D8
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 21:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfLIU5J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 15:57:09 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34370 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbfLIU5J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 15:57:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 73D098EE112;
        Mon,  9 Dec 2019 12:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575925028;
        bh=EniOcEMFZZZS0LCHITKvY44oObdcidMrDvbzkr++vyo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BqK4sU0YRloZcN9cSC5FH8phBPQADv5hSZOxr85qJ1/OsIDwz0UnV74yfjF4yXHTJ
         VOcb7wvuSCDCNHCL/8t3KutqcPzNV1ZaVGSox5SKJsPyS+m3ZspCOpL6tZQyn49P2U
         NzvtIRtfNWCJQVyHkh4j8Ju7jB5XqRreUlnzfurE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8WkMDGQV39O9; Mon,  9 Dec 2019 12:57:08 -0800 (PST)
Received: from jarvis.lan (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 01A748EE0FC;
        Mon,  9 Dec 2019 12:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1575925028;
        bh=EniOcEMFZZZS0LCHITKvY44oObdcidMrDvbzkr++vyo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BqK4sU0YRloZcN9cSC5FH8phBPQADv5hSZOxr85qJ1/OsIDwz0UnV74yfjF4yXHTJ
         VOcb7wvuSCDCNHCL/8t3KutqcPzNV1ZaVGSox5SKJsPyS+m3ZspCOpL6tZQyn49P2U
         NzvtIRtfNWCJQVyHkh4j8Ju7jB5XqRreUlnzfurE=
Message-ID: <1575925024.31378.28.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/8] Fix TPM 2.0 trusted keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Date:   Mon, 09 Dec 2019 12:57:04 -0800
In-Reply-To: <20191209202024.GJ19243@linux.intel.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <20191209202024.GJ19243@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-09 at 22:20 +0200, Jarkko Sakkinen wrote:
> On Sat, Dec 07, 2019 at 09:06:40PM -0800, James Bottomley wrote:
> > The big problem with this patch is still that we can't yet combine
> > policy with authorization because that requires proper session
> > handling, but at least with this rewrite it becomes possible
> > (whereas it was never possible with the old external policy session
> > code). Thus, when we have the TPM 2.0 security patch upstream,
> > we'll be able to use the session logic from that patch to imlement
> > authorizations.
> 
> This essentially means that this is an RFC, not something that can be
> merged at this point before whatever you mean by proper has been
> landed.

No it doesn't.  It just means we have a limitation in the keys that
needs to be removed at a later time when we have the authentication
mechanisms.  Since there will simply be a feature added with no
backward compat problems, it's not a merge blocker.

James

