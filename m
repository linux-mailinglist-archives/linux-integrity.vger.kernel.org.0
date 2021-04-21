Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21503366B45
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Apr 2021 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhDUMwx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Apr 2021 08:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240075AbhDUMwp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Apr 2021 08:52:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 734D161451;
        Wed, 21 Apr 2021 12:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619009532;
        bh=IZaohxyczQIzHLXvsyuiv2v5D/4sNbVy8dDuoz3fFGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4aIOOTC5ix2jgy/a9TcU89YGXm1NuU8SlAsyk607UNWbUwWtM/+3g6lRvPLItq9m
         fZnhJ6eaunWWrQtYzx6iCDj9PGqNkPWZhU1q12R63kVf6ERMvZKtMrkgA/B7mapb1B
         Wr8ksXPlU3mRj/bejwntX1cLj6ULhpg8DaB9mczPKgC2fy7spouD4N2UP+uLEPb8py
         FD8wfmZSi78O9pq0fCD3ddJ5ASn4b+KCRMyd34lT28Pjq47I679K6LDjWp0LdJ0h5Q
         vwEv3bvob0a4ZkphNyJzNEDytjYPrX7jHbjPfi1UEGRrmPPOWxe/6S17SdCsqBMwDK
         R28D3o8CrINBQ==
Date:   Wed, 21 Apr 2021 14:52:06 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] certs: Add support for using elliptic curve keys
 for signing modules
Message-ID: <YIAf9jYGu03lrJLn@gunter>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
 <20210408152403.1189121-3-stefanb@linux.ibm.com>
 <YH7fKUjJoynyPkHt@gunter>
 <794ef635-de91-9207-f28b-ab6805fd95c9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <794ef635-de91-9207-f28b-ab6805fd95c9@linux.ibm.com>
X-OS:   Linux gunter 5.11.12-1-default x86_64
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+++ Stefan Berger [20/04/21 17:02 -0400]:
>
>On 4/20/21 10:03 AM, Jessica Yu wrote:
>>+++ Stefan Berger [08/04/21 11:24 -0400]:
>>>
>>>diff --git a/crypto/asymmetric_keys/pkcs7_parser.c 
>>>b/crypto/asymmetric_keys/pkcs7_parser.c
>>>index 967329e0a07b..2546ec6a0505 100644
>>>--- a/crypto/asymmetric_keys/pkcs7_parser.c
>>>+++ b/crypto/asymmetric_keys/pkcs7_parser.c
>>>@@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, 
>>>size_t hdrlen,
>>>        ctx->sinfo->sig->pkey_algo = "rsa";
>>>        ctx->sinfo->sig->encoding = "pkcs1";
>>>        break;
>>>+    case OID_id_ecdsa_with_sha256:
>>>+        ctx->sinfo->sig->pkey_algo = "ecdsa";
>>>+        ctx->sinfo->sig->encoding = "x962";
>>>+        break;
>>
>>Hi Stefan,
>>
>>Does CONFIG_MODULE_SIG_KEY_TYPE_ECDSA have a dependency on 
>>MODULE_SIG_SHA256?
>
>You are right, per the code above it does have a dependency on SHA256. 
>ECDSA is using NIST p384 (secp384r1) for signing and per my tests it 
>can be paired with all the sha hashes once the code above is extended. 
>Now when it comes to module signing, should we pair it with a 
>particular hash? I am not currently aware of a guidance document on 
>this but sha256 and sha384 seem to be good choices these days, so 
>maybe selecting ECDSA module signing should have a 'depends on' on 
>these?

Yeah, I would tack on the 'depends on' until the code above has been
extended to cover more sha hashes - because currently if someone
builds and signs a bunch of modules with an ECDSA key, they will fail
to load if they picked something other than sha256. I am unfortunately
not knowledgeable enough to suggest an official guideline on choice of
hash, but for now it is reasonable to have a 'depends on' for which
hashes the code currently supports, so that users don't run into
module loading rejection issues.

Thanks!

Jessica
