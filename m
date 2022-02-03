Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCB74A7C57
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 01:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348296AbiBCAHK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 19:07:10 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54664 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiBCAHJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 19:07:09 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0376F72C8FA;
        Thu,  3 Feb 2022 03:07:08 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D1C5B4A46F0;
        Thu,  3 Feb 2022 03:07:07 +0300 (MSK)
Date:   Thu, 3 Feb 2022 03:07:07 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <20220203000707.okvycfr24phj2bjl@altlinux.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <5bb23626-afe1-9e05-566b-8830882904f6@linux.ibm.com>
 <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220202212437.mlj4cta4voqiqfpf@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

JFYI,

On Thu, Feb 03, 2022 at 12:24:37AM +0300, Vitaly Chikunov wrote:
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
>   encrypt=y
>   decrypt=n
>   sign=n
>   verify=y
> 
> W/o patch max_data_size= and max_sig_size= will be 32.

In case someone wants to reproduce `keyctl pkey_verify`, there are steps:
1. Keys are generated using ima-evm-utils tests suite, for example
test-gost2012_512-A.cer:

  $ base64 test-gost2012_512-A.cer
  MIIB/DCCAWagAwIBAgIUK8+whWevr3FFkSdU9GLDAM7ure8wDAYIKoUDBwEBAwMFADARMQ8wDQYD
  VQQDDAZDQSBLZXkwIBcNMjIwMjAxMjIwOTQxWhgPMjA4MjEyMDUyMjA5NDFaMBExDzANBgNVBAMM
  BkNBIEtleTCBoDAXBggqhQMHAQEBAjALBgkqhQMHAQIBAgEDgYQABIGALXNrTJGgeErBUOov3Cfo
  IrHF9fcj8UjzwGeKCkbCcINzVUbdPmCopeJRHDJEvQBX1CQUPtlwDv6ANjTTRoq5nCk9L5PPFP1H
  z73JIXHT0eRBDVoWy0cWDRz1mmQlCnN2HThMtEloaQI81nTlKZOcEYDtDpi5WODmjEeRNQJMdqCj
  UDBOMAwGA1UdEwQFMAMBAf8wHQYDVR0OBBYEFCwfOITMbE9VisW1i2TYeu1tAo5QMB8GA1UdIwQY
  MBaAFCwfOITMbE9VisW1i2TYeu1tAo5QMAwGCCqFAwcBAQMDBQADgYEAmBfJCMTdC0/NSjz4BBiQ
  qDIEjomO7FEHYlkX5NGulcF8FaJW2jeyyXXtbpnub1IQ8af1KFIpwoS2e93LaaofxpWlpQLlju6m
  KYLOcO4xK3Whwa2hBAz9YbpUSFjvxnkS2/jpH2MsOSXuUEeCruG/RkHHB3ACef9umG6HCNQuAPY=

2. Hash and raw signature generated using openssl dgst:

  $ head -123c /dev/zero > foo.data
  $ openssl dgst -md_gost12_512 -out foo.hash512 -binary foo.data
  $ openssl dgst -md_gost12_512 -sign test-gost2012_512-A.key -out foo.sign512 -binary foo.data

This may require configuring openssl to support engine, so there are resulting files:

  $ base64 foo.data
  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAA
  $ base64 foo.hash512
  CZEpA3sP+swJIsahmsA2GX/GDp+4Ibt8c/Oli01NbTXmSyjbC0yivmouDW+LfqckewMKiKWCdNIE
  aY4cxfy4sQ==
  $ base64 foo.sign512
  WNz9w7qmCvL/UG4uuCnj57C9udLRz1JXQLTOflpVa3fHPrp0qLBhoiLAdMtDr0AHPAsIlGS0vb9o
  vJIxtlGsimeqlAfffIpfmvu1oD/tqOT5NRa7xANT7tW2V9jiMRWt887dDSX+QBARcmXNwe07reoX
  Ko8xWMZ8xvOqWEuVPPw=

3. Then (with this patch applied, I run in virtme):

  # k=`keyctl padd asymmetric "" @u < test-gost2012_512-A.cer`
  # keyctl pkey_verify $k 0 foo.hash512 foo.sign512 enc=raw hash=streebog512

This gives exit 0. Test failure (due to wrong hash):

  # keyctl pkey_verify $k 0 foo.sign512 foo.sign512 enc=raw hash=streebog512
  keyctl_pkey_verify: Bad message

Thanks,
