Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5BE1D4422
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 05:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEODo1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 23:44:27 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:41926 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgEODo0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 23:44:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8213A8EE2B2;
        Thu, 14 May 2020 20:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589514265;
        bh=Pap4SSzXaAz3qlkjmLgUnEFiE3PZuWsdUzZD0OJ7fiA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TGUEdkRThl20DBgXdJaUabwDybzxIbl5+ur31mOYD4jaFMaU2uMgbnrrQ8Evu1koK
         HhpuOcHE6eEOaVk7aTXxQKwehOEMgqdwcwE1riUKG7R0zEJJe+GZcC5UkNkDuSD5p4
         zn1czUf6ZfUBQUZS1c/iSE5y+iXMXh/+R1Yu/MH8=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uyMGBPmMGRkA; Thu, 14 May 2020 20:44:25 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id DF2FC8EE165;
        Thu, 14 May 2020 20:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1589514265;
        bh=Pap4SSzXaAz3qlkjmLgUnEFiE3PZuWsdUzZD0OJ7fiA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TGUEdkRThl20DBgXdJaUabwDybzxIbl5+ur31mOYD4jaFMaU2uMgbnrrQ8Evu1koK
         HhpuOcHE6eEOaVk7aTXxQKwehOEMgqdwcwE1riUKG7R0zEJJe+GZcC5UkNkDuSD5p4
         zn1czUf6ZfUBQUZS1c/iSE5y+iXMXh/+R1Yu/MH8=
Message-ID: <1589514263.5759.25.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Thu, 14 May 2020 20:44:23 -0700
In-Reply-To: <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
         <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
         <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-05-15 at 05:22 +0300, Jarkko Sakkinen wrote:
> On Thu, 2020-05-14 at 17:31 +0300, Jarkko Sakkinen wrote:
> > I'm compiling now kernel with all series included.
> > 
> > Kind of checking if I could just take the whole series. Let see.
> > 
> > In all cases I want the style errors in 3/8 to be fixes with a
> > helper
> > but maybe better to hold before sending anything. Possibly that is
> > all
> > needed I'll just carve that patch myself.
> > 
> > Please don't do anything for the moment.
> 
> This is what I tried first (with the full series applied):
> 
> #!/bin/sh
> 
> die()
> {
> 	keyctl clear @u
> 	./tpm2-flush --all-transient
> 	exit $1
> }
> 
> KEYHANDLE=$(./tpm2-root-key || die 1)
> KEYID=$(keyctl add trusted kmk "new 32 keyhandle=$KEYHANDLE
> hash=sha256" @u || die 1)
> 
> echo "$KEYID ($KEYHANDLE)"
> 
> keyctl pipe $KEYID > blob.hex || die 1
> keyctl clear @u || die 1
> 
> echo "Import key from blob"
> 
> keyctl add trusted kmk "load `cat blob.hex` keyhandle=$KEYHANDLE" @u
> || die 1
> 
> die 0
> 
> Result:
> 
> sudo ./keyctl-smoke.sh
> 566201053 (0x80000000)
> keyctl_read_alloc: Permission denied

Well, it's clearly failing in keyctl pipe

I do confess to never having tested a volatile primary, but I just did
so and it works for me.  I will also add the keyhandle in the load
isn't necessary, because it should be in the blob, but there should
also be no harm (just tested).

However, I don't have keyctl_read_alloc in my tree, so it may be an
incompatibility with another patch set.  What's your base and what
other patches do you have applied?

James

> Any ideas what I might have done wrong? Have not tried auth value yet
> but afaik the above should fully test import and export.
> 
> Uses tpm2-scripts:
> 
> https://github.com/jsakkine-intel/tpm2-scripts
> 
> I'll probably move these to git.infradead.org because I don't like
> really like at all Github and my kernel tree is there anyway.
> 
> /Jarkko
> 

