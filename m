Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FEE3096C9
	for <lists+linux-integrity@lfdr.de>; Sat, 30 Jan 2021 17:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhA3QfU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 11:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhA3Q3z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 11:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A35764E0C;
        Sat, 30 Jan 2021 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612024154;
        bh=JPXNyiE4eXTSyKDUPFy4fH+5Q9mPbW4vvpiFALGbmiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxlgGRXUWnyqcE7NzF0nJYYnSM0RPbob3B23NIb3Z4Hd9w8to3hDm+0/HmgswDS2l
         1Y4kvra8vPk3yo/u2ZtKw3K533xON4jCFCr5Pl0xbRzz/9yy5WiWw+/X68OfQzGOs4
         aNh6+0Q7Sdv5SAzAHxl06VhQguckBQW8KSaGrsdtZBxkBdZCP1zIw8756ffoLlcFAE
         avDXWiRprFTJcDDYu01XO8cjqqJ5ChkcD1bVMdzvRXpW8pOIMNKzjU3qRm/re7FDv3
         PMNWUBbNTgDwFwiicujmiwTwTfsPgaZOdvXKwvsDL6VFUFPzw+n/pdrPaPbuo1mgM0
         Gii7xGn2zDNuQ==
Date:   Sat, 30 Jan 2021 18:29:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v15 4/5] security: keys: trusted: use ASN.1 TPM2 key
 format for the blobs
Message-ID: <YBWJVcM8/2tIlWHk@kernel.org>
References: <20210127190617.17564-1-James.Bottomley@HansenPartnership.com>
 <20210127190617.17564-5-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127190617.17564-5-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 27, 2021 at 11:06:16AM -0800, James Bottomley wrote:
> Modify the TPM2 key format blob output to export and import in the
> ASN.1 form for TPM2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two TPM2B quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.
> 
> The benefit of the ASN.1 format is that it's a standard and thus the
> exported key can be used by userspace tools (openssl_tpm2_engine,
> openconnect and tpm2-tss-engine).  The format includes policy
> specifications, thus it gets us out of having to construct policy
> handles in userspace and the format includes the parent meaning you
> don't have to keep passing it in each time.
> 
> This patch only implements basic handling for the ASN.1 format, so
> keys with passwords but no policy.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

This one had some coding style errors:

WARNING: Possible repeated word: 'for'
#147: FILE: security/keys/trusted-keys/tpm2key.asn1:2:
+--- ASN.1 for for TPM 2.0 keys

ERROR: space required after that ',' (ctx:VxV)
#198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
                               ^

ERROR: space required after that ',' (ctx:VxV)
#198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
                                  ^

ERROR: space required after that ',' (ctx:VxV)
#198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
                                      ^

ERROR: space required after that ',' (ctx:VxV)
#198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };
                                         ^

ERROR: space required after that ',' (ctx:VxV)
#198: FILE: security/keys/trusted-keys/trusted_tpm2.c:29:
+static u32 tpm2key_oid[] = { 2,23,133,10,1,5 };

I fixed them by hand. I will apply these now to my master branch first,
but can you just sanity check that your changes still work for you?

Cutting hairs, but better to be safe than sorry when doing even a single
change to the source code.

/Jarkko
