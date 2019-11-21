Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974E11048D6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Nov 2019 04:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKUDLW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 22:11:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42906 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfKUDLW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 22:11:22 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id BB23820B7185;
        Wed, 20 Nov 2019 19:11:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB23820B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574305881;
        bh=gTFGVwIweV1rSl+0K4uxrvsQYK2nyN8aEGlIR9MKgV0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=jSQRp8Qlr0Z+080phAZU/poDFshC1wW4Q5gy0b7vwdikQZyT/3ouS0p3UxIYj77M4
         CgBDKbTerQyk0O5+sIVveKVmtl0kMBHkAnJxLc5UTEk4N90WXAcXR3MoSWgJXq6h3f
         aVihKY6ND0bmIZZIlfB0OaLepBLJGLTFLu5gdOt0=
Subject: Re: [PATCH v8 4/5] IMA: Add support to limit measuring keys
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        dhowells@redhat.com
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-5-nramas@linux.microsoft.com>
 <1574291957.4793.144.camel@linux.ibm.com>
 <fef8fc67-643d-e579-9628-6516fd02b4db@linux.microsoft.com>
 <1574297611.4793.154.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9ed2c456-c959-06d8-7e4c-34662d60b169@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 19:11:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574297611.4793.154.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Adding David Howells@Redhat

Hi David,

On 11/20/19 4:53 PM, Mimi Zohar wrote:
> I would very much like for a regression test to be included in this
> patch set, but it isn't a requirement, as long as everything needed
> for verifying a signature is included in the key measurement.

/*
  * Cryptographic data for the public-key subtype of
  * the asymmetric key type.
  *
  * Note that this may include private part of the key as well
  * as the public part.
  */
struct public_key {
	void *key;
	u32 keylen;
	enum OID algo;
	void *params;
	u32 paramlen;
	bool key_is_private;
	const char *id_type;
	const char *pkey_algo;
};

 From the "struct key" the public_key is being retrieved like this:
struct public_key *pk = key->payload.data[asym_crypto];

The buffer being measured currently includes the data pointed to by 
"key" only (in struct public_key).

The function that verifies signature using public key takes public_key 
and public_key_signature as input:

/*
  * Verify a signature using a public key.
  */
int public_key_verify_signature(const struct public_key *pkey,
				const struct public_key_signature *sig)

Just wanted to confirm:

For verifying "struct public_key_signature" would it be sufficient if I 
include all the fields in "struct public_key" structure?

thanks,
  -lakshmi
