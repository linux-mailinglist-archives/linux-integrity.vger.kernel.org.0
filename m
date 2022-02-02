Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9A34A7A4F
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347612AbiBBVY5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 16:24:57 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50576 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347635AbiBBVYj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 16:24:39 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 954B672C8FA;
        Thu,  3 Feb 2022 00:24:37 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7E9924A46F0;
        Thu,  3 Feb 2022 00:24:37 +0300 (MSK)
Date:   Thu, 3 Feb 2022 00:24:37 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Wed, Feb 02, 2022 at 07:55:43AM -0500, Stefan Berger wrote:
> On 2/2/22 01:59, Vitaly Chikunov wrote:
> > Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> > failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> > does not pass in/out sizes check in keyctl_pkey_params_get_2.
> > This in turn because these values cannot be distinguished by a single
> > `max_size' callback return value.
> > Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> > algorithms.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> How do you use pkey_query?
> 
> $ keyctl padd asymmetric testkey %keyring:test < cert.der
> 385037223

It should be (for RSA key):

  keyctl pkey_query 385037223 0 enc=pkcs1 hash=sha256

`0` is placeholder for a password.

For example, I generated keys with your eckey-testing/generate.sh, and
pkey_query after this patch is applied:
  
  # keyctl padd asymmetric "" @u < ecdsa-ca/ca.crt.der
  66509339
  # keyctl pkey_query 66509339 0 enc=x962 hash=sha256
  key_size=256
  max_data_size=64
  max_sig_size=64
  max_enc_size=32
  max_dec_size=32
  encrypt=y
  decrypt=n
  sign=n
  verify=y

W/o patch max_data_size= and max_sig_size= will be 32.

Thanks,

> $ keyctl pkey_query 385037223 ''
> Password passing is not yet supported
> $ keyctl pkey_query 385037223
> Format:
> š keyctl --version
> š keyctl add <type> <desc> <data> <keyring>
> [...]
> 
> $ keyctl unlink 385037223
> 1 links removed
> 
