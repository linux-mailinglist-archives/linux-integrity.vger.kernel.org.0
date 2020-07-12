Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F521CBA8
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2020 23:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgGLVyf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jul 2020 17:54:35 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53150 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729398AbgGLVyf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jul 2020 17:54:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9C19B8EE284;
        Sun, 12 Jul 2020 14:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594590874;
        bh=ATO/jWPru2zvsHpUzRgnkYYzz1idT3TAdZKflVNrHeY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nejra/nFe6IuHbH1T3iGWPhQjMwY3eZILd9uXduA1qgrYitzN2ZYkD2RCkOJ6IoSW
         L7y63X5xSp6FAZsDCU29+HZxLcndZt8WXcZ+IEiKh0GzpBbEjmob+GqYxdy4TmgF1G
         ruby1yJfR6w1YCcAF+/k8CSkki4GQiub26eWhEu4=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vGp-IWQVgwig; Sun, 12 Jul 2020 14:54:34 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C8F6B8EE100;
        Sun, 12 Jul 2020 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1594590874;
        bh=ATO/jWPru2zvsHpUzRgnkYYzz1idT3TAdZKflVNrHeY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nejra/nFe6IuHbH1T3iGWPhQjMwY3eZILd9uXduA1qgrYitzN2ZYkD2RCkOJ6IoSW
         L7y63X5xSp6FAZsDCU29+HZxLcndZt8WXcZ+IEiKh0GzpBbEjmob+GqYxdy4TmgF1G
         ruby1yJfR6w1YCcAF+/k8CSkki4GQiub26eWhEu4=
Message-ID: <1594590872.3446.33.camel@HansenPartnership.com>
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Ken Goldman <kgold@linux.ibm.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Sun, 12 Jul 2020 14:54:32 -0700
In-Reply-To: <34d5fef9-1baf-83a8-3e54-5065ea96f412@linux.ibm.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
         <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
         <34d5fef9-1baf-83a8-3e54-5065ea96f412@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-07-12 at 17:38 -0400, Ken Goldman wrote:
> On 2/27/2020 3:57 PM, James Prestwood wrote:
> > I am learning lots from this discussion, so thank you. I had
> > assumed that the parent key crypto had to match the child key, RSA
> > vs EC, but sounds like that is not the case. And yes, this sounds
> > like a much better way to go now that I have a bit more info on it.
> 
> I know this old.  Just FYI:
> 
> The TPM WG debated this for a while, but decided that the TPM should
> not enforce parent / child algorithm matching.  It's for the
> application to decide.

Heh, they're lucky they made that decision otherwise we'd likely have
been deprecating RSA keys (see below).

> I also note that parent keys wrap their child keys using a symmetric
> key, typically AES, not an RSA or ECC key.  The load time would be
> the  same for an ECC or RSA parent, because it's not using the
> asymmetric key.

But that's not actually the problem.  The problem is that if the
primary parent doesn't exist, it has to be created.  The TCG PC
provisioning guide did require that the RSA storage parent be
provisioned at 81000001 but that seems largely to be ignored, leading
to most TPM2 key using applications, like the TPM2 engines, having to
run TPM2_CreatePrimary themselves.  The time taken to run
TPM2_CreatePrimary for an RSA key is prohibitive, which is why we
always use EC parent keys.  If you look at both my engine and the Intel
one, there's simply no provision for creating RSA parents, although you
may use the NV version if it exists.

I also note that if we're using loadable, not importable keys which,
again, is the majority use case, we actually don't care about the
asymmetric part of the parent, so it would have been nice to have some
type of partial create primary where it only derived the symmetric key
and thus would save a huge amount of time for the RSA key and even a
bit of time for the EC one.

> This different from TPM 1.2, which always uses parent RSA wrapping.
> 
> The asymmetric key is used for:
> 
> 1 - import (key backup, using externally generated keys)
> 2 - Salted sessions
> 
> While both are useful, they're not typically used in a
> critical path.

There's a third critical advantage: because TPM 1.2 isn't crypto agile,
the parent is actually present in the TPM and doesn't have to be
created on the fly.

James

