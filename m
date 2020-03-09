Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DA17EBB1
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Mar 2020 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCIWI1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Mar 2020 18:08:27 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57554 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgCIWI1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Mar 2020 18:08:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 891DD8EE130;
        Mon,  9 Mar 2020 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583791706;
        bh=8qnLnJ0TylGaGU7IaxmzGUxtMZPiNg594i7ggcqCpkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mzvjwi92O+3CZz8uMP/PH8JM5X6VMuN8t746Go6vbdzEqycr9l5IF8lqOoFuBuTVo
         QeABWAknpH5MkOwu47xtEht+6a5tqL8a8Iumi63tHE8DZ01F8dBXQ2scChF4H06BP9
         Ha8QQZt1yt9+gjtlRFceetlhEf0NvWox6HYbjpxM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ghq7l2BhfMVk; Mon,  9 Mar 2020 15:08:25 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 271968EE121;
        Mon,  9 Mar 2020 15:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1583791704;
        bh=8qnLnJ0TylGaGU7IaxmzGUxtMZPiNg594i7ggcqCpkA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=rC8YyA2zk7O7WnoScHtYy/0sY/aCiYf1JbDhgradTPdz+DlwDqI+Ik7AdBEVN2zRL
         7Oe0ZLmEE3S75klM1depn0b74p7+P8FAaeS8mnG7bRsHYL9Po6KDSouNU+xg6l+fjd
         yIIXVoDShJp0BxZtwBu2LD+pXcLXhVnnGUotGPCg=
Message-ID: <1583791703.6009.3.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 4/6] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Date:   Mon, 09 Mar 2020 15:08:23 -0700
In-Reply-To: <1583762386.3429.6.camel@HansenPartnership.com>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
         <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
         <20200307220026.GA122868@linux.intel.com>
         <1583762386.3429.6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-03-09 at 06:59 -0700, James Bottomley wrote:
> On Sun, 2020-03-08 at 00:00 +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 04, 2020 at 06:27:42PM -0800, James Bottomley wrote:
> > > Modify the TPM2 key format blob output to export and import in
> > > the ASN.1 form for TPM2 sealed object keys.  For compatibility
> > > with prior trusted keys, the importer will also accept two TPM2B
> > > quantities representing the public and private parts of the
> > > key.  However, the export via keyctl pipe will only output the
> > > ASN.1 format.
> > > 
> > > The benefit of the ASN.1 format is that it's a standard and thus
> > > the exported key can be used by userspace tools
> > > (openssl_tpm2_engine, openconnect and tpm2-tss-engine).  The
> > > format includes policy specifications, thus it gets us out of
> > > having to construct policy handles in userspace and the format
> > > includes the parent meaning you don't have to keep passing it in
> > > each time.
> > > 
> > > This patch only implements basic handling for the ASN.1 format,
> > > so keys with passwords but no policy.
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > 
> > Not yet sure but I get
> > 
> > keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo=03000001 6768033e216468247bd031a0a2d9876d79818f8f" @u
> > add_key: No such device
> 
> What's the last hex string?  Is there supposed to be a command
> preceding it (like blobauth since there's 40 hex chars?).
> 
> > After applying 1/6-4/6.
> 
> As you guessed for most of the rebases I've been testing the whole
> set of patches.  Let me wind back to 4/6 and have a look.
> 
> > At this point I'm assuming that I've made mistake somewhere, which
> > is entirely possible.
> 
> Heh, don't bet on it, I should be able to reconstruct the environment
> today and try it out.

OK, I got the environment constructed, and everything seems to work
fine for me.

However, there is still a problem with the patch.  It appears in going
from v4->v5 two additional patches got folded into this one:

[PATCH v4 5/9] security: keys: trusted: Make sealed key properly
 interoperable
[PATCH v4 6/9] security: keys: trusted: add PCR policy to TPM2 keys

I'll see if I can disentangle them otherwise the commit log saying we
don't add policy is completely wrong.

James

