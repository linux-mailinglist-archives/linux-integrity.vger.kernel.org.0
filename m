Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040414A7B2D
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 23:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240027AbiBBWiI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 17:38:08 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:53386 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiBBWiI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 17:38:08 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EAAFB72C8FA;
        Thu,  3 Feb 2022 01:38:06 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id CA0FC4A46F0;
        Thu,  3 Feb 2022 01:38:06 +0300 (MSK)
Date:   Thu, 3 Feb 2022 01:38:06 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <20220202223806.bcfsjtr472kl3jj3@altlinux.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
 <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Feb 03, 2022 at 12:24:37AM +0300, Vitaly Chikunov wrote:
> Stefan,
> 
> On Wed, Feb 02, 2022 at 07:55:43AM -0500, Stefan Berger wrote:
> > On 2/2/22 01:59, Vitaly Chikunov wrote:
> > > Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> > > failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> > > does not pass in/out sizes check in keyctl_pkey_params_get_2.
> > > This in turn because these values cannot be distinguished by a single
> > > `max_size' callback return value.
> > > Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> > > algorithms.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > 
> > How do you use pkey_query?
> > 
> > $ keyctl padd asymmetric testkey %keyring:test < cert.der
> > 385037223
> 
> It should be (for RSA key):
> 
>   keyctl pkey_query 385037223 0 enc=pkcs1 hash=sha256
> 
> `0` is placeholder for a password.
> 
> For example, I generated keys with your eckey-testing/generate.sh, and
> pkey_query after this patch is applied:
>   
>   # keyctl padd asymmetric "" @u < ecdsa-ca/ca.crt.der
>   66509339
>   # keyctl pkey_query 66509339 0 enc=x962 hash=sha256
>   key_size=256
>   max_data_size=64
>   max_sig_size=64

>   max_enc_size=32
>   max_dec_size=32

I just thought, we can also set these to 0 if encrypt/decrypt is not
enabled. Currently, there is no way to detect that encrypt is not
possible, except by extending that if (strcmp...), but if we going to
have it, why not correct other info too?

Thanks,

>   encrypt=y
>   decrypt=n
>   sign=n
>   verify=y
> 
> W/o patch max_data_size= and max_sig_size= will be 32.
> 
> Thanks,
> 
> > $ keyctl pkey_query 385037223 ''
> > Password passing is not yet supported
> > $ keyctl pkey_query 385037223
> > Format:
> > š keyctl --version
> > š keyctl add <type> <desc> <data> <keyring>
> > [...]
> > 
> > $ keyctl unlink 385037223
> > 1 links removed
> > 
