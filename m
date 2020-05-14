Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070191D24D8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 03:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgENBlM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 May 2020 21:41:12 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:55924 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgENBlM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 May 2020 21:41:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DB5178EE268;
        Wed, 13 May 2020 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589420471;
        bh=A1nXPApd7wcueNVD8U+KyxA88Q0w9bBsMwIvb9bzOW0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=khU5xKIQkgyJg0umnQ9QSPgFBgcIXCiVuNuXbDKdDQFhrX/qq9Rh3jKekxBhoYSDy
         QeDj9bCJV2GleaC1MQWmHTDgLYT8uz7MtzzlEnNqQO6fi4WfEsxviA1bKk1byazRnB
         NU/JYZSltrWHigfDEI2aHFug/9tZz+98Eh8yRrRY=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wB0GkTSLQdKd; Wed, 13 May 2020 18:41:11 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5D07A8EE173;
        Wed, 13 May 2020 18:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589420471;
        bh=A1nXPApd7wcueNVD8U+KyxA88Q0w9bBsMwIvb9bzOW0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=khU5xKIQkgyJg0umnQ9QSPgFBgcIXCiVuNuXbDKdDQFhrX/qq9Rh3jKekxBhoYSDy
         QeDj9bCJV2GleaC1MQWmHTDgLYT8uz7MtzzlEnNqQO6fi4WfEsxviA1bKk1byazRnB
         NU/JYZSltrWHigfDEI2aHFug/9tZz+98Eh8yRrRY=
Message-ID: <1589420469.9117.12.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 3/8] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Wed, 13 May 2020 18:41:09 -0700
In-Reply-To: <664f00cf18c68e3f6316b50679b2fd56919d5aeb.camel@linux.intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <20200507231147.27025-4-James.Bottomley@HansenPartnership.com>
         <00325dff8292a18212bbdaa3fd81cebee2a60bc2.camel@linux.intel.com>
         <664f00cf18c68e3f6316b50679b2fd56919d5aeb.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-14 at 04:12 +0300, Jarkko Sakkinen wrote:
> On Thu, 2020-05-14 at 04:11 +0300, Jarkko Sakkinen wrote:
> > On Thu, 2020-05-07 at 16:11 -0700, James Bottomley wrote:
> > > In TPM 1.2 an authorization was a 20 byte number.  The spec
> > > actually recommended you to hash variable length passwords and
> > > use the sha1 hash as the authorization.  Because the spec doesn't
> > > require this hashing, the current authorization for trusted keys
> > > is a 40 digit hex number.  For TPM 2.0 the spec allows the
> > > passing in of variable length passwords and passphrases directly,
> > > so we should allow that in trusted keys for ease of use.  Update
> > > the 'blobauth' parameter to take this into account, so we can now
> > > use plain text passwords for the keys.
> > > 
> > > so before
> > > 
> > > keyctl add trusted kmk "new 32
> > > blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> > > 
> > > after we will accept both the old hex sha1 form as well as a new
> > > directly supplied password:
> > > 
> > > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > > 
> > > Since a sha1 hex code must be exactly 40 bytes long and a direct
> > > password must be 20 or less, we use the length as the
> > > discriminator for which form is input.
> > > 
> > > Note this is both and enhancement and a potential bug fix.  The
> > > TPM 2.0 spec requires us to strip leading zeros, meaning empyty
> > > authorization is a zero length HMAC whereas we're currently
> > > passing in 20 bytes of zeros.  A lot of TPMs simply accept this
> > > as OK, but the Microsoft TPM emulator rejects it with
> > > TPM_RC_BAD_AUTH, so this patch makes the Microsoft TPM emulator
> > > work with trusted keys.
> > > 
> > > Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0
> > > chips")
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership
> > > .com>
> > > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > Have not checked yet the tail. Probably won't check before PR for
> > v5.8 is out.
> > 
> > Just wondering would it hurt to merge everything up until this
> > patch?

Everything would be OK if you applied 1, 2 and 3.  Except we'd have an
ASN.1 API in the tree with no consumers, which excites some people.

> I.e. could land it also to the release.

That would likely be fine and should satisfy the API with no consumers
issue.

James

