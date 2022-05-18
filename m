Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9ABF52B6B3
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiERJmK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 05:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiERJly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 05:41:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D920B0D3D;
        Wed, 18 May 2022 02:41:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3CEE21FB1D;
        Wed, 18 May 2022 09:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652866912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gvqmwd32pWfeTd+pQbb+XvmLC36shUm4oEYSUHUH/4s=;
        b=VmbfWJ8JScNoKhmKbR4C9ZO64MZdKjOsfSFQ9u0TxeoN8yIcQbA8bSGDJAJiyjMeuWQkFm
        bVjYMG/RGdqHikQV42UWgAuICyP0T1Rvn2DdLgPgwfWZKBN0A2esT9qSwLHxeZg+cP6ZSj
        yhMwCwkyLfABT42xMpYxYSNy3CUExGA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F03E9133F5;
        Wed, 18 May 2022 09:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qcvsOF+/hGLGFAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 18 May 2022 09:41:51 +0000
Message-ID: <642471c7-f717-2ef4-1d6d-6fabf57db08f@suse.com>
Date:   Wed, 18 May 2022 11:41:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 15/21] xen/tpmfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-16-jgross@suse.com> <YnWh6P7kBtPa2aTA@kernel.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <YnWh6P7kBtPa2aTA@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------40zZX2QheKufpfo6R9R2UDWP"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------40zZX2QheKufpfo6R9R2UDWP
Content-Type: multipart/mixed; boundary="------------TgxGHQPVJJUkPuHCpNDyxMvE";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>
Message-ID: <642471c7-f717-2ef4-1d6d-6fabf57db08f@suse.com>
Subject: Re: [PATCH v3 15/21] xen/tpmfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-16-jgross@suse.com> <YnWh6P7kBtPa2aTA@kernel.org>
In-Reply-To: <YnWh6P7kBtPa2aTA@kernel.org>

--------------TgxGHQPVJJUkPuHCpNDyxMvE
Content-Type: multipart/mixed; boundary="------------GyGKEkcibCyskU997scHLe0C"

--------------GyGKEkcibCyskU997scHLe0C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDUuMjIgMDA6MzIsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gT24gVGh1LCBN
YXkgMDUsIDIwMjIgYXQgMTA6MTY6MzRBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IFNpbXBsaWZ5IHRwbWZyb250J3MgcmluZyBjcmVhdGlvbiBhbmQgcmVtb3ZhbCB2aWEg
eGVuYnVzX3NldHVwX3JpbmcoKQ0KPj4gYW5kIHhlbmJ1c190ZWFyZG93bl9yaW5nKCkuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0K
PiANCj4gUGxlYXNlIGFkZCB0byB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IHRoZXNlIHByb3Zp
ZGUgYW4gZXF1aXZhbGVudA0KPiBmdW5jdGlvbmFsaXR5Lg0KDQpXb3VsZCB5b3UgYmUgZmlu
ZSB3aXRoOg0KDQogICBTaW1wbGlmeSB0cG1mcm9udCdzIHJpbmcgY3JlYXRpb24gYW5kIHJl
bW92YWwgdmlhIHhlbmJ1c19zZXR1cF9yaW5nKCkNCiAgIGFuZCB4ZW5idXNfdGVhcmRvd25f
cmluZygpLCB3aGljaCBhcmUgcHJvdmlkZWQgZXhhY3RseSBmb3IgdGhlIHVzZQ0KICAgcGF0
dGVybiBhcyBzZWVuIGluIHRoaXMgZHJpdmVyLg0KDQoNCkp1ZXJnZW4NCg==
--------------GyGKEkcibCyskU997scHLe0C
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------GyGKEkcibCyskU997scHLe0C--

--------------TgxGHQPVJJUkPuHCpNDyxMvE--

--------------40zZX2QheKufpfo6R9R2UDWP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmKEv18FAwAAAAAACgkQsN6d1ii/Ey+Q
Gwf/ehwm6jUVpEx0+yC4NILAFBiMMpghweN7oXV0/HJir7zTTMMijxvTV8f7AbuBIcmB8vARGnsl
WuftbUX84JXnTdadLZBDwu1GlMoopubDJdB7Y5Q3XVPEovNvsQYh/ImQ3Jlyj9UYz2mcFTTZ0sUk
BJZeDn+vzF8sOnlLGcGwHPVCuBLLZlKqngtEoEHMpbpR0JKGR4+TzVnxrftnG9w8PYKuhgV/5X/v
cKGD4Na6ulAuKU73AdUaaf21oxr0ptm9ZU66c1bA29Ttg9j01pBsc3u5qLldjrDXmViT0KwvVkVQ
WbqyphGjTYqwCTcGorFhmvnbqGc3RLvoNYDA3vr8bg==
=vI4g
-----END PGP SIGNATURE-----

--------------40zZX2QheKufpfo6R9R2UDWP--
