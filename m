Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B938C939
	for <lists+linux-integrity@lfdr.de>; Fri, 21 May 2021 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbhEUOaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 May 2021 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEUOaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 May 2021 10:30:18 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF125C061574;
        Fri, 21 May 2021 07:28:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C983D128098C;
        Fri, 21 May 2021 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621607333;
        bh=uie0Vp5XGM9UPvx/pFHZaJMB7jyP6Wt5/yPlSNjeRnQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AFS8tRsHkHHSbstJK5vxYl0vbBAFqwUEHgnMiVKjEY2t61Z9/TWGTXrZ2r2iL3qPr
         u7w9vIIuvECpJL+wCWvbXxTyhtvPQ+oYl1kVJ5eGYQMcP4yycchgttYOFWhIWK6Vir
         eJXbVVrZSQHz6wlV4cmjstm+ZYetPExuZUM/wn3M=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 30wRJ8inO5q0; Fri, 21 May 2021 07:28:53 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:600:8280:66d1::527])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 63A9E1280932;
        Fri, 21 May 2021 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1621607333;
        bh=uie0Vp5XGM9UPvx/pFHZaJMB7jyP6Wt5/yPlSNjeRnQ=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=AFS8tRsHkHHSbstJK5vxYl0vbBAFqwUEHgnMiVKjEY2t61Z9/TWGTXrZ2r2iL3qPr
         u7w9vIIuvECpJL+wCWvbXxTyhtvPQ+oYl1kVJ5eGYQMcP4yycchgttYOFWhIWK6Vir
         eJXbVVrZSQHz6wlV4cmjstm+ZYetPExuZUM/wn3M=
Message-ID: <57728f2272f26b8ca9e58a8fdac112ec0440e9f6.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] Trusted Key policy for TPM 2.0
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Date:   Fri, 21 May 2021 07:28:52 -0700
In-Reply-To: <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
         <49bf69d011373f339a21bb61183b135babb6edc8.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-21 at 14:48 +0100, David Woodhouse wrote:
> On Thu, 2021-05-20 at 17:43 -0700, James Bottomley wrote:
> > Now that the ASN.1 representation of trusted keys is upstream we
> > can add policy to the keys as a sequence of policy statements
> > meaning the kernel can now construct and use the policy session
> > rather than the user having to do it and pass the session down to
> > the kernel.  This makes TPM 2.0 keys with policy much easier.
> > 
> > The format of the policy statements is compatible with the
> > openssl_tpm2_engine policy implementation:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/
> > 
> > And the seal_tpm2_data command in the above can be used to create
> > sealed keys (including with policy statements) for the kernel.
> 
> I'd love to see that format properly defined and documented instead
> of just a reference to another implementation.

Well if you want to help me write an RFC, I can try to submit it.

James


